public with sharing class SortLinesService {
  public static final String TEXT = 'Wlazł kotek na płotek\ni mruga,\nładna to piosenka,\nnie długa.\nNie długa, nie krótka,\nlecz w sam raz,\nzaśpiewaj koteczku,\njeszcze raz.';

  @AuraEnabled(Cacheable=true)
  public static List<String> getSortedString() {
    return sortString(TEXT);
  }

  @TestVisible
  private static List<String> sortString(String text) {
    if (text != null && !String.isEmpty(text)) {
      List<String> lines = text.split('\n');
      Map<Integer, String> stringMap = new Map<Integer, String>();

      for (String line : lines) {
        stringMap.put(line.length(), line);
      }

      List<Integer> sortedKeys = new List<Integer>(stringMap.keySet());
      sortedKeys.sort();
      List<String> sortedStrings = new List<String>();

      for (Integer i = sortedKeys.size() - 1; i >= 0; i--) {
        sortedStrings.add(stringMap.get(sortedKeys[i]));
      }

      return sortedStrings;
    }

    return null;
  }
}
