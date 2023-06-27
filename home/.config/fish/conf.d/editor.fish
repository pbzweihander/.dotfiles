# editor
if type -q helix
    set -gx EDITOR helix
else if type -q vim
    set -gx EDITOR vim
end
