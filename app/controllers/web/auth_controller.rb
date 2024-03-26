# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      # {
      #   'nickname' => 'tovarish39',
      #   'email' => 'gorrus100@gmail.com',
      #   'name' => 'Alexey ',
      #   'image' => 'https://avatars.githubusercontent.com/u/76408801?v=4',
      #   urls: { 'GitHub' => 'https://github.com/tovarish39', 'Blog' => '' }
      # }
      user_info = request.env['omniauth.auth']['info']

      user = User.find_or_create_by(email: user_info['email'])
      name = user_info['name']
      user.update(name:) if user.name != name # обновление данных юзера, если изменены

      session['user_id'] = user.id

      redirect_to root_path
    end

    def log_out
      session.delete('user_id')
      redirect_to root_path
    end
  end
end
