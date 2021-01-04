<template>
  <div id="app">
    <p>{{ message }}</p>
    <Top/> 
  </div>
</template>

<script>
import Top from "./components/Top";

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
    components: {
    Top,
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
