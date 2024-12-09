
@Entry
@Component
struct TeamDetail {
  @State name : string = "软院"

  build() {
      Text(this.name)
  }
}