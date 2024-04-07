<template>
    <button class="color" :class="clase" :id="color" @click="selection()"></button>
</template>
<script>
export default {
    name: "color",
    props: {
        color: String
    },
    data() {
        return { clase: "" };
    },
    methods: {
        selection() {
            this.$emit('choose', this.color);
            this.clase = 'animate';
            var audio = new Audio(this.color+'.ogg');
            audio.play();
            setTimeout(() => this.clase='', 500)
        },
    },
};
</script>

<style scoped>
.color {
    height: 150px;
    width: 150px;
    filter: brightness(0.7)
}
.animate {
    filter: brightness(1);
}
#blue {
    background: rgb(150, 197, 241);
}
#red {
    background: rgb(247, 150, 160);
}
#yellow {
    background: rgb(243, 243, 150);
}
#green {
    background: rgb(150, 240, 150);
}
</style>
