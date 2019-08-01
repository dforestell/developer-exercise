<template>
  <div>
    <ul
      v-for="pageNumber in pageNumbers"
    >
      <li @click="changePage(pageNumber)">{{pageNumber}}</li>
    </ul>
  </div>
</template>

<script>
export default {
  props: {
    pages: Number,
    changePage: Function
  },
  data(){
    return {
      pageNumbers: [1,2,3]
    }
  },
  watch: {
    pages: function() {
      this.pageNumbers = []
      for (let i = 1; i <= this.pages; i++) {
        this.pageNumbers.push(i);
      }
    }
  }
}
</script>

<style lang="css" scoped>
</style>
