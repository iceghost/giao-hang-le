

export const get: import("./__types/[wid]").RequestHandler = ({ params }) => {
    const waitingOrders: Order[] = [{ id: 1 }, { id: 2 }];
    const waitingContainers: Container[] = [{ id: 1 }, { id: 2 }];
    const arrivedContainers: Container[] = [];
    return {
        body: {
            waitingOrders,
            waitingContainers,
        },
    };
};
