namespace :w do
  desc "Fixes the replies per thread incase it's out of sync"
  task :fix_replies => :environment do
    WasabbiThread.transaction do
      WasabbiThread.all.each do |thread|
        thread.recalc_replies!
      end
    end
  end
end