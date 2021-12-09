////
////  Chess.swift
////  finalExamS1
////
////  Created by BRYAN RUIZ on 11/29/21.
////
//
//import Foundation
//import UIKit
//
//enum chessState {
//    case idle
//    case check
//    case checkmate
//    case scalemate
//}
//
//enum chessPiece {
//    case king
//    case queen
//    case bishop
//    case knight
//    case rook
//    case pawn
//    var  value:Int {
//        switch self {
//        case .king:
//            return 0
//        case .queen:
//            return  9
//        case .bishop:
//            return  3
//        case .knight:
//            return 3
//        case .rook:
//            return  5
//        case .pawn:
//            return  1
//        }
//    }
//}
//
//
//enum PieceColor {
//    case white
//    case black
//    var color:PieceColor{
//        switch self {
//        case .white:
//            return .white
//        case .black:
//            return .black
//        }
//    }
//}
//
//public class PieceID: ExpressibleByStringLiteral {
//    public typealias StringLiteralType = String
//    var id:String
//    var type:chessPiece
//    var colors:PieceColor
//    required public init(stringLiteral PieceID: String){
//        id = PieceID
//        let letters = Array(arrayLiteral: PieceID)
//        switch letters[0] {
//        case "B": colors = .black
//        case "W": colors = .white
//        default:
//            colors = .black
//        }
//        switch letters[1] {
//        case "K": type = .king
//        case "Q": type = .queen
//        case "B": type = .bishop
//        case "N": type = .knight
//        case "R": type = .rook
//        case "P": type = .pawn
//        default:
//            type = .pawn
//        }
//    }
//}
//
//struct Move {
//    var from,to: Position
//}
//    
//public class Chess {
//    var board:Board
//    var history:[Move]
//    var turn:PieceColor {
//        return history.last.flatMap { board.piecePlace(at: $0.to).colors.color ?? .white } as! PieceColor
//    }
//    
////    var state:chessState{
////       let color = turn
////    }
//    
//    func canSelectPiece(at position: Position) -> Bool {
//        return board.piecePlace(at: position)!.colors == turn
//    }
//    
//    func canMove(from: Position, by: change) -> Bool {
//        return canMove(from: from, to: Position(x: from.x+by.x, y: from.y+by.y) )
//    }
//    
//    func canMove(from: Position, to:Position) -> Bool {
//        return false
//    }
//    
////    func pawnCanTake(from: Position, with delta: change) -> Bool {
////        guard abs(delta.x) == 1, let pawn = board.piecePlace(at: from) else {
////            return false
////        }
////        assert(pawn.type == .pawn)
////        switch pawn.colors {
////        case .white:
////            return delta.y == -1
////        case .black:
////            return delta.y == 1
////        }
////    }
////
////    func enPassantTakePermitted(from: Position, to: Position) -> Bool {
////        guard let this = board.piecePlace(at: from),
////              pawnCanTake(from: from, with: change(x: to.x-from.x, y: to.x-from.y) ),
////            let lastMove = history.last, lastMove.to.x == to.x,
////            let piece = board.piecePlace(at: lastMove.to),
////            piece.type == .pawn, piece.colors != this.colors
////        else {
////            return false
////        }
////        switch piece.colors {
////        case .white:
////            return lastMove.from.y == to.y + 1 && lastMove.to.y == to.y - 1
////        default:
////            return lastMove.from.y == to.y - 1 && lastMove.to.y == to.y + 1
////        }
////    }
////
////    func pieceHasMoved(at position: Position) -> Bool {
////        return history.contains(where: { $0.from == position })
////    }
////
////
//    
//    init() {
//    board = Board()
//    history = []
//    }
//    
//}
//
//struct change {
//    var x,y:Int
//}
//
//struct Position:Equatable{
//    var x,y:Int
//}
//
//struct Board {
//    
//    private var boardPieces:[[PieceID]]
//    static let allPositions = (0 ..< 8).flatMap { y in (0 ..< 8).map { Position(x: $0, y: y) } }
//    
//    var allPositions: [Position] { return Self.allPositions }
//    
//// var allPieces: [(position: Position, blah: PieceID)] {
////     return allPositions.compactMap {position in boardPieces[position.y][position.x].map { (position,$0) } } }
//
//    init() {
//        boardPieces =
//        [
//        ["BR0","BN1","BB2","BQ3","BK4","BB5","BN6","BR7"],
//        ["BP0","BP1","BP2","BP3","BP4","BP5","BP6","BP7"],
//        ["","","","","","","",""],
//        ["","","","","","","",""],
//        ["","","","","","","",""],
//        ["","","","","","","",""],
//        ["WP0","WP1","WP2","WP3","WP4","WP5","WP6","WP7"],
//        ["WR0","WN1","WB2","WQ3","WK4","WB5","WN6","WR7"]
//        ]
//    }
//
//    func less(one: Position,two: Position) -> change{
//        return change(x: one.x-two.x,y: one.y-two.y)
//    }
//    
//    func more(one: Position,two: change) -> Position {
//        return Position(x: one.x-two.x, y: one.y-two.y)
//    }
//    
//    func add(one: inout Position,two: change){
//        one.x += two.x
//        one.y += two.y
//    }
//    
////    func firstPosition(where condition: (PieceID) -> Bool) -> Position? {
////        return allPieces.first(where: { condition($1) })?.position
////    }
//    
//    func piecePlace(at position: Position) -> PieceID? {
//        guard (0 ..< 8).contains(position.y), (0 ..< 8).contains(position.x) else {
//            return ""
//        }
//        return boardPieces[position.y][position.x]
//    }
//    
//    mutating func movePiece(from: Position,to: Position) {
//        var piece = self.boardPieces
//        piece[to.y][to.x] = piecePlace(at: from)!
//        piece[from.y][from.x] = ""
//        self.boardPieces = piece
//    }
//    
//    mutating func removePiece(at: Position) {
//        var piece = self.boardPieces
//        piece[at.y][at.x] = ""
//        self.boardPieces = piece
//    }
//    
//    mutating func promotePiece(at positions: Position, to types: chessPiece) {
//        var piece = self.piecePlace(at: positions)
//        piece!.type = types
//        boardPieces[positions.y][positions.x] = piece!
//    }
//    
////    func piecesExist(between: Position, and: Position) -> Bool {
////        let step = change(
////            x: between.x > and.x ? -1 : (between.x < and.x ? 1 : 0),
////            y: between.y > and.y ? -1 : (between.y < and.y ? 1 : 0)
////        )
////        var position = between
////        position += step
////        while position != and {
////            if piece(at: position) != nil {
////                return true
////            }
////            position += step
////        }
////        return false
////    }
//    
//}
