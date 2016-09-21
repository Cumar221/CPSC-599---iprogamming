//: [Back to page 1 of 3 ...](@previous)
//: ## Functions & Closures
//:

    func calculator(a: Int, b: Int) -> Int {
        return a + b
    }
//: Call the `calculator()` function with 1 and 2
//: _(1 point)_
    let sum = calculator(1,b: 2)
//: Change `calculator` to return both a + b and a * b
//: _(2 points)_
    func calculator2(a: Int, b: Int) -> (sum:Int, mult:Int) {
        return (a + b, a * b)
    }
//: Write a function `average()` to calculate the average value of an Integer array.
//: _(2 point)_
    func average() -> Int{
        var sum = 0
        var avg = 0
        let numbers : [Int] = [1,2,4,5,]

        sum = numbers.reduce(0, combine: +)
        avg = sum/2
        
        return avg
    }
//: Write a function `greet` that takes an array of names (as strings) and a `greeter` function with signature String -> String, so that, for example, a call of `greet(["Alice", "Bob"], greeting: greeter)` prints "Hello, Alice!" and "Hello, Bob!".
//: _(6 points)_
    func greet(names: [String], greeting: String -> String){
        for name in names{
                print(greeting(name))
        }
    }

   func greeter(namez: String) -> String{
        return "Hello, \(namez)!"
    }

    greet(["Alice", "Bob"], greeting: greeter)
//: Use the map function on the following array of numbers to create an array of strings with the respective lengths.
//: _(2 points)_
let primeNumbers = [2, 3, 5, 7, 11, 13]
let newArray = primeNumbers.map({"\($0)"})


//: Write a function `updateEntry` that receives an array of integers and a closure to change the value of each entry in the array to a new value.
//: _(5 points)_
//:
    func updateEntry( arr: [Int], changeFunc: Int -> Int) -> [Int]{
        var numbers: [Int] = []
        for x in arr{
            numbers.append(changeFunc(x))
       }
        return numbers ;
    }


//: Use the following code to see whether your implementation works.
//: _(1 point)_
//:
//: `let results = updateEntry(primeNumbers) { $0 * $0 }`
//: `print(results)`
    let results = updateEntry(primeNumbers) { $0 * $0 }
    print(results)
//: Create an enum of `TimeUnit` with appropriate values Second, Minute, Hour, Day and Week.
//: Add a method for converting between them, so that one could call:  `TimeUnit.Day.convertTo(TimeUnit.Hour) == 24.0`.
//: _(6 points)_
enum TimeUnit{
    case Second, Minute, Hour, Day, Week
}
//: [To page 3 of 3 ...](@next)
