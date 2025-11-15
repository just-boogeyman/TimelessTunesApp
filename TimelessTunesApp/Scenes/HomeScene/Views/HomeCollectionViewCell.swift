//
//  HomeCollectionViewCell.swift
//  TimelessTunesApp
//
//  Created by Ярослав Кочкин on 14.11.2025.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
	
	private let imageView = UIImageView()
	private let executorLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(viewModel: HomeViewModel) {
		imageView.image = UIImage(resource: .image1)
		executorLabel.text = viewModel.trackName
	}
	
}

private extension HomeCollectionViewCell {
	
	func setupView() {
		backgroundColor = .white
		layer.cornerRadius = 15
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.1
		layer.shadowOffset = CGSize(width: 3, height: 3)
		layer.shadowRadius = 3
		
		[imageView, executorLabel]
			.forEach{contentView.addSubview($0)}
		
		setupImage()
		setupLabel()
		setupLayout()
	}
	
	func setupImage() {
		imageView.layer.cornerRadius = 10
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFill
		imageView.layer.masksToBounds = true
	}
	
	func setupLabel() {
		executorLabel.font = .systemFont(ofSize: 14, weight: .medium)
		executorLabel.textColor = UIColor(resource: .textPrimary)
	}
	
}

// MARK: - Setup Layout

private extension HomeCollectionViewCell {
	func setupLayout() {
		[imageView, executorLabel]
			.forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			imageView.heightAnchor.constraint(equalToConstant: 130),

			executorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
			executorLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
			executorLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
		])
	}
}
