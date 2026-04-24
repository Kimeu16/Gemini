import os

path = r'c:\Apps\Leave Tracker\deploy-v2.ps1'
if not os.path.exists(path):
    print(f"Error: Path not found {path}")
    exit(1)

with open(path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Target line 1033 (0-indexed is 1032)
# We want to find '"@' regardless of where it is and force it to column 0
found = False
for i in range(len(lines)):
    if '"@' in lines[i] and (1000 < i < 1050):
        # Specific fix for the cleanup script terminator
        lines[i] = '"@\n'
        found = True
        print(f"Fixed terminator at line {i+1}")

if found:
    with open(path, 'w', encoding='utf-8', newline='') as f:
        f.writelines(lines)
    print("Script repaired successfully.")
else:
    print("Could not find the problematic terminator in the expected range.")
