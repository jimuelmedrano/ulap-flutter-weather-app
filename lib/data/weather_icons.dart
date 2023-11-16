String getWeatherIcon(String iconName) {
  if (iconName == 'Clear' ||
      iconName == 'Clouds' ||
      iconName == 'Drizzle' ||
      iconName == 'Rain' ||
      iconName == 'Thunderstorm') {
    return 'assets/images/$iconName.svg';
  } else {
    return 'assets/images/others.svg';
  }
}
