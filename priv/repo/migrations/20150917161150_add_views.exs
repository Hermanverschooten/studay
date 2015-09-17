defmodule Studay.Repo.Migrations.AddViews do
  use Ecto.Migration

  def up do
    execute("""
    create or replace function game_count() returns integer as $$
    declare gcount INTEGER;
    begin
    select into gcount COUNT(*) from games where active=true;
    return gcount;
    end; $$
    language plpgsql;
    """
    )

    execute("""
    create or replace view students_completed as
    SELECT s0.id, s0.firstname, s0.lastname, s0.telephone, s0.email, s0.gender, s0.inserted_at, s0.updated_at
    FROM "students"
    AS s0
    LEFT OUTER JOIN "scores" AS s1
    ON s1."student_id" = s0."id"
    GROUP BY s0."id"
    HAVING (count(s1."id") = game_count());
    """)

    execute("""
    create or replace view scores_completed as
    select *
    from scores
    where student_id in (select id from students_completed);
    """)

    execute("""
    create or replace view positions as
      select a.student_id as id, sum(((a.points - b.min)/b.divider::float)) as position
      from scores as a
      inner join (
         select game_id, min(points) as min, case (max(points)-min(points)) when 0 then 1 else max(points)-min(points) end as divider
         from scores_completed
         group by game_id) b
      on a.game_id=b.game_id
      group by a.student_id;
    """)
  end

  def  down do
    execute("drop view positions;")
    execute("drop view scores_completed;")
    execute("drop view students_completed;")
    execute("drop function game_count();")
  end
end
