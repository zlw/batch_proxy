defmodule BatchProxyTest do
  use ExUnit.Case

  @requests_file "test/fixtures/requests.json"
  @zlw_request   BatchProxy.Request.new(method: "get", url: "https://api.github.com/users/zlw")
  
  test "building Request records" do
    { :ok, json } = File.read(@requests_file)    
    requests      = BatchProxy.build_requests(json)
    
    assert length(requests)     == 2
    assert Enum.first(requests) == @zlw_request    
  end
  
  test "making request and returning Response record" do
    responses = BatchProxy.make_requests([@zlw_request])    
    response  = Enum.first(responses)
    
    assert response.status == 200
    assert response.body
    assert response.headers
  end
end
