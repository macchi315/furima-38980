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
        expect(@order_payment.errors.full_messages).to include("Postcode can't be blank")
      end
    end
    context '配送先情報の保存ができない' do
      it '郵便番号が-無しだと登録できない' do
        @order_payment.postcode = '1234567'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Postcode is invalid')
      end
      it '郵便番号が全角数字だと登録できない' do
        @order_payment.postcode = '１２３４５６７'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Postcode is invalid')
      end
      it '郵便番号がひらがなだと登録できない' do
        @order_payment.postcode = 'いちにさんしご'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Postcode is invalid')
      end
      it '郵便番号が8文字数字だと登録できない' do
        @order_payment.postcode = '123-12345'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Postcode is invalid')
      end
      it '郵便番号が英語だと登録できない' do
        @order_payment.postcode = 'aaa-aaaa'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Postcode is invalid')
      end
      it 'prefectureが---では登録できない' do
        @order_payment.prefecture_id = 1
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @order_payment.sityouson = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Sityouson can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @order_payment.banchi = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Banchi can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @order_payment.tell_number = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Tell number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @order_payment.tell_number = '123 - 1234 - 1234'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Tell number is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @order_payment.tell_number = '12345678910123'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Tell number is invalid')
      end
      it 'トークンが空だと保存できないこと' do
        @order_payment.token = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Token can't be blank")
      end
      it '電話番号が9桁以下では購入できない' do
        @order_payment.tell_number = '123456789'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Tell number is invalid")
      end
      it 'userが紐付いていなければ購入できない' do
        #@order_payment.user = nil
        @order_payment.user_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_payment.item_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end