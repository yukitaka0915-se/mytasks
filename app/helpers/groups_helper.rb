module GroupsHelper
  # 正常に動作していない
  def judge_delete_tasklist(edit_flg, authority_flg)
    content_tag(:div, class: "mytask-group-form__delete-btn") do 
      if edit_flg == true and authority_flg == false
        content_tag(:a, value:"削除" , class: "mytask-group-form__delete-btn", method: :delete) 
      end
    end
  end
end