defmodule BatchProxy do
  defrecord Request, method: nil, url: nil, body: nil, headers: nil
  defrecord Response, status: nil, body: nil, headers: nil
  
  @doc """
  Parse JSON and create Request records using opts from JSON
  """
  def build_requests(batch_json) do
    if JSEX.is_json?(batch_json) do
      do_build_requests(batch_json)
    else
      []
    end
  end
  
  defp do_build_requests(batch_json) do
    { :ok, request_opts } = parse_json(batch_json)    
    Enum.map request_opts, Request.new(&1)
  end 
  
  defp parse_json(json), do: JSEX.decode(json, [{:labels, :atom}])
  
  @doc """
  Make requests
  """
  def make_requests(requests) do
    HTTPotion.start
    Enum.map requests, make_request(&1)
  end
  
  defp make_request(Request[method: "get"] = request) do    
    HTTPotion.get(request.url, request.headers || []) |> build_response
  end
  
  defp build_response(HTTPotion.Response[body: body, headers: headers, status_code: status]) do
    Response.new(status: status, body: body, headers: headers)
  end
end
