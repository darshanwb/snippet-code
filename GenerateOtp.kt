// Main Function
fun main() {
    var getOtp=generateOTP()
    println("Your OTP is : $getOtp")
}

// Function For New OTP Generate
fun generateOTP(): String {
    val otp = (1000..9999).random()
    return otp.toString()
}
