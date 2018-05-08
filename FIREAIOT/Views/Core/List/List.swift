//
//  List.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 25/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

class List: UITableView, Frameable, UITableViewDataSource {
    var height: CGFloat {
        get {
            return CGFloat(items.count * 50)
        }
    }
    
    private var items: [ListItem]!
    private lazy var cellId: String = "cellId"
    
    public convenience init(items: [ListItem]) {
        self.init(frame: .zero, style: .plain)
        self.items = items
        
        register(ListItemCell.self, forCellReuseIdentifier: cellId)
        
        dataSource = self
        allowsSelection = false
        isScrollEnabled = false
        separatorStyle = .none
        backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ListItemCell {
            cell.listItem = items[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
}
