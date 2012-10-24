module Proxify
  module Base

    def find_or_create_class(class_name, container)
      if k = class_exists?(class_name)
        k
      else
        Object.const_set(class_name, container)
      end
    end

    def class_exists?(class_name)
      Object.const_get(class_name)
    rescue NameError
      return false
    end

  end
end
