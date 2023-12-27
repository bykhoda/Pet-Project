//
//  PostCell.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

final class PostCell: UITableViewCell {
    
    private let cellViewModel: PostCellViewModel!
    
    var post: Post?
    
    //MARK: - Приватные UI-свойства:
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let categoryImageView: RoundedImageView = {
        let imageView = RoundedImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.fixColorBlending()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .gray
        label.fixColorBlending()
        return label
    }()
    
    private let menuButton: UIButton = {
        let button = CustomExpandedButton()
        let ellipsisImage = UIImage(systemName: "ellipsis")
        button.setImage(ellipsisImage, for: .normal)
        return button
    }()
    
    private let optionsMenu: UIMenu = {
        //Действия для UIMenu:
        let action1 = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { action in
            print("проверка функционала кнопки поделиться")
        }
        
        let actions = [action1]
        let menu = UIMenu(children: actions)
        return menu
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 2
        label.fixColorBlending()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textColor = .black
        label.fixColorBlending()
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let commentsCountButton: UIButton = {
        let button = UIButton()
        let commentImage = UIImage(systemName: "bubble.right")
        let commentImageTapped = UIImage(systemName: "bubble.right.fill")
        button.setImage(commentImage, for: .normal)
        button.setImage(commentImageTapped, for: .selected)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.fixColorBlending()
        return button
    }()
    
    private let repostsCountButton: UIButton = {
        let button = UIButton()
        let repostImage = UIImage(systemName: "arrow.2.squarepath")
        button.setImage(repostImage, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.fixColorBlending()
        return button
    }()
    
    private let favoritesButton: UIButton = {
        let button = UIButton()
        let notFavoriteImage = UIImage(systemName: "bookmark")
        let isFavoriteImage = UIImage(systemName: "bookmark.fill")
        button.setImage(notFavoriteImage, for: .normal)
        button.setImage(isFavoriteImage, for: .selected)
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image = UIImage(systemName: "chevron.up", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let dislikeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image = UIImage(systemName: "chevron.down", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.fixColorBlending()
        return label
    }()
    
    //MARK: - Добавление subview
    
    private func setupViews() {
        contentView.addSubview(stackView)
        stackView.addSubview(categoryImageView)
        stackView.addSubview(categoryLabel)
        stackView.addSubview(durationLabel)
        stackView.addSubview(menuButton)
        stackView.addSubview(titleLabel)
        stackView.addSubview(descriptionLabel)
        stackView.addSubview(postImageView)
        stackView.addSubview(commentsCountButton)
        stackView.addSubview(repostsCountButton)
        stackView.addSubview(favoritesButton)
        stackView.addSubview(dislikeButton)
        stackView.addSubview(likeButton)
        stackView.addSubview(likesCountLabel)
    }
    
    private var isFavourite: Bool = false {
        didSet {
            favoritesButton.isSelected = isFavourite ? true : false
            let notFavoriteImage = UIImage(systemName: "bookmark")
            let isFavoriteImage = UIImage(systemName: "bookmark.fill")
            favoritesButton.setImage(isFavourite ? isFavoriteImage : notFavoriteImage, for: .normal)
        }
    }
    
    //MARK: - Установка констреинтов
    
    private func setupConstraints() {
        
        self.backgroundColor = UIColor.white
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(5)
            make.horizontalEdges.equalToSuperview().inset(5)
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(1)
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.top.equalToSuperview().inset(2)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryImageView.snp.trailing).inset(-3)
            make.centerY.equalTo(categoryImageView.snp.centerY)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryLabel.snp.trailing).inset(-8)
            make.centerY.equalTo(categoryImageView.snp.centerY)
        }
        
        menuButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.centerY.equalTo(categoryImageView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-10)
            make.leading.equalTo(categoryImageView.snp.leading)
            make.trailing.equalTo(menuButton.snp.trailing)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-5)
            make.leading.equalTo(categoryImageView.snp.leading)
            make.trailing.equalTo(menuButton.snp.trailing)
        }
        
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).inset(-5)
            make.horizontalEdges.equalToSuperview().inset(-5)
            guard let width = post?.postImageWidth, let height = post?.postImageHeight, width != 0 else { return }
            make.height.equalTo(postImageView.snp.width).multipliedBy(height/width)
        }
        
        commentsCountButton.snp.makeConstraints { make in
            make.leading.equalTo(categoryImageView.snp.leading)
            make.top.equalTo(postImageView.snp.bottom).inset(-5)
            make.bottom.equalToSuperview().inset(1)
        }
        
        repostsCountButton.snp.makeConstraints { make in
            make.leading.equalTo(commentsCountButton.snp.trailing).inset(-3)
            make.top.equalTo(postImageView.snp.bottom).inset(-5)
            make.bottom.equalToSuperview().inset(1)
        }
        
        favoritesButton.snp.makeConstraints { make in
            make.leading.equalTo(repostsCountButton.snp.trailing).inset(-5)
            make.top.equalTo(postImageView.snp.bottom).inset(-5)
            make.bottom.equalToSuperview().inset(1)
        }
        
        dislikeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(1)
            make.bottom.equalToSuperview().inset(1)
            make.top.equalTo(postImageView.snp.bottom).inset(-5)
        }
        
        likesCountLabel.snp.makeConstraints { make in
            make.trailing.equalTo(dislikeButton.snp.leading).inset(-2)
            make.bottom.equalToSuperview().inset(1)
            make.top.equalTo(postImageView.snp.bottom).inset(-5)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(likesCountLabel.snp.leading).inset(-2)
            make.bottom.equalToSuperview().inset(1)
            make.top.equalTo(postImageView.snp.bottom).inset(-5)
        }
        
    }
    
    //MARK: - Установка свойств для UI-элементов
    
    private func setupCell() {
        let baseImgURL = Constants.baseImageURLString
        // Установка изображения аватара, если доступно
        let avatarPlaceholder = UIImage(named: "placeholderAvatar")
        if let avatarId = post?.avatarImageId {
            let avatarImageURL = URL(string: baseImgURL + avatarId)
            categoryImageView.sd_setImage(with: avatarImageURL, placeholderImage: avatarPlaceholder)
        } else {
            categoryImageView.image = avatarPlaceholder
        }
        
        // Установка текста со временем
        if let timePosted = post?.postedTime {
            durationLabel.text = cellViewModel.timeAgoString(from: timePosted)
        }
        
        // Установка изображения поста
        if let postImageId = post?.postImageId {
            let postPlaceholder = UIImage(named: "postPlaceholder")
            let postImageURL = URL(string: baseImgURL + postImageId)
            postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            postImageView.sd_setImage(with: postImageURL, placeholderImage: postPlaceholder)
        }
        
        // Установка текста для кнопок счетчиков комментариев и репостов
        commentsCountButton.setTitle("\(post?.commentsCount ?? 0)", for: .normal)
        repostsCountButton.setTitle("\(post?.repostsCount ?? 0)", for: .normal)
        
        // Установка текста для метки количества лайков
        likesCountLabel.text = "\(post?.likesCount ?? 0)"
        
        // Установка текста для меток категории, заголовка и описания поста
        categoryLabel.text = post?.avatarName ?? ""
        titleLabel.text = post?.postTitle ?? ""
        descriptionLabel.text = post?.postDescription ?? ""
    }
    
    //MARK: - Инициализация ячейки
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, post: Post, cellViewModel: PostCellViewModel) {
        self.post = post
        self.cellViewModel = cellViewModel
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupCell()
        setupConstraints()
        favoritesButton.addTarget(self, action: #selector(favouriteDidTapped), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(configureButtonMenu), for: .touchUpInside)
        let tapGestureRecognizer = UITapGestureRecognizer(target: cellViewModel, action: #selector(cellViewModel.cellImageTapped(_:)))
        postImageView.isUserInteractionEnabled = true
        postImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func prepareForReuse() {
        post = nil
    }
    
    //MARK: - Добавить пост в избранное
    
    @objc func favouriteDidTapped() {
        isFavourite = !isFavourite
    }
    
    //MARK: - Вызов меню у поста:
    
    @objc func configureButtonMenu() {
        menuButton.menu = optionsMenu
        menuButton.showsMenuAsPrimaryAction = true
    }
    
}

//MARK: - Установка opaque для Color Blended Layer

extension UILabel {
    func fixColorBlending() {
        self.isOpaque = true
        self.backgroundColor = .white
    }
}
