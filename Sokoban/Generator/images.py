from os import system
from collections import namedtuple

    
for color_and_name in [('black', 'floor'), ('blue', 'wall')]:
    for size in [('40x40', ''), ('80x80', '@2x'), ('120x120', '@3x')]:
        command = 'magick -size ' + size[0] + ' canvas:' + color_and_name[0] + ' ' + color_and_name[1] + size[1] + '.png'
        print(command)
        if system(command) != 0:
            print('command failed. exiting')
            exit(1)
