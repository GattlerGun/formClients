<template>
    <div id="app">
        <header>
            <h1>Simon Says!</h1>
        </header>
        <main>
            <label class="" v-if="round > 0"> Round: {{ round }}</label>
            <div
                class="btn-box"
                :style="{
                    pointerEvents:
                        this.turn === 'pc' && isStart ? 'none' : 'all',
                }"
            >
                <color class="btn" :color="'blue'" @choose="selection"> </color>
                <color class="btn" :color="'red'" @choose="selection"> </color>
                <color class="btn" :color="'yellow'" @choose="selection">
                </color>
                <color class="btn" :color="'green'" @choose="selection">
                </color>
            </div>
            <div v-if="round === 0" class="info-box">
                <button class="btn-start" @click="startGame">Start</button>
                <ul>
                    <li v-for="diff in this.dificcult" v-bind:key="diff">
                        <label class="difficult">
                            <input
                                name="difficult"
                                type="radio"
                                value="diff"
                                @focus="setDifficult(diff)"
                                checked
                            />{{ diff }}
                        </label>
                    </li>
                </ul>
            </div>
        </main>
    </div>
</template>
<script>
import color from "./components/color.vue";
export default {
    components: {
        color,
    },
    data() {
        return {
            round: 0,
            colors: ["blue", "red", "yellow", "green"],
            simon: [],
            response: [],
            turn: "pc",
            index: 0,
            dificcult: ["hard", "normal", "easy"],
            delay: 1500,
            isStart: false,
        };
    },
    methods: {
        selection(data) {
            if (this.turn === "user") {
                this.response.push(data);
                this.comparate();
            }
        },
        setDifficult(diff) {
            console.log(diff);
            switch (diff) {
                case "hard":
                    this.delay = 400;
                    break;
                case "normal":
                    this.delay = 1000;
                    break;
                case "easy":
                    this.delay = 1500;
                    break;
            }
        },
        animate(sequence) {
            var i = 0;
            var that = this;
            var interval = setInterval(function () {
                document.querySelector("#" + that.simon[i]).click();
                i++;
                if (i >= sequence.length) {
                    clearInterval(interval);
                }
            }, this.delay);
        },
        comparate() {
            if (this.response[this.index] === this.simon[this.index]) {
                this.index++;
                console.log(this.index === this.round);
                if (this.index === this.round) {
                    this.response = [];
                    // this.simon = [];
                    setTimeout(() => this.startGame(), 600);
                }
            } else {
                alert("You are wrong!");
                this.isStart = false;
                this.round = 0;
                this.index = 0;
                this.response = [];
                this.simon = [];
                this.turn = "pc";
            }
        },
        getLoseMessege() {

        },
        randomise() {
            return Math.floor(Math.random() * 4);
        },
        startGame() {
            this.isStart = true;
            this.index = 0;
            this.turn = "pc";
            this.round++;
            this.simon = [...this.simon, this.colors[this.randomise()]];
            this.animate(this.simon);
            setTimeout(
                () => (this.turn = "user"),
                this.delay * this.simon.length
            );
        },
    },
};
</script>

<style scoped>
* {
    margin: 0;
    padding: 0;
}
*:focus {
    outline: none !important;
}
h1 {
    text-align: center;
}
header {
    margin-bottom: 50px;
    margin-top: -100px;
}
main {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-wrap: wrap;
    gap: 30px;
    text-align: center;
}
ul {
    display: flex;
    flex-direction: column;
    list-style: none;
    align-items: start;
}
.difficult {
    display: flex;
    gap: 10px;
    align-items: center;
    justify-content: center;
    pointer-events: all;
    cursor: pointer;
}
input {
    cursor: pointer;
}
.btn-start {
    margin-bottom: 15px;
}
.btn-box {
    display: grid;
    grid-template-columns: 150px 150px;
    grid-template-rows: 150px 150px;
}
.btn:hover {
    border: 1px solid white;
}
.info-box {
    display: flex;
    flex-direction: column;
}
</style>
