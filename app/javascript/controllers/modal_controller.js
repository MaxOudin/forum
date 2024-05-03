import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["modal","close"]

  connect() {
  }

  close(e) {
    // console.log(e);
    if (e.target == this.modalTarget || e.target == this.closeTarget) {
      this.modalTarget.style.display = "none";
      const ifrm = this.modalTarget.childNodes[3].children[2];
      let symbol = ifrm.src.indexOf("?") > -1 ? "&" : "?";
      ifrm.src += symbol + "autoplay=0";
    }
  }

  open(){
    this.modalTarget.style.display = "flex";
  }
}

