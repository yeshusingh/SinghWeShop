import Cocoa
import Foundation
import UIKit


//------------ Common Hardcoded Sample Data ------------

var itemPrices = [ 100.0, 12.6, 19.3, 55.5, 70.0, 44.4, 39.99]
let totalAmount = itemPrices.reduce(0) { $0 + $1 }

let discountType = [
    "Default" : 5.0,
    "National Day" : 10.0,
    "Black Friday" : 15.0,
    "New Year" : 20.0
]


//------------ Assignment 1 ------------

func applyDiscount(on totalAmount: Double, discountPercentage: Double) -> Double {
    let discount = totalAmount * (discountPercentage / 100)
    let amountAfterDiscount = totalAmount - discount
    return amountAfterDiscount
}

print("\nAssignment 1:  Function")
print("totalAmountAfterDiscount = ", applyDiscount(on: totalAmount, discountPercentage: 5))


//------------ Assignment 2 ------------

func applyDiscount(totalAmount: Double, discountPercentage: Double = 10.0) -> Double {
    let discount = totalAmount * (discountPercentage / 100)
    let amountAfterDiscount = totalAmount - discount
    return amountAfterDiscount
}

print("\nAssignment 2: Function Overloading")
print("totalAmountAfterDiscount = ", applyDiscount(totalAmount: totalAmount))


//------------ Assignment 3 ------------

typealias ApplyDiscountType = (Double, String) -> Double

func calculateAmountForDiscountType(on totalAmount: Double, type: String) -> Double {
    guard let discountPercentage = discountType[type] else { return totalAmount }
    let discount = totalAmount * (discountPercentage / 100)
    let amountAfterDiscount = totalAmount - discount
    return amountAfterDiscount
}

func printDiscount(using calculate: ApplyDiscountType) {
    for (type, _) in discountType {
        print("Discount Type : \(type), \t totalAmountAfterDiscount : \(calculate(totalAmount, type))")
    }
}

print("\nAssignment 3: typealias")
printDiscount(using: calculateAmountForDiscountType)


//------------ Assignment 4 ------------

let closureCalculateAmountForDiscountType = { (totalAmount: Double, type: String) in
    guard let discountPercentage = discountType[type] else {
        print("Discount Type : INVALID, \t totalAmountAfterDiscount: \(totalAmount)")
        return
    }
    
    let discount = totalAmount * (discountPercentage / 100)
    let amountAfterDiscount = totalAmount - discount
    print("Discount Type : \(type), \t totalAmountAfterDiscount: \(amountAfterDiscount)")
}

print("\nAssignment 4: Closure")
closureCalculateAmountForDiscountType(totalAmount, "Default")
closureCalculateAmountForDiscountType(totalAmount, "National Day")
closureCalculateAmountForDiscountType(totalAmount, "Black Friday")
closureCalculateAmountForDiscountType(totalAmount, "New Year")
closureCalculateAmountForDiscountType(totalAmount, "Random Discount Type")


//------------ Assignment 5 ------------

print("\nAssignment 5: Map")
itemPrices.map { price in
    print("Old price : \(price), \tNew price : \(price + price * 0.5)")
}


//------------ Assignment 6 ------------

let sortedDiscountType = discountType.sorted {
    $0.value > $1.value
}
print("\nAssignment 6: Sorted")
print("Sorted DiscountType Dictionary : ", sortedDiscountType)


//------------ Assignment 7 ------------

//Note: CaseIterable Protocol confromance added to enum as in Assignment 9 need to iterate over allCases
enum DiscountType: Double, CaseIterable {
    case defaultDiscount = 5.0
    case nationalDay = 10.0
    case blackFriday = 15.0
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

print("\nAssignment 7: Enums and Switch Cases")
printDiscount(type: .blackFriday)
printDiscount(type: .defaultDiscount)
printDiscount(type: .nationalDay)
printDiscount(type: .newYear)


//------------ Assignment 8, 9, 10 ------------
// DiscountType used in below Struct is the enum created in Assignment 7, copied here for reference
// enum DiscountType: Double, CaseIterable {
//    case defaultDiscount = 5.0
//    case nationalDay = 10.0
//    case blackFriday = 15.0
//    case newYear = 20.0
// }

struct Items {
    private var itemPrices = [ 100.0, 12.6, 19.3, 55.5, 70.0, 44.4, 39.99]
    private var currentDiscountType = DiscountType.defaultDiscount
    private var totalAmount: Double {
        itemPrices.reduce(0) { $0 + $1 }
    }
    
