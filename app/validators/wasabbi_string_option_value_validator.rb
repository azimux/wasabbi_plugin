class WasabbiStringOptionValueValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    good_vals = WasabbiForumStringOption.possible_values record.name

    if good_vals
      unless good_vals.include?(value)
        record.errors.add attribute,
          "unexpected value '#{value}', must be one of the following: #{
        good_vals.map{|s| "'#{s}'"}.join(", ")
}"
      end
    end
  end
end
