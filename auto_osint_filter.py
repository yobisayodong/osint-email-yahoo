#!/usr/bin/env python3
import subprocess
import re
import time

# === SETTINGS ===
TARGET_DOMAIN = "yahoo.com"
ALLOWED_DOMAINS = ['.us', '.edu', '.gov']
OUTPUT_FILE = "yahoo_clean_auto.txt"

def run_theHarvester(target_domain):
    print(f"🚀 [1/2] Running theHarvester for {target_domain}...")
    start = time.time()
    raw_file = "hasil_raw.txt"
    with open(raw_file, "w") as outfile:
        process = subprocess.Popen(["python3", "theHarvester.py", "-d", target_domain, "-b", "all"], stdout=outfile)
        while process.poll() is None:
            print("⏳ Scraping emails... please wait...")
            time.sleep(3)
        end = time.time()
    print(f"✅ theHarvester done in {round(end-start,2)} sec. Raw results saved to {raw_file}.")
    return raw_file

def validate_email(email):
    return re.match(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$", email)

def filter_emails(input_file, output_file):
    print("🚀 [2/2] Filtering Yahoo emails (with country lock)...")
    start = time.time()
    filtered_emails = []
    total = 0
    with open(input_file, 'r') as infile:
        lines = infile.readlines()
        for idx, line in enumerate(lines):
            total += 1
            email = line.strip()
            if validate_email(email) and email.endswith('@yahoo.com'):
                if any(email.endswith(dom) for dom in ALLOWED_DOMAINS) or ALLOWED_DOMAINS == []:
                    filtered_emails.append(email)
            if idx % 50 == 0 and idx > 0:
                print(f"📊 Processed {idx}/{len(lines)} lines...")
    with open(output_file, 'w') as outfile:
        for email in sorted(set(filtered_emails)):
            outfile.write(email + '\n')
    end = time.time()
    print(f"✅ Filtering done in {round(end-start,2)} sec. Total processed: {total}. Saved to {output_file}.")

if __name__ == "__main__":
    print("🔍 Auto OSINT + Yahoo Filter Script with Progress Bar")
    start_time = time.time()
    raw_file = run_theHarvester(TARGET_DOMAIN)
    filter_emails(raw_file, OUTPUT_FILE)
    end_time = time.time()
    print(f"🎯 ALL DONE! Total runtime: {round(end_time-start_time,2)} sec. Check the file: {OUTPUT_FILE}")
