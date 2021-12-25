<template>
  <div class="flex flex-col mx-auto space-y-5 p-8 max-w-5xl break-words">
    <h1 class="text-3xl font-semibold text-orange-600">B1 to B0 Code Converter</h1>

    <h3 class="text-gray-800 font-bold text-lg">From</h3>
    <h3 class="text-gray-800 bg-gray-300 font-mono rounded">
      "RfRaw":{"Data":"AA B1 04 0122 09D8 04E2 29EA
      381808280828280828082808082828080828280828082808280808282808280808280828082808280828082808280828082808280828082808280828082828082808
      55"
    </h3>
    <h3 class="text-gray-800 font-bold text-lg">just enter the content of the data part:</h3>
    <h3 class="text-gray-800 bg-gray-300 font-mono rounded">
      AA B1 04 0122 09D8 04E2 29EA
      381808280828280828082808082828080828280828082808280808282808280808280828082808280828082808280828082808280828082808280828082828082808
      55
    </h3>

    <textarea
      class="
        bg-gray-100
        rounded
        border border-gray-400
        leading-normal
        resize-none
        w-full
        h-24
        py-2
        px-2
        font-medium
        placeholder-gray-400
        focus:outline-none focus:bg-white
      "
      placeholder="Insert code here..."
      v-model="input"
    ></textarea>

    <button
      class="bg-slate-500 text-white font-bold py-2 px-4 rounded hover:bg-slate-800"
      @click="convert"
    >
      Convert to B0 Code
    </button>
    <div v-if="result" class="text-lg font-bold">Result:</div>
    <div v-if="result" class="rounded">
      {{ result }}
    </div>
    <button
      class="bg-cyan-600 text-white font-bold py-2 px-4 rounded hover:bg-cyan-800"
      @click="copyToClipboard"
      v-if="result"
    >
      Copy Result to Clipboard
    </button>
  </div>
</template>

<script>
export default {
  name: "App",
  data() {
    return {
      input: "",
      result: "",
    };
  },

  methods: {
    convert() {
      try {
        let output = [];
        const split = this.input.trim().split(" ");
        output.push(split[0]);
        output.push("B0");

        const bucketCount = parseInt(split[2]);
        const data = split[3 + bucketCount];

        output.push(((data.length + bucketCount * 4) / 2 + 2).toString(16));
        output.push(split[2]);
        output.push("14");

        for (let index = 0; index < bucketCount; index++) {
          output.push(split[3 + index]);
        }

        output.push(data);
        output.push(split[split.length - 1]);

        this.result = output.join(" ").toUpperCase();
      } catch (error) {
        this.result = error;
      }
    },
    copyToClipboard() {
      navigator.clipboard.writeText(this.result);
      this.$toast.success("<b>Copied to Clipboard!</b>", {position: "top-right", duration: 2500});
    },
  },
};
</script>

<style>
app {
  padding: 8px;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;

  font-family: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji",
    "Segoe UI Symbol", "Noto Color Emoji";
}

body {
  -ms-overflow-style: none;
  scrollbar-width: none;
  overflow-y: scroll;
}

body::-webkit-scrollbar {
  display: none;
}
.v--default-css .c-toast--success {
  background-color: #0891b2 !important;
}
</style>
