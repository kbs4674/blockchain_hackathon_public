# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## 테스트 계정 생성(어드민 권한 O)
test1 = User.create( email: 'kbs4674@naver.com', password: '123456', nickname: '어드민', admin: true, eathereum_hash: "0x32fc929d805fe0d72f7b822141c6ae68cb48ae44" )
user = User.find(1)
user.add_role :admin

## 게시판 생성
# Bulletin.create( title: '어드민 게시판', content: '어드민만 글 작성이 가능한 게시판 입니다', opt_admin_only: true, user_nickname: '어드민', user_id: '1' )
# Bulletin.create( title: '투표 게시판', content: '게시글 및 댓글에 투표가 가능합니다.', opt_post_vote: true, opt_comment_vote: true , user_nickname: '어드민', user_id: '1' )
# Bulletin.create( title: '이메일 전송 게시판', content: '이메일 전송이 가능한 게시판 입니다', opt_email: true, opt_email_quantity: '2', user_nickname: '어드민', user_id: '1' )
# Bulletin.create( title: '자유게시판', content: '누구나 글쓰기가 가능한 게시판 입니다', opt_hashtag: true, user_nickname: '어드민', user_id: '1' )
# Bulletin.create( title: '해시태그 자유게시판', content: '누구나 글쓰기가 가능한 게시판 입니다', opt_hashtag: true, user_nickname: '어드민', user_id: '1' )
Bulletin.create( title: '시민 청원', content: '여러분들의 민주주의를 투표로 행사하세요!', opt_card: true, opt_post_vote: true, user_nickname: '어드민', user_id: '1' )
Bulletin.create( title: '정책 투표', content: '다양한 안건 중 마음에 드는 안건에 투표해 보세요!', opt_card: true, opt_agenda: true, opt_admin_only: true, user_nickname: '어드민', user_id: '1' )
Bulletin.create( title: '토큰 상점', content: '토큰으로 다양한 상품을 구매해보세요!', opt_shop: true, opt_card: true, opt_admin_only: true, user_nickname: '어드민', user_id: '1' )

## 데이터 테스트용
# for num in 1..50000
#     AllNotice.create( title: "#{num}", content: "안녕#{num+2}", global_notice: 'false', local_notice: 'false', user_nickname: "어드민", user_id: "1" )
# end