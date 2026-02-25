#!/bin/bash
backup_dir="/path/to/backup"
source_dir="/path/to/source"
timestamp=$(date +"%Y%m%d%H%M%S")
tar -czf "$backup_dir/backup_$timestamp.tar.gz" "$source_dir"


One-line memory trick

🧠 tar = pack files
🧠 gz = shrink files

🎤 Interview one-liner

.tar is used for archiving multiple files, while .gz is used for compressing a single file. Combined as .tar.gz, they archive and compress together.


#!/bin/bash
source_dir="/path/to/source"
backup_dir="/path/to/backup"
timestamp=$(date "%Y%m%d%H%M%S")
tar -cvf "backup_$timestamp.tar.gz" "source_dir"