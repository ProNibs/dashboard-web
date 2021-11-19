import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'

const API_HOSTNAME = window.env.API_HOSTNAME;
const API_PORT = window.env.API_PORT;

export const apiSlice = createApi({
  reducerPath: 'api',
  baseQuery: fetchBaseQuery({ baseUrl: 'https://'+API_HOSTNAME+':'+API_PORT+'/api/v1' }),
  tagTypes: ['Condenser'],
  endpoints: (builder) => ({
    getCondensers: builder.query({
      query: () => '/condenser',
      providesTags: (result = [], error, arg) => [
        'Condenser',
        ...result.map(({ condenserId }) => ({ type: 'Condenser', condenserId})),
      ],
    }),
    getCondenser: builder.query({
      query: (condenserId) => `/condenser/${condenserId}`,
      providesTags: (result, error, arg) => [{ type: 'Condenser', id: arg }],
    }),
    addNewCondenser: builder.mutation({
      query: (initialCondenser) => ({
        url: '/condenser',
        method: 'POST',
        body: initialCondenser,
      }),
      invalidatesTags: ['Condenser'],
    }),
    editCondenser: builder.mutation({
      query: (condenser) => ({
        url: `condenser/${condenser.condenserId}`,
        method: 'PATCH',
        body: condenser,
      }),
      invalidatesTags: (result, error, arg) => [{ type: 'Condenser', id: arg.condenserId}],
    }),
  }),
})

export const {
  useGetCondensersQuery,
  useGetCondenserQuery,
  useAddNewCondenserMutation,
  useEditCondenserMutation,
} = apiSlice