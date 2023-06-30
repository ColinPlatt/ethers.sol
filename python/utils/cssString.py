from bs4 import BeautifulSoup

with open('../test/output/renderedSite_testing.html', 'r') as f:
    contents = f.read()

soup = BeautifulSoup(contents, 'html.parser')

style_tag = soup.find('style')

# Remove leading/trailing whitespace, newlines and extra spaces
style_string = style_tag.string.strip().replace('\n', '').replace('  ', ' ')

print(style_string)


