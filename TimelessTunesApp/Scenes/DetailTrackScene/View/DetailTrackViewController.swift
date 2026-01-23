
import UIKit

protocol IDetailTrackViewController: AnyObject {}

final class DetailTrackViewController: UIViewController, IDetailTrackViewController {
	
	private let contentView: IDetailTrackView
	private let presenter: IDetailTrackPresenter
	
	init(presenter: IDetailTrackPresenter) {
		self.contentView = DetailTrackView()
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
		view.backgroundColor = .red
	}
}
