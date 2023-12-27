//
//  ConvertToPost.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation

//MARK: - Приведение типа PostEntity к типу пост
extension PostEntity {
    func convertToPost() -> Post {
        let post = Post(avatarImageId: avatarImageId, avatarName: avatarName, commentsCount: Int(commentsCount), isFavourite: isFavourite, likesCount: Int(likesCount), postDescription: postDescription, postedTime: Int(postedTime), postImageId: postImageId, postTitle: postTitle, postImageWidth: Int(postImageWidth), postImageHeight: Int(postImageHeight), repostsCount: Int(repostsCount))
        return post
    }
}

//MARK: - Приведение типа Feed к типу пост
extension ItemData {
    func convertToPost() -> Post {
        
        var postImageData: AvatarData? {
            if let allItems = self.blocks?.compactMap({ $0.data.items }) {
                for items in allItems {
                    switch items {
                    case .itemsClass(_): break
                    case .unionArray(let itemsUnion):
                        for item in itemsUnion {
                            switch item {
                            case .itemItem(let itemItem):
                                return itemItem.image.data
                            case .string(_): break
                            }
                        }
                    }
                }
            }
            return nil
        }
        let avatarId = self.author?.avatar.data.uuid
        let avatarName = self.author?.name
        let commentsCount = self.counters?.comments
        let repostsCount = self.counters?.reposts
        let isFavourite = false
        let likesCount = self.likes?.counterLikes
        let postDescription = self.blocks?.filter { $0.type == .text }.first?.data.text
        let postedTime = self.date
        let postTitle = self.title
        let postImageWidth = postImageData?.width
        let postImageHeight = postImageData?.height
        let post = Post(avatarImageId: avatarId, avatarName: avatarName, commentsCount: commentsCount, isFavourite: isFavourite, likesCount: likesCount, postDescription: postDescription, postedTime: postedTime, postImageId: postImageData?.uuid, postTitle: postTitle, postImageWidth: postImageWidth, postImageHeight: postImageHeight, repostsCount: repostsCount)
        return post
    }
}
