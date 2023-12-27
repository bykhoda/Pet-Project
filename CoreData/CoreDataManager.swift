//
//  CoreDataManager.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    private let networkManager = NetworkClient()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    //MARK: - Создание (сохранение) поста в БД
    public func createPost(from postData: Post) {
        guard let postDescription = NSEntityDescription.entity(forEntityName: "PostEntity", in: context) else { return }
        let postEntity = PostEntity(entity: postDescription, insertInto: context)
        
        postEntity.avatarImageId = postData.avatarImageId
        postEntity.avatarName = postData.avatarName
        postEntity.postedTime = Int64(postData.postedTime ?? 0)
        postEntity.postTitle = postData.postTitle
        postEntity.postDescription = postData.postDescription
        postEntity.postImageId = postData.postImageId
        postEntity.commentsCount = Int64(postData.commentsCount ?? 0)
        postEntity.likesCount = Int64(postData.likesCount ?? 0)
        postEntity.isFavourite = postData.isFavourite
        postEntity.postImageWidth = Int64(postData.postImageWidth ?? 0)
        postEntity.postImageHeight = Int64(postData.postImageHeight ?? 0)
        postEntity.repostsCount = Int64(postData.repostsCount ?? 0)
        
        appDelegate.saveContext()
    }
    
    //MARK: - Получение постов
    public func fetchPosts() -> [Post] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostEntity")
        do {
            let postEntities = (try? context.fetch(fetchRequest) as? [PostEntity]) ?? []
            let posts = postEntities.map { $0.convertToPost() }
            return posts
        }
    }
    
    //MARK: - Удаление постов
    public func deleteAllPosts() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostEntity")
        do {
            let posts = try? context.fetch(fetchRequest) as? [PostEntity]
            posts?.forEach({ context.delete($0) })
        }
        appDelegate.saveContext()
    }
    
}
