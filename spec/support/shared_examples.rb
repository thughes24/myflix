shared_examples "redirects to root if logged out" do
  it "redirects to the front page" do
    clear_session
    action
    expect(response).to redirect_to root_path
  end
end