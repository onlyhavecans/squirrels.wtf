#Bunny LAZY!!!
pelican --debug --autoreload --output output --settings pelican.conf.py src &
cd output && python -m SimpleHTTPServer &
