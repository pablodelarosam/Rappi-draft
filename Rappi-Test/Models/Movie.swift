//
//  Movie.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/16/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import Foundation

struct Movie: Equatable, Hashable, Codable {
    var poster_path: String?
    var adult: Bool?
    var overview: String?
    var id: Int?
    var genre_ids: [Int]?
    var title: String?
}


//"poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
//"adult": false,
//"overview": "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
//"release_date": "2016-08-03",
//"genre_ids": [
//14,
//28,
//80
//],
//"id": 297761,
//"original_title": "Suicide Squad",
//"original_language": "en",
//"title": "Suicide Squad",
//"backdrop_path": "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
//"popularity": 48.261451,
//"vote_count": 1466,
//"video": false,
//"vote_average": 5.91

//"poster_path": "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
//"popularity": 47.432451,
//"id": 31917,
//"backdrop_path": "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
//"vote_average": 5.04,
//"overview": "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
//"first_air_date": "2010-06-08",
//"origin_country": [
//"US"
//],
//"genre_ids": [
//18,
//9648
//],
//"original_language": "en",
//"vote_count": 133,
//"name": "Pretty Little Liars",
//"original_name": "Pretty Little Liars"
