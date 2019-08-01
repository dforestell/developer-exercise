<template>
  <div>
    <button @click="getAll()">All Quotes</button>
    <button @click="getType('movies')">Movies</button>
    <button @click="getType('games')">Games</button>
    <input type="text" placeholder="search by quote" @input="search($event.target.value)">
  </div>

</template>

<script>
export default {
  props: {
    getType: Function,
    getAll: Function,
    search: Function
  },
}
</script>
