function jp
    curl -s "https://www.google.com/transliterate?langpair=en|ja&text=$argv[1]" | jq -r '.[0].hws | .[]' | fzf | wl-copy -n
end
