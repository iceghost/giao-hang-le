import {faker} from '@faker-js/faker'
faker.locale = 'vi'

export const get: import("./__types/[uid]").RequestHandler = ({ params }) => {
    const user = {
        id: 1,
        name: faker.name.firstName(),
        avatar: faker.image.cats(),
        points: Math.trunc(Math.random() * 1000),
    }
    return {
        body: {
            // 1-indexed
            user,
        },
    };
};