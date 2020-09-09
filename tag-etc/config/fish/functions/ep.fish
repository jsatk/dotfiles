# Defined in /var/folders/d6/55nbd6lj26952tnnxgbmydqdmrmpnd/T//fish.KFf3Ng/ep.fish @ line 2
function ep --description 'Edit .plan'
    # Path to repo.
    set --local repo "$HOME/Developer/jsatk.us"
    # Path to dotplan relative to internal to the repo.
    set --local dotplan "content/dotplan.md"

    # Fetch latest before getting started.
    git -C $repo pull

    # MM-DD-YYYY date format.
    set --local date_format "%m-%d-%Y"
    # MM-DD-YYYY format of the current date.
    # i.e. September 07, 2020 would be 09-07-2020.
    set --local mmddyyyy (date "+$date_format")
    # MM-DD-YYYY format of the last .plan update date.
    # i.e. September 07, 2020 would be 09-07-2020.
    set --local last_updated_date (
        git -C $repo log -1 --pretty="format:%cd" --date=format:$date_format $dotplan
    )

    # MM format of Month.
    # i.e. September would be 09.
    set --local current_month (date "+%m")
    # MM format of Month.
    # i.e. September would be 09.
    set --local last_updated_month (string split - $last_updated_date)[1]

    # If we've already updated our .plan this month then don't add the month
    # to the TOC and don't create a header for today.
    if test "$current_month" = "$last_updated_month"
        echo "📣 We've already updated this month."
        set cmd1 ""
    else
        echo "📣 First update of the month."
        set --local month (date "+%B")
        set --local year (date "+%Y")
        set --local lmonth (string lower "$month")
        set --local lyear (string lower "$year")

        # Detailing what this does for those that may be less comfortable with
        # vim syntax.
        #
        #     `normal!` means everything that comes after this (following a
        #     space) is to be entered as if this series of keys were pressed in
        #     normal mode.
        #
        #     gg    - Go to top of file.
        #     }}}}} - Jump down for blocks/paragraphs.
        #     O     - Create a new line above where we are and enter insert mode.
        #
        #     The text following "O" is literally typed in with
        #     the variables being expended.
        #     i.e. * [September 2020](september-2020)
        set cmd1 "normal! gg}}}}}O* [$month $year](#$lmonth-$year)"
    end

    # If we've already updated our .plan today then don't add datetime stamps
    # to the TOC and don't create a header for today.
    if test "$mmddyyyy" = "$last_updated_date"
        echo "📣 We've already updated this today."
        set cmd2 ""
        set cmd3 ""

        # Detailing what this does for those that may be less comfortable with
        # vim syntax.
        #
        #     `exe` executes the string that results from the evaluation
        #      of {expr1} as an Ex command.
        #
        #     `normal!` means everything that comes after this (following a
        #     space) is to be entered as if this series of keys were pressed in
        #     normal mode.
        #
        #     G      - Go to bottom of file.
        #     o      - Insert new line below and enter insert mode.
        #     \<esc> - Exit insert mode (i.e. literally press Esc key).
        #     o      - Insert new line below and enter insert mode.
        #     \<esc> - Exit insert mode (i.e. literally press Esc key).
        set cmd4 'exe "normal! Go\<esc>o\<esc>"'
    else
        echo "📣 First update of the day."

        # Detailing what this does for those that may be less comfortable with
        # vim syntax.
        #
        #     `normal!` means everything that comes after this (following a
        #     space) is to be entered as if this series of keys were pressed in
        #     normal mode.
        #
        #     gg    - Go to top of file.
        #     }}}}} - Jump down for blocks/paragraphs.
        #     O     - Create a new line above where we are and enter insert mode.
        #
        #     The text following "O" is literally typed in with
        #     the variables being expended.
        #     i.e. * [09-07-2020](09-07-2020)
        set cmd2 "normal! gg}}}}}O    * [$mmddyyyy](#$mmddyyyy)"

        # Detailing what this does for those that may be less comfortable with
        # vim syntax.
        #
        #     `exe` executes the string that results from the evaluation
        #      of {expr1} as an Ex command.
        #
        #     `normal!` means everything that comes after this (following a
        #     space) is to be entered as if this series of keys were pressed in
        #     normal mode.
        #
        #     G      - Go to bottom of file.
        #     o      - Insert new line below and enter insert mode.
        #     \<esc> - Exit insert mode (i.e. literally press Esc key).
        #     o      - Insert new line below and enter insert mode.
        #     \<esc> - Exit insert mode (i.e. literally press Esc key).
        set cmd3 'exe "normal! Go\<esc>o\<esc>"'

        # Detailing what this does for those that may be less comfortable with
        # vim syntax.
        #
        #     `normal!` means everything that comes after this (following a
        #     space) is to be entered as if this series of keys were pressed in
        #     normal mode.
        #
        #     i - Enter insert mode.
        #
        #     The text following "i" is literally typed in with
        #     the variables being expended.
        #     i.e. ### 09-07-2020
        set cmd4 "normal! i### $mmddyyyy"
    end

    # Open nvim and run the commands before dropping us into editing our .plan.
    nvim +Goyo \
        -c "$cmd1" \
        -c "$cmd2" \
        -c "$cmd3" \
        -c "$cmd4" \
        "$repo/$dotplan"

    # Commit & push the latest update to our .plan.
    git -C $repo commit -am "Update .plan"
    git -C $repo push
end
