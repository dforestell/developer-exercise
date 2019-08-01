<template>
  <div>
    <ul>
      <li
        v-for="pageNumber in pageNumbers"
        @click="changePage(pageNumber)">{{pageNumber}}
      </li>
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
  ul li{
    display: inline;
    padding: 10px;
  }
</style>
