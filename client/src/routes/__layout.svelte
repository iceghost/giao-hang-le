<script context="module" lang="ts">
    import type { Load } from "@sveltejs/kit";
    import { faker } from "@faker-js/faker";

    export const load: Load = async ({ fetch }) => {
        const res = await fetch("/khach-hang/1");
        const { user } = await res.json();
        return {
            props: {
                user,
            },
        };
    };
</script>

<script lang="ts">
    import "../app.css";

    export let user: { name: string; avatar: string; points: number };
</script>

<div class="h-screen w-full font-body flex">
    <nav
        class="h-full w-64 flex flex-col items-center border-r py-5 px-2 bg-gray-50"
    >
        <h1 class="text-lg font-semibold">🚢 Giao hàng lẹ</h1>
        <img
            src={user.avatar}
            alt="profile pic"
            class="mt-3 w-16 h-16 rounded-full"
        />
        <p class="mt-3 font-semibold">{user.name}</p>
        <p class="uppercase text-xs tracking-widest">
            <span class="font-bold text-sm tabular-nums">
                {user.points}
            </span> điểm
        </p>
        <div
            class="mt-5 flex-grow border-b w-full text-lg space-y-2 text-gray-700"
        >
            <a
                href="/dashboard"
                class="flex items-center space-x-2 py-2 bg-gray-200 rounded-md px-2"
            >
                <!-- prettier-ignore -->
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
                </svg>
                <span>Danh sách đơn hàng</span>
            </a>
            <a
                href="/dashboard/dat-hang"
                class="flex items-center space-x-2 py-2 hover:bg-gray-100 rounded-md px-2 group"
            >
                <!-- prettier-ignore -->
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-400 group-hover:rotate-180 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
                </svg>
                <span>Đặt hàng</span>
            </a>
        </div>
        <p class="mt-5 flex items-center space-x-2">
            <!-- prettier-ignore -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M3 3a1 1 0 00-1 1v12a1 1 0 102 0V4a1 1 0 00-1-1zm10.293 9.293a1 1 0 001.414 1.414l3-3a1 1 0 000-1.414l-3-3a1 1 0 10-1.414 1.414L14.586 9H7a1 1 0 100 2h7.586l-1.293 1.293z" clip-rule="evenodd" />
            </svg>
            <span>Đăng xuất</span>
        </p>
    </nav>
    <slot />
</div>
