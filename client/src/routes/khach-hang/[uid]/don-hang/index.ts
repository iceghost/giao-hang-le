import {faker} from '@faker-js/faker'

export const get: import("./__types/index").RequestHandler = ({ params }) => {
 const statuses = ["success", "fail", "pending"]
    const orders = [...new Array(Math.trunc(Math.random() * 10)).keys()].map((_, i) => ({
        id: i + 1,
        addrTo: faker.address.streetAddress(),
        addrFrom: faker.address.streetAddress(),
        status: statuses[Math.trunc(Math.random() * statuses.length)],
        createdAt: faker.date.recent(7)
    }))
    return {
        body: {
            // 1-indexed
            orders,
        },
    };
};