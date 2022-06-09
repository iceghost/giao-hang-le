export const get: import("./__types/forward").RequestHandler = async ({
    url: reqURL,
}) => {
    const address = decodeURI(reqURL.searchParams.get("address") || "");
    const url = new URL("https://rsapi.goong.io/geocode");

    url.searchParams.set("address", address);
    url.searchParams.set("api_key", import.meta.env.VITE_GOONG_KEY);

    const res = await fetch(url);
    const body = await res.json();
    const { lat, lng } = body.results[0].geometry.location;

    return {
        body: { lat, lng },
    };
};
