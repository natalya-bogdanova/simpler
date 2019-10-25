class TestsController < Simpler::Controller

  def index
    @tests = Test.all
  end

  def create
    status(201)
  end

  def show
    @test = Test[params[':id']]
  end
end
