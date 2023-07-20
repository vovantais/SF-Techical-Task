import { LightningElement, wire } from "lwc";
import getSortedString from "@salesforce/apex/SortLinesService.getSortedString";
import LightningAlert from "lightning/alert";

export default class StringArrayLengthFilter extends LightningElement {
  picklistOptions = [];
  sortedLines;
  text = `Wlazł kotek na płotek\ni mruga,\nładna to piosenka,\nnie długa.\nNie długa, nie krótka,\nlecz w sam raz,\nzaśpiewaj koteczku,\njeszcze raz.`;

  @wire(getSortedString) async sortedString({ err, data }) {
    if (data) {
      this.sortedLines = data;
    } else if (err) {
      await this.handleError(err);
    }
  }
  connectedCallback() {
    this.picklistOptions = this.createPicklist();
  }

  get isShowData() {
    return this.picklistOptions !== [] && this.picklistOptions != null && this.sortedLines != null;
  }

  sortString() {
    const lines = this.text?.split("\n");
    const sortedLines = lines?.sort((a, b) => b?.length - a?.length);

    return sortedLines;
  }

  createPicklist() {
    return this.sortString().map((item) => {
      return { label: item, value: item };
    });
  }

  async handleError(error) {
    await LightningAlert.open({
      message: error,
      theme: "error",
      label: "An error has occurred!"
    });
  }
}
