Factory.define :category do |c|
  c.sequence(:name){ |n| "Category #{n}" }
end
