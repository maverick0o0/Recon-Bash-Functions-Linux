function line(){
    #Read file from user input
    file=$1
    result=$(cat $file | wc -l)
    echo $result
}