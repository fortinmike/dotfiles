# ----> .NET Config

source dnvm.sh # dnvm must be installed through Homebrew for this to work
export MONO_MANAGED_WATCHER=disabled

code () {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        open -a "Visual Studio Code" --args "$F"
    fi
}
