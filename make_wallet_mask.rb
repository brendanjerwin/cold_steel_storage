#! /usr/bin/env ruby
require "qrencoder"
require "RMagick"
include Magick

PIXELS_PER_MODULE = 13

wallet = `vanitygen 1`
private_key = wallet.match(/Privkey: (.*)$/)[1]
address = wallet.match(/Address: (.*)$/)[1]

private_key_qr = QREncoder.encode(private_key, :correction => :high)
private_key_qr.png(:margin => 2, :pixels_per_module => PIXELS_PER_MODULE).save('private_key.png')
private_key_qr = Image::read('private_key.png').first
`rm -P private_key.png`

address_qr = QREncoder.encode(address, :correction => :high)
address_qr.png(:margin => 2, :pixels_per_module => PIXELS_PER_MODULE).save('address.png')
address_qr = Image::read('address.png').first.resize(525,525)
`rm -P address.png`

template = Image::read('mask_template.png').first
template.composite!(address_qr, 25, 350, OverCompositeOp)
template.composite!(private_key_qr, 900, 150, OverCompositeOp)

font_name = File.expand_path(File.join(File.dirname(__FILE__), "OCRA.ttf"))
private_key_image = Image.read("caption:#{private_key}") {
    self.font = font_name
    self.fill = 'black'
    self.stroke = 'transparent'
    self.pointsize = 67
    self.gravity = NorthGravity

    self.size = 860
}.first
private_key_image.rotate!(-90)

template.composite!(private_key_image, 615, 20, OverCompositeOp)

address_image = Image.read("caption:#{address}") {
    self.font = font_name
    self.fill = 'black'
    self.stroke = 'transparent'
    self.pointsize = 58
    self.gravity = NorthWestGravity

    self.size = 512
}.first

template.composite!(address_image, 50, 110, OverCompositeOp)

template = template.flop().negate()

template.write('mask.png')
`open mask.png`
