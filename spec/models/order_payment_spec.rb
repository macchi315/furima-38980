require 'rails_helper'

RSpec.describe OrderPayment, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_payment = FactoryBot.build(:order_payment, user_id: user.id, item_id: item.id)
    sleep(0.1) #データベースの処理よりもPが早く動こうとして、テストエラーになる事があるため、sleepを入れています（PC環境により異なる）
  end

  describe '配送先情報の保存ができる' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_payment).to be_valid
      end
      it '建物名が空でも購入できる' do
        @order_payment.build_name = ''
        expect(@order_payment).to be_valid
      end
    end
    context '配送先情報の保存ができない' do
      it '郵便番号が空で登録できない' do
        @order_payment.postcode = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("郵便番号を入力してください")
      end
    end
    context '配送先情報の保存ができない' do
      it '郵便番号が-無しだと登録できない' do
        @order_payment.postcode = '1234567'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '郵便番号が全角数字だと登録できない' do
        @order_payment.postcode = '１２３４５６７'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '郵便番号がひらがなだと登録できない' do
        @order_payment.postcode = 'いちにさんしご'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '郵便番号が8文字数字だと登録できない' do
        @order_payment.postcode = '123-12345'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '郵便番号が英語だと登録できない' do
        @order_payment.postcode = 'aaa-aaaa'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it 'prefectureが---では登録できない' do
        @order_payment.prefecture_id = 1
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市区町村が空だと保存できないこと' do
        @order_payment.sityouson = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が空だと保存できないこと' do
        @order_payment.banchi = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空だと保存できないこと' do
        @order_payment.tell_number = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @order_payment.tell_number = '123 - 1234 - 1234'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @order_payment.tell_number = '12345678910123'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'トークンが空だと保存できないこと' do
        @order_payment.token = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it '電話番号が9桁以下では購入できない' do
        @order_payment.tell_number = '123456789'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'userが紐付いていなければ購入できない' do
        #@order_payment.user = nil
        @order_payment.user_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_payment.item_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end