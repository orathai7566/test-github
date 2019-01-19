import UIKit

final class PDFTopLedger1Footer: UIView {
    
    @IBOutlet weak var viewMarkerRight: UIView!
    @IBOutlet weak var imageRightCar: UIImageView!
    
    @IBOutlet weak var viewMarkerFront: UIView!
    @IBOutlet weak var imageFrontCar: UIImageView!
    
    @IBOutlet weak var viewMarkerLeft: UIView!
    @IBOutlet weak var imageLeftCar: UIImageView!
    
    @IBOutlet weak var viewMarkerRear: UIView!
    @IBOutlet weak var imageRearCar: UIImageView!
    
    @IBOutlet weak var borderDropOffDate: UILabel!
    @IBOutlet weak var borderPickUpDate: UILabel!
    
    @IBOutlet weak var dropOffDateLabel: UILabel!
    @IBOutlet weak var pickupDateLabel: UILabel!
    
    // MARK: Public
    public func configure(withOrder order: Order) {
        setDate(withOrder: order)
        setMarker(order: order)
        setupBorder()
    }
    
    // MARK: Fileprivate
    fileprivate func setupBorder() {
        let group: [UIView] = [borderDropOffDate, borderPickUpDate, dropOffDateLabel, pickupDateLabel]
        group.forEach({$0.setBorder(color: .black, width: 0.5)})
    }
    
    fileprivate func setDate(withOrder order:Order) {
        if let dropOffDate = order.dropoffDate {
            self.dropOffDateLabel.text = String(format: "%@ %@", dropOffDate.toJapShortDate(), dropOffDate.toTimeString())
        }
        if  order.status != CartStatus.pickedUp {
            if let pickUpDate = order.pickUpDate {
                self.pickupDateLabel.text = String(format: "%@ %@", pickUpDate.toJapShortDate(), pickUpDate.toTimeString())
            }
        } else {
            if let pickUpDate = order.actualPickUpDate {
                self.pickupDateLabel.text = String(format: "%@ %@", pickUpDate.toJapShortDate(), pickUpDate.toTimeString())
            }
        }
    }
    
    fileprivate func setMarker(order:Order) {
        var damages = [NewDamage]()
        for item in order.orderItems {
            if let repair = item.product.repairProduct {
                let id = Int.random(1000000, to: 9999999)
                let damage = NewDamage(id: id,
                                       touches: Int(item.quantity),
                                       unitPrice: item.unitPrice,
                                       side: repair.side,
                                       partName: item.name,
                                       position: repair.position,
                                       type: repair.type,
                                       willBeFixed: repair.willBeFixed,
                                       photos: [UIImage](),
                                       photoUrls: nil,
                                       orderItemID: nil)
                damages.append(damage)
            }
        }
        
        for damage in damages {
            guard let viewMarkerFront = self.viewMarkerFront else { continue }
            let damageMarker = NewDamageMarker(damage: damage, size: .small, readOnly: true, view: viewMarkerFront)
            switch damageMarker.damage.side {
            case .front:
                self.viewMarkerFront.addSubview(damageMarker)
            case .rear:
                self.viewMarkerRear.addSubview(damageMarker)
            case .left:
                self.viewMarkerLeft.addSubview(damageMarker)
            case .right:
                self.viewMarkerRight.addSubview(damageMarker)
            }
        }
    }
    
    
    
}













