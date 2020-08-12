require "pg"

class Database
  def conn
    conn_hash = { host: "pgdb", dbname: "ninjapixel", user: "postgres", password: "qaninja" }
    conn = PG.connect(conn_hash)
  end

  def remove_product(name)
    conn.exec("DELETE FROM public.products where title = '#{name}';")
  end
end
