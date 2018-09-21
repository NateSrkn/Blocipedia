require 'stripe'
class ChargesController < ApplicationController

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
        redirect_to user_path(current_user)

        rescue Stripe::CardError => e
            flash[:alert] = e.message
            redirect_to new_charge_path
    end


    def new
        @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "Premium Membership - #{current_user.name}",
        amount: 15_00
        }
    end

    def cancel
        subscription = Stripe::Subscription.retrieve("sub_8Xw6Ak8Gc4EvJx")
        subscription.delete(at_period_end: true)
        
        current_user.update_attribute(:role, 'standard')
        current_user.wikis.where(private: true).update_all(private: false)
        
        
        flash[:notice] = "You are now a Standard Member."
        redirect_to wikis_path
      end
    
      private
    
      def upgrade_user_role
        @user.role = 1
      end

end
