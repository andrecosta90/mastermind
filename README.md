# mastermind
mastermind: code-breaking game for two players

## How to Run

To play the game, make sure you have Ruby installed on your system. Then, navigate to the directory containing the `main.rb` file and run the following command:

```bash
ruby main.rb
```

## How to Play
1. You will be prompted to choose whether you want to be the Codemaker or the Codebreaker.
1. If you choose to be the Codemaker, you will set a secret code for the Codebreaker to guess. The Codebreaker will utilize the [Knuth's algorithm](https://puzzling.stackexchange.com/questions/546/clever-ways-to-solve-mastermind) to generate guesses.
1. If you choose to be the Codebreaker, you will attempt to guess the secret code set by the Codemaker.
1. The game will continue for a specified number of rounds. After each guess, feedback will be provided to indicate how close the guess was to the secret code.
1. Keep playing until either the Codebreaker guesses the secret code correctly or the maximum number of rounds is reached.

Enjoy the game!