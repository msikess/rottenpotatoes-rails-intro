module ApplicationHelper
    def sorted(header)
        params[:sort] == header ? "hilite" : ''
    end
end
