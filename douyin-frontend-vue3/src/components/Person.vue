<script lang="ts">
    export default {
        // vue2 - optionsAPI选项式api
        // 功能A和功能B...各种api都是分开的
        name: 'Person',
        // 数据
        data() {
            return {
                name: '谢吴军',
                age: 18,
                tel: '15601749931'
            }
        },
        // 方法
        methods: {
            getTel() {
                alert(this.tel)
            }
        },
        // 计算属性
        computed: {
        },
        // 监视数据变化
        watch: {
        },
        // vue3
        // // data() {}和setup() {}可以同时存在
        // // setup() { // 这里不能调用data内部的数据}的生命周期早于data() { // 这里可以通过this.xxx调用setup内部的数据 }
        // setup() {
        //     // 数据：此时的数据不是响应式的
        //     let name = 'xiewujun'
        //     let age = 18
        //     let tel = '15601749931'

        //     function getTel() {
        //         // alert(this.tel) // 不能在setup中写this
        //         alert(tel)
        //         name = '谢吴军'
        //     }

        //     // template里面暂时不需要使用的可以不return
        //     // return {key1: name, key2: age, key3: getTel}
        //     // return {name: name, age: age, getTel: getTel}
        //     return {name, age, getTel}
        //     // // setup函数的返回值也可以是一个渲染函数
        //     // return () => 'haha'
        // }
    }
</script>

<!-- 
setup语法糖
1>.如果不写组件名则组件名和文件名一致
2>.如果需要指定组件名需要在写一个script
<script lang='ts'>
    export default {
        name: 'Person'
    }  
