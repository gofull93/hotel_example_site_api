User.create!(id: 1, email: 'ichiro@example.com', username:'山田一郎', rank: 'premium', address: '東京都豊島区池袋', tel: '01234567891', gender: 1, birthday: nil, notification: true, password: 'password')
User.create!(id: 2, email: 'sakura@example.com', username:'松本さくら', rank: 'normal', address: '神奈川県横浜市鶴見区大黒ふ頭', tel: nil, gender: 2, birthday: '2000/04/01', notification: false, password: 'pass1234')
User.create!(id: 3, email: 'jun@example.com', username:'林潤', rank: 'premium', address: '大阪府大阪市北区梅田', tel: '01212341234', gender: 9, birthday: '1988/12/17', notification: false, password: 'pa55w0rd!')
User.create!(id: 4, email: 'yoshiki@example.com', username:'木村良樹', rank: 'normal', address: nil, tel: '01298765432', gender: 0, birthday: '1992/08/31', notification: true, password: 'pass-pass')

Plan.create!(id: 0, name: 'お得な特典付きプラン', room_bill: 7000, min_head_count: 1, max_head_count:	9, min_term: 1, max_term: 9, room_type_id: 2, only: nil)
Plan.create!(id: 1, name: 'プレミアムプラン', room_bill: 10_000, min_head_count: 2, max_head_count: 9, min_term: 1, max_term: 9, room_type_id: 3, only: 'premium')
Plan.create!(id: 2, name: 'ディナー付きプラン', room_bill: 8500, min_head_count: 1, max_head_count: 4, min_term: 1, max_term: 3, room_type_id: 0, only: 'normal')
Plan.create!(id: 3, name: 'お得なプラン', room_bill: 6000, min_head_count: 1, max_head_count: 9, min_term: 1, max_term: 9, room_type_id: 0, only: 'normal')
Plan.create!(id: 4, name: '素泊まり', room_bill: 5500, min_head_count: 1, max_head_count: 2, min_term: 1, max_term: 9, room_type_id: 1, only: nil)
Plan.create!(id: 5, name: '出張ビジネスプラン', room_bill: 7500, min_head_count: 1, max_head_count: 2, min_term: 1, max_term: 9, room_type_id: 1, only: nil)
Plan.create!(id: 6, name: 'エステ・マッサージプラン', room_bill: 9000, min_head_count: 1, max_head_count: 6, min_term: 1, max_term: 9, room_type_id: 0, only: nil)
Plan.create!(id: 7, name: '貸し切り露天風呂プラン', room_bill: 9000, min_head_count: 1, max_head_count: 6, min_term: 1, max_term: 3, room_type_id: 0, only: nil)
Plan.create!(id: 8, name: 'カップル限定プラン', room_bill: 8000, min_head_count: 2, max_head_count: 2, min_term: 1, max_term: 2, room_type_id: 3, only: nil)
Plan.create!(id: 9, name: 'テーマパーク優待プラン', room_bill: 10_000, min_head_count: 1, max_head_count: 9, min_term: 1, max_term: 5, room_type_id: 0, only: nil)

RoomType.create!(id: 0, room_type_name: nil, room_category_name: '部屋指定なし', min_capacity: nil, max_capacity: nil, room_size: nil, facilities: nil)
RoomType.create!(id: 1, room_type_name: 'シングル', room_category_name: nil, min_capacity: 1, max_capacity: 1, room_size: 14, facilities: ['ユニット式バス・トイレ'])
RoomType.create!(id: 2, room_type_name: 'ツイン', room_category_name: 'スタンダード', min_capacity: 1, max_capacity: 2, room_size: 18, facilities: ['ユニット式バス・トイレ', '独立洗面台'])
RoomType.create!(id: 3, room_type_name: 'ツイン', room_category_name: 'プレミアム', min_capacity: 1, max_capacity: 3, room_size: 24, facilities: ['セパレート式バス・トイレ', '独立洗面台'])
