<template>
  <div id="app">
    <Search
      :getType="getType"
      :getAll="getAll"
      :search="search"
     />
    <QuoteList
      :displayedQuotes="currentQuotes.slice(indexOfFirstQuote, indexOfLastQuote)"
    />
    <!-- <ul
      v-for="pageNumber in pageNumbers"
      @click="changePage(pageNumber)"
    >
      <li>{{pageNumber}}</li>
    </ul> -->

    <PageNumbers
      :pages="pages"
      :changePage="changePage"
    />

  </div>
</template>

<script>
import QuoteList from './components/QuoteList.vue'
import Search from './components/Search.vue'
import PageNumbers from './components/PageNumbers.vue'

export default {
  name: 'app',
  components: {
    QuoteList,
    Search,
    PageNumbers
  },
  data(){
    return{
      quotes: [],
      currentQuotes: [],
      currentPage: 1,
      quotesPerPage: 15,
      indexOfFirstQuote: 0,
      indexOfLastQuote: 15,
      pageNumbers: [],
    }
  },
  computed: {
    pages(){
      return Math.ceil(this.currentQuotes.length / this.quotesPerPage)
    }
  },
  methods: {
    changePage(pageNumber){
      this.currentPage = pageNumber
      this.indexOfLastQuote = pageNumber * this.quotesPerPage
      this.indexOfFirstQuote = this.indexOfLastQuote - this.quotesPerPage
    },
    getType(type){
      this.reset()
      this.currentQuotes =  this.quotes.filter(quote => quote.theme === type)
    },
    getAll(){
      this.reset()
      this.currentQuotes = this.quotes
    },
    search(searchText){
      this.currentQuotes = this.quotes.filter(quote => quote.quote.includes(searchText));
      this.reset()
    },
    reset(){
      this.currentPage = 1
      this.indexOfFirstQuote = 0
      this.indexOfLastQuote = 15
    }
  },
  mounted: function(){
    fetch('https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json')
    .then((response) =>{
      return response.json()
    })
    .then((jsonData) => {
      this.quotes = jsonData
      this.currentQuotes = jsonData
      this.getPageNumbers()
    })
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
