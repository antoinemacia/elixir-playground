defmodule Todo.Server do
  use GenServer

  def init(todo_list) do
    {:ok, todo_list}
  end

  def start do
    GenServer.start(Todo.Server, Todo.List.new)
  end

  def start(todo_list) do
    GenServer.start(Todo.Server, todo_list)
  end

  def add_entry(todo_server, new_entry) do
    GenServer.cast(todo_server, {:add_entry, new_entry})
  end

  def entries(todo_server, date) do
    GenServer.call(todo_server, {:entries, date})
  end

  def update_entry(todo_server, entry_id, update_fun) do
    GenServer.cast(todo_server, {:update_entry, entry_id, update_fun})
  end

  def delete_entry(todo_server, entry_id) do
    GenServer.cast(todo_server, {:delete_entry, entry_id})
  end

  def handle_cast({:add_entry, new_entry}, todo_list) do
    {:noreply, Todo.List.add_entry(todo_list, new_entry)}
  end

  def handle_cast({:update_entry, entry_id, update_fun}, todo_list) do
    {:noreply, Todo.List.update_entry(todo_list, entry_id, update_fun)}
  end

  def handle_cast({:delete_entry, entry_id}, todo_list) do
    {:noreply, Todo.List.delete_entry(todo_list, entry_id)}
  end

  def handle_call({:entries, date}, _, todo_list) do
    {:reply, Todo.List.entries(todo_list, date), todo_list}
  end
end
