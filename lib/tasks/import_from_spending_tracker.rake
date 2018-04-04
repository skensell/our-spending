require 'csv'

namespace :ourspending do

  desc "Import Data from Spending tracker."
  task :import_from_spending_tracker, [:file] => :environment do |t, args|


    # NOTE: Follow instructions here https://stackoverflow.com/a/1067841/2248638
    # :set nobomb and save the exported data from Spending tracker

    puts 'Started import.'

    all_data = CSV.read("to_import.csv", encoding: "UTF-16LE:UTF-8")
    all_data.each do |day,category,amount,note|
      day = day.strip
      category = category.strip
      amount = amount.strip.to_f
      note = note.strip
      t = Transaction.new
      puts day
      t.date = Date.strptime(day, '%m/%d/%Y')
      t.category = category
      if amount > 0
        t.amount = amount
        t.is_income = true
      else
        t.amount = -amount
        t.is_income = false
      end
      t.note = note
      t.save!
    end

    puts 'Finished import.'

  end

end