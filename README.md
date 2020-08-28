# SwiftMovie
Um app que mostra informações do filme Taylor Swift: The 1989 World Tour - Live


<img width="300" alt="Screen Shot 2020-08-28 at 1 19 34 AM" src="https://user-images.githubusercontent.com/6511079/91520861-be2fd680-e8cc-11ea-911c-d5da16106ffb.png">

### Explicação geral do código
Arquitetura: MVVM

##### Model
* SimilarMovieList
* MovieDetail
* MovieGenre
* MovieGenreList

##### ViewController
* MovieDetailViewController

##### ViewModel
* MovieDetailViewModel

##### Repository
* MovieDetailRepository

##### Helper
* Networker
* Extensions

##### Fluxo de informação
* ViewController -> ViewModel -> Repository -> Networker -> Alamofire

### Libs
Metodo de instalação: Swift Package Manager

* [Alamofire](https://github.com/Alamofire/Alamofire): Networking
* [RxSwift](https://github.com/ReactiveX/RxSwift): Rx
* [Kingfisher](https://github.com/onevcat/Kingfisher): Download e cache de imagem assíncrono
* [Swiftlint](https://github.com/realm/SwiftLint): Lint de código

### Se eu tivesse mais tempo...
* Fazer a tableview funcionar com self resizing cells
* Coordinator
* Tratamento de erro

### Regras de lint customizadas
* networker_outside_repository: Não deixar desenvolvedores implementarem Networker de uma classe que não seja Repository
<img width="770" alt="Screen Shot 2020-08-28 at 1 19 34 AM" src="https://user-images.githubusercontent.com/6511079/91520833-a9534300-e8cc-11ea-883f-6f886414eef3.png">

* alamofire_outside_networker: Não deixar desenvolvedores implementarem Alamofire de uma classe que nao seja a Networker
<img width="809" alt="Screen Shot 2020-08-28 at 1 19 53 AM" src="https://user-images.githubusercontent.com/6511079/91520837-ace6ca00-e8cc-11ea-837c-64e829b5cd1c.png">
