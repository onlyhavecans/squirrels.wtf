#Bunny LAZY!!!
pelican --verbose --autoreload --output output --settings pelican.conf.py src &
cd output && python -m SimpleHTTPServer &
