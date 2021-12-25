import {createApp} from "vue";
import App from "./App.vue";
import Toaster from "@meforma/vue-toaster";
import "./index.css";

createApp(App).use(Toaster).mount("#app");
