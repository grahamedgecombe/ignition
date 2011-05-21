require 'ignition/routing'

Ignition::Engine.routes.draw do
  constraints Ignition::PageExistsConstraint do
    get '*id', :to => 'ignition/pages#show', :as => 'page'
  end
end

