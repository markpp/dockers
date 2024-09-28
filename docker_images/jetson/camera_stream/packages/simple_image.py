import cv2

def show_image(path='img.jpg'):
    frame = cv2.imread(path)
    window_title = "Image"

    window_handle = cv2.namedWindow(window_title, cv2.WINDOW_AUTOSIZE)
    while True:
        
        if cv2.getWindowProperty(window_title, cv2.WND_PROP_AUTOSIZE) >= 0:
            cv2.imshow(window_title, frame)
        else:
            break 
        keyCode = cv2.waitKey(10) & 0xFF
        # Stop the program on the ESC key or 'q'
        if keyCode == 27 or keyCode == ord('q'):
            break
    
    cv2.destroyAllWindows()

if __name__ == "__main__":
    show_image(path='img.jpg')
