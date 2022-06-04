<script context="module" lang="ts">
    import type { Load } from ".svelte-kit/types/src/routes/dashboard/__types/index";

    export const load: Load = async ({ fetch, params }) => {
        const res = await fetch(`/khach-hang/1/don-hang`);
        const { orders } = await res.json();
        return {
            props: {
                orders: orders.map((order: { createdAt: string }) => ({
                    ...order,
                    createdAt: new Date(order.createdAt),
                })),
            },
        };
    };
</script>

<script lang="ts">
    import { formatRelative } from "date-fns";
    import { vi } from "date-fns/locale";

    export let orders: [
        {
            id: number;
            addrFrom: string;
            addrTo: string;
            status: string;
            createdAt: Date;
        }
    ];
</script>

<p>Đơn hàng chờ giao</p>
<table class="table w-full">
    <thead>
        <tr class="border-b">
            <th class="px-2 py-1">Mã đơn hàng</th>
            <th class="px-2 py-1">Địa chỉ đến</th>
            <th class="px-2 py-1">Trạng thái</th>
            <th class="px-2 py-1">Thời gian gửi</th>
        </tr>
    </thead>
    <tbody>
        {#each orders as order, i}
            <tr class="py-2" class:bg-gray-100={i % 2 == 0}>
                <td
                    class="text-center space-x-1 before:content-['#'] before:text-xs before:text-gray-400 before:relative before:bottom-0.5 before:right-1"
                >
                    {order.id}
                </td>
                <td>{order.addrTo}</td>
                <td>{order.status}</td>
                <td
                    >{formatRelative(order.createdAt, new Date(), {
                        locale: vi,
                    })}</td
                >
            </tr>
        {/each}
    </tbody>
</table>
