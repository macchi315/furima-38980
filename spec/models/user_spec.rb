require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it '名字が空欄だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '名前が空欄だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名前が空欄だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'お名前カナ(全角)の名字が空欄だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'お名前カナ(全角)の名前が空欄だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it '生年月日が空欄だと登録できない' do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
      it '名字(全角)は、半角カタカナだと入力できない' do
        @user.last_name = 'ｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名字(全角)は、数字だと入力できない' do
        @user.last_name = '11'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名字(全角)は、英語だと入力できない' do
        @user.last_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名前(全角)は、半角カタカナだと入力できない' do
        @user.first_name = 'ｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名前(全角)は、数字だと入力できない' do
        @user.first_name = '11'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名前(全角)は、英語だと入力できない' do
        @user.first_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'お名前カナ(全角)は、半角カタカナだと入力できない' do
        @user.last_name_kana = 'ｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'お名前カナ(全角)は、ひらがなだと入力できない' do
        @user.last_name_kana = 'いい'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'お名前カナ(全角)は、英語だと入力できない' do
        @user.last_name_kana = 'ee'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'お名前カナ(全角)は、漢字だと入力できない' do
        @user.last_name_kana = '田中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'お名前カナ(全角)は、数字だと入力できない' do
        @user.last_name_kana = '11'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'お名前カナ(全角)は、半角カタカナだと入力できない' do
        @user.first_name_kana = 'ｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it 'お名前カナ(全角)は、ひらがなだと入力できない' do
        @user.first_name_kana = 'いい'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it 'お名前カナ(全角)は、英語だと入力できない' do
        @user.first_name_kana = 'ee'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it 'お名前カナ(全角)は、漢字だと入力できない' do
        @user.first_name_kana = '田中'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it 'お名前カナ(全角)は、数字だと入力できない' do
        @user.first_name_kana = '11'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = '1234あ5'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it '英字のみのパスワードでは登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it '数字のみのパスワードでは登録できない' do
        @user.password = '432562'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
    end
  end
end
