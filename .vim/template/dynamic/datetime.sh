#!/bin/bash
# 将时间函数作为共享使用
datetime_zh()
{
    WEEKDAYS=(星期日 星期一 星期二 星期三 星期四 星期五 星期六)
    WEEKDAY=$(date +%w)
    #DT="$(date +%Y年%m月%d日) ${WEEKDAYS[$WEEKDAY]}"
    YY=$(date +%Y)
    MN=$(date +%m)
    DN=$(date +%d)
    DT="$YY年$MN月$DN日 ${WEEKDAYS[$WEEKDAY]}"
    echo "$DT"
}
datetime_zh
export datetime_zh
