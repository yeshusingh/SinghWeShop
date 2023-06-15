//
//  Item.swift
//  SinghWeShop
//
//  Created by Yeshu Singh on 4/16/23.
//

import Foundation

struct Item: Hashable, Identifiable, Codable {
  enum CodingKeys: String, CodingKey {
    case id, price, category, description
    case name = "title"
    case imageURL = "image"
  }

  let id: Int
  var name: String
  var price: Double
  var discountedPrice: Double
  var category: String
  var description: String
  var imageURL: String
}

extension Item {
  init(id: Int, name: String, price: Double, description: String, category: String, imageURL: String) {
    self.id = id
    self.name = name
    self.price = price
    self.discountedPrice = price
    self.description = description
    self.category = category
    self.imageURL = imageURL
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    price = try container.decode(Double.self, forKey: .price)
    discountedPrice = price
    category = try container.decode(String.self, forKey: .category)
    description = try container.decode(String.self, forKey: .description)
    imageURL = try container.decode(String.self, forKey: .imageURL)
  }
}

enum ItemSampleData {
  public static let womenTshirt = Item(
    id: 20,
    name: "DANVOUY Womens T Shirt Casual Cotton Short",
    price: 12.99,
    discountedPrice: 12.99,
    category: "women's clothing",
    description: """
      95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, \
      The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. \
      Season: Spring,Summer,Autumn,Winter.
      """,
    imageURL: "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg"
  )

  public static let shortSleeve = Item(
    id: 19,
    name: "Opna Women's Short Sleeve Moisture",
    price: 7.9500000000000002,
    discountedPrice: 7.9500000000000002,
    category: "women's clothing",
    description: """
      100% Polyester, Machine wash, 100% cationic polyester interlock, Machine Wash & \
      Pre Shrunk for a Great Fit, Lightweight, roomy and highly breathable with moisture wicking \
      fabric which helps to keep moisture away, Soft Lightweight Fabric with comfortable V-neck \
      collar and a slimmer fit, delivers a sleek, more feminine silhouette and Added Comfort
      """,
    imageURL: "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg"
  )

  public static let boatNeckT = Item(
    id: 18,
    name: "MBJ Women's Solid Short Sleeve Boat Neck V ",
    price: 9.8499999999999996,
    discountedPrice: 9.8499999999999996,
    category: "women's clothing",
    description: """
    95% RAYON 5% SPANDEX, Made in USA or Imported, Do Not Bleach, Lightweight fabric with great \
    stretch for comfort, Ribbed on sleeves and neckline / Double stitching on bottom hem
    """,
    imageURL: "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg"
  )

  public static let rainJacket = Item(
    id: 17,
    name: "Rain Jacket Women Windbreaker Striped Climbing Raincoats",
    price: 39.990000000000002,
    discountedPrice: 39.990000000000002,
    category: "women's clothing",
    description: """
      Lightweight perfet for trip or casual wear---Long sleeve with hooded, adjustable drawstring waist design. \
      Button and zipper front closure raincoat, fully stripes Lined and The Raincoat has 2 side pockets are a good \
      size to hold all kinds of things, it covers the hips, and the hood is generous but doesn't overdo it.Attached \
      Cotton Lined Hood with Adjustable Drawstrings give it a real styled look.
      """,
    imageURL: "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg"
  )
}

