require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = build(:item)
  end

  context '商品出品ができるとき' do
    it '全ての値が正しく入力されていれば保存できる' do
      expect(@item).to be_valid
    end
  end

  context '商品出品ができないとき' do
    it '画像が必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が必須であること' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品の説明が必須であること' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end

    it 'カテゴリーが---では保存できないこと' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it '価格が空では保存できないこと' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end

    it '価格が300未満では保存できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格が9,999,999を超えると保存できないこと' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end

    it '価格は半角数値のみ保存可能であること' do
      @item.price = '３０００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
  end
end
