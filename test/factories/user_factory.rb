FactoryGirl.define do
  sequence( :email ) { |n| "foo#{n}@ex#{n+1}ample.com" }

  factory :user do
    name                  "Foo Bar"
    email                 { FactoryGirl.generate(:email) }
    university            'University'
    created_at            Time.now
    updated_at            Time.now
  end
end
