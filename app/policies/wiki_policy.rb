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
       user.present? 
    end

    def update?
        edit?
    end

    private

    def wiki 
        record
    end

end