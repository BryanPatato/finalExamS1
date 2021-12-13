import Foundation; import CoreGraphics;
enum activeState
{
    case unplayed
    case active
    case clear
    case explosion
}
enum tileType
{
    case mine
    case empty
    case number
    var value:String{
        switch self {
        case .mine:
            return "mine"
        case .empty:
            return "blank"
        case .number:
            return "x"
        }
    }
}
public class mineSweeper
{
    var state: activeState
    var board: [[tileType]]
    var hidBoard: [[Bool]]
    var adjacent: [[Int]]
    static var x = 0
    static var y = 0
    fileprivate var c: generator
    init(desX: Int, desY: Int)
    {
        mineSweeper.x = desX
        mineSweeper.y = desY
        state = .unplayed
        c = generator(boardSizeX: mineSweeper.x, BoardSizeY: mineSweeper.y)
        board = [[]]
        hidBoard = [[]]
        adjacent = [[]]
    }
    func initReveal(unit: Int)
    {
        state = .active
        board = c.generate(tapLocal: unit)
        hidBoard = [[Bool]](repeating: [Bool](repeating: false, count: mineSweeper.x), count: mineSweeper.y)
        adjacent = c.genAdjacent(board: board)
        reveal(unit: unit)
    }
    func reveal(unit: Int)
    {
        if state != .explosion 
        {
            hidBoard[Int(unit / mineSweeper.x)][unit % mineSweeper.y] = true
        }
    }
    func explode()
    {
        state = .explosion
        for i in 0...mineSweeper.x - 1
        {
            for e in 0...mineSweeper.y - 1
            {
                if board[i][e] == .mine
                {
                    hidBoard[i][e] = true
                }
            }
        }
    }
    func placeFlag(unit: Int)
    {
        hidBoard[Int(unit / mineSweeper.x)][unit % mineSweeper.y] = true
    }
    func remFlag(unit: Int)
    {
        hidBoard[Int(unit / mineSweeper.x)][unit % mineSweeper.y] = false
    }
    func getNums(unit: Int) -> Int
    {
        return adjacent[Int(unit / mineSweeper.x)][unit % mineSweeper.y]
    }
    func getSize() -> Int
    {
        return mineSweeper.x * mineSweeper.y
    }
    func isBomb(unit: Int) -> Bool
    {
        if board[Int(unit / mineSweeper.x)][unit % mineSweeper.y] == .mine
        {
            return true
        }
        else
        {
            return false
        }
    }
    func flagged(unit: Int) -> Bool
    {
        if hidBoard[Int(unit / mineSweeper.x)][Int(unit % mineSweeper.y)] == true
        {
            return true
        }
        else
        {
            return false
        }
    }
}
private class generator
{
    var bombHandler = [0, 0.0]
    init(boardSizeX: Int, BoardSizeY: Int)
    {
        mineSweeper.x = boardSizeX
        mineSweeper.y = BoardSizeY
        let base = boardSizeX * BoardSizeY
        // Base case is an 8 by 8 board
        // in the base case, this would make 15 of the 64 tiles bombs
        bombHandler[0] = floor(Double(Double(base)/4.17))
        // in the base case, this would make the bomb density 1 ( This handles extra bombs on larger boards, thus the new bomb total is 20 bombs )
        bombHandler[1] = (64/Double(base))
    }
    func generate(tapLocal: Int) -> [[tileType]]
    {
        var newBoard = [[tileType]](repeating: [tileType](repeating: .empty, count: mineSweeper.y), count: mineSweeper.x)
        print(newBoard.count)
        for _ in 0...Int(bombHandler[0])
        {
            let randPlaceX = Int(CGFloat.random(in: 0...CGFloat(mineSweeper.x)))
            let randPlaceY = Int(CGFloat.random(in: 0...CGFloat(mineSweeper.y)))
//            if  randPlaceX - 1 > 0 && randPlaceY - 1 > 0 && randPlaceX + 1 < mineSweeper.x && randPlaceY + 1 < mineSweeper.y && (newBoard[randPlaceX - 1][randPlaceY] == .mine || newBoard[randPlaceX + 1][randPlaceY] == .mine || newBoard[randPlaceX][randPlaceY - 1] == .mine || newBoard[randPlaceX][randPlaceY + 1] == .mine && randPlaceX != tapLocal + 1 && randPlaceX != tapLocal - 1 && randPlaceX != tapLocal && randPlaceY != tapLocal + mineSweeper.x && randPlaceY != tapLocal - mineSweeper.x && randPlaceY != tapLocal)
//            {
//                break
//            }
            newBoard[randPlaceX][randPlaceY] = .mine
        }
        return newBoard
    }
    func genAdjacent(board: [[tileType]]) -> [[Int]]
    {
        var likewiseTileArray = [[Int]](repeating: [Int](repeating: 0, count: mineSweeper.y), count: mineSweeper.x)
        for e in 0...mineSweeper.x - 1
        {
            for i in 0...mineSweeper.y - 1
            {
                if board[e][i] == .mine
                {
                    likewiseTileArray[e][i] = 9
                }
                else
                {
                    if e - 1 >= 0 && i - 1 >= 0 && e < mineSweeper.x - 1 && i < mineSweeper.y - 1
                    {
                        for qu in 0...2
                        {
                            for uq in 0...2
                            {
                                if board[(e - 1) + uq][(i - 1) + qu] == .mine
                                {
                                    likewiseTileArray[e][i] += 1
                                }
                            }
                        }
                    }
                    else
                    {
                        if e == 0 && i == 0
                        {
                            if board[e + 1][i] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e][i + 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e + 1][i + 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                        }
                        else if e == mineSweeper.x - 1 && i == 0
                        {
                            if board[e - 1][i] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e][i + 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e - 1][i + 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                        }
                        else if e == 0 && i == mineSweeper.y - 1
                        {
                            if board[e + 1][i] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e][i - 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e + 1][i - 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                        }
                        else if e == mineSweeper.x - 1 && i == mineSweeper.y - 1
                        {
                            if board[e - 1][i] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e][i - 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                            if board[e - 1][i - 1] == .mine
                            {
                                likewiseTileArray[e][i] += 1
                            }
                        }
                        else if e - 1 < 0 && i != mineSweeper.y - 1 && e != mineSweeper.x - 1
                        {
                            for qu in 0...1
                            {
                                for uq in 0...2
                                {
                                    if board[e + qu][i - 1 + uq] == .mine
                                    {
                                        likewiseTileArray[e][i] += 1
                                    }
                                }
                            }
                        }
                        else if i - 1 < 0 && i != mineSweeper.y - 1 && e != mineSweeper.x - 1
                        {
                            for qu in 0...1
                            {
                                for uq in 0...2
                                {
                                    if board[e - 1 + uq][i + qu] == .mine
                                    {
                                        likewiseTileArray[e][i] += 1
                                    }
                                }
                            }
                        }
                        else if e + 1 > mineSweeper.x - 1
                        {
                            for qu in 0...1
                            {
                                for uq in 0...2
                                {
                                    if board[e - qu][i - 1 + uq] == .mine
                                    {
                                        likewiseTileArray[e][i] += 1
                                    }
                                }
                            }
                        }
                        else if i + 1 > mineSweeper.y - 1
                        {
                            for qu in 0...1
                            {
                                for uq in 0...2
                                {
                                    if board[e - 1 + uq][i - qu] == .mine
                                    {
                                        likewiseTileArray[e][i] += 1
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
      return likewiseTileArray
    }
}
