//
//  RootView.swift
//  ConnectFour
//
//  Created by Vincent Smithers on 11.07.19.
//  Copyright © 2019 Vincent Smithers. All rights reserved.
//

import SwiftUI

struct RootView : View {
    @ObjectBinding var boardViewModel: BoardViewModel
    var body: some View {
        ZStack() {
            Image("wallpaper").resizable()
            .shadow(color: Color.purple, radius: 50)
            TransparentBoard(viewModel: boardViewModel).blendMode(.exclusion)
        }
    }
}

