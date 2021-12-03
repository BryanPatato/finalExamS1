//
//  Chess.swift
//  finalExamS1
//
//  Created by BRYAN RUIZ on 11/29/21.
//

import Foundation
import UIKit

enum chessState {
    case idle
    case check
    case checkmate
    case scalemate
}

enum chessPiece {
    case king
    case queen
    case bishop
    case knight
    case rook
    case pawn
    var  value:Int {
        switch self {
        case .king:
            return 0
        case .queen:
            return  9
        case .bishop:
            return  3
        case .knight:
            return 3
        case .rook:
            return  5
        case .pawn:
            return  1
        }
    }
}


enum PieceColor {
    case white
    case black
    var color:UIColor{
        switch self {
        case .white:
            return .white
        case .black:
            return .black
        }
    }
}

public class PieceID{
    var id:String
    var type:chessPiece
    var colors:PieceColor
    init(pieceID: String){
        id = pieceID
        let letters = Array(arrayLiteral: pieceID)
        switch letters[0] {
        case "B": colors = .black
        case "W": colors = .white
        default:
            colors = .black
        }
        switch letters[1] {
        case "K": type = .king
        case "Q": type = .queen
        case "B": type = .bishop
        case "N": type = .knight
        case "R": type = .rook
        case "P": type = .pawn
        default:
            type = .pawn
        }
    }
}

//public class Chess {
//
//}
//
//public class board {
//    private var boardPieces:[[PieceID]]
//    var x,y:Int
//
//    init() {
//        boardPieces =
//        [[PieceID(pieceID: "BR0"),"BN1","BB2","BQ3","BK4","BB5","BN6","BR7"],
//        ["BP0","BP1","BP2","BP3","BP4","BP5","BP6","BP7"],
//        [nil,nil,nil,nil,nil,nil,nil,nil],
//        [nil,nil,nil,nil,nil,nil,nil,nil],
//        [nil,nil,nil,nil,nil,nil,nil,nil],
//        [nil,nil,nil,nil,nil,nil,nil,nil],
//        ["WP0","WP1","WP2","WP3","WP4","WP5","WP6","WP7"],
//        ["WR0","WN1","WB2","WQ3","WK4","WB5","WN6","WR7"]
//        ]
//    }
//
//
//}

