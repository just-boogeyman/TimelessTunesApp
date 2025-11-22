
import UIKit

protocol IFavoriteViewController: AnyObject {
	var handlerUpdate: (() -> Void)? { get set }
}

final class FavoriteViewController: UIViewController, IFavoriteViewController {

	private var contentView: IFavoriteContentView
	private let presenter: IFavoritePresenter
	var handlerUpdate: (() -> Void)?
	
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
		setupView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		handlerUpdate?()
	}
}

private extension FavoriteViewController {
	func setupView() {
		navigationItem.title = "Favorite"
		view.backgroundColor = .white
	 }
}
