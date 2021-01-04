<template>
  <v-app id="app">
    <Header/>
    <h1>This is app.vue</h1> 
    <p>{{ message }}</p>
    <Top/> 
  </v-app>
</template>

<script>
import Header from "./components/Header"; 
import Top from "./components/Top";

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
    components: {
    Header,
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
