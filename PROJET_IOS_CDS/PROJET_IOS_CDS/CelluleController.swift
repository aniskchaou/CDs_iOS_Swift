//KCHAOU Anis, LAHLOU Mohammed

import UIKit

class CelluleController: UITableViewCell {
    
    //decalaration des labels
    @IBOutlet weak var auteur: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var titre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
 
    }
    
    
    
}
