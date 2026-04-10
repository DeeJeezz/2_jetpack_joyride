# Jetpack Joyride

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/deejeezz/2_jetpack_joyride/deploy-itch.yml)
![GitHub Tag](https://img.shields.io/github/v/tag/deejeezz/2_jetpack_joyride)

https://20_games_challenge.gitlab.io/games/jetpack/

## Description

Jetpack Joyride is a side-scrolling endless mobile game from 2011. 
It only requires a single input button to control the player. 
The game is fairly complex overall, though the basic premise is very simple. 
The game came from the same studio that made Fruit Ninja.

The game features a character with a machine-gun jetpack. 
When holding the input, the player will rise (and destroy everything below!) 
When the input is released, the character will fall. 
The character can run on the ground if they reach the bottom of the screen.

This game featured many power-ups and special game modes. 
The difficulty rating is for the main game mechanic with simple obstacles. 
If you want to add more to the game, it will be more difficult and take longer to complete.

## Goal:
* Create a game world with a floor. The world will scroll from right to left endlessly.
* Add a player character that falls when no input is held, but rises when the input is held.
* Add obstacles that move from right to left. Feel free to make more than one type of obstacle.
	* Obstacles can be placed in the world using a script so the level can be truly endless.
	* Obstacles should either be deleted or recycled when they leave the screen.
* The score increases with distance. The goal is to beat your previous score, 
so the high score should be displayed alongside the current score.

## Stretch goal:

* Save the high score between play sessions.
* The jetpack is a machine gun! Add bullet objects that spew from your character when the input is held.
* Particle effects are a fun way to add game juice. Mess around with some here, 
making explosions or sparks when things get destroyed!
