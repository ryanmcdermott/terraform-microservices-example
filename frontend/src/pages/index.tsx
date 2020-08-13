import Head from 'next/head'
import { fetchRoute } from '../lib/api';

type Data = any;

export default function Home(data: Data) {
  return (
    <div className="container">
      <Head>
        <title>Your Project</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>
        <div>
          Test Data from API server route /api/foo: {data.foo}
        </div>
      </main>
    </div>
  )
}

export async function getServerSideProps() {
  let data: any;
  try {
    data = await fetchRoute('foo');
  } catch (err) {
    data = { foo: "ERROR CANNOT CONNECT WITH API" };
  }

  // Pass data to the page via props
  return { props: { ...data } }
}