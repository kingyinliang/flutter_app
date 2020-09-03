int getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  hexColor = hexColor.replaceAll('0X', '');
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return int.parse(hexColor, radix: 16);
}
