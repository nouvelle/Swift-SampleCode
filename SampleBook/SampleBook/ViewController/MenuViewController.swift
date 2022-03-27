//
//  MenuViewController.swift
//  SampleBook
//
//  Created by eriko on 2022/03/27.
//

import UIKit

struct Menu {
    var name: String
    var title: String
    var description: String
    var imgName: String
}

class MenuViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let items = [
        Menu(name: "ドリップ コーヒー", title: "厳選された香り高いドリップコーヒー", description: "世界中のコーヒー産地から厳選された高品質のアラビカ種コーヒー豆を使用したスターバックスの定番商品です。バラエティあふれるコーヒー豆を通して、スターバックスのコーヒージャーニーをお楽しみください。異なるローストレベルのコーヒーを日替わりでご用意していますので、お気に入りの1杯を見つけてみませんか。", imgName: "menu01.jpg"),
        Menu(name: "カフェ ミスト", title: "香り高いドリップコーヒーにふわふわのスチームミルクを加えて", description: "高品質のアラビカ種コーヒー豆を使用したドリップ コーヒーにスチームしたミルクを注ぎ、さらにふわふわのフォームミルクをのせました。やさしくホッとできるビバレッジです。", imgName: "menu02.jpg"),
        Menu(name: "スターバックス ラテ", title: "エスプレッソとミルクが互いを引き立て合う、定番のエスプレッソビバレッジ", description: "リッチな風味のエスプレッソにミルクをたっぷりと注いだラテ。エスプレッソとの相性を追求したミルクにより、コーヒーの余韻をお楽しみいただけます。ミルクのほっとする甘さやエスプレッソの豊かなアロマと一緒に、ゆっくりとした時間をお過ごしください。", imgName: "menu03.jpg"),
        Menu(name: "キャラメル マキアート", title: "フォームミルクがたっぷりのったバニラ風味のラテにキャラメルをトッピング", description: "バニラシロップとスチームミルクのコンビネーションになめらかなフォームミルクをたっぷりのせ、その上からエスプレッソを注いでアクセントを付けました。仕上げにオリジナルキャラメルソースをトッピングしています。", imgName: "menu04.jpg"),
        Menu(name: "カフェ アメリカーノ", title: "エスプレッソに特別にろ過したウォーターを加えて", description: "エスプレッソに熱いお湯を注いだ、すっきりとしたのどごしのコーヒーです。ドリップ コーヒーのお好きな方にもおすすめです。", imgName: "menu05.jpg")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    // 値の受け渡しを行う: segueによる画面遷移が行われる直前に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // indexPathForSelectedRow: 最後に選択したセルのindexPathを渡す
        if let selectedRow = tableView.indexPathForSelectedRow {
            // destination: 遷移先の UIViewController を返す（ダウンキャストしている）
            let controller = segue.destination as! MenuDetailViewController
            controller.info = items[selectedRow.row]
        }
    }
    // セルの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // セルの元となる UITableViewCell を返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 引数で渡した文字列にマッチする名前のUITableViewCell のインスタンスを返す
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "NameCell")
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
    

}
