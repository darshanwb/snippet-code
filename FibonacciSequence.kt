fun fibonacci(n: Int): Int {
    // Initialize an array to keep track of results of subproblems
    // We'll use 0 as the placeholder initial value
    val results = Array(n + 1) { 0 }
    // Set the base cases
    results[1] = 1
    results[2] = 1
    for (i in 3..n) {
        results[i] = results[i-1] + results[i-2]
    }
    return results[n]
}
