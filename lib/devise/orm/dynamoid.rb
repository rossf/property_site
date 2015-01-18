require 'orm_adapter-dynamoid/dynamoid'

Dynamoid::Document::ClassMethods.send :include, Devise::Models