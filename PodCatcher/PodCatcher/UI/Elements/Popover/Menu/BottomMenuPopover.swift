import UIKit

final class BottomMenuPopover: BasePopoverMenu {
    
    var popView: MenuView = {
        let popView = MenuView()
      //  popView.backgroundColor = PlayerViewConstants.titleViewBackgroundColor
        popView.isUserInteractionEnabled = true
        return popView
    }()
    
    public override func showPopView(viewController: UIViewController) {
        super.showPopView(viewController: viewController)
        viewController.view.addSubview(popView)
        viewController.view.bringSubview(toFront: popView)
        
        UIView.animate(withDuration: 0.5) {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.popView.alpha = 1
                strongSelf.popView.frame = CGRect(x: viewController.view.bounds.width * 0.001,
                                                  y: viewController.view.bounds.height * 0.45,
                                                  width: viewController.view.bounds.width,
                                                  height: viewController.view.bounds.height * 0.55)
                strongSelf.layoutIfNeeded()
            }
        }
        let tap = UIGestureRecognizer(target: self, action: #selector(hidePopView(viewController:)))
        containerView.addGestureRecognizer(tap)
    }
    
    public override func hidePopView(viewController: UIViewController) {
        super.hidePopView(viewController: viewController)
    }
    
    func dismissMenu(controller: UIViewController) {
        removeFromSuperview()
        hidePopView(viewController: controller)
        controller.view.sendSubview(toBack: self)
    }
    
    func hideMenu(controller: UIViewController) {
        hidePopView(viewController: controller)
        popView.removeFromSuperview()
    }
    
    func setupPop() {
        popView.isUserInteractionEnabled = true
        popView.configureView()
        popView.layer.borderWidth = 1.5
    }
}



