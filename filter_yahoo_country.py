#!/usr/bin/env python3
import re

# === SETTINGS ===
ALLOWED_DOMAINS = ['.us', '.edu', '.gov']  # bisa tambah misal '.uk', '.ca', dll
TARGET_DOMAIN = '@yahoo.com'

def validate_email(email):
    return re.match(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$", email)

def filter_yahoo_emails(input_file, output_file):
    filtered_emails = []
    with open(input_file, 'r') as infile:
        for line in infile:
            email = line.strip()
            if validate_email(email) and email.endswith(TARGET_DOMAIN):
                # cek apakah domain akhir sesuai filter negara
                if any(email.endswith(dom) for dom in ALLOWED_DOMAINS) or ALLOWED_DOMAINS == []:
                    filtered_emails.append(email)
    with open(output_file, 'w') as outfile:
        for email in sorted(set(filtered_emails)):
            outfile.write(email + '\n')
    print(f"✅ Done! Filtered Yahoo emails (country locked) saved to {output_file}")

if __name__ == "__main__":
    print("🔍 Yahoo Email Filter Tool with Country Lock")
    print("Usage: python3 filter_yahoo_country.py <input_file> <output_file>")
