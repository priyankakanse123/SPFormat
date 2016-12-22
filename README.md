# SPFormat

var ar = [3.8,2.6,5.9,6.8]
        
        sort(&ar, <)
        // or
        ar = ar.sorted(<)
        
        print(ar);

https://gist.github.com/benvium/acb5d1cd90e6644096d5



//childview controller

let viewController:mPinViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("mPinViewAlert") as! mPinViewController
        
        
//        let mPinView : UIView = viewController.view
//        mPinView.frame = CGRectMake(0, 0, 200, 200)
//        mPinView.center = self.view.center
//        mPinView.layer.cornerRadius = 5
//        mPinView.layer.shadowRadius = 5
//        mPinView.layer.shadowColor = UIColor.darkGrayColor().CGColor
//        
//        self.view.addSubview(mPinView)
        
        self.addChildViewController(viewController)
        viewController.view.frame = CGRectMake(0, 0,250, 250);
        viewController.view.center = self.view.center
        self.view.addSubview(viewController.view)
        viewController.didMoveToParentViewController(self)

