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

public class PieceID: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    var id:String
    var type:chessPiece
    var colors:PieceColor
    required public init(stringLiteral PieceID: String){
        id = PieceID
        let letters = Array(arrayLiteral: PieceID)
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
    
public class Chess {
    
}

struct change {
    var x,y:Int
}

struct Position{
    var x,y:Int
}

struct board {
    
    private var boardPieces:[[PieceID]]
    
    init() {
        boardPieces =
        [
        ["BR0","BN1","BB2","BQ3","BK4","BB5","BN6","BR7"],
        ["BP0","BP1","BP2","BP3","BP4","BP5","BP6","BP7"],
        ["","","","","","","",""],
        ["","","","","","","",""],
        ["","","","","","","",""],
        ["","","","","","","",""],
        ["WP0","WP1","WP2","WP3","WP4","WP5","WP6","WP7"],
        ["WR0","WN1","WB2","WQ3","WK4","WB5","WN6","WR7"]
        ]
    }

    func less(one: Position,two: Position) -> change{
        return change(x: one.x-two.x,y: one.y-two.y)
    }
    
    func more(one: Position,two: change) -> Position {
        return Position(x: one.x-two.x, y: one.y-two.y)
    }
    
    func add(one: inout Position,two: change){
        one.x += two.x
        one.y += two.y
    }
    
    func piecePlace(at position: Position) -> PieceID {
        guard (0 ..< 8).contains(position.y), (0 ..< 8).contains(position.x) else {
            return ""
        }
        return boardPieces[position.y][position.x]
    }
    
    mutating func movePiece(from: Position,to: Position) {
        var piece = self.boardPieces
        piece[to.y][to.x] = piecePlace(at: from)
        piece[from.y][from.x] = ""
        self.boardPieces = piece
    }
    
    mutating func removePiece(at: Position) {
        var piece = self.boardPieces
        piece[at.y][at.x] = ""
        self.boardPieces = piece
    }
    
    mutating func promotePiece(at positions: Position, to types: chessPiece) {
        var piece = self.boardPieces(removePiece(at: positions)
        piece.type = types
        boardPieces[positions.y][positions.x] = piece
    }
    
    
    
    
    
    
    
    
    
    
    
}

