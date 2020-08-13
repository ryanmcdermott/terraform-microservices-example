export function constructRoute(route: string) {
    if (process.env.DEV_MODE === 'dev') {
        return `http://${process.env.API_BASE}:${process.env.API_PORT}/api/${route}`;
    } else {
        return `http://api-service.discovery.local:8080/api/${route}`;
    }
}

export async function fetchRoute(route: string) {
    const res = await fetch(`${constructRoute(route)}`);

    console.log(res);
    let data: any;
    if (res.ok) {
        const data = await res.json();
        return data;
    } else {
        throw new Error("Cannot reach route: " + route);
    }
}