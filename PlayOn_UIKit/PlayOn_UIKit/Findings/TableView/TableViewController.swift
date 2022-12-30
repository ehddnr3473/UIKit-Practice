//
//  TableViewController.swift
//  PlayOn_UIKit
//
//  Created by 김동욱 on 2022/12/30.
//

import UIKit

class TableViewController: UIViewController {

    private let model = TableModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    private func configure() {
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.label.text = model.cellTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.numberOfRowsInSection[section]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        model.sectionHeader[section]
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        model.sectionFooter[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model.numberOfSections
    }
}

#if DEBUG

import SwiftUI

struct TableViewRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    func makeUIViewController(context: Context) -> some UIViewController {
        TableViewController()
    }
}

struct TableViewRepresentablePreviewProvider: PreviewProvider {
    static var previews: some View {
        TableViewRepresentable()
    }
}

#endif

