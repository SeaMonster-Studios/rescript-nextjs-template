open! Utils
open! Belt

let default = () => {
  <div>
    <h1> {"my home page"->str} </h1>
    <PageMetaFields
      description={"some details"}
      title={"My app or website"}
      img={"https://techcrunch.com/wp-content/uploads/2015/04/codecode.jpg?w=1390&crop=1"}
      url="https://myhomepage.com"
    />
  </div>
}
