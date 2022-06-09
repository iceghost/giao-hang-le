type Order = {
    id: number;
};

type Container = {
    id: number;
};

type Level = {
    name_with_type: string;
    code: `${number}`;
};

type Address = {
    first: Level | undefined;
    second: Level | undefined;
    third: Level | undefined;
    rest: string | undefined;
};