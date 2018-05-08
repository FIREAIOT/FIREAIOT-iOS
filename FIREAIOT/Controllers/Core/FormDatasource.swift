//
//  RegisterFormDatasource.swift
//  FIREAIOT
//
//  Created by Saleem on 20/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

class FormDatasource: Datasource {
    open var sections = [Section]()
    
    convenience init(sections: [Section]) {
        self.init()
        self.sections = sections
    }
    
    override func numberOfSections() -> Int {
        return sections.count
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [DefaultCell.self]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return sections[indexPath.section].items[indexPath.row]
    }
}
