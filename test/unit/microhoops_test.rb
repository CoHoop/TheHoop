describe Microhoop do
  before do
    @user = FactoryGirl.create :user
    @mh   = @user.microhoops.build(content: 'foobar', location: 'Campus')
  end

  subject { @mh }

  it 'should have content'           do should respond_to :content end
  it 'should have a location'        do should respond_to :location end
  it 'should have an user id'        do should respond_to :user_id end

  it { should be_valid }
end
