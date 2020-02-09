" File: template.vim  
" Author: Wonder <wonderbeyond@gmail.com>  
" Description:  
"   Generates template for new files.  
"   这里主要根据文件名加载模板, 而不是根据 vim 识别到的文件类型.  
"   .c 和 .h 文件可能会被识别为相同类型, 显然它们需要不同的模板.  
" Rules:  
" *先看整个文件名(不含路径), 再看扩展名.  
"   例如 main.cc 文件中会定义 main 函数, 其他 .cc 文件则未必然.  
" *先看是否有普通的静态模板, 再看是否有动态模板.

if exists("g:enable_template") && g:enable_template == 1 && exists("g:template_dir") 
    augroup Template_Generator
        autocmd! Template_Generator
        autocmd BufNewFile * call Read_template()
    augroup END
else
    finish
endif

let s:common_tpl_dir  = g:template_dir . "/common"
let s:dynamic_tpl_dir = g:template_dir . "/dynamic"

function! Read_template()
    let filename = expand("%:t")
    let extname  = expand("%:e")

    " 先检查是否存在[普通的][全名]匹配模板(例如 main.cc).
    let common_tpl_file = expand(s:common_tpl_dir . "/full/" . filename)
    if filereadable(common_tpl_file)
        call Read_template_file(common_tpl_file)
        return
    endif

    " 再检查是否存在[动态的][全名]匹配模板.
    let dynamic_template_generator = expand(s:dynamic_tpl_dir . "/full/" .filename)
    if executable(dynamic_template_generator)
        call Read_dynamic_template(dynamic_template_generator, filename)
        return
    endif

    " 再检查是否存在[普通的][后缀]匹配模板.
    let common_tpl_file = expand(s:common_tpl_dir . "/ext/" . extname)
    if filereadable(common_tpl_file)
        call Read_template_file(common_tpl_file)
        return
    endif

    " 最后检查是否存在[动态的][后缀]匹配模板.
    let dynamic_template_generator = expand(s:dynamic_tpl_dir . "/ext/" . extname)
    if executable(dynamic_template_generator)
        call Read_dynamic_template(dynamic_template_generator, filename)
        return
    endif
endfunction

function! Read_template_file(filename)
    silent execute "0r " . a:filename
endfunction

" 读取模板生成器动态生成的模板.
" generator参数指定生成器程序的路径.
" 同时还把文件名传递给生成器.
function! Read_dynamic_template(generator, filename)
    silent execute "0r !" . a:generator . " " . a:filename
endfunction
