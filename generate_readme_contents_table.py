"""
This script automatically generates a table of contents for the README.md file in this repository.
It scans specific directories for markdown (.md) files, organizes them in alphanumeric order, and
creates markdown links pointing to each file within the GitHub repository.

### What the script does:
1. Scans the following directories:
   - 0_research
   - 1_azure_practicals
   - 2_aws_practical
   - script_reference
2. Filters for files with a .md extension.
3. Sorts the markdown files in alphanumeric order within each directory.
4. Generates a formatted table of contents with clickable links to each markdown file.
5. Updates the README.md file with the new table of contents.
"""
import os


# Base URL for the GitHub repository
base_url = "https://github.com/raiyans/tech264-cloud/blob/main/"

# List of directories to include in the table of contents
directories = [
    "0_research",
    "1_azure_practicals",
    "2_aws_practical",
    "script_reference"
]

# Prepare a list to store the markdown lines
markdown_lines = []

# Header for the table of contents
markdown_lines.append("# Table of Contents\n")
markdown_lines.append("Below is a list of all markdown files in this repository, contents generated and sorted from generate_readme_contents_table.py:\n")

# Function to create the markdown links
def create_markdown_link(directory, filename):
    return f"- [{filename}]({base_url}{directory}/{filename})"

# Iterate through each directory
for directory in directories:
    markdown_lines.append(f"## {directory.replace('_', ' ').title()}\n")
    
    # Get all files in the directory and filter only markdown files
    md_files = [filename for filename in os.listdir(directory) if filename.endswith('.md')]
    
    # Sort files alphanumerically
    md_files.sort()
    
    # Add each markdown file to the list
    for filename in md_files:
        markdown_lines.append(create_markdown_link(directory, filename))
    
    markdown_lines.append("\n")

# Write the markdown content to the README.md file
with open("README.md", "w") as readme_file:
    readme_file.write("\n".join(markdown_lines))

print("README.md tc")