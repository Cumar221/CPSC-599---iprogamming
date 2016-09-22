//: [Back to page 2 of 3 ...](@previous)

//: ## Classes and Structures
//:

//: Write a class `IntegerStack` that represents a stack of integers, with push() and pop() methods.
//: _(7 points)_

    class IntegerStack {
        var nums = [Int]()
        
        func push(_ newNum: Int){
            nums.append(newNum)
        }
        func pop() -> Int{
            return nums.removeLast()
        }
    }

//: Test your IntegerStack class to show that it works

    var test = IntegerStack()
    test.push(1)
    print(test.nums[0])

//: Extend the `String` class to add the method `reverseWords()`. 
//:
//: You should then be able to get an output of `true` for the following input:
//:
//: `"mary had a little lamb".reverseWords() == "lamb little a had mary"`
//:
//: _(8 points)_

    extension String{
        func reverseWords() -> String{
            var words = self.characters.split(" ").map(String.init)
            words = words.reverse()
            let string = words.joinWithSeparator(" ")

            return string
            }
        }
        
     print("mary had a little lamb".reverseWords() == "lamb little a had mary")

    

//: Add a subclass of Vehicle called Car which implements makeNoise()
//:
//: Car should be initializable like this:
//:
//: `let car = Car(seats: 5)`
//: `car.motionType == Vehicle.MotionType.Driving`
//:
//: _(9 points)_

    class Vehicle {
        enum MotionType { case Driving, Flying, Sailing }

        let motionType: MotionType

        init(motionType: MotionType) {
            self.motionType = motionType
        }

        func makeNoise() {
            // Nothing here yet
        }
    }

    class Car: Vehicle{
        var seats : Int  = 0
        
        init(motionType: MotionType, seats: Int){
            self.seats = seats
            super.init(motionType : motionType)
        }
        convenience init(seats:Int){
            self.init(motionType: .Driving, seats: seats)
        }
        override func makeNoise(){
            print("can't cant me!!!!")
        }
    }
    
    let car = Car(seats: 5)
    car.motionType == Vehicle.MotionType.Driving
    
//: [You are done! Return to first page ...](Overview)
