using DelimitedFiles, Dates

function hfun_btable(params)
    path = params[1]
    csvcontent,headers   = readdlm(path, ',', String, header=true)
    nrows, ncols = size(csvcontent)

    # sort the table so earlier deadlines are first
    sorting = sortperm(Date.(csvcontent[:,3],"m/d/yyyy"))
    csvcontent = csvcontent[sorting,:]

    io = IOBuffer()
    # write headers
    println(io,"<table class=\"table table-striped table-responsive table-sm\">")
    println(io,"<caption>","$nrows conferences","</caption>")
    println(io,"<thead class=\"thead-dark\">")
    println(io,"<tr>")
    for i in 1:ncols-1
        println(io,"<th scope=\"col\" class=\"align-middle\">",headers[i],"</th>")
    end
    println(io,"</tr>")
    println(io,"</thead>")

    # writing content
    println(io,"<tbody>")
    for i in 1:nrows
        println(io, "<tr>")

        println(io,"<td>","<a href=\"",csvcontent[i,ncols],"\">",csvcontent[i,1],"</a>","</td>")
        for j in 2:ncols-1
            println(io,"<td>",csvcontent[i,j],"</td>")
        end
        println(io,"</tr>")
    end
    println(io,"</table>")
    return String(take!(io))
end