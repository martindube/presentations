#!/usr/bin/python3 

import json
import random
import copy

def get_gaps_color(score):
  if score == 0:
    return '#dddddd'
  elif score == 1:
    return '#32e379'
  elif score == 2:
    return '#f5cb1b'
  elif score == 3:
    return '#f5881b'
  elif score == 4:
    return '#f16e6e'

def generate_gaps_map(data, out_file, p=[0, 0.5, 0.2, 0.2, 0.1]):
  my_data=copy.deepcopy(data)

  i=0
  for t in my_data['techniques']:
    i=i+1

    if t['score'] == 1:
      #score = random.randint(1,4)
      score = random.choices(range(0,5), p)[0]
      t['score'] = score
      t['color'] = get_gaps_color(score)

  my_data['legendItems'] = [
    {
      "label": "Not tested (0)",
      "color": "#dddddd"
    },    
    {
      "label": "Tested and compliant (1)",
      "color": "#32e379"
    },
    {
      "label": "Tested and 1pts gap (2)",
      "color": "#f5cb1b"
    },
    {
      "label": "Tested and 2pts gap (3)",
      "color": "#f5881b"
    },
    {
      "label": "Tested and 3pts gap (4)",
      "color": "#f16e6e"
    }
  ]

  # Save
  with open(out_file, 'w') as json_file:
    json.dump(my_data, json_file)
    print('Saved %i techniques in %s' % (i,out_file))



def main():
  with open('data/default.json') as f:
    data = json.load(f)
    generate_gaps_map(data, 'data/gaps.json')
    generate_gaps_map(data, 'data/sophistication1.json', p=[0, 0.8, 0.1, 0.05, 0.05])
    generate_gaps_map(data, 'data/sophistication2.json', p=[0.2, 0.4, 0.2, 0.1, 0.1])
    generate_gaps_map(data, 'data/sophistication3.json', p=[0.4, 0.2, 0.2, 0.2, 0.2])

if __name__ == "__main__":
  main()