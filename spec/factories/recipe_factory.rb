Factory.define :recipe do |r|
  r.sequence(:name){ |n| "Recipe #{n}" }
  r.directions 'Do not do anything'
  r.association :category
end
