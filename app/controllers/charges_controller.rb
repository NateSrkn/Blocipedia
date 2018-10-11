class ChargesController < ApplicationController
    require 'stripe'

    def create
        @user = current_user
        @amount = 15_00

        customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
        )

        charge = Stripe::Charge.create(
            customer: customer.id,
            amount: @amount,
            description: "Premium Membership - #{current_user.email}",
            currency: 'usd'
        )

        flash[:notice] = "Thank you for your membership, #{current_user.email}."
        @user.update_attributes(role: 1)
        redirect_to root_path

        rescue Stripe::CardError => e
            flash[:alert] = e.message
            redirect_to new_charge_path
    end


    def new
        @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "Premium Membership - #{current_user.email}",
        amount: 15_00
        }
    end

    def cancel
        @user = current_user
        
        @user.update_attributes(role: 0)
        @user.wikis.where(private: true).update_all(private: false)

        redirect_to wikis_path
      end
    
      private
    
      def upgrade_user_role
        @user.role = 1
      end

end
