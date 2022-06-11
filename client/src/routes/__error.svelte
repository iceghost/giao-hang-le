<script>
    import { page } from "$app/stores";
</script>

<div class="mx-auto w-full max-w-xl">
    {#if $page.status === 404}
        <img alt="404 not found" src="/404.png" />
        <p class="text-center text-xl">Trang bạn cần tìm không tồn tại</p>
    {/if}
</div>
