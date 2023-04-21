import Cocoa

var itemPrices = [ 100.0, 12.6, 19.3, 55.5, 70.0, 44.4, 39.99]
let totalAmount = itemPrices.reduce(0) { $0 + $1 }
let discountPercentage = 2.0

let discountType = [
    "Default" : 5.0,
    "National Day" : 10.0,
    "Black Friday" : 15.0,
    "New Year" : 20.0
]
var discountedAmount = 0.0
var totalAmountAfterDiscount = 0.0

//var discountedAmount = totalAmount * (discountPercentage / 100)
//var totalAmountAfterDiscount = totalAmount - discountedAmount


//------------ Assignment 1 ------------

func applyDiscount(on totalAmount: Double, discountPercentage: Double) -> Double {
    discountedAmount = totalAmount * (discountPercentage / 100)
    totalAmountAfterDiscount = totalAmount - discountedAmount
    return totalAmountAfterDiscount
}

totalAmountAfterDiscount = applyDiscount(on: totalAmount, discountPercentage: 5)

//------------ Assignment 2 ------------

func applyDiscount(totalAmount: Double, discountPercentage: Double = 10.0) -> Double {
    discountedAmount = totalAmount * (discountPercentage / 100)
    totalAmountAfterDiscount = totalAmount - discountedAmount
    return totalAmountAfterDiscount
}

totalAmountAfterDiscount = applyDiscount(totalAmount: totalAmount)

//------------ Assignment 3 ------------

typealias ApplyDiscountType = (Double, String) -> Double

func calculateAmountForDiscountType(on totalAmount: Double, type: String) -> Double {
    guard let discountPercentage = discountType[type] else { return 0.0 }
    discountedAmount = totalAmount * (discountPercentage / 100)
    totalAmountAfterDiscount = totalAmount - discountedAmount
    return totalAmountAfterDiscount
}

func printDiscount(using calculate: ApplyDiscountType) {
    discountType.forEach { discountType, _ in
        print("Discount Type : \(discountType), \t totalAmountAfterDiscount: \(calculate(totalAmount, discountType))")
    }
}

printDiscount(using: calculateAmountForDiscountType)

//------------ Assignment 4 ------------

let closureCalculateAmountForDiscountType = { (totalAmount: Double, type: String) in
    if let discountPercentage = discountType[type] {
        discountedAmount = totalAmount * (discountPercentage / 100)
        totalAmountAfterDiscount = totalAmount - discountedAmount
        print("Discount Type : \(type), \t totalAmountAfterDiscount: \(totalAmountAfterDiscount)")
    }
}

discountType.forEach {
    closureCalculateAmountForDiscountType(totalAmount, $0.key)
}

//------------ Assignment 5 ------------

itemPrices.map { price in
    print("Old price : \(price), \tNew price : \(price + price * 0.5)")
}

//------------ Assignment 6 ------------

let sortedDiscountType = discountType.sorted {
    $0.value > $1.value
}
print(sortedDiscountType)

//------------ Assignment 7 ------------
/*
enum DiscountType: String {
    case defaultDiscount = "Default"
    case nationalDay = "National Day"
    case blackFriday = "Black Friday"
    case newYear = "New Year"
}

let newDiscountType = [
    DiscountType.defaultDiscount : 5.0,
    DiscountType.nationalDay : 10.0,
    DiscountType.blackFriday : 15.0,
    DiscountType.newYear : 20.0
]

func printDiscount(type: DiscountType) {
    switch type {
    case .defaultDiscount :
        print("Discount Value : \(newDiscountType[type] ?? 0) ")
    case .nationalDay :
        print("Discount Value : \(newDiscountType[type] ?? 0)")
    case .blackFriday :
        print("Discount Value : \(newDiscountType[type] ?? 0)")
    case .newYear :
        print("Discount Value : \(newDiscountType[type] ?? 0)")
    }
}

printDiscount(type: .blackFriday)
printDiscount(type: .defaultDiscount)
printDiscount(type: .nationalDay)
printDiscount(type: .newYear)

*/

//------------ Assignment 7  Again ------------

enum DiscountType: Double, CaseIterable {
    case defaultDiscount = 15.0
    case nationalDay = 5.0
    case blackFriday = 10.0
    case newYear = 20.0
}

func printDiscount(type: DiscountType) {
    switch type {
    case .defaultDiscount:
        print(type.rawValue)
    case .nationalDay:
        print(type.rawValue)
    case .blackFriday:
        print(type.rawValue)
    case .newYear:
        print(type.rawValue)
    }
}

printDiscount(type: .blackFriday)
printDiscount(type: .defaultDiscount)
printDiscount(type: .nationalDay)
printDiscount(type: .newYear)

//------------ Assignment 8 ------------
//------------ Assignment 9 ------------
//------------ Assignment 10 ------------
//------------ Assignment 11 ------------

protocol Discount {
    var discountType: DiscountType { get set }
    var discountPercentage: Double { get set }

    func applyDiscount() -> Double
}

class DataModel: Discount {
    var itemPrices = [ 100.0, 12.6, 19.3, 55.5, 70.0, 44.4, 39.99]
    var selectedItemPrices = [12.6, 19.3, 55.5]
    
    var totalAmount: Double {
        selectedItemPrices.reduce(0) { $0 + $1 }
    }
    
    var discountType = DiscountType.defaultDiscount
    var discountPercentage: Double = DiscountType.defaultDiscount.rawValue
    var discountedAmount: Double {
        totalAmount * (self.discountPercentage / 100)
    }
    
    lazy var maxDiscount = DiscountType.allCases.sorted { $0.rawValue > $1.rawValue }.first?.rawValue ?? 0.0
    
    var totalAmountAfterDiscount : Double {
        return totalAmount - discountedAmount
    }
    
    var currentDiscountedAmount : Double {
        return totalAmount - discountedAmount
    }
    
    func setDiscountType(type: DiscountType) {
        self.discountPercentage = type.rawValue
    }
    
    func applyDiscount() -> Double {
        return totalAmount - discountedAmount
    }
}

var model = DataModel()
model.setDiscountType(type: .newYear)

print("Current Discounted Amount : \(model.currentDiscountedAmount) as current Discount % is \(model.discountPercentage)")

print("Max Discount : \(model.maxDiscount)")
print("Method for discount : \(model.applyDiscount())")
print(model.totalAmountAfterDiscount)

//------------ Assignment 12 ------------

extension DataModel {
    var totalAmountAfterDiscountRounded : Double {
        totalAmountAfterDiscount.rounded()
    }
}

print(model.totalAmountAfterDiscount)
print(model.totalAmountAfterDiscountRounded)


//------------ Assignment 13 ------------



//------------ Assignment 14 ------------

let closureCalculateAmountForDiscountTypeV1 = { (totalAmount: Double, type: String) in
    if let discountPercentage = discountType[type] {
        discountedAmount = totalAmount * (discountPercentage / 100)
        totalAmountAfterDiscount = totalAmount - discountedAmount
        print("Discount Type : \(type), \t totalAmountAfterDiscount: \(totalAmountAfterDiscount)")
    }
}

let closureCalculateAmountForDiscountTypeV2: (Double, String) -> Void = {
    if let discountPercentage = discountType[$1] {
        print("Discount Type : \($1), \t totalAmountAfterDiscount: \($0 - ($0 * (discountPercentage / 100)))")
    }
}

discountType.forEach {
    closureCalculateAmountForDiscountTypeV1(totalAmount, $0.key)
}
discountType.forEach {
    closureCalculateAmountForDiscountTypeV2(totalAmount, $0.key)
}





