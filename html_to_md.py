import os
import requests
from urllib.parse import urlparse
from html_to_markdown import convert


def url_to_markdown():
    # Ask user for input
    url = input("Enter URL: ").strip()
    folder_name = input("Enter folder name (e.g. firewalld): ").strip()

    try:
        # Fetch website
        response = requests.get(url)
        response.raise_for_status()
        html_content = response.text

        # Convert to Markdown
        markdown_content = convert(html_content)

        # Create folder if not exists
        os.makedirs(folder_name, exist_ok=True)

        # Create filename from URL path
        parsed_url = urlparse(url)
        file_name = parsed_url.path.strip("/").replace("/", "_")

        if not file_name:
            file_name = "index"

        file_path = os.path.join(folder_name, f"{file_name}.md")

        # Save file
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(markdown_content)

        print(f"\n✅ Markdown saved to: {file_path}")

    except Exception as e:
        print(f"\n❌ Error: {e}")


if __name__ == "__main__":
    url_to_markdown()
