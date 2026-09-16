let fruits = ["Apple", "Banana", "Orange", "Mango", "Kiwi"]
print("e1. third fruit:", fruits[2])


//2
var favoriteNumbers: Set = [7, 13, 21, 192]
favoriteNumbers.insert(17)
print("e2. Favorite numbers:", favoriteNumbers)



//3
let languages = ["Python": 1991, "Java": 1995, "Swift": 2014]
print("e3. swift release year:", languages["Swift"]!)

//4
var colors = ["Red", "Blue", "Green", "Yellow"]
colors[1] = "Purple"
print("e4. Updated colors:", colors)

//1
let set: Set = [1, 2, 3, 4]
let set1: Set = [3, 4, 5, 6]
let set3 = set.intersection(set1)
print("m1. Intersection:", set3)


//2
var students = ["Askar": 85, "Vadim": 90, "Amir": 78]
students.updateValue(95, forKey: "Vadim")
print("m2. Updated students:", students)


//3
let fruits1 = ["apple", "banana"]
let fruits2 = ["cherry", "date"]
let fruits3 = fruits1 + fruits2
print("m3. Merged array:", fruits3)


//h1
var countries = ["Kazakhstan": 20600000, "Japan": 123700000, "Germany": 84000000]
countries.updateValue(67000000, forKey: "France")
print("h1. Updated countries:", countries)


//h2
let animals1: Set = ["cat", "dog"]
let animals2: Set = ["dog", "mouse"]
let union = animals1.union(animals2)
let finalSet = union.subtracting(animals2)
print("h2. final answ:", finalSet)


//h3
let grades = ["Askar": [85, 90, 78], "Vadim": [92, 88, 95], "Amirkhan": [75, 80, 82]]
print("h3. Vadim's second grade:", grades["Vadim"]![1])
