#!/bin/bash

if [ ! -d log ]
then
	mkdir log
fi


process_memory(){
process=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])
for pid in $process
do
	name_process=$(ps -p $pid -o comm=)
	echo -n $(date +%F,%H:%M:%S,) >> log/$name_process.log
	size_process=$(ps -p $pid -o size | grep [0-9])
	echo "$(bc <<< "scale=2;$size_process/1024") MB" >> log/$name_process.log

done
}

process_memory
if [ $? -eq 0 ]
then
	echo "Os arquivos foram salvos"
else
	echo "Falha na hora de salvar os arquivos"
fi
