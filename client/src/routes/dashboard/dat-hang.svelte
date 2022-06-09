<script lang="ts">
    import { browser } from "$app/env";

    import AddressInput from "$lib/AddressInput.svelte";

    let prevAddress: Address;
    let address: Address;

    $: if (browser) {
        console.log(address);

        if (address && address.third && address.third != prevAddress.third) {
            const url = new URL("/geocode/forward", window.origin);
            url.searchParams.set(
                "address",
                encodeURIComponent(
                    `${address.third.name_with_type}, ${
                        address.second!.name_with_type
                    }, ${address.first!.name_with_type}`
                )
            );
            fetch(url)
                .then((res) => res.json())
                .then(console.log);
        }
    }
</script>

<div class="px-4 py-4">
    <h3>Địa chỉ giao</h3>
    <AddressInput
        on:change={(e) => {
            prevAddress = address;
            address = e.detail.address;
        }}
    />
    <h3>Địa chỉ nhận</h3>
</div>
