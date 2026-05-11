function ep --description "Edit .plan — pulls, inserts today's heading if missing, opens nvim, then commits + pushes on close"
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

    # Two-pass awk: first pass scans for existing year/month/today entries in
    # both the Table of Contents and the body; second pass rewrites the file
    # inserting only the missing ones — TOC bullets appended after the last
    # existing TOC bullet, body headings inserted before the trailing vim
    # modeline. If everything already exists, the file is rewritten unchanged.
    set --local tmp (mktemp)
    awk \
        -v year=(date "+%Y") \
        -v month=(date "+%B") \
        -v today=(date "+%Y-%m-%d") \
        '
        BEGIN {
            lmonth = tolower(month)
            year_toc   = "* ["   year  "](#" year   ")"
            month_toc  = "  * [" month "](#" lmonth ")"
            day_toc    = "    * [" today "](#" today ")"
            year_body  = "## "   year
            month_body = "### "  month
            day_body   = "#### " today
        }
        NR == FNR {
            if ($0 == "## Table of Contents") in_toc = 1
            else if (in_toc && /^## /)        in_toc = 0
            if (in_toc) {
                if      ($0 == year_toc)  has_year_toc  = 1
                else if ($0 == month_toc) has_month_toc = 1
                else if ($0 == day_toc)   has_day_toc   = 1
                if (/^[ ]*\* /) last_toc_line = FNR
            } else {
                if      ($0 == year_body)  has_year_body  = 1
                else if ($0 == month_body) has_month_body = 1
                else if ($0 == day_body)   has_day_body   = 1
            }
            next
        }
        FNR == 1 {
            if      (has_day_toc)   toc_block = ""
            else if (has_month_toc) toc_block = day_toc "\n"
            else if (has_year_toc)  toc_block = month_toc "\n" day_toc "\n"
            else                    toc_block = year_toc "\n" month_toc "\n" day_toc "\n"

            if      (has_day_body)   body_block = ""
            else if (has_month_body) body_block = day_body "\n"
            else if (has_year_body)  body_block = month_body "\n\n" day_body "\n"
            else                     body_block = year_body "\n\n" month_body "\n\n" day_body "\n"
        }
        /^<!-- vim:/ && body_block != "" && !body_inserted {
            print body_block
            body_inserted = 1
        }
        { print }
        FNR == last_toc_line && toc_block != "" {
            printf "%s", toc_block
        }
        END {
            if (body_block != "" && !body_inserted) {
                print ""
                print body_block
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
