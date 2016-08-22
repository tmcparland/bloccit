module PostHelper
    
   def user_is_authorized_to_edit_post?(post)
       current_user && (current_user == post.user || current_user.mod? || current_user.admin?)
   end

   def user_is_authorized_to_delete_post?(post)
      current_user && (current_user == post.user || current_user.admin? )
   end
   
end
