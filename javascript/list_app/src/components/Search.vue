<template>
  <div>
    <button @click="getAll()">All Quotes</button>
    <button @click="getType('movies')">Movies</button>
    <button @click="getType('games')">Games</button>
    <input type="text">
  </div>

</template>

<script>
export default {
  props: {
    getType: Function
  }
}
</script>
