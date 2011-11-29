class Smartdict::Core::Conf
  class ConfError < Exception; end
  class NoOption < ConfError; end;

  # make it being Blank Slate
  instance_methods.each{|m| undef_method m unless m =~ /^(__|class|is_a\?|object_id)/ }


  def self.init
    if File.exists?(Smartdict.conf_file)
      new(defaul_opts).deep_merge(YAML.load_file(Smartdict.conf_file))
    else
      new(defaul_opts)
    end
  end

  def self.defaul_opts
    {:store => { :adapter  => 'sqlite',
                 :db => File.join(Smartdict.user_dir, 'database.sqlite') },
     :plugins => ['one', 'two']}
  end

 
  def initialize(opts = {})
    @opts = opts.keys
    @data = Hash.new{ self.class.new }

    opts.each do |key, value|
      @data[key] = value.is_a?(Hash) ? self.class.new(value) : value
    end
  end

  def [](opt)
    self.__send__(opt)
  end

  def []=(opt, value)
    self.__send__("#{opt}=", value)
  end

  def deep_merge(hash)
    hash.each do |key, value|
      if value.is_a? Hash
        @data[key].deep_merge(value)
      else
        @data[key] = value
      end
    end
    self
  end

  def to_hash
    @data.inject({}){ |h,(k,v)| h[k] = v.is_a?(self.class) ? v.to_hash : v; h}
  end

  def to_s(prefix='')
    @data.map do |key, value|
      value.is_a?(self.class) ?  value.to_s("#{key}.") : "#{prefix}#{key}=#{value}"
    end.join("\n")
  end

  def save!
    File.open(Smartdict.conf_file, 'w') do |file|
      file.puts(to_hash.to_yaml)
    end
  end

  def method_missing(meth, *args)
    opt = meth.to_s.sub(/=$/, '').to_sym
    raise NoOption.new("Has no option #{opt}") unless @opts.include?(opt)
    
    if meth.to_s =~ /=$/
      @data[opt] = args[0]
    else
      @data[opt]
    end
  end

  def respond_to?(meth)
    opt = meth.to_s.sub(/=$/, '').to_sym
    @opts.include?(opt)
  end

end
