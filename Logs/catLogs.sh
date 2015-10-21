# Activate extr-globbing
shopt -s extglob

for file in $1?(\.[0-9])
do
        echo "catting $file"
        #cat $file | sed -n '1!G;h;$p' 
        cat $file | awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' 
done

# checkout le ls -v to have the numbers being sorted the right way !!
for file in `ls -v $1*.gz`
do
        echo "catting $file"
        #gzip -cd $file | sed -n '1!G;h;$p' 
        gzip -cd $file | awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
done
