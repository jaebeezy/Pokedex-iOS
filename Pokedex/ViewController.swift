//
//  ViewController.swift
//  Pokedex
//
//  Created by Jae Young Choi on 3/1/22.
//

import UIKit

class ViewController: UIViewController {

    var pokemonList = [PokemonList]()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        return table

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setUpViews()

        NetworkManager.shared.fetchPokemonList { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let result):
                print(result)
                self?.pokemonList = result.results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

    func setUpViews() {
        view.backgroundColor = .systemRed
        view.addSubview(tableView)

        setUpConstraints()
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pokemonList[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
}
