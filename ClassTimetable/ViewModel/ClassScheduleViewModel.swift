//
//  ClassScheduleViewModel.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/16.
//  Copyright © 2017年 NTUB. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Moya
import RxMoya

class ClassScheduleViewModel {

    private let provider = MoyaProvider<APIManager>()
    private var id: String = ""
    var curriculumModel: CurriculumModel?
    var sessionModels =
        [
            "第一節\n08:10\n09:00",
            "第二節\n09:10\n10:00",
            "第三節\n10:10\n11:00",
            "第四節\n11:10\n12:00",
            "第五節\n13:30\n14:20",
            "第六節\n14:25\n15:15",
            "第七節\n15:25\n16:15",
            "第八節\n16:20\n17:10",
            "第九節\n17:15\n18:05",
            "第十節",
            "第十一節\n18:30\n19:15",
            "第十二節\n19:20\n20:05",
            "第十三節\n20:15\n21:00",
            "第十四節\n21:05\n21:50"
        ]
    var courseModels = [CourseModel]()
    private var disposeBag = DisposeBag()

    var sessionCol: UICollectionView?
    var courseCol: UICollectionView?

    init(sessionCol: UICollectionView, courseCol: UICollectionView) {
        self.sessionCol = sessionCol
        self.courseCol = courseCol
        getLocalData()
    }

    func search(from id: String) {
        self.id = id
        self.loadCurriculumData()
    }

    func loadCurriculumData() {
        provider.rx.request(.getCourse(id))
            .filterSuccessfulStatusCodes()
            .map(CurriculumModel?.self)
            .asObservable()
            .catchErrorJustReturn(nil)
            .subscribe(onNext: { [unowned self] data in
                self.processSuccess(data)
            })
            .disposed(by: disposeBag)
    }

    func processSuccess(_ data: CurriculumModel?) {
        // START: JSON HANDLE
        if let curriculum = data {
            sessionModels.removeAll()
            courseModels.removeAll()

            if let sessionList = curriculum.sessions as? [SessionModel] {
                for session in sessionList {
                    let sessionNo = session.sessionNo ?? ""
                    let startTime = session.startTime ?? ""
                    let endTime = session.endTime ?? ""
                    let sessionInfo = "\(sessionNo)\n\(startTime)\n\(endTime)"
                    sessionModels.append(sessionInfo)
                }
            }

            if let courseList = curriculum.subjects {
                for (week, daySubjects) in zip(0..., courseList) {
                    for (session, subject) in zip(0..., daySubjects) {
                        let courseInfo = CourseModel.init(week: week, session: session, subject: subject)
                        courseModels.append(courseInfo)
                    }
                }
            }

            saveToLocal()
            reloadCollectionView()
        }
        // END: JSON HANDLE
    }

    func reloadCollectionView() {
        sessionCol?.reloadData()
        courseCol?.reloadData()
    }

    private func saveToLocal() {
        let sessionData = try? JSONEncoder().encode(sessionModels)
        let courseData = try? JSONEncoder().encode(courseModels)

        if let data = sessionData {
            UserDefaults.standard.set(data, forKey: "ntub-session")
        }

        if let data = courseData {
            UserDefaults.standard.set(data, forKey: "ntub-course")
        }
    }

    private func getLocalData() {
        if let sessionData = UserDefaults.standard.data(forKey: "ntub-session") {
            if let models = try? JSONDecoder().decode([String].self, from: sessionData) {
                sessionModels = models
            }
        }

        if let courseData = UserDefaults.standard.data(forKey: "ntub-course") {
            if let models = try? JSONDecoder().decode([CourseModel].self, from: courseData) {
                courseModels = models
            }
        }

        if !sessionModels.isEmpty || !courseModels.isEmpty {
            reloadCollectionView()
        }
    }

}
