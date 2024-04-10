# frozen_string_literal: true

after :"deploy:finishing", :"slacky:updated"
after :"deploy:finishing_rollback", :"slacky:reverted"
after :"deploy:failed", :"slacky:failed"
