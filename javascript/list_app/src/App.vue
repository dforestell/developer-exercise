<template>
  <div id="app">
    <Search />
    <QuoteList
      :displayedQuotes="currentQuotes.slice(indexOfFirstQuote, indexOfLastQuote)"
    />

  </div>
</template>

<script>
import QuoteList from './components/QuoteList.vue'
import Search from './components/Search.vue'

export default {
  name: 'app',
  components: {
    QuoteList,
    Search,
  },
  data(){
    return{
      quotes: [],
      currentQuotes: [],
      currentPage: 1,
      quotesPerPage: 15,
      indexOfFirstQuote: 0,
      indexOfLastQuote: 15,
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