// enum ItemSampleData {
//  public static let notepad = Item(
//    id: 1,
//    name: "Amazon Basics Narrow Ruled Writing Note Pads",
//    price: 12.0,
//    description: """
//    6-pack of writing pads; 50 sheets of paper per pad; ideal for everyday \
//    lists, notes, and more.2 of each color (pink, orchid, and blue) for a \
//    nice appearance and optional color coding.
//    """,
//    category: "stationary",
//    imageURL: "https://www.amazon.com/AmazonBasics-Writing-Narrow-Orchid-6-Pack/dp/B07TQ8567K/ref=sr_1_1_sspa?crid=1LTRTKZ07Q71Z&keywords=notepad&qid=1681672066&sprefix=notepad%2Caps%2C249&sr=8-1-spons&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUEyWEhBOUJCVUVHSDI4JmVuY3J5cHRlZElkPUEwNDAxMzQxMlk4UVpBMDg3SVJaTCZlbmNyeXB0ZWRBZElkPUEwMTMxMzEzMVRCVjRVOFJTSVdHVCZ3aWRnZXROYW1lPXNwX2F0ZiZhY3Rpb249Y2xpY2tSZWRpcmVjdCZkb05vdExvZ0NsaWNrPXRydWU&th=1")
//
//  public static let pencil = Item(
//    id: 2,
//    name: "TICONDEROGA Pencils, Wood-Cased, Pre-Sharpened",
//    price: 6.0,
//    description: "Exclusive #2 graphite formula provides extra smooth performance. Pre-sharpened to save you time",
//    category: "stationary",
//    imageURL: "https://www.amazon.com/Ticonderoga-Wood-Cased-Graphite-Pre-Sharpened-13830/dp/B006CSPZK4/ref=sr_1_1?crid=34FN74U8N5CWG&keywords=pencil&qid=1681671881&sprefix=pencil%2Caps%2C170&sr=8-1&th=1")
//
//  public static let eraser = Item(
//    id: 3,
//    name: "Amazon Basics Block White Eraser",
//    price: 6.9,
//    description: "Efficient: quickly removes lead-pencil marks from paper without smudging or smearing",
//    category: "stationary",
//    imageURL: "https://www.amazon.com/AmazonBasics-Block-White-Easer-pack/dp/B087B69598/ref=sr_1_1_sspa?crid=2FPDO48QWB2SJ&keywords=eraser&qid=1681672286&sprefix=erase%2Caps%2C302&sr=8-1-spons&psc=1&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUEyQjJZQzdaMFgyQUc2JmVuY3J5cHRlZElkPUEwNjAyNDcwM0dFUFhDUTVINUZRVSZlbmNyeXB0ZWRBZElkPUExMDM5Mjk4M0c4MTVWRVZPTE03UiZ3aWRnZXROYW1lPXNwX2F0ZiZhY3Rpb249Y2xpY2tSZWRpcmVjdCZkb05vdExvZ0NsaWNrPXRydWU=")
//
//
//  public static let glueStick = Item(
//    id: 4,
//    name: "Elmer's Disappearing Purple School Glue Sticks",
//    price: 4.94,
//    description: """
//    Bonds to paper, cardboard, foam board, display board, and more. \
//    Goes on purple and dries clear. Washable, non-toxic, acid-free, and photo safe.
//    """,
//    category: "stationary",
//    imageURL: "https://www.amazon.com/Elmers-Disappearing-Purple-School-Washable/dp/B003ULCZ7M/ref=pd_bxgy_img_sccl_1/138-0721064-1243301?pd_rd_w=2IxWC&content-id=amzn1.sym.6ab4eb52-6252-4ca2-a1b9-ad120350253c&pf_rd_p=6ab4eb52-6252-4ca2-a1b9-ad120350253c&pf_rd_r=3X8TXD2NXJT2N7X94AE1&pd_rd_wg=1vqLN&pd_rd_r=d73a0e98-7b58-4a4a-a4b4-5f7f8d41d693&pd_rd_i=B003ULCZ7M&th=1")
//
//  public static let sharpener = Item(
//    id: 5,
//    name: "STAEDTLER pencil sharpener, premium quality sharpener with screw-on lid",
//    price: 5.61,
//    description: """
//    Premium quality sharpener ensures you never have a dull moment in the office, \
//    at school, or around the house!. Metal sharpener with secure screw-on lid prevents accidental opening
//    """,
//    category: "stationary",
//    imageURL: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
//
//  public static let paper = Item(
//    id: 6,
//    name: "Amazon Basics Multipurpose Copy Printer Paper, 8.5 x 11 Inch",
//    price: 39.99,
//    description: """
//    8 ream case (4,000 sheets) of 8.5 x 11 white copier and printer paper for home \
//    or office use. Multipurpose letter size copy paper works with laser/inkjet printers, \
//    copiers and fax machines.
//    """,
//    category: "stationary",
//    imageURL: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
//
//
//  public static let iPad = Item(
//    id: 7,
//    name: "Ipad Pro",
//    price: 799.99,
//    description: """
//    Pad Pro is the ultimate iPad experience, with the astonishing performance of the M2 chip, \
//    superfast wireless connectivity, and next-generation Apple Pencil experience. Plus powerful \
//    productivity features in iPadOS.iPadOS makes iPad more productive, intuitive, and versatile. \
//    With iPadOS, run multiple apps at once, use Apple Pencil to write in any text field with \
//    Scribble, and edit and share photos. Stage Manager makes multitasking easy with resizable, \
//    overlapping apps and external display support. iPad Pro comes with essential apps like Safari, \
//    Messages, and Keynote, with over a million more apps available on the App Store.
//    """,
//    category: "electronics",
//    imageURL: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
//
//  public static let appleWatch = Item(
//    id: 8,
//    name: "Apple Watch",
//    price: 529.99,
//    description: """
//    All the essentials to help you monitor your fitness, keep connected, track your health, \
//    and stay safe. Now up to 20 percent faster, with features like Crash Detection and enhanced \
//    workout metrics, it’s a better value than ever.It works seamlessly with your Apple devices \
//    and services. Unlock your Mac automatically. Find your devices with a tap. Pay and send money \
//    with Apple Pay. Apple Watch requires an iPhone 8 or later with the latest iOS version.
//    """,
//    category: "electronics",
//    imageURL: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
//
//  public static let monitor = Item(
//    id: 9,
//    name: "Dell Monitor",
//    price: 499.99,
//    description: """
//    Experience 4x the resolution of Full HD with colors of up to 1.07 billion \
//    together with 99% sRGB across wide viewing angles with this 32 Inch 4K monitor. \
//    Aspect ratio:16:9.Response time:4.0 milliseconds.
//    """,
//    category: "electronics",
//    imageURL: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
//
//
//  public static let tShirt = Item(
//    id: 10,
//    name: "White Tshirt",
//    price: 29.99,
//    description: """
//    Get a smooth, durable, premium finish that's always flake-proof, peel-proof, \
//    and wash-proof. This basic, lightweight T-shirt is perfect for just about \
//    any design or occasion you can think of.
//    """,
//    category: "clothes",
//    imageURL: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
//
//  public static let jeans = Item(
//    id: 11,
//    name: "Blue Jeans",
//    price: 59.99,
//    description: """
//    These classic 5-pocket Athletic-Fit jeans are crafted with a bit of stretch \
//    for additional comfort and to help maintain their shape. Athletic Fit sits at \
//    the waist and features a roomier cut through the hip and thigh and a tapered leg
//    """,
//    category: "clothes",
//    imageURL: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
//
//  public static let jacket = Item(
//    id: 12,
//    name: "Jacket",
//    price: 199.99,
//    description: "Soft, warm and fuzzy mid-weight polar fleece fabric",
//    category: "clothes",
//    imageURL: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
// }
