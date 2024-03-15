function resizedImage = DM_1L(inputImage, fact)
    [row, col, ch] = size(inputImage);

    new_row = row * fact;
    new_col = col * fact;

    resizedImage = zeros(new_row, new_col, ch);

    for k = 1 : ch
        for i = 1 : row
            for j = 1 : col
                resizedImage((i-1)*fact + 1, (j - 1)*fact + 1, k) = inputImage(i, j, k);
            end
        end
    end

    for k = 1 : ch
        for i = 1 : fact : new_row
            for j = 1 : fact : new_col
                first = resizedImage(i, j, k);
                if j + fact <= new_col
                    second = resizedImage(i, j + fact, k);
                else
                    second = 0;
                end
                if second ~= 0
                    if first > second
                        for l = 1 : fact - 1
                            resizedImage(i, j + l, k) = round(((first - second) / fact) * (fact - l) + second);
                        end
                    else
                        for l = 1 : fact - 1
                            resizedImage(i, j + l, k) = round(((second - first) / fact) * l + first);
                        end
                    end

            end
        end
    end

    for k = 1 : ch
        for i = 1 : fact : new_row
            for j = 1 : new_col
                if resizedImage(i, j, k) == 0
                    resizedImage(i, j, k) = resizedImage(i, j - 1, k);
                end
            end
        end
    end

    for k = 1 : ch
        for j = 1 : new_col
            for i = 1 : fact : new_row
                first = resizedImage(i, j, k);
                if i + fact <= new_row
                    second = resizedImage(i + fact, j, k);
                else
                    second = 0;
                end
                if second ~= 0
                    if first > second
                        for l = 1 : fact - 1
                            resizedImage(i + l, j, k) = round(((first - second) / fact) * (fact - l) + second);
                        end
                    else
                        for l = 1 : fact - 1
                            resizedImage(i + l, j, k) = round(((second - first) / fact) * l + first);
                        end
                    end
                end
            end
        end
    end

    for k = 1 : ch
        for j = 1 : new_col
            for i = 1 : new_row
                if resizedImage(i, j, k) == 0
                    resizedImage(i, j, k) = resizedImage(i - 1, j, k);
                end
            end
        end
    end
end
resizedImage = uint8(resizedImage);
figure,imshow(inputImage),title('Original')
figure,imshow(resizedImage),title('Resized')
