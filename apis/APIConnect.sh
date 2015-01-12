#!/bin/sh

STATIC_OPTS="-H 'Content-Type:application/json'"
API_URL='https://msbioscreen.herokuapp.com/api/'
API_VER='v1'
API_AUTH='Authorization: Token token="53f3b31a96268f04fdc20f636c2ed33c"'
API_METH='GET'
API_COLLECTION='visits'
JSON_parsing=
JSON_parsing_post=
JSON_arg=
TIMING_arg=
ID=
EX_VAR=

usage()
{
cat << EOF
Interaction Utility for the MSBioscreen mdb - v1.2

USAGE:
 -h display this help
 -V Verbose: print the curl command
 -E Example: Print an example record for this collection
 -J Parse the Jaaaaason
 -M In -J mode, mute the meta info and send the parsed JSON to stdout.
 -T Gimme some timing info only. Do not (yet!) work with -J
 
*** Choose max one amongst the following:
 -G [field filtering request] ONLY if you want to filter fields when displaying records. Default is display without filtering.
   ---> [field filtering request] ~ 'fields:["field_1","field2"]'
 -U [json] update the record
   ---> [json] ~ '{"epicid":3,"field1":new_value}'
 -S [json] Perform a search, with an optional filtering of result fields
   ---> [json] ~ '{"query":{"field1":{operator:[value1,value2]}},"fields":["field1","field2"]}'
        w/ operator ~ "\$in", "\$gt", "\$lt" ,...
 -C [json] Create a record
   ---> [json] ~ '{"field1":new_value,"field2":new_value}'
   
*** Optional arguments
 -i [idkey] provide the id key of one ressource                            
 -c [collection] specify the collection (default is "visits")
 -u [url] change the url (defaut is the api)
 -v [version] change the version of the api (default is v1)
 -t [token_string] change the authentication token (default is for Antoine Lizee) 
  
EOF
}

opt_str='hEVJMTu:v:j:i:G:U:S:C:t:c:'

while getopts $opt_str OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         u)
             API_URL=$OPTARG
             ;;
         v)
             API_VER=$OPTARG
             ;;
         i)
             ID=$OPTARG
             ;;    
         G)
	     API_METH='GET -G'
	     JSON_arg="-d '$OPTARG'"
	     ;;
	 U)
             API_METH='PUT'
             JSON_arg="-d '$OPTARG'"
             ;;
         S)
             ID='search'
             API_METH='POST'
             JSON_arg="-d '$OPTARG'"
             ;;
         C)
	     API_METH='POST'
	     JSON_arg="-d '$OPTARG'"
	     ;;
	 t)
             API_AUTH='-H Authorization: Token token="'$OPTARG'"'
             ;;
         c)
             API_COLLECTION=$OPTARG
             ;;
         J)
             JSON_parsing='-o >(python -mjson.tool)'
             ;;
         M)
             MUTE_arg='-s'
             JSON_parsing_post='| python -mjson.tool'
             ;;
         T)
             TIMING_arg='-s -w "Total Time: %{time_total} \n" -o /dev/null'
             ;;
         V)
             VERBOSE=1
             ;;
         E)
             EX_VAR=1
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [ $EX_VAR ]
then
	echo 'Fetching example ------------'
	JSON_arg="-d '{\"query\":{\"epicid\":{\"\$lt\":15}},\"fields\":\"_id\"}'"
	ID=$(bash -c "curl -X POST -s $JSON_arg $STATIC_OPTS -H '$API_AUTH' $API_URL$API_VER/$API_COLLECTION/search | python -mjson.tool | grep -m 1 _id | cut -d ':' -f 2 | cut -d '\"' -f 2")
	bash -c "curl -X GET -s $TIMING_arg $STATIC_OPTS -H '$API_AUTH' $API_URL$API_VER/$API_COLLECTION/$ID | python -mjson.tool"
	exit 1
fi

if [ -z $ID ] && [ "$API_METH" = 'GET' ]
then
	echo 'You are asking to get a complete collection, please provide an ID (-i [ID]) or a filtering request (-G []). See -h for more help.'
	exit 1
fi

cmd_string="curl -X $API_METH $MUTE_arg $TIMING_arg $JSON_arg $STATIC_OPTS -H '$API_AUTH' $JSON_parsing $API_URL$API_VER/$API_COLLECTION/$ID $JSON_parsing_post"
if [ $VERBOSE ]
then
	echo "--- CURL COMMAND:"
	echo $cmd_string
	echo "------------------"
fi
bash -c "$cmd_string"
#eval "$cmd_string"
#$($cmd_string)



