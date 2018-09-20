class WikiPolicy < ApplicationPolicy

    def index? 
        true
    end

    def show?
        true
    end
    
    def create? 
        user.present?
    end

    def new?
        create?
    end

    def edit?
      user.try(:admin?) || record.user == user
    end

    def update?
        edit?
    end

    def destroy?
        edit?
    end


end