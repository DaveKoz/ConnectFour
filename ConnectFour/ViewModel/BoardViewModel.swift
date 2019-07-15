//
//  BoardViewModel.swift
//  ConnectFour
//
//  Created by Vincent Smithers on 11.07.19.
//  Copyright © 2019 Vincent Smithers. All rights reserved.
//

import SwiftUI
import Combine

final class BoardViewModel: BindableObject {
    
    var didChange = PassthroughSubject<BoardViewModel, Never>()
    var moveCount = 0
    var board: Board
    
    var state: GameState = .playerOneTurn {
        didSet {
            moveCount += 1
        }
    }
    
    init(columns: Int, rows: Int) {
      board = Board(columns: columns, rows: rows)
    }
    
    func dropTile(inColumn column: Int) {
        if let tile = board.addTile(inColumn: column, forState: state.currentTile) {
            updateState(newTile: tile)
            board.log()
        } else {
            print("Column full")
        }
    }
    
    func updateState(newTile: Tile) {
        let winCheckResult = WinChecker(board: board, winningTile: newTile, moveCount: moveCount).result
        switch winCheckResult {
        case .win(let tileState):
            state = .gameOver(.win(tileState))
        case .draw:
            state = .gameOver(.draw)
        case .inProgress:
            state = state.nextTurn()
        }
        didChange.send(self)
    }
}
