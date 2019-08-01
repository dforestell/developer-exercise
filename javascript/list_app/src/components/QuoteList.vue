<template>
  <div>
    <h1>QuoteList</h1>
    <p
      v-for="(quote, index) in displayedQuotes"

    >
    {{ quote.quote }}
  </p>
    <p>page numbers</p>
  </div>
</template>

<script>
export default {
  props: {
    displayedQuotes: Object
  }
}
</script>
