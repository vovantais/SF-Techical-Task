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
      Map<Integer, List<String>> lengthMap = new Map<Integer, List<String>>();

      for (String line : lines) {
        Integer length = line.length();
        if (!lengthMap.containsKey(length)) {
          lengthMap.put(length, new List<String>{ line });
        } else {
          lengthMap.get(length).add(line);
        }
      }

      List<String> sortedStrings = new List<String>();
      List<Integer> sortedKeys = new List<Integer>(lengthMap.keySet());
      sortedKeys.sort();

      for (Integer i = sortedKeys.size() - 1; i >= 0; i--) {
        Integer key = sortedKeys[i];
        sortedStrings.addAll(lengthMap.get(key));
      }

      return sortedStrings;
    }

    return null;
  }
}
