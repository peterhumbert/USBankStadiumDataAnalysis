
print(irregArea([202,258,335,407,415,440,441,434,373,319,230,219,203,198],
    [211,188,172,167,171,241,257,266,288,303,310,304,257,215])*1.809^2)


function irregArea(x,y)
    numPoints = length(x)
    area = 0
    j = numPoints

    for i=1:numPoints
        area += (x[j]+x[i])*(y[j]-y[i])
        j = i
    end
    return area/2
end

# irregArea([0, 0, 1, 1],[0, 1, 1, 0]) -- should be 1
# irregArea([4,  4,  8,  8, -4,-4],[6, -4, -4, -8, -8, 6]) -- should be 128
# irregArea([56,175,406,488,557,573,499,359,171],
#     [145,43,21,47,113,278,319,363,373]) -- should be 138784
