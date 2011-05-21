Dummy::Application.routes.draw do
  mount Ignition::Engine => '/'
  get 'time', :to  => 'time#now'
end
