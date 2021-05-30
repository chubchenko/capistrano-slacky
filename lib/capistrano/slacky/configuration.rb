# frozen_string_literal: true

module Capistrano
  module Slacky
    class Configuration
      DEFAULT_USERNAME = "ChatOps"
      DEFAULT_ICON_EMOJI = ":robot_face:"
      DEFAULT_CHANNEL = "#deployment"

      private_constant :DEFAULT_USERNAME, :DEFAULT_ICON_EMOJI, :DEFAULT_CHANNEL

      def initialize(env: ::Capistrano::Configuration.env)
        @env = env
      end

      def username
        data.fetch(:username, DEFAULT_USERNAME)
      end

      def icon_emoji
        data.fetch(:icon_emoji, DEFAULT_ICON_EMOJI)
      end

      def channel
        data.fetch(:channel, DEFAULT_CHANNEL)
      end

      def klass
        data[:klass]
      end

      def slacky?
        return false unless data

        true
      end

      def repo
        @repo ||= Repo.new(
          remote: @env.fetch(:repo_url)
        )
      end

      private

      def data
        @data ||= @env.fetch(:slacky, {})
      end

      class Repo
        def initialize(remote:)
          @remote = remote
        end

        def url
          return @url if @url

          @url =
            if ssh?
              "https://" + @remote[/(?<=@).*/].gsub(".git", "").tr(":", "/")
            else
              @remote
            end
        end

        def ssh?
          @remote.match?(/((git|ssh|http(s)?)|(git@[\w.]+))(:(\/)?)([\w.@:\/~-]+)(\.git)(\/)?/)
        end
      end

      private_constant :Repo
    end
  end
end
