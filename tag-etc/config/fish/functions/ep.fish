# Defined in /var/folders/lz/1xf3qf1s1s9dd732yvyrdklh0000gq/T//fish.0EQNbo/ep.fish @ line 2
function ep --description 'Edit .plan'
    # TODO: This is fairly inefficent.  Very hacked together.  When I get some
    # time lets make this cleaner.
    git -C ~/Developer/jsatk.us pull

    # MM-DD-YYYY format of the current date.  i.e. September 07, 2020 would be 09-07-2020.
    set ymd (date "+%m-%d-%Y")
    # MM-DD-YYYY format of the last .plan update date.  i.e. September 07, 2020 would be 09-07-2020.
    set lastUpdatedDate (git -C ~/Developer/jsatk.us log -1 --pretty="format:%cd" --date=format:%m-%d-%Y content/dotplan.md)

    # MM format of Month.  i.e. September would be 09.
    set currentMonth (date "+%m")
    # MM format of Month.  i.e. September would be 09.
    set lastUpdatedMonth (string split - $lastUpdatedDate)[1]

    # If we've already updated our .plan this month then don't add month
    # to the TOC and don't create a header for today.
    if test "$currentMonth" = "$lastUpdatedMonth"
        echo "We've already updated this month."
        set cmd1 ""
    else
        echo "First update of the month."
        set -lx month (date "+%B")
        set -lx year (date "+%Y")
        set -lx lmonth (string lower "$month")
        set -lx lyear (string lower "$year")
        set cmd1 "normal! gg}}}}}O* [$month $year](#$lmonth-$year)"
    end

    # If we've already updated our .plan today then don't add datetime stamps
    # to the TOC and don't create a header for today.
    if test "$ymd" = "$lastUpdatedDate"
        echo "We've already updated this today."
        set cmd2 ""
        set cmd3 ""
        set cmd4 'exe "normal! Go\<esc>o\<esc>"'
    else
        echo "First update of the day."
        set cmd2 "normal! gg}}}}}O    * [$ymd](#$ymd)"
        set cmd3 'exe "normal! Go\<esc>o\<esc>"'
        set cmd4 "normal! i### $ymd"
    end

    nvim +Goyo -c "$cmd1" -c "$cmd2" -c "$cmd3" -c "$cmd4" ~/Developer/jsatk.us/content/dotplan.md
    git -C ~/Developer/jsatk.us commit -am "Update .plan"
    git -C ~/Developer/jsatk.us push
end
