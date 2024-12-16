# 2D Car Driving Simulation Game in x86 Assembly

This project demonstrates a **2D Car Driving Simulation Game** created using **Assembly language**. The objective of the game is to control a car using arrow keys, avoid obstacles (represented by holes), and survive while the hole speed increases with the difficulty level.

## Features:

- **Controls**: The car is controlled using the **arrow keys**.
- **Obstacles**: Avoid holes that appear in the lanes. The player has a health value of **5**.
- **Difficulty Levels**: The game has two difficulty modes: **Easy** and **Hard**. The speed of the obstacles increases in **Hard** mode.
- **Health**: The player starts with 5 health points, which are lost if they hit an obstacle.

## Python Script for Image Conversion:

This project also includes a **Python script** to convert images into **Assembly arrays**. The script uses the default **VGA 256-color palette** to convert the colors in the image into the corresponding colors in the palette, making it easier to use images in the game.

### How to Use the Image Converter Script:

1. **Clone the repository** to your local machine.
2. Run the Python script to convert your image into an Assembly array. The script takes an image as input and generates an array that can be directly used in the Assembly code.
3. The script ensures that the colors of the image are mapped to the 256-color VGA palette, which is compatible with the game's graphics.

## Video:

Check out the video representing this project, which includes a demo of the game and a walkthrough of the code:  
**[Watch the video](https://youtu.be/NkLQzTs90e4)**

## Installation:

1. Clone the repository:
   ```
   git clone https://github.com/pr0G-alt/driving-car-asm.git
   ```
2. To run the game, use an **Assembly compiler** (TASM or similar).
3. Compile the provided `main.asm` file.
4. Run the generated `main.exe` to play the game.

## Team:

- **[Youssef Tawakal](https://www.linkedin.com/in/yousseftawakal/)**
- **[Saleh Mostafa](https://www.linkedin.com/in/saleh-mostafa-286606263/)**
- **[Salah ElSaadawy](https://www.linkedin.com/in/salah-tamer/)**
