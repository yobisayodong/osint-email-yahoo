#!/usr/bin/env python3
import re

def validate_email(email):
    # Basic regex to validate email format
    return re.match(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$", email)

def filter_yahoo_emails(input_file, output_file):
    yahoo_emails = []
    with open(input_file, 'r') as infile:
        for line in infile:
            email = line.strip()
            if validate_email(email) and email.endswith('@yahoo.com'):
                yahoo_emails.append(email)
    with open(output_file, 'w') as outfile:
        for email in sorted(set(yahoo_emails)):
            outfile.write(email + '\n')
    print(f"✅ Done! Filtered Yahoo emails saved to {output_file}")

if __name__ == "__main__":
    print("🔍 Yahoo Email Filter Tool")
    print("Usage: python3 filter_yahoo.py <input_file> <output_file>")
