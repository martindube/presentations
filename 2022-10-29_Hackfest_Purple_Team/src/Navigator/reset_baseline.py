#!/usr/bin/python3 

# Fail safe
exit(1)

import json

# Import
with open('data/baseline.json') as f:
  data = json.load(f)

  # Process
  i=0
  data['name'] = ''
  data['description'] = ''
  for t in data['techniques']:
    i=i+1

    t['color'] == None
    t['comment'] = ''

    if t['score'] > 0:
      t['score'] = 1


print('Reseted %i techniques' % i)

# Save
with open('data/default.json', 'w') as json_file:
  json.dump(data, json_file)
