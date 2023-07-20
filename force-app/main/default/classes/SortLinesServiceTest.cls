@IsTest
private with sharing class SortLinesServiceTest {
  private static final String TEXT = 'This is a testing.\nHello, World!\nApex code.\n';

  @IsTest
  private static void getSortedStringTest_Positive() {
    List<String> sortedString = SortLinesService.getSortedString();

    Assert.isNotNull(sortedString);
  }

  @IsTest
  private static void sortStringTest_Positive() {
    List<String> sortedString = SortLinesService.sortString(TEXT);

    Assert.isNotNull(sortedString);
    Assert.areEqual(sortedString[0], 'This is a testing.');
    Assert.areEqual(sortedString[1], 'Hello, World!');
  }

  @IsTest
  private static void sortStringTest_Negative() {
    List<String> sortedString = SortLinesService.sortString(null);

    Assert.isNull(sortedString);

    sortedString = SortLinesService.sortString('');
    Assert.isNull(sortedString);
  }
}
