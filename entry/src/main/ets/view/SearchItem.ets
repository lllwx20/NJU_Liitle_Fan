@Component
export default struct  SearchExample {
  @State changeValue: string = ''
  @State submitValue: string = ''
  controller: SearchController = new SearchController()
  build() {
    Column() {
      Search({ value: this.changeValue, placeholder: '输入球员名称或者位置', controller: this.controller })
        .height(30)
        .backgroundColor('#F5F5F5')
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 14, weight: 400 })
        .textFont({ size: 14, weight: 400 })
        .onSubmit((value: string) => {
          this.submitValue = value
        })
        .onChange((value: string) => {
          this.changeValue = value
        })
    }.width('95%')
  }
}