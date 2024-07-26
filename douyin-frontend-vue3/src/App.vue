<script lang="ts">
  // 1.引入组件
  import Person from './components/Person.vue'

  // js/ts行为
  export default {
    // 默认模式 - 导出
    // 组件名
    name: 'App',
    // 2.注册组件
    components: {
      Person
    }
  }
</script>

<template>
  <!-- html结构标签 -->
   <!-- 
    vue2只支持一个rootTag
    vue3支持多个rootTag
   -->
   <div class="app">
    <h1>hello world</h1>
    <!-- 3.使用组件 -->
    <Person></Person>
   </div>
</template>

<style>
  /* css样式 */
  .app {
    box-shadow: 10px;
    border-radius: 10px;
    padding: 20px;
    background-color: red;
  }
</style>
