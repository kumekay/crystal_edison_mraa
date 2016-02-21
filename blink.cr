@[Link("mraa")]
lib LibMRAA
  struct Gpio
    pin, phy_pin, value_fp, isr_value_fp : Int32
    isr_thread_terminating, owner : UInt8
  end

  enum MRAAGpioDir
    MRAA_GPIO_OUT = 0     # /**< Output. A Mode can also be set */
    MRAA_GPIO_IN = 1      # /**< Input */
    MRAA_GPIO_OUT_HIGH = 2# /**< Output. Init High */
    MRAA_GPIO_OUT_LOW = 3 #  /**< Output. Init Low */
  end

  fun mraa_init() : Int32
  fun mraa_get_version() : UInt8*
  fun mraa_gpio_init( Int32 ) : Gpio*
  fun mraa_gpio_write( gpio : Gpio* , value : Int32)
  fun mraa_gpio_dir( gpio : Gpio* , dir : MRAAGpioDir)
end

PIN = 3

LibMRAA.mraa_init
puts  "MRAA Version: #{LibMRAA.mraa_get_version}\nStarting Blinking on IO#{PIN}\n"

gpio = LibMRAA.mraa_gpio_init(PIN)
LibMRAA.mraa_gpio_dir(gpio, LibMRAA::MRAAGpioDir::MRAA_GPIO_OUT)

while true
  LibMRAA.mraa_gpio_write(gpio, 0)
  puts "Write 0"
  sleep(1)

  LibMRAA.mraa_gpio_write(gpio, 1)
  puts "Write 1"
  sleep(1)
end
