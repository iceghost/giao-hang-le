<script lang="ts">
    export let waitingOrders: Order[];
    export let waitingContainers: Container[];
</script>

<p>Đơn hàng đang chờ:</p>
<ul>
    {#each waitingOrders as waitingOrder}
        <li>{waitingOrder.id}</li>
    {/each}
</ul>
<p>Thùng hàng đang chờ:</p>
<ul>
    {#each waitingContainers as waitingContainer}
        <li>{waitingContainer.id}</li>
    {/each}
</ul>
