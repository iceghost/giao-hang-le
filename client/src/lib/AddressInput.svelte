<script lang="ts">
    import StyledListbox from "$lib/StyledListbox.svelte";
    import { createEventDispatcher, onMount } from "svelte";

    let firstLevels: Promise<Array<Level>> = Promise.race([]);
    let secondLevels: Promise<Array<Level>>;
    let thirdLevels: Promise<Array<Level>> | null;
    let selectedFirstLevel: Level | undefined;
    let selectedSecondLevel: Level | undefined;
    let selectedThirdLevel: Level | undefined;

    onMount(() => {
        firstLevels = getLevels(0, "0");
    });

    $: if (selectedFirstLevel) {
        thirdLevels = null;
        secondLevels = getLevels(1, selectedFirstLevel.code);
    }

    $: if (selectedSecondLevel) {
        thirdLevels = getLevels(2, selectedSecondLevel.code);
    }

    const levelUrls = [
        (_: `${number}`) =>
            "https://raw.githubusercontent.com/madnh/hanhchinhvn/master/dist/tinh_tp.json",
        (code: `${number}`) =>
            `https://raw.githubusercontent.com/madnh/hanhchinhvn/master/dist/quan-huyen/${code}.json`,
        (code: `${number}`) =>
            `https://raw.githubusercontent.com/madnh/hanhchinhvn/master/dist/xa-phuong/${code}.json`,
    ] as const;
    async function getLevels(level: 0 | 1 | 2, code: `${number}`) {
        const res = await fetch(levelUrls[level](code));
        const result: Array<Level> = Object.values(await res.json());
        result.sort((a, b) => {
            if (a.code == "79") return -1;
            if (b.code == "79") return 1;
            return Number(a.code) - Number(b.code);
        });
        return result;
    }

    let restLevel: string;

    type Address = {
        first: Level | undefined;
        second: Level | undefined;
        third: Level | undefined;
        rest: string | undefined;
    };

    let address: Address;

    $: address = { ...address, first: selectedFirstLevel };
    $: address = { ...address, second: selectedSecondLevel };
    $: address = { ...address, third: selectedThirdLevel };
    $: address = { ...address, rest: restLevel };

    const dispatch = createEventDispatcher();
    $: dispatch("change", { address });
</script>

<div class="flex items-center space-x-2">
    <div class="w-full">
        <span class="text-sm">Tỉnh/Thành phố</span>
        <StyledListbox items={firstLevels} bind:item={selectedFirstLevel} />
    </div>
    <div class="w-full">
        <span class="text-sm">Quận/Huyện</span>
        <StyledListbox items={secondLevels} bind:item={selectedSecondLevel} />
    </div>
    <div class="w-full">
        <span class="text-sm">Xã/Phường/Thị trấn</span>
        <StyledListbox items={thirdLevels} bind:item={selectedThirdLevel} />
    </div>
</div>
<div class="w-full mt-2">
    <span class="text-sm">Số nhà, đường</span>
    <input
        type="text"
        bind:value={restLevel}
        class="bg-gray-100 px-2 h-10 w-full shadow-sm rounded-md"
    />
</div>
