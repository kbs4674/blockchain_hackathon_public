class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title # 제목
      t.text :content # 내용
      t.string :summary
      t.integer :price
      t.string :user_nickname # 유저 닉네임
      
      t.string :opt_agenda1 #안건 1
      t.string :opt_agenda2 #안건 2
      t.string :opt_agenda3 #안건 3
      t.string :opt_agenda4 #안건 4
      t.string :opt_agenda5 #안건 5
      t.string :opt_agenda6 #안건 6
      t.string :opt_agenda7 #안건 7
      t.string :opt_agenda8 #안건 8
      t.string :opt_agenda9 #안건 9
      t.string :opt_agenda10 #안건 10
      
      t.string :email # 이메일 주소 적는 란(이메일 전송 게시판에서 쓰이는 Attribute)
      t.string :thumb_image
      t.integer :user_id # 게시글 작성자 정보(유저 번호)

      t.timestamps
    end
  end
end
