//
//  PrecoBitcoinViewController.swift
//  PrecoBitcoin
//
//  Created by Jean Ramalho on 28/03/25.
//
import Foundation
import UIKit

class PrecoBitcoinViewController: UIViewController {
    
    private let contentView: PrecoBitcoinView = PrecoBitcoinView()
    private let service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        
        fetchBitcoinPrice()
        setupContentView()
        setHierarchy()
        setConstraints()
    }
    
    private func setupContentView(){
        
        let updatePrecoButton = contentView.updatePrecoButton

        updatePrecoButton.addTarget(self, action: #selector(updatePrice), for: .touchUpInside)

    }
    
    private func setHierarchy(){
        
        view.addSubview(contentView)
    }
    
    private func setConstraints(){
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func fetchBitcoinPrice(){
        service.fetchBitcoinPrice { [weak self] price in
            DispatchQueue.main.async {
                self?.contentView.precoLabel.text = price
                self?.contentView.updatePrecoButton.setTitle("Atualizar", for: .normal)
            }
        }
    }
    
    @objc private func updatePrice(){
        contentView.updatePrecoButton.setTitle("Atualizando...", for: .normal)
        fetchBitcoinPrice()

        
    }
}
