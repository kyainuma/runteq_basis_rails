class UserMailer < ApplicationMailer
  # reset_password_emailメソッドなので、reset_password_email.〇〇のビューがメールのフォーマットになる
  # コントローラの場合と同様、メイラーのメソッド内で定義されたインスタンス変数はメイラーのビューで使える。
  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email,
         subject: t('defaults.password_reset'))
  end
end
