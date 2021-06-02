# frozen_string_literal: true

module Capistrano
  module Slacky
    module Command
      class Diff
        def self.call(previous:, current:)
          output = nil

          ::Capistrano::Slacky.on(within: :repository) do
            output = new(previous: previous, current: current).call
          end

          output
        end

        def initialize(previous:, current:)
          @previous = previous
          @current = current
        end

        def call
          log = ::SSHKit::Backend.current.capture(
            :git, :log, "--oneline", "--first-parent", "#{previous}..#{current}"
          ).split("\n")

          log.map.with_index(1) do |line, index|
            sha, commit = line.match(/^(\w+) (.*+?)/).captures

            if /^Merge pull request/.match?(commit)
              commit = ::SSHKit::Backend.current.capture(:git, :log, "-1", sha, '--pretty=format:"%b"')
            end

            Message.new(index: index, sha: sha, commit: commit)
          end
        end

        private

        attr_reader :previous, :current
      end

      class Message
        EMOJI_MAP = {
          "1" => ":one:",
          "2" => ":two:",
          "3" => ":three:",
          "4" => ":four:",
          "5" => ":five:",
          "6" => ":six:",
          "7" => ":seven:",
          "8" => ":eight:",
          "9" => ":nine:",
          "0" => ":zero:"
        }.freeze

        def initialize(index:, sha:, commit:)
          @index = index
          @sha = sha
          @commit = commit
        end

        def emoji
          @index.to_s.chars.map do |value|
            EMOJI_MAP[value]
          end.join
        end

        def link
          "<#{::Capistrano::Slacky.repo.url}/commit/#{@sha}|#{@sha}>"
        end

        def commit
          @commit.delete('"').strip
        end

        def to_a
          [emoji, link, commit]
        end
      end

      private_constant :Message
    end
  end
end
