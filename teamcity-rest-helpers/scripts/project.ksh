#
#
#

projects=(DepositRegistration Libra2 Libra2Administration LibraOpen)
PS3='Select teamcity project: '

select opt in "${projects[@]}"
do
    case $opt in
    *)
    echo "export TEAMCITY_PROJECT=$opt"
    break
    ;;
    esac
done

#
# end of file
#
