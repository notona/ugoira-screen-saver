import re
import json
import urllib.request
import io
import os
import zipfile
import sys

def requestSourceServerResource(url):
    req = urllib.request.Request(url)
    req.add_header('Referer', 'http://www.pixiv.net')
    response = urllib.request.urlopen(req)
    return response.read()

#url = "http://www.pixiv.net/member_illust.php?mode=medium&illust_id=44304107"
url = "http://www.pixiv.net/member_illust.php?mode=medium&illust_id=44426877"

if (len(sys.argv) == 2):
    url = "http://www.pixiv.net/member_illust.php?mode=medium&illust_id=" + sys.argv[1];

response = urllib.request.urlopen(url)
html = response.read().decode('utf-8')
#print(html)

pattern = re.compile(r'pixiv.context.ugokuIllustData  = (.+?);</script>')
matchObj = pattern.search(html)
ugoira_data_json_string =  matchObj.group(1)
#print(ugoira_data_json_string)

string_io = io.StringIO(ugoira_data_json_string);
json_data = json.load(string_io);

frames = json_data['frames']
for frame in frames:
    frame['file'] = 'ugoira_zip/' + frame['file']


f = open(os.path.abspath(os.path.dirname(__file__)) + '/ugoira_data.json', 'w')
output_json_string = json.dumps(json_data, sort_keys=True, indent=2)
print(output_json_string)
f.write('var hon_meta = ' + output_json_string)

zip_url = json_data['src']
zip_url_full_hd = zip_url.replace('ugoira600x600.zip', 'ugoira1920x1080.zip')
print(zip_url_full_hd)
zip_binary_data = requestSourceServerResource(zip_url_full_hd);
byte_io = io.BytesIO(zip_binary_data)

#bf = open('ugoira.zip', 'wb')
#bf.write(zip_binary_data)

#zipfile.read(p_binary_data);
zip_file = zipfile.ZipFile(byte_io, 'r');
zip_file.extractall(os.path.abspath(os.path.dirname(__file__)) + '/ugoira_zip');
