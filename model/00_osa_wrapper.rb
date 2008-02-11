class OSAWrapper
  attr_reader :obj

  def initialize obj
    @obj = obj
    reindex
  end
  
  def self.cache_methods *names
    names.each do |name|
      define_method name do
        ivar = ivar_name(name)
        
        if instance_variables.include? ivar
          instance_variable_get(ivar)
        else
          instance_variable_set(ivar, @obj.send(name))
        end
      end
    end
  end
  
  cache_methods :name, :id2
  
  def reindex
  end
  
  def <=> t
    self.sort_key <=> t.sort_key
  end
  
  def sort_key
    name
  end
  
  def method_missing name, *args
    puts "delegating to #{@obj.class.name} object for method `#{name}'"
    @obj.send(name, *args)
  end
  
  private
  
  def ivar_name f
    f = f.to_s
    '@' + (f.include?('?') ? f[0..-2] : f)
  end
end