class Ability
  include CanCan::Ability

  def initialize(user)

    if user.role == "admin"
      can :manage, :all
      
    elsif user.role == "standard"
      can :read, Listing
      can :manage, Listing, :user_id => user.id

      can :read, User
      can :manage, User, :id => user.id
      cannot :destroy, User

      can :read, Offer, :listing => { :user_id => user.id }

      can :read, Inquiry
      can :read, Message

      # can :read, Offer do |offer| 
      #   offer.listing.user.includes? user.id
      # end
    end
  end
end
