fun main() {
    val options = arrayOf("rock", "paper", "scissors")
    val computerChoice = options.random()
    print("Enter your choice (rock, paper, or scissors): ")
    val userChoice = readLine()?.toLowerCase()
    println("Computer chooses : $computerChoice")
    when (userChoice) {
        "rock", "paper", "scissors" -> {
            if (userChoice == computerChoice) {
                println("It's a tie!")
            } else if ((userChoice == "rock" && computerChoice == "scissors") ||
                       (userChoice == "paper" && computerChoice == "rock") ||
                       (userChoice == "scissors" && computerChoice == "paper")) {
                println("You win!")
            } else {
                println("Computer wins!")
            }
        }
        else -> println("Invalid choice!")
    }
}
