
TOKEN='insertTokenHere'

while read -r link file #|| [[ -n $line ]] #In order to read the last line if it has no trailing EOL
do
#Create the correct option for curl ouput
FILE_NAME="-O" && [ $file ] && FILE_NAME="-o $file" 
#Move to a directory if needed, bail if it doesn't work
[ $2 ] && { cd $2; if [ $? -eq 0 ] ; then echo "moving to $2 ..." ; else exit 1 ; fi; }  
#Some output
echo "getting file at $link to $FILE_NAME"
#Actually doing th query
curl -s -w '%{http_code}\n' -H "Authorization: token $TOKEN" -H 'Accept: application/vnd.github.v3.raw' -L $link $FILE_NAME
#Come back...
[ $2 ] && { cd - > /dev/null; echo "moving back..."; }

done < $1
