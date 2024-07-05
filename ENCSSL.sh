#!/bin/bash

# Function to encrypt a file
encrypt_file() {
    local input_file="$1"
    local output_file="$2"
    local key="$3"
    
    # Generate a random IV (Initialization Vector)
    local iv=$(openssl rand -hex 16)
    
    # Encrypt the input file using AES-256-CBC
    openssl enc -aes-256-cbc -K "$key" -iv "$iv" -in "$input_file" -out "$output_file"
    
    # Save IV to a separate file (if needed)
    echo "$iv" > "${output_file}.iv"
}

# Function to decrypt a file
decrypt_file() {
    local input_file="$1"
    local output_file="$2"
    local key="$3"
    local iv_file="${input_file}.iv"
    
    # Read IV from the IV file
    local iv=$(cat "$iv_file")
    
    # Decrypt the input file using AES-256-CBC
    openssl enc -d -aes-256-cbc -K "$key" -iv "$iv" -in "$input_file" -out "$output_file"
    
    # Remove IV file (clean up)
    rm "$iv_file"
}
clear
# Prompt user for input file, output file, and password
read -p "Input file: " input_file
read -p "Output file: " output_file
read -p "Password: " password

# Example usage:
if [[ ! -f "$input_file" ]]; then
    echo "Error: Input file '$input_file' not found."
    exit 1
fi

if [[ -f "$output_file" ]]; then
    read -p "Output file '$output_file' already exists. Overwrite? (y/n): " overwrite_confirm
    if [[ "$overwrite_confirm" != "y" ]]; then
        echo "Operation aborted."
        exit 1
    fi
fi

# Convert password to hexadecimal representation (optional)
key=$(echo -n "$password" | openssl dgst -hex -sha256 | cut -d ' ' -f 2)

# Perform encryption or decryption based on user input
echo -e ""
read -p "(enc/dec) ?? : " operation

case "$operation" in
    enc)
        encrypt_file "$input_file" "$output_file" "$key"
        echo "File encrypted successfully."
        ;;
    dec)
        decrypt_file "$input_file" "$output_file" "$key"
        echo "File decrypted successfully."
        ;;
    *)
        echo "Unknown operation. Use 'enc' or 'dec'."
        exit 1
        ;;
esac
clear
echo -e "\e[93;1mOutput saved to\e[92;1m '$output_file'. \e[0m"

