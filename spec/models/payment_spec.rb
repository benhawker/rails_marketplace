require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { should belong_to(:listing_transaction).class_name('Transaction').with_foreign_key('payment_id') }
  it { should belong_to(:payer).class_name('User').with_foreign_key('payer_id') }
  it { should belong_to(:recipient).class_name('User').with_foreign_key('recipient_id') }

  pending "payment status" do
    it 'payment has a status of "pending" by default' do
      expect(payment.status).to eq ("pending")
    end

    it 'payment is invalid if status is not found within Payment::VALID_STATES' do
      payment.status = "bob"
      expect(payment).to_not be_valid
      expect(payment.errors[:status]).to include "is not included in the list"
    end

    it 'payment is invalid if status is blank' do
      payment.status = nil
      expect(payment).to_not be_valid
      expect(payment.errors[:status]).to include "is not included in the list"
    end
  end

end


