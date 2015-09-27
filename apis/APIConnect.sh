## Script to query the humhum MongoDB based ROR api hosting the data for the MSBIOSCREEN.
# Example of query:
# apimdbc -JTS '{"query":{"epicid":54},"fields":["_id","edss_numeric","sql_visitid"]}'

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
SOURCE_ID=
EXT_ID=
EX_VAR=

usage()
{
cat << EOF
Interaction Utility for the MSBioscreen mdb - v1.3

USAGE:
 -h display this help
 -V Verbose: print the curl command
 -E Example: Print an example record for this collection
 -J Parse the Jaaaaason
 -M In -J mode, mute the meta info and send the parsed JSON to stdout.
 -T Gimme some timing info only. Do not (yet!) work with -J
 
*** Choose max one amongst the following:
 -G [field filtering request] ONLY if you want to filter fields when displaying records. Default is display without filtering.
   ---> [field filtering request] ~ 'fields=["field_1","field2"]'
 -U [json] update the record
   ---> [json] ~ '{"epicid":3,"field1":new_value}'
 -S [json] Perform a search, with an optional filtering of result fields
   ---> [json] ~ '{"query":{"field1":{operator:[value1,value2]}},"fields":["field1","field2"]}'
        w/ operator ~ "\$in", "\$gt", "\$lt" ,...
 -C [json] Create a record
   ---> [json] ~ '{"field1":new_value,"field2":new_value}'
   
*** Optional arguments
 -i [source_id:external_identifier] provide the source/external identifiers of one ressource                            
 -c [collection] specify the collection (default is "visits")
 -u [url] change the url (defaut is the uat api)
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
             SOURCE_ID=sources/${OPTARG%:*}/
             EXT_ID=${OPTARG#*:}
             ;;    
         G)
             echo -e "-G option non supported anymore. Field filtering is supported only within a search.\nUse the -S option instead with the filed filtering."
             exit 1
	     ;;
	 U)
             API_METH='PUT'
             JSON_arg="-d '$OPTARG'"
             ;;
         S)
             EXT_ID='search'
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
             TIMING_arg='-s -w "Total Time: %{time_total} \n"'
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
	echo 'Fetching example ids ------------'
	JSON_arg="-d '{\"query\":{\"epicid\":{\"\$lt\":3}},\"fields\":[\"source_id\",\"external_identifier\"]}'"
        EXT_ID='search'
        API_METH='POST'
fi

cmd_string="curl -X $API_METH $MUTE_arg $TIMING_arg $JSON_arg $STATIC_OPTS -H '$API_AUTH' $JSON_parsing $API_URL$API_VER/${SOURCE_ID}${API_COLLECTION}/$EXT_ID $JSON_parsing_post"
if [ $VERBOSE ]
then
	echo "--- CURL COMMAND:"
	echo $cmd_string
	echo "------------------"
fi
bash -c "$cmd_string"

if [ $EX_VAR ]
then
	echo 'You can now get an example record by giving us the source_id and external id of your choice'
	read -p 'Source id >>' SID
	read -p 'External id >>' EID
	
fi


