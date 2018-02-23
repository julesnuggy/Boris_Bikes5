require 'docking_station'

describe Bike do
  it { is_expected.to respond_to :working }

  it "expects a new bike to be working" do
    expect(Bike.new.working).to be_truthy
  end

  it { is_expected.to respond_to :report }

  it "allows a user to report a broken bike" do
    bike = Bike.new
    bike.report
    expect(bike.working).to be_falsy
  end

end
