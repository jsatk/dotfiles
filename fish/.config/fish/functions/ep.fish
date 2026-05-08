function ep --description 'Edit .plan — pulls, inserts today\'s heading if missing, opens nvim, then commits + pushes on close'
    set --local repo "$HOME/workspace/jesse-atkinson"
    set --local plan "$repo/.plan"

    if not test -d "$repo/.git"
        echo "ep: $repo is not a git repo" >&2
        return 1
    end
    if not test -f "$plan"
        echo "ep: $plan not found" >&2
        return 1
    end

    # Pull strict: abort before opening nvim if pull fails.
    if not git -C "$repo" pull
        echo "ep: git pull failed; not opening nvim" >&2
        return 1
    end

    # Two-pass awk: first pass detects which year/month/today headings already
    # exist; second pass rewrites the file inserting only the missing ones,
    # immediately before the trailing vim modeline. If today already exists,
    # the file is rewritten unchanged.
    set --local tmp (mktemp)
    awk \
        -v year=(date "+%Y") \
        -v month=(date "+%B") \
        -v today=(date "+%Y-%m-%d") \
        '
        NR == FNR {
            if ($0 == "## " year) has_year = 1
            else if ($0 == "### " month) has_month = 1
            else if ($0 == "#### " today) has_today = 1
            next
        }
        FNR == 1 {
            if (has_today)      block = ""
            else if (has_month) block = "#### " today "\n"
            else if (has_year)  block = "### " month "\n\n#### " today "\n"
            else                block = "## " year "\n\n### " month "\n\n#### " today "\n"
        }
        /^<!-- vim:/ && block != "" && !inserted {
            print block
            inserted = 1
        }
        { print }
        END {
            if (block != "" && !inserted) {
                print ""
                print block
            }
        }
        ' "$plan" "$plan" >"$tmp"
    and mv "$tmp" "$plan"

    nvim '+$' "$plan"

    # If the edit (or the heading insertion alone) produced changes, commit
    # and best-effort push. Push failures don't fail the function — the local
    # commit lands and you can push next time online.
    if not git -C "$repo" diff --quiet -- "$plan"
        git -C "$repo" commit -am "Update .plan"
        if not git -C "$repo" push
            echo "ep: git push failed (committed locally; push next time)" >&2
        end
    end
end