</script>
3>.下载插件可以实现name="Person"
$npm i vite-plugin-vue-setup-extend -D
修改vite.config.ts文件
import vueSetupExtend from 'vite-plugin-vue-setup-extend'
vueSetupExtend()
-->
<script lang="ts" setup name="Person">

    import { computed, ref } from 'vue'
    import { reactive } from 'vue'
    import { toRefs, toRef } from 'vue'
    import { watch } from 'vue';

    // 想要数据改变页面也随着改变，这样的数据就是响应式数据
    // 使用ref包起来的数据就是响应式数据（针对基本数据类型有效...也针对对象类型有效）
    // 可以使用valar插件自动提醒.value
    let name = ref('xiewujun')
    let age = ref(18)
    let tel = '15601749931'
    let car1 = ref({
        brand: '奔驰',
        price: 1000000,
        color: {
            inner: {
                // reactive对该数据依旧有效
                x_color: 'red'
            }
        }
    })
    let games1 = ref([
        {id: '001', name: '英雄联盟'},
        {id: '002', name: '王者荣耀'},
        {id: '003', name: '原神'}
    ])
    // 使用reactive包起来的数据就是响应式数据（针对对象类型有效）
    // ！！！重新分配对象会让该对象失去响应式：无法整体修改！！！
    let car = reactive({
        brand: '奔驰',
        price: 1000000,
        color: {
            inner: {
                // reactive对该数据依旧有效
                x_color: 'red'
            }
        }
    })
    let games = reactive([
        {id: '001', name: '英雄联盟'},
        {id: '002', name: '王者荣耀'},
        {id: '003', name: '原神'}
    ])
    let student = reactive({
        name1: ' zs',
        age1: 18
    })

    // 将响应式对象结构出来以后数据还具有响应式
    // // 值传递
    // // let name1 = student.name1
    // // let age1 = student.age1
    // let {name1, age1} = student
    // toRefs
    let {name1, age1} = toRefs(student)
    // toRef
    let name2 = toRef(student, 'name1')
    let age2 = toRef(student, 'age1')

    // 计算属性：只读属性（只能修改name或者age导致fullName改动，不能直接修改fullName）、有缓存
    // 方法没有缓存
    let fullName = computed({

        get() {
            return name.value + age.value
        },
        // 什么时候调用该方法：调用fullName.value = xxx会调用该方法
        // val = xxx
        set(val) {
            // 内部实现修改逻辑
        }
    })

    // 监视数据变化
    // A.第一种情况：监视ref定义的基本类型数据（监视的是value值的改变）
    // // age --- 需要监视的数据（不需要加.value）
    // /*
    // // 1>.ref定义的数据...age.value不是ref定义的数据，age才是
    // // 2>.reactive定义的数据
    // // 3>.函数返回一个值（getter函数）
    // // 4>.包含上述数据的数组
    //  */
    // // 回调函数 --- 监视数据变化以后执行的函数
    // // 这里是持续监视数据
    // watch(age, (newValue, oldValue) => {
    //     console.log('ref定义的数据name改变了')
    // })
    // 停止监视数据变化
    const stopWatch = watch(age, (newValue, oldValue) => {
        console.log('ref定义的数据name改变了')
        if (newValue > 10) {
            stopWatch()
        }
    })
    // A2.第二种情况：监视ref定义的对象类型数据（监视对象地址值变化）
    // 如果想要监视的对象内部属性的变化需要手动开启深度监视（既可以监视对象地址值变化，也可以监视对象属性变化）
    // 如果修改对象属性，则newValue和oldValue都一样是newValue，因为对象地址没有改变
    // 如果修改对象本身，则newValue和oldValue不一样
    watch(car1, (newValue, oldValue) => {
        // deep --- 是否开启深度监视
        // immediate --- 刚进入就会调用一次（newValue == 当前值、oldValue == undefined）
    }, {deep: true, immediate: true})
    // A3.第三种情况：监视reactive定义的对象默认开启深度监视：不可以关闭
    // 如果修改对象属性，则newValue和oldValue都一样是newValue，因为对象地址没有改变
    // 无法直接修改对象
    watch(student, (newValue, oldValue) => {

    })
    // A4.第四种情况：ref或reactive定义的对象类型中的某一个属性
    let person = reactive({
        name: '',
        age: 18,
        car: {
            c1: '奔驰',
            c2: '宝马'
        }
    })
    // // 1>.监视整个对象：无论是对象属性发生改变还是对象地址发生改变
    // watch(person, (newValue, oldValue) => {

    // })
    // 2>.只监视对象属性的改变
    // a>.该属性不是对象类型：需要写成函数形式
    watch(() => { return person.name }, (newValue, oldValue) => {

    })
    watch(() => person.name, (newValue, oldValue) => {

    })
    // b>.该属性是对象类型：可以直接写，也可以写成函数形式
    watch(person.car, (newValue, oldValue) => {
        // person.car对象属性改变可以监视
        // person.car对象改变无法监视
    })
    watch(() => { return person.car }, (newValue, oldValue) => {
        // person.car对象属性改变无法监视
        // person.car对象改变可以监视
    })
    watch(() => person.car, (newValue, oldValue) => {

    })
    // c>.想要都行：看我下面的写法
    watch(() => { return person.car }, (newValue, oldValue) => {
        // Lambda函数简写省略
    }, {deep: true})
    // A5.第五种情况
    // p21

    function getTel() {
        // alert(this.tel) // 不能在setup中写this
        alert(tel)
        name.value = '谢吴军' // 这里需要加value

        name1.value += '...'
        age1.value += 1

        name2.value += '...'
        age2.value += 1

        // 对象地址值没有改变
        Object.assign(student, {name1: ' zs', age1: 18})
    }
    
    function changePrice() {
        car.price = 100
        car1.value.price = 100
        // 直接换对象也可以
        car1.value = {
            brand: '奔驰1',
            price: 100,
            color: {
                inner: {
                    // reactive对该数据依旧有效
                    x_color: 'yellow'
                }
            }
        }
        // // 重新分配对象会让该对象失去响应式
        // car = {
        //     brand: '奔驰1',
        //     price: 100,
        //     color: {
        //         inner: {
        //             // reactive对该数据依旧有效
        //             x_color: 'yellow'
        //         }
        //     }
        // }
        // // 即使这样写也不行
        // car = reactive({
        //  brand: '奔驰1',
        //     price: 100,
        //     color: {
        //     inner: {
        //             // reactive对该数据依旧有效
        //             x_color: 'yellow'
        //         }
        //     }
        // })
        // // 这样可以：没有重新分配新的对象（批量修改对象的属性）
        // Object.assign(car, car1)
    }

    function changeFirstGameName() {
        if (games.length > 0) {
            games[0].name = 'DNF'
        }
        if (games1.value.length > 0) {
            games1.value[0].name = 'dnf'
        }
    }
</script>

<!-- 尽可能让template里面的数据保持简单 -->
<template>
    <div class="person">
        <!-- 这里不能加value -->
        <h2>姓名：{{ name }}</h2>
        <h2>年龄：{{ age }}</h2>
        <button @click="getTel">获取联系方式</button>
        <h2>这里有一辆{{ car.brand }}，价值{{ car.price }}</h2>
        <button @click="changePrice">修改汽车价格</button>
        <h2>游戏列表：</h2>
        <ul>
            <!-- 
            单向绑定：由数据流向页面
            v-bind:标签属性 = 'script属性' ===> :标签属性 = 'script属性' 
            -->
            <!-- <li v-for="game in games" v-bind:key="game.id">{{ game.name }}</li> -->
            <li v-for="game in games" :key="game.id">{{ game.name }}</li>
            <!-- 
            双向绑定：由数据流向页面，由页面流向数据
            v-model:标签属性 = 'script属性' ===> v-model = 'script属性' 
            <li v-for="game in games" v-model:key="game.id">{{ game.name }}</li>
            <li v-for="game in games" v-model="game.id">{{ game.name }}</li> 
            -->
            <!-- 
            对于需要拼接、截取data数据才可以实现的需求：我们一般直接使用计算属性：
            >>对于客户端开发而言也是一样，model中尽量将一些属性计算好（该谁的事情谁来做）
             -->
        </ul>
        <button @click="changeFirstGameName">修改第一个游戏名称</button>
    </div>
</template>

<style scoped>
</style>