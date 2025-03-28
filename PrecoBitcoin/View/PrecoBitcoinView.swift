//
//  PrecoBitcoinViewController.swift
//  PrecoBitcoin
//
//  Created by Jean Ramalho on 28/03/25.
//
import Foundation
import UIKit

class PrecoBitcoinView: UIView {
    
    lazy var bitcoinImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "bitcoin")
        return image
    }()
    
    lazy var precoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 48, weight: .heavy)
        label.textColor = .orange
        label.text = "R$ 222,22"
        return label
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = .white
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        
        addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(bitcoinImageView)
        mainStackView.addArrangedSubview(precoLabel)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            bitcoinImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06),
        ])
    }
}
