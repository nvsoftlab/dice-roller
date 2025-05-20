class LayoutUtils {
  static double getDiceSize(double availableWidth, int diceCount) {
    int dicePerRow = (availableWidth / 140).floor().clamp(1, 3);
    double spacing = 20 * (dicePerRow + 1);
    return ((availableWidth - spacing) / dicePerRow).clamp(60, 160);
  }
}
