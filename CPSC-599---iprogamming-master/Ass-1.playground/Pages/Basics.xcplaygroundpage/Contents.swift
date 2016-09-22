//: [Back to Overview ...](@previous)
//:
//: ## Basics
//:
//: Declare a variable called 'string' that holds the value "This is my string!".
//: _(1 point)_
    var string : String  = "This is my string"

//: Print the length of variable 'string'.
//: _(1 point)_
    print(string.characters.count)
//: Print the first character in 'string'.
//: _(1 point)_
    print(String(string[string.startIndex.advancedBy(0)]))
    
//: Print the 9th character in 'string'
//: _(1 point)_
    print(String(string[string.startIndex.advancedBy(9)]))
//: Print the first 4 characters in 'string'.
//: _(2 points)_
    print(String(string.characters.prefix(4)))
//: Print the last 5 characters in 'string'.
//: _(2 points)_
    print(String(string.characters.suffix(5)))
//: Print the last 6 characters in 'string', but in reverse order.
//: _(2 points)_
    print(String(string.characters.suffix(6).reverse()))
//: Print the 3rd word in 'string'.
//: _(2 point)_
    print(String(string.characters.split(" ")[2]))
//: Create an array that contains "a", "b", "c", called 'myArray'.
//: _(1 point)_
    var myArray : [String] = ["a","b","c"]
//: Get the length of 'myArray'.
//: _(1 point)_
    myArray.count
//: Get the 2nd item in 'myArray'.
//: _(1 point)_
    myArray[2]
//: Print "long" if the length of 'myArray' is more than 5, else print "short".
//: _(2 point)_
    if(myArray.count > 5){
        print("long")
    }
    else{
        print("short")
    }
//: Print each element in 'myArray' on a line by itself.
//: _(2 point)_
    for index in myArray{
        print(index)
    }
//: Create a constant array called 'myStrings' that contains the strings: "these" "are" "my" "strings".
//: _(1 point)_
    let myStrings = ["these", "are", "my" ,"strings"]
//: Print the index of "my" in 'myStrings', if it is in the array
//: _(2 point)_
    var counter = 0
    for str in myStrings{
        if (str == "my"){
            print(counter)
        }
        counter++
    }
//: Print each key and value in the following dictionary. Sort your output alphabetically by the capital cities.
//: _(2 point)_
    let capitals = ["Israel": "Jerusalem", "Germany": "Berlin", "France": "Paris", "England": "London", "Canada": "Ottawa"]
    let sorted_capitals = capitals.sort({$0.1 < $1.1})

    
    for (country, capital_city) in sorted_capitals{
        print("The capital city of \(country) is \(capital_city)")
    }

//: Add "a" to the value in the key "hello" in this dictionary. You can only add one line of code!
//: _(2 point)_
    var someDictionary = ["hello": ["b", "c"]]
    someDictionary["hello"]?.insert("a", atIndex: 0)
    
    

//: [To page 2 of 3 ...](@next)
