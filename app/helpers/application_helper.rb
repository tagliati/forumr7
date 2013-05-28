module ApplicationHelper
  def create_tree(post)
    html=''
    if post
      if @posts_loaded >= @start
        html = "<li><i>#{post.created_at.strftime "%Y-%m-%d %H:%M:%S"}</i> #{post.comment} #{render :partial => 'shared/treeform',:locals => {:post => post}}</li>"
      end
      @posts_loaded += 1
      if post.children.any?
        for child in post.children
          if @posts_loaded == @final
            break
          end
          html << "<ul>"
          html << create_tree(child)
          html << "</ul>"
        end
      end
    end
    return html
  end

  def tree_info(post)
    if post
      @total_posts += 1
      if post.children.any?
        for template_child in post.children
          tree_info(template_child)
        end
      else
        @counter += 1
      end
    end
  end

  def paginate
    @total_pages = (@total_posts/10).ceil
    render :partial => 'shared/paginate'
  end

end
