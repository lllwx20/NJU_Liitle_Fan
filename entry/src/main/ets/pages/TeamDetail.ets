
@Entry
@Component
struct TeamDetail {
  @State name : string = "软院"
  @State score : number = 0
  build() {
    Row() {
      Text(this.name)
      Text()
    }
  }
}