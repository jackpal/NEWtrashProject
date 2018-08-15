//
//  Pieces.swift
//  TrashProject
//
//  Created by Jack Palevich on 8/5/18.
//  Copyright © 2018 Sydrah Al-saegh. All rights reserved.
//

import Foundation

// The type of a piece.
enum PieceType: String {
  case compost = "compost"
  case recycling = "recycling"
  case trash = "trash"
}

// An individual piece of trash
struct Piece {
  let name: String
  let type: PieceType
  let description: String

  init(name: String, type: PieceType) {
    self.init(name:name, type: type, description: "")
  }
  init(name: String, type: PieceType, description: String) {
    self.name = name
    self.type = type
    self.description = description
  }
}

let trashPieces = [
  Piece(name: "candyWrapper", type:.trash, description: "Candy wrappers should be thrown in the trash."),
  Piece(name: "diapers", type:.trash, description: "Diapers should be thrown in the trash."),
  Piece(name: "oldBulb", type:.trash, description: "Old incandecent lightbulbs should be thrown in the trash."),
  Piece(name: "paperCup", type:.trash, description: "Styrofoam cups should be thrown away."),
  Piece(name: "shotNeedle", type:.trash, description: "Needles should be handled with care, wrapped, and thrown in the trash."),
  Piece(name: "straw", type:.trash, description: "Straws go in the trash."),
  Piece(name: "toys", type:.trash, description: "Toys made from industrial plastic are not recyclable."),
  Piece(name: "tshirt", type:.trash, description: "Clothes can be repurposed or donated to charity."),
  Piece(name: "woodenSpoon", type:.trash, description: "Wood cannot be recycled, especially when finished."),
]

let recyclingPieces = [
  Piece(name: "bake", type:.recycling, description: "Bakeware is recyclable."),
  Piece(name: "battery", type:.recycling, description: "Batteries are recyclable."),
  Piece(name: "can", type:.recycling, description: "Steel cans are recyclable."),
  Piece(name: "car", type:.recycling, description: "Cars are recylable and crushed to reuse the steel."),
  Piece(name: "cardboardBox", type:.recycling, description: "Cardboard boxes are recyclable, and reuseable."),
  Piece(name: "carpet", type:.recycling, description: "Carpets are recyclable."),
  Piece(name: "cerealBox", type:.recycling, description: "Cereal boxes are recyclable."),
  Piece(name: "drink", type:.recycling, description: "Drink cups made of paper are recyclable."),
  Piece(name: "envelopes", type:.recycling, description: "Envelopes made of paper are recyclable."),
  Piece(name: "etrash", type:.recycling, description: "Electronic trash is recyclable."),
  Piece(name: "fluolight", type:.recycling, description: "Flourecent lightbulbs can be recycled."),
  Piece(name: "fridge", type:.recycling, description: "Refrigeraters should be recycled."),
  Piece(name: "mattress", type:.recycling, description: "Matresses can be recyled."),
  Piece(name: "milkCarton", type:.recycling, description: ""),
  Piece(name: "paintcans", type:.recycling, description: "Paintcans are recylcable."),
  Piece(name: "paper", type:.recycling, description: "Paper is recyclable."),
  Piece(name: "paperBag", type:.recycling, description: "Paper bags are recyclable."),
  Piece(name: "milkCarton", type:.recycling, description: "Milk cartons are recyclable."),
  Piece(name: "yogogo", type:.recycling, description: "Yogurt containers are recyclable."),
  Piece(name: "battery", type:.recycling, description: "Milk cartons are recyclable."),
  Piece(name: "soda", type:.recycling, description: "Soda cans are recyclable."),
  Piece(name: "shampoo", type:.recycling, description: "Shampoo and detergent bottles are recyclable."),
  Piece(name: "plasticBottle", type:.recycling, description: "Plastic bottles are recyclable but take the cap off before doing so."),
  Piece(name: "shampoo", type:.recycling, description: "Shampoo and detergent bottles are recyclable."),
  Piece(name: "soda", type:.recycling, description: "Soda cans are recyclable."),
  Piece(name: "foil", type:.recycling, description: "Aluminum foil is recylable. However, if it has food on it, it will get` caught in the machines, and should be washed before being recycled."),
  Piece(name: "Yogogo", type:.recycling, description: "Yogurt containers are recyclable."),
]

let compostPieces = [
  Piece(name: "appleCore", type:.compost, description: "Apple cores are compostable."),
  Piece(name: "avocadoPits", type:.compost, description: "Avacado pits are compostable."),
  Piece(name: "eggCarton", type:.compost, description: "Egg cartons are compostable."),
  Piece(name: "eggShells", type:.compost, description: "Egg shells are compostable."),
  Piece(name: "foodWaste", type:.compost, description: "Food waste should be composted."),
  Piece(name: "leaf", type:.compost, description: "Leaves, grass, and yard waste should be composted."),
  Piece(name: "muffinWraper", type:.compost, description: "Muffin wrappers are compostable."),
  Piece(name: "peanuts", type:.compost, description: "Peanut shells are compostable."),
  Piece(name: "pizzaBox", type:.compost, description: "Pizza boxes with grease go in the compost."),
  Piece(name: "toothpick", type:.compost, description: "Toothpicks are compostable."),
]

let allPieces = trashPieces + recyclingPieces + compostPieces

let pieceIndex = [trashPieces, recyclingPieces, compostPieces]
