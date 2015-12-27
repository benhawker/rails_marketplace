class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all

    if user.role == "admin"
      can :manage, :all
      
    elsif user.role == "standard"
      can :manage, :all
      can :read, Listing
      can :manage, Listing, :user_id => user.id

      can :read, User
      can :manage, User, :id => user.id
      cannot :destroy, User

      can :read, Offer, :listing => { :user_id => user.id }

      can :read, Inquiry
      can :read, Message
      # cannot :update, User unless :id == user.id

      # can :read, Offer do |offer| 
      #   offer.listing.user.includes? user.id
      # end
    end
  end
end
