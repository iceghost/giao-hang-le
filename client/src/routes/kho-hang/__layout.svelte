<script>
    import { page } from "$app/stores";
</script>

<main class="mx-auto w-full max-w-xl">
    <div>
        <h2 class="text-3xl font-semibold">Kho hàng {$page.params.wid}</h2>
    </div>
    <slot />
</main>
