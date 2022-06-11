import {faker} from '@faker-js/faker'

export const get: import("./__types/[cid]").RequestHandler = ({ params }) => {
    const containers = [{
        id: 1,
        addrFrom: faker.address.streetAddress(),
        addrTo: faker.address.streetAddress(),
    }]
    return {
        body: {
            // 1-indexed
            container: containers[parseInt(params.cid) - 1],
        },
    };
};