
import UIKit

protocol IFavoriteViewController: AnyObject {}

final class FavoriteViewController: UIViewController, IFavoriteViewController {

	private var contentView: IFavoriteContentView
	private let presenter: IFavoritePresenter
	
	init(presenter: IFavoritePresenter) {
		self.contentView = FavoriteContentView()
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		self.view = contentView
		presenter.loadView(controller: self, view: contentView)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemCyan
		setupNavigationBar()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
}

private extension FavoriteViewController {
	func setupNavigationBar() {
		navigationItem.title = "Favorite"
	 }
}
