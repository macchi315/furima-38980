require 'rails_helper'

RSpec.describe OrderPayment, type: :model do
  before do
    @order = FactoryBot.build(:order_payment)
  end

  describe '配送先情報の保存ができる' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order).to be_valid
      end
    end
    context '配送先情報の保存ができない' do
      it '郵便番号が空で登録できない' do
        @order.postcode = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Postcode can't be blank")
      end
    end
    context '配送先情報の保存ができない' do
      it '郵便番号が-無しだと登録できない' do
        @order.postcode = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postcode is invalid')
      end
      it '郵便番号が全角数字だと登録できない' do
        @order.postcode = '１２３４５６７'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postcode is invalid')
      end
      it '郵便番号がひらがなだと登録できない' do
        @order.postcode = 'いちにさんしご'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postcode is invalid')
      end
      it '郵便番号が8文字数字だと登録できない' do
        @order.postcode = '123-12345'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postcode is invalid')
      end
      it '郵便番号が英語だと登録できない' do
        @order.postcode = 'aaa-aaaa'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postcode is invalid')
      end
      it 'prefectureが---では登録できない' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @order.sityouson = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Sityouson can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @order.banchi = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Banchi can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @order.tell_number = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Tell number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @order.tell_number = '123 - 1234 - 1234'
        @order.valid?
        expect(@order.errors.full_messages).to include('Tell number is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @order.tell_number = '12345678910123'
        @order.valid?
        expect(@order.errors.full_messages).to include('Tell number is invalid')
      end
      it 'トークンが空だと保存できないこと' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
