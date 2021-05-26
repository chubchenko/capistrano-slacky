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
          ":heart_eyes:"
        ].freeze

        REVERTED_SUCCESSFULLY = [
          ":upside_down_face:",
          ":pensive:",
          ":face_with_raised_eyebrow:",
          ":worried:"
        ].freeze

        DEPLOYMENT_FAILED = [
          ":grimacing:",
          ":face_with_head_bandage:",
          ":face_with_thermometer:",
          ":woozy_face:",
          ":exploding_head:",
          ":sob:",
          ":cry:"
        ].freeze

        ROLLBACK_FAILED = DEPLOYMENT_FAILED

        EMOJI_MAP = {
          deployed_successfully: DEPLOYED_SUCCESSFULLY,
          reverted_successfully: REVERTED_SUCCESSFULLY,
          deployment_failed: DEPLOYMENT_FAILED,
          rollback_failed: ROLLBACK_FAILED
        }.freeze

        def initialize(text)
          super(t("slacky.#{text}", emoji: EMOJI_MAP.fetch(text).sample))
        end
      end
    end
  end
end
