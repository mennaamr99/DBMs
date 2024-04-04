db_user="UNIVERSITY"
db_password="123"
db_name="xe"

backup_dir="my_backup_dir"          	# Which is created by the user in the above lines.
timestamp=$(date +"%y_%m_%d_%h_%m_%s")
backup_file="$db_name"_"$timestamp.dmp"

expdp ${db_user}/${db_password}@${db_name} \
  directory=DATA_PUMP_DIR  \
  dumpfile=${backup_file} \
  schemas=UNIVERSITY

