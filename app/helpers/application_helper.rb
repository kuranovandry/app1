module ApplicationHelper

def sortable column, title = nil
    title ||= column.titleize
    sort = column.kind_of?(Array) ? column.join(" #{sort_direction}, ") : column
    direction = (sort == sort_column && sort_direction == "asc") ? "desc" : "asc"
    css_class = (sort == sort_column) ? "current #{sort_direction}" : nil
    sort = column.kind_of?(Array) ? column.join(" #{direction}, ") : column
    link_to title, params.merge({ sort: "#{sort}", direction: direction }) , { class: css_class }
end

end

