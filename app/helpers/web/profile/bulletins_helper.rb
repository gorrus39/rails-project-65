# frozen_string_literal: true

module Web
  module Profile
    module BulletinsHelper
      def bulletin_states_as_options
        db_states = Bulletin.aasm.states.map(&:name)
        db_states.map { |state| [t("web.profile.bulletins.index.state.#{state}"), state] }
      end
    end
  end
end
