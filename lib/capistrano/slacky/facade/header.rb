# frozen_string_literal: true

module Capistrano
  module Slacky
    module Facade
      class Header < ::Capistrano::Slacky::Block::Header
        DEPLOYED_SUCCESSFULLY = [
          ":smile:",
          ":drooling_face:",
          ":sunglasses:",
          ":partying_face:",
          ":heart_eyes:",
          ":star-struck:",
          ":yum:"
        ].freeze

        REVERTED_SUCCESSFULLY = [
          ":upside_down_face:",
          ":pensive:",
          ":face_with_raised_eyebrow:",
          ":worried:",
          ":pleading_face:",
          ":shushing_face:"
        ].freeze

        DEPLOYMENT_FAILED = [
          ":grimacing:",
          ":face_with_head_bandage:",
          ":face_with_thermometer:",
          ":woozy_face:",
          ":exploding_head:",
          ":sob:",
          ":cry:",
          ":dizzy_face:",
          ":face_with_hand_over_mouth:",
          ":broken_heart:"
        ].freeze

        ROLLBACK_FAILED = DEPLOYMENT_FAILED

        EMOJI_MAP = {
          deployed_successfully: DEPLOYED_SUCCESSFULLY,
          reverted_successfully: REVERTED_SUCCESSFULLY,
          deployment_failed: DEPLOYMENT_FAILED,
          rollback_failed: ROLLBACK_FAILED
        }.freeze

        def initialize(text)
          super(::I18n.t("slacky.#{text}", scope: "capistrano", emoji: EMOJI_MAP.fetch(text).sample))
        end
      end
    end
  end
end
