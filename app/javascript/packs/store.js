import { createStore, applyMiddleware } from 'redux'
import reduxThunk from 'redux-thunk'
import reduxLogger from 'redux-logger'
import reducers from './reducers'

export default createStore(reducers, applyMiddleware(reduxThunk, reduxLogger))
