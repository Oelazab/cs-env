#!/bin/bash

# Lab 1 - Setup Script
# Creates directory structure and sample files for introductory Linux commands lab
# Authors: Marwa M. El-Azab, Omar M. El-Azab

LAB_DIR="linux_lab1"

create_directories() {
    echo "Creating directory structure..."
    sudo mkdir -p "$LAB_DIR"/{documents,backups,logs,temp}
    sudo mkdir -p "$LAB_DIR"/documents/{personal,work,school}
    sudo mkdir -p "$LAB_DIR"/backups/system/{daily,weekly,monthly}
}

create_sample_files() {
    echo "Creating sample files..."
    
    # Personal documents
    touch "$LAB_DIR"/documents/personal/{notes.txt,todo.list,contacts.csv}
    echo "This is a sample text file." > "$LAB_DIR"/documents/personal/notes.txt
    
    # Work documents
    touch "$LAB_DIR"/documents/work/{report.docx,meeting_notes.txt,project1}
    printf "Line 1\nLine 2\nLine 3" > "$LAB_DIR"/documents/work/meeting_notes.txt
    
    # School documents
    touch "$LAB_DIR"/documents/school/{assignment1.sh,lecture_notes.txt}
    
    # Log files
    touch "$LAB_DIR"/logs/{system.log,error.log,access.log}
    echo "Error: something went wrong" > "$LAB_DIR"/logs/error.log
    
    # Temp files
    touch "$LAB_DIR"/temp/{file1.tmp,file2.tmp,old_file.tmp}
    echo "Lorem ipsum dolor sit amet" > "$LAB_DIR"/temp/file1.tmp
    
    # Hidden files
    touch "$LAB_DIR"/.hidden_config
    touch "$LAB_DIR"/documents/.secret_notes
}

create_backup() {
    echo "Creating sample backup..."
    tar -czf "$LAB_DIR"/backups/system/daily/backup_$(date +%Y%m%d).tar.gz \
        -C "$LAB_DIR"/documents/work .
}

set_permissions() {
    echo "Setting file permissions..."
    chmod 600 "$LAB_DIR"/documents/.secret_notes
    chmod 644 "$LAB_DIR"/documents/personal/notes.txt
    chmod 755 "$LAB_DIR"/documents/school/assignment1.sh
}

main() {
    echo "Starting Linux Lab 1 environment setup"
    
    if [ -d "$LAB_DIR" ]; then
        echo "Warning: $LAB_DIR already exists. Overwriting contents."
        rm -rf "$LAB_DIR"
    fi
    
    create_directories
    create_sample_files
    create_backup
    set_permissions
    
    echo -e "\nLab environment setup complete in $LAB_DIR"
    echo "Directory structure created:"
    tree "$LAB_DIR" -L 2
}

main