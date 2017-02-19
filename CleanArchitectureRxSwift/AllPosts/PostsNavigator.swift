import UIKit
import Domain

protocol PostsNavigator {
    func toCreatePost()
    func toPost(_ post: Post)
    func toPosts()
}

class DefaultPostsNavigator: PostsNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: ServiceLocator
    
    init(services: ServiceLocator,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toPosts() {
        let vc = storyBoard.instantiateViewController(ofType: PostsViewController.self)
        vc.viewModel = PostsViewModel(useCase: services.getAllPostsUseCase(),
                                      navigator: self)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func toCreatePost() {
        let vc = storyBoard.instantiateViewController(ofType: CreatePostViewController.self)
        let nc = UINavigationController(rootViewController: vc)
        navigationController.present(nc, animated: true, completion: nil)
    }
    
    func toPost(_ post: Post) {
        print("\(#function)\(post)")
    }
}