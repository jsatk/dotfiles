function __compliance_packs_owners
    grep -hE '^owner:' ~/workspace/zenpayroll/packs/**/package.yml 2>/dev/null \
        | string replace -rf '^owner:\s*[\'"]?(.+?)[\'"]?\s*$' '$1' \
        | sort -u
end

complete -c compliance-packs -x -a '(__compliance_packs_owners)'
