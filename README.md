# AssemblyBattleship
A Simple Battleship game created in x8086 Assembly 

## 📋 User Manual

### :dart: Objective
The game generates a random battlefield grid for the player. Your mission is to locate and destroy all the hidden enemy ships. You are given a limited number of shots, which will vary depending on the chosen difficulty level. The game is played blindly, meaning the ships remain hidden until you discover them.

### :video_game: How to Play
1. **Navigate** the battlefield using the **arrow keys**.
2. The **asterisk (`*`)** character shows your current position on the grid.
3. Once you are confident about a location, press **ENTER** to fire a shot:
   - **“X”** indicates a hit.
   - **“_”** indicates a miss.

### 🏆 Winning & Losing
- The game ends if you run out of shots (loss) or if you destroy all ships on the battlefield (victory).
- The battlefield always contains **6 ships**, totaling **19 hits** required to win:
  - 1 Battleship
  - 1 Frigate
  - 2 Submarines
  - 2 Seaplanes

**Note**: Ships can be oriented in any direction **except diagonally**.

---

## ⚙️ Technical Information
This game is implemented in Assembly language. It uses keyboard input and basic terminal display for interaction. 

### 💻 Running the Game
Ensure you have an assembler (MASM/TASM) or an emulator (MASM/TASM in DOSBox) configured on your system.

---

## :hammer_and_wrench: Future Improvements
- Fix cursor character
- Improve visibility 

---

## 📄 License
This project is licensed under the GNU License.