    //----Assignment 9: Lazy Property----
    lazy var maxDiscount = DiscountType.allCases.sorted { $0.rawValue > $1.rawValue }.first?.rawValue ?? 0.0
    
    var currentDiscountedAmount: Double {
        let discountPercentage = currentDiscountType.rawValue
        let discount = totalAmount * (discountPercentage / 100)
        let amountAfterDiscount = totalAmount - discount
        return amountAfterDiscount
    }
    
    //----For Assignment 10: Method----
    func calculateTotalAmountAfterDiscount() -> Double {
        let discountPercentage = currentDiscountType.rawValue
        let discount = totalAmount * (discountPercentage / 100)
        let amountAfterDiscount = totalAmount - discount
        return amountAfterDiscount
    }

    mutating func setDiscountType(type: DiscountType) {
        self.currentDiscountType = type
    }
    
}

var allItems = Items()
allItems.currentDiscountedAmount // Uses default Discount value
allItems.setDiscountType(type: .blackFriday)

print("\nAssignment 8: Computed Property")
print(allItems.currentDiscountedAmount)

print("\nAssignment 9: Lazy Property")
print(allItems.maxDiscount)

print("\nAssignment 10: Method")
print(allItems.calculateTotalAmountAfterDiscount())


//------------ Assignment 11 ------------
// DiscountType used in below Struct is the enum created in Assignment 7, copied here for reference
// enum DiscountType: Double, CaseIterable {
//    case defaultDiscount = 5.0
//    case nationalDay = 10.0
//    case blackFriday = 15.0
//    case newYear = 20.0
// }

protocol Discount {
    var discountType: DiscountType { get set }
    var discountPercentage: Double { get }

    func calculateTotalAmountAfterDiscount() -> Double
}

class ItemsClass: Discount {
    private var itemPrices = [ 100.0, 12.6, 19.3, 55.5, 70.0, 44.4, 39.99]
    private var totalAmount: Double {
        itemPrices.reduce(0) { $0 + $1 }
    }
    
    var discountType = DiscountType.defaultDiscount
    var discountPercentage: Double {
        get {
            discountType.rawValue
        }
    }

    func calculateTotalAmountAfterDiscount() -> Double {
        let discount = totalAmount * (discountPercentage / 100)
        let amountAfterDiscount = totalAmount - discount
        return amountAfterDiscount
    }
}

let allStuff = ItemsClass()

//Access(Get) discountType propety
allStuff.discountType

//Set discountType property
allStuff.discountType = .blackFriday

// Access(Get) discountPercentage propety
allStuff.discountPercentage

// Set discountPercentage property - Gives error as this is GET only property.
// allStuff.discountPercentage = 8

// Method to calculate discount in conformance to the protocol
print("\nAssignment 11: Protocol")
print(allStuff.calculateTotalAmountAfterDiscount())


//------------ Assignment 12 ------------

extension ItemsClass {
    var totalDiscountedAmountRounded : Double {
        calculateTotalAmountAfterDiscount().rounded()
    }
}
print("\nAssignment 12: Extension")
print(allStuff.totalDiscountedAmountRounded)


//------------ Assignment 13 ------------



//------------ Assignment 14 ------------

//Progression of usage of Closure syntax shown below in V1, V2

let closureCalculateAmountForDiscountTypeV1 = { (totalAmount: Double, type: DiscountType) in
    print("Discount Type : \(type), \t totalAmountAfterDiscount: \(totalAmount - (totalAmount * type.rawValue / 100))")
}

let closureCalculateAmountForDiscountTypeV2: (Double, DiscountType) -> Void = {
    print("Discount Type : \($1), \t totalAmountAfterDiscount: \($0 - ($0 * $1.rawValue / 100))")
}

print("\nAssignment 14: Nice to Haves: Using Closure V1 - long syntax")
closureCalculateAmountForDiscountTypeV1(totalAmount, .blackFriday)
closureCalculateAmountForDiscountTypeV1(totalAmount, .newYear)

print("\nAssignment 14: Nice to Haves: Using Closure V2 - short syntax")
closureCalculateAmountForDiscountTypeV2(totalAmount, .blackFriday)
closureCalculateAmountForDiscountTypeV2(totalAmount, .newYear)














