require 'spec_helper'

module Spree
  module Admin
    describe VariantsController, type: :controller do
      stub_authorization!

      describe "#index" do
        let(:product) { create(:product) }
        let!(:variant_1) { create(:variant, product: product) }
        let!(:variant_2) { create(:variant, product: product) }
        let(:params) { { product_id: product.slug } }

        before { variant_2.destroy }

        subject { get :index, params: params }

        context "deleted is not requested" do
          it "does not assign deleted variants for a requested product" do
            subject
            expect(assigns(:collection)).to include variant_1
            expect(assigns(:collection)).not_to include variant_2
          end
        end

        context "deleted is requested" do
          let(:params) { { product_id: product.slug, deleted: "on" } }
          it "assigns deleted along with non-deleted variants for a requested product" do
            subject
            expect(assigns(:collection)).to include variant_1
            expect(assigns(:collection)).to include variant_2
          end
        end
      end
    end
  end
end
