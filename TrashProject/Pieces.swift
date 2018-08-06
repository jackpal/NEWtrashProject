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

let allPieces = [
  Piece(name: "diapers", type:.trash, description: "Diapers should be thrown in the trash"),
  Piece(name: "straw", type:.trash),
  Piece(name: "candyWrapper", type:.trash),
  Piece(name: "paperCup", type:.trash),
  Piece(name: "oldBulb", type:.trash),
  Piece(name: "shotNeedle", type:.trash),
  Piece(name: "woodenSpoon", type:.trash),
  Piece(name: "toys", type:.trash),
  Piece(name: "tshirt", type:.trash),


  // Recycling
  Piece(name: "bake", type:.recycling),
  Piece(name: "battery", type:.recycling),
  Piece(name: "can", type:.recycling),
  Piece(name: "car", type:.recycling),
  Piece(name: "cardboardBox", type:.recycling),
  Piece(name: "carpet", type:.recycling),
  Piece(name: "cerealBox", type:.recycling),
  Piece(name: "drink", type:.recycling),
  Piece(name: "envelopes", type:.recycling),
  Piece(name: "etrash", type:.recycling),
  Piece(name: "fluolight", type:.recycling),
  Piece(name: "foil", type:.trash),
  Piece(name: "fridge", type:.recycling),
  Piece(name: "mattress", type:.recycling),
  Piece(name: "paintcans", type:.recycling),
  Piece(name: "paper", type:.recycling),
  Piece(name: "paperBag", type:.recycling),
  Piece(name: "milkCarton", type:.recycling),
  Piece(name: "Yogogo", type:.recycling),
  Piece(name: "battery", type:.recycling),
  Piece(name: "soda", type:.recycling),
  Piece(name: "foil", type:.recycling),
  Piece(name: "shampoo", type:.recycling),
  Piece(name: "plasticBottle", type:.recycling),

  // Compost
  Piece(name: "appleCore", type:.compost),
  Piece(name: "avocadoPits", type:.compost),
  Piece(name: "eggCarton", type:.compost),
  Piece(name: "eggShells", type:.compost),
  Piece(name: "foodWaste", type:.compost),
  Piece(name: "leaf", type:.compost),
  Piece(name: "muffinWraper", type:.compost),
  Piece(name: "peanuts", type:.compost),
  Piece(name: "toothpick", type:.compost),
  Piece(name: "pizzaBox", type:.compost),    ]
