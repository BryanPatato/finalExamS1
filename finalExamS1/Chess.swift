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
}

enum playerSide{
    case white
    case black
}

enum squareColor {
    case white
    case black
}

    
public class Chess {
    init(P: chessPiece,pl: playerSide,)
}

public class board {
    var position[[Chess]] = [[8]]
}
