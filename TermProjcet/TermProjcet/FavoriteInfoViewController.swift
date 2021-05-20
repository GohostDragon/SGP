//
//  FavoriteInfoViewController.swift
//  TermProjcet
//
//  Created by kpugame on 2021/05/20.
//

import UIKit
import Charts

class FavoriteInfoViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var favTableVIew: UITableView!
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    var unitsSold: [Double]!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
               
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 20)
        barChartView.noDataTextColor = .lightGray
        
        setChart(dataPoints: months, values: unitsSold)
        
        favTableVIew!.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Favorite.SharedInstance().favlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath)
        
        cell.textLabel?.text = Favorite.SharedInstance().favlist[indexPath.row].title
        cell.detailTextLabel?.text = Favorite.SharedInstance().favlist[indexPath.row].addr
        return cell
    }
        
    func setChart(dataPoints: [String], values: [Double]) {
        
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "판매량")
        
        // 차트 컬러
        chartDataSet.colors = [.systemBlue]
        
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        barChartView.doubleTapToZoomEnabled = false


        // X축 레이블 위치 조정
        barChartView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)

        
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        
        // 오른쪽 레이블 제거
        barChartView.rightAxis.enabled = false
        
        // 기본 애니메이션
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // 옵션 애니메이션
        //barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)


        // 리미트라인
        //let ll = ChartLimitLine(limit: 10.0, label: "타겟")
        //barChartView.leftAxis.addLimitLine(ll)


        // 맥시멈
        //barChartView.leftAxis.axisMaximum = 30
        // 미니멈
        //barChartView.leftAxis.axisMinimum = -10

        
        // 백그라운드컬러
        //barChartView.backgroundColor = .yellow
        
    }

}
