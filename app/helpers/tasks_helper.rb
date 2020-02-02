module TasksHelper
  def button_text
    if action_name == "new"
      "SAVE"
    elsif action_name == "edit"
      "UPDATE"
    end
  end
end
