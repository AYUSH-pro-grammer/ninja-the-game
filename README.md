# Ninja - The Game

My second Godot game :)

This is a small 2D ninja platform game in which you need to get to the trophy on each level while dodging enemies, traps, and other obstacles.

I have created this game and submitted as a part of **Hack Club - Phantom**.
This is my second game, so i have tried to make some improvements to the previous game.

<img width="573" height="329" alt="Screenshot 2026-10-07 at 12 58 23 AM" src="https://github.com/user-attachments/assets/7e5fc2f8-722c-4c31-83ec-41a7aa74cc3b" />




---

## How To Play

- ← → → for movement
- Space → jump
- Space again → double jump
- W → dash
- A → attack with ninja stars
- Get the trophy to complete the level
- After completing a level, you unlock the next level
- You can replay the levels which you have already completed

Try not to die lol 💀

<img width="576" height="320" alt="Screenshot 2026-10-07 at 1 00 25 AM" src="https://github.com/user-attachments/assets/8be2cfd2-9fb8-4127-8164-567376c5deba" />

---

## Features

- 2D platforming
- Double jump
- Dash
- Attack with ninja stars
- Enemies with patrolling and chasing logic
- Spikes, saws, and other traps
- Level completion mechanics
- Locked and unlocked levels
- Level complete screen
- Simple home, options and information screens

---

--- 
## GamwPlay

<img width="576" height="320" alt="Screenshot 2026-10-07 at 1 01 00 AM" src="https://github.com/user-attachments/assets/212e776a-5616-4d44-a8ee-a9b785ac5140" />


## Project Structure

Here are some of the most important files from the project:

```text
home.tscn / home.gd       → home screen
menu.tscn / menu.gd       → level selection screen
level0.tscn               → first level
level1.tscn               → second level
level2.tscn               → third level
main_character.gd         → character movement and abilities
enemy.gd                  → enemy behavior
ninja_star.gd             → ninja star
finish.tscn / finish.gd   → level completed screen
died.tscn                 → game over screen
GameManager.gd            → level unlocking progression
