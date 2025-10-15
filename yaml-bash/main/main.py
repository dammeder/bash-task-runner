import yaml 
import getpass
import random

with open("game_config.yml", "r") as f: 
    config = yaml.safe_load(f)

range_min = config['range']['min']
range_max = config['range']['max']
guesses_allowed = config['guesses']
mode = config['mode']

solved = False

if mode == "single":
    correct_number = random.randint(range_min, range_max)
elif mode == "multi": 
    correct_number = int(getpass.getpass("Playe 2 please enter number to guess:"))
else: 
    print("invalid")
    exit()

for i in range(guesses_allowed):

    guess = int(input("enter your guess: "))

    if guess == correct_number:

        print("correct")
        solved = True
        break
    elif guess < correct_number:
        print("Too low")
    else:
        print("too high")

if not solved:
    print("You lost")


