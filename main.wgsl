@stage(fragment)
fn main(@builtin(position) position: vec4<f32>) -> @location(0) vec4<f32> {
    var uv: vec3<f32> =vec3<f32>(position.xyx/Resolution.xyx);
    var uv_x: f32 = f32(position.x/Resolution.x);
    var uv_y: f32 = f32(position.y/Resolution.y);

    var up_y: f32 = f32(f32(Position.y/Resolution.y)/2.0+(-0.3f));
    var up_x: f32 = f32(f32(Position.x/Resolution.x)+0.5f);


    var sky_col: vec3<f32> = vec3<f32>(0.44,0.77,0.81);
    var groung_col: vec3<f32> = vec3<f32>(0.86,0.85,0.58);
    var groung_more_col: vec3<f32> = vec3<f32>(0.84,0.66,0.32);
    var groung_more2_col: vec3<f32> = vec3<f32>(0.37,0.30,0.33);
    var cloud_col: vec3<f32> = vec3<f32>(0.92,0.99,0.88);
    var green_1: vec3<f32> = vec3<f32>(0.61,0.89,0.34);
    var green_2: vec3<f32> = vec3<f32>(0.45,0.74,0.16);
    var green_3: vec3<f32> = vec3<f32>(0.87,0.99,0.56);
    var green_4: vec3<f32> = vec3<f32>(0.32,0.48,0.11);

    var tree_1: vec3<f32> = vec3<f32>(0.52,0.89,0.55);
    var tree_2: vec3<f32> = vec3<f32>(0.42,0.78,0.49);

    var bird_1: vec3<f32> = vec3<f32>(0.89,0.88,0.70);
    var bird_2: vec3<f32> = vec3<f32>(0.84,0.76,0.17);
    var bird_3: vec3<f32> = vec3<f32>(0.90,0.50,0.15);
    var bird_4: vec3<f32> = vec3<f32>(0.83,0.35,0.27);
    var bird_5: vec3<f32> = vec3<f32>(0.93,1.0,0.98);

    // 伪随机生成
    var time_rand: f32 = f32(u32(Time/4.0f)%5u);
    var rand: f32;
    if (time_rand==0.0)
    {
        rand=0.10;
    }
    else if (time_rand==1.0)
    {
        rand=0.16;
    }
    else if (time_rand==2.0)
    {
        rand=-0.06;
    }
    else if (time_rand==3.0)
    {
        rand=-0.14;
    }
    else if (time_rand==4.0)
    {
        rand=0.02;
    }
    
    //循环显示管道
    var move_speed :f32 = f32(f32(Time/-3.0)+f32(u32(Time/4.0))*f32(4.0/3.0)+0.5);
    //草地移动速度
    var speed_ground :f32= f32(Time/3.0);

    //碰撞检测
    if (up_x>=(0.475+move_speed) && up_x<=(0.800+move_speed))
    {
        if ((0.505+up_y)>(0.50-rand) || (0.505+up_y)<(0.3-rand))
        {
            move_speed=0.0;
            speed_ground=0.0;
        }
    }

    if (uv_y>0.85)
    {
        return vec4<f32>(groung_col, 1.0);
    }
    else if (uv_y<=0.85 &&  uv_y>0.83)
    {
        return vec4<f32>(groung_more_col, 1.0);
    }
    else if (uv_y<=0.83 &&  uv_y>0.81)
    {
        return vec4<f32>(green_4, 1.0);
    }
    else if (uv_y<=0.81 &&  uv_y>=0.77)
    {
        if (sin(50.0*(uv_y-uv_x-speed_ground))>0.0f)
        {
            return vec4<f32>(green_1, 1.0);
        }
        else
        {
            return vec4<f32>(green_2, 1.0);
        }
    }
    else if (uv_y<=0.77 &&  uv_y>0.76)
    {
        return vec4<f32>(green_3, 1.0);
    }
    else if (uv_y<=0.76 &&  uv_y>0.75)
    {
        return vec4<f32>(groung_more2_col, 1.0);
    }
    else
    {
        // 画小鸟
        if (uv_y<=0.75)
        {
            if (uv_y<=0.505+up_y && uv_y>=0.500+up_y && uv_x<=0.510 && uv_x>=0.485)
            {
                return vec4<f32>(groung_more2_col, 1.0);
            }
            else if (uv_y<=0.510+up_y && uv_y>=0.505+up_y)
            {
                if(uv_x<=0.485 && uv_x>=0.475)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.495 && uv_x>=0.485)
                {
                    return vec4<f32>(bird_1, 1.0);
                }
                else if (uv_x<=0.50 && uv_x>=0.495)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.510 && uv_x>=0.500)
                {
                    return vec4<f32>(bird_5, 1.0);
                }
                else if (uv_x<=0.515 && uv_x>=0.510)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=0.515+up_y && uv_y>=0.510+up_y)
            {
                if(uv_x<=0.475 && uv_x>=0.470)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.485 && uv_x>=0.475)
                {
                    return vec4<f32>(bird_1, 1.0);
                }
                else if (uv_x<=0.495 && uv_x>=0.485)
                {
                    return vec4<f32>(bird_2, 1.0);
                }
                else if (uv_x<=0.500 && uv_x>=0.495)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.515 && uv_x>=0.500)
                {
                    return vec4<f32>(bird_5, 1.0);
                }
                else if (uv_x<=0.520 && uv_x>=0.515)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=0.520+up_y && uv_y>=0.515+up_y)
            {
                if(uv_x<=0.470 && uv_x>=0.465)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.475 && uv_x>=0.470)
                {
                    return vec4<f32>(bird_1, 1.0);
                }
                else if (uv_x<=0.490 && uv_x>=0.475)
                {
                    return vec4<f32>(bird_2, 1.0);
                }
                else if (uv_x<=0.495 && uv_x>=0.490)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.500 && uv_x>=0.495)
                {
                    return vec4<f32>(bird_1, 1.0);
                }
                else if (uv_x<=0.510 && uv_x>=0.500)
                {
                    return vec4<f32>(bird_5, 1.0);
                }
                else if (uv_x<=0.515 && uv_x>=0.510)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.520 && uv_x>=0.515)
                {
                    return vec4<f32>(bird_5, 1.0);
                }
                else if (uv_x<=0.525 && uv_x>=0.520)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=0.525+up_y && uv_y>=0.520+up_y)
            {
                if(uv_x<=0.465 && uv_x>=0.460)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.490 && uv_x>=0.465)
                {
                    return vec4<f32>(bird_2, 1.0);
                }
                else if (uv_x<=0.495 && uv_x>=0.490)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.500 && uv_x>=0.495)
                {
                    return vec4<f32>(bird_1, 1.0);
                }
                else if (uv_x<=0.510 && uv_x>=0.500)
                {
                    return vec4<f32>(bird_5, 1.0);
                }
                else if (uv_x<=0.515 && uv_x>=0.510)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.520 && uv_x>=0.515)
                {
                    return vec4<f32>(bird_5, 1.0);
                }
                else if (uv_x<=0.525 && uv_x>=0.520)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=0.530+up_y && uv_y>=0.525+up_y)
            {
                if(uv_x<=0.485 && uv_x>=0.460)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.495 && uv_x>=0.485)
                {
                    return vec4<f32>(bird_2, 1.0);
                }
                else if (uv_x<=0.500 && uv_x>=0.495)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.505 && uv_x>=0.500)
                {
                    return vec4<f32>(bird_1, 1.0);
                }
                else if (uv_x<=0.520 && uv_x>=0.505)
                {
                    return vec4<f32>(bird_5, 1.0);
                }
                else if (uv_x<=0.525 && uv_x>=0.520)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=0.535+up_y && uv_y>=0.530+up_y)
            {
                if(uv_x<=0.460 && uv_x>=0.455)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.480 && uv_x>=0.460)
                {
                    return vec4<f32>(bird_1, 1.0);
                }
                else if(uv_x<=0.485 && uv_x>=0.480)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.500 && uv_x>=0.485)
                {
                    return vec4<f32>(bird_2, 1.0);
                }
                else if (uv_x<=0.525 && uv_x>=0.500)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=0.540+up_y && uv_y>=0.535+up_y)
            {
                if(uv_x<=0.460 && uv_x>=0.455)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.480 && uv_x>=0.460)
                {
                    return vec4<f32>(bird_1, 1.0);
                }
                else if(uv_x<=0.485 && uv_x>=0.480)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.495 && uv_x>=0.485)
                {
                    return vec4<f32>(bird_2, 1.0);
                }
                else if(uv_x<=0.500 && uv_x>=0.495)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.525 && uv_x>=0.500)
                {
                    return vec4<f32>(bird_3, 1.0);
                }
                else if (uv_x<=0.530 && uv_x>=0.525)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=0.545+up_y && uv_y>=0.540+up_y)
            {
                if(uv_x<=0.460 && uv_x>=0.455)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.480 && uv_x>=0.460)
                {
                    return vec4<f32>(bird_1, 1.0);
                }
                else if(uv_x<=0.485 && uv_x>=0.480)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.495 && uv_x>=0.485)
                {
                    return vec4<f32>(bird_2, 1.0);
                }
                else if(uv_x<=0.500 && uv_x>=0.495)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.525 && uv_x>=0.500)
                {
                    return vec4<f32>(bird_3, 1.0);
                }
                else if (uv_x<=0.530 && uv_x>=0.525)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=0.550+up_y && uv_y>=0.545+up_y)
            {
                if(uv_x<=0.480 && uv_x>=0.460)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.490 && uv_x>=0.480)
                {
                    return vec4<f32>(bird_3, 1.0);
                }
                else if(uv_x<=0.495 && uv_x>=0.490)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.500 && uv_x>=0.495)
                {
                    return vec4<f32>(bird_4, 1.0);
                }
                else if (uv_x<=0.525 && uv_x>=0.500)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=0.555+up_y && uv_y>=0.550+up_y)
            {
                if(uv_x<=0.470 && uv_x>=0.465)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.495 && uv_x>=0.470)
                {
                    return vec4<f32>(bird_3, 1.0);
                }
                else if(uv_x<=0.500 && uv_x>=0.495)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if (uv_x<=0.520 && uv_x>=0.500)
                {
                    return vec4<f32>(bird_4, 1.0);
                }
                else if (uv_x<=0.525 && uv_x>=0.520)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=0.560+up_y && uv_y>=0.555+up_y)
            {
                if(uv_x<=0.480 && uv_x>=0.470)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if(uv_x<=0.500 && uv_x>=0.480)
                {
                    return vec4<f32>(bird_3, 1.0);
                }
                else if(uv_x<=0.520 && uv_x>=0.500)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=0.565+up_y && uv_y>=0.560+up_y)
            {
                if(uv_x<=0.500 && uv_x>=0.480)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }




        }



        // 画管道
        if (uv_y<=0.75)
        {
            if (uv_y<=0.75 && uv_y>=(0.60-rand))
            {
                if ((uv_x-move_speed)<=0.65 && (uv_x-move_speed)>=0.645)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if ((uv_x-move_speed)<=0.645 && (uv_x-move_speed)>=0.63)
                {
                    return vec4<f32>(green_4, 1.0);
                }
                else if ((uv_x-move_speed)<=0.63 && (uv_x-move_speed)>=0.625)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.625 && (uv_x-move_speed)>=0.62)
                {
                    return vec4<f32>(green_4, 1.0);
                }
                else if ((uv_x-move_speed)<=0.62 && (uv_x-move_speed)>=0.57)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.57 && (uv_x-move_speed)>=0.565)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.565 && (uv_x-move_speed)>=0.55)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.55 && (uv_x-move_speed)>=0.535)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.535 && (uv_x-move_speed)>=0.53)
                {
                    return vec4<f32>(green_3, 1.0);
                }
                else if ((uv_x-move_speed)<=0.53 && (uv_x-move_speed)>=0.525)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.525 && (uv_x-move_speed)>=0.52)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=(0.60-rand) && uv_y>=(0.59-rand) && (uv_x-move_speed)<=0.655 && (uv_x-move_speed)>=0.515)
            {
                return vec4<f32>(groung_more2_col, 1.0);
            }
            else if (uv_y<=(0.59-rand) && uv_y>=(0.58-rand) && (uv_x-move_speed)<=0.655 && (uv_x-move_speed)>=0.515)
            {
                if (((uv_x-move_speed) <= 0.66 && (uv_x-move_speed) >= 0.65) ||((uv_x-move_speed) <= 0.52 && (uv_x-move_speed) >= 0.51))
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                return vec4<f32>(green_4, 1.0);
            }
            else if (uv_y<=(0.58-rand) && uv_y>=(0.52-rand))
            {
                if ((uv_x-move_speed)<=0.655 && (uv_x-move_speed)>=0.65)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if ((uv_x-move_speed)<=0.65 && (uv_x-move_speed)>=0.635)
                {
                    return vec4<f32>(green_4, 1.0);
                }
                else if ((uv_x-move_speed)<=0.635 && (uv_x-move_speed)>=0.63)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.63 && (uv_x-move_speed)>=0.625)
                {
                    return vec4<f32>(green_4, 1.0);
                }
                else if ((uv_x-move_speed)<=0.625 && (uv_x-move_speed)>=0.56)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.56 && (uv_x-move_speed)>=0.55)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.55 && (uv_x-move_speed)>=0.545)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.545 && (uv_x-move_speed)>=0.53)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.53 && (uv_x-move_speed)>=0.525)
                {
                    return vec4<f32>(green_3, 1.0);
                }
                else if ((uv_x-move_speed)<=0.525 && (uv_x-move_speed)>=0.52)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.52 && (uv_x-move_speed)>=0.515)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=(0.52-rand) && uv_y>=(0.51-rand) && (uv_x-move_speed)<=0.655 && (uv_x-move_speed)>=0.515)
            {
                if (((uv_x-move_speed) <= 0.66 && (uv_x-move_speed) >= 0.65) ||((uv_x-move_speed) <= 0.52 && (uv_x-move_speed) >= 0.51))
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                return vec4<f32>(green_3, 1.0);
            }
            else if (uv_y<=(0.51-rand) && uv_y>=(0.50-rand) && (uv_x-move_speed)<=0.655 && (uv_x-move_speed)>=0.515)
            {
                return vec4<f32>(groung_more2_col, 1.0);
            }


            if (uv_y<=(0.20-rand) && uv_y>=0.0)
            {
                if ((uv_x-move_speed)<=0.65 && (uv_x-move_speed)>=0.645)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if ((uv_x-move_speed)<=0.645 && (uv_x-move_speed)>=0.63)
                {
                    return vec4<f32>(green_4, 1.0);
                }
                else if ((uv_x-move_speed)<=0.63 && (uv_x-move_speed)>=0.625)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.625 && (uv_x-move_speed)>=0.62)
                {
                    return vec4<f32>(green_4, 1.0);
                }
                else if ((uv_x-move_speed)<=0.62 && (uv_x-move_speed)>=0.57)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.57 && (uv_x-move_speed)>=0.565)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.565 && (uv_x-move_speed)>=0.55)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.55 && (uv_x-move_speed)>=0.535)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.535 && (uv_x-move_speed)>=0.53)
                {
                    return vec4<f32>(green_3, 1.0);
                }
                else if ((uv_x-move_speed)<=0.53 && (uv_x-move_speed)>=0.525)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.525 && (uv_x-move_speed)>=0.52)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=(0.21-rand) && uv_y>=(0.20-rand) && (uv_x-move_speed)<=0.655 && (uv_x-move_speed)>=0.515)
            {
                return vec4<f32>(groung_more2_col, 1.0);
            }
            else if (uv_y<=(0.22-rand) && uv_y>=(0.21-rand) && (uv_x-move_speed)<=0.655 && (uv_x-move_speed)>=0.515)
            {
                if (((uv_x-move_speed) <= 0.66 && (uv_x-move_speed) >= 0.65) ||((uv_x-move_speed) <= 0.52 && (uv_x-move_speed) >= 0.51))
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                return vec4<f32>(green_4, 1.0);
            }
            else if (uv_y<=(0.28-rand) && uv_y>=(0.22-rand))
            {
                if ((uv_x-move_speed)<=0.655 && (uv_x-move_speed)>=0.65)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                else if ((uv_x-move_speed)<=0.65 && (uv_x-move_speed)>=0.635)
                {
                    return vec4<f32>(green_4, 1.0);
                }
                else if ((uv_x-move_speed)<=0.635 && (uv_x-move_speed)>=0.63)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.63 && (uv_x-move_speed)>=0.625)
                {
                    return vec4<f32>(green_4, 1.0);
                }
                else if ((uv_x-move_speed)<=0.625 && (uv_x-move_speed)>=0.56)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.56 && (uv_x-move_speed)>=0.55)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.55 && (uv_x-move_speed)>=0.545)
                {
                    return vec4<f32>(green_2, 1.0);
                }
                else if ((uv_x-move_speed)<=0.545 && (uv_x-move_speed)>=0.53)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.53 && (uv_x-move_speed)>=0.525)
                {
                    return vec4<f32>(green_3, 1.0);
                }
                else if ((uv_x-move_speed)<=0.525 && (uv_x-move_speed)>=0.52)
                {
                    return vec4<f32>(green_1, 1.0);
                }
                else if ((uv_x-move_speed)<=0.52 && (uv_x-move_speed)>=0.515)
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
            }
            else if (uv_y<=(0.29-rand) && uv_y>=(0.28-rand) && (uv_x-move_speed)<=0.655 && (uv_x-move_speed)>=0.515)
            {
                if (((uv_x-move_speed) <= 0.66 && (uv_x-move_speed) >= 0.65) ||((uv_x-move_speed) <= 0.52 && (uv_x-move_speed) >= 0.51))
                {
                    return vec4<f32>(groung_more2_col, 1.0);
                }
                return vec4<f32>(green_3, 1.0);
            }
            else if (uv_y<=(0.30-rand) && uv_y>=(0.29-rand) && (uv_x-move_speed)<=0.655 && (uv_x-move_speed)>=0.515)
            {
                return vec4<f32>(groung_more2_col, 1.0);
            }
        }
        if (uv_y<=0.75 &&  uv_y>0.68)
        {
            return vec4<f32>(tree_1, 1.0);       
        }
        else if (uv_y<=0.68 &&  uv_y>0.50)
        {
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.27,0.69))<0.04)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.27,0.69))<0.035)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.85,0.70))<0.05)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.85,0.70))<0.045)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.75,0.69))<0.04)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.75,0.69))<0.035)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.63,0.71))<0.06)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.63,0.71))<0.055)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.16,0.69))<0.03)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.16,0.69))<0.025)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.03,0.70))<0.06)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.03,0.70))<0.05)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
                
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.05,0.68))<0.05)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.05,0.68))<0.04)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.10,0.68))<0.08)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.10,0.68))<0.07)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.20,0.68))<0.06)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.20,0.68))<0.05)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.30,0.68))<0.07)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.30,0.68))<0.06)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.38,0.66))<0.04)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.38,0.66))<0.035)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.43,0.68))<0.03)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.43,0.68))<0.025)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.48,0.68))<0.08)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.48,0.68))<0.07)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.55,0.68))<0.06)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.55,0.68))<0.05)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.60,0.68))<0.08)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.60,0.68))<0.07)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.68,0.68))<0.05)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.68,0.68))<0.045)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.75,0.68))<0.06)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.75,0.68))<0.05)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.77,0.68))<0.08)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.77,0.68))<0.07)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.92,0.68))<0.04)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.92,0.68))<0.035)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.98,0.68))<0.08)
            {
                if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.98,0.68))<0.07)
                {
                    return vec4<f32>(tree_1, 1.0);
                }
                else
                {
                    return vec4<f32>(tree_2, 1.0); 
                }
            }

            return vec4<f32>(cloud_col, 1.0);       
        }
        else if (uv_y<=0.50 &&  uv_y>0.18)
        {
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.48,0.55))<0.18)
            {
                return vec4<f32>(cloud_col, 1.0);
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.28,0.47))<0.23)
            {
                return vec4<f32>(cloud_col, 1.0);
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.08,0.51))<0.15)
            {
                return vec4<f32>(cloud_col, 1.0);
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.81,0.44))<0.12)
            {
                return vec4<f32>(cloud_col, 1.0);
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.89,0.51))<0.15)
            {
                return vec4<f32>(cloud_col, 1.0);
            }
            if (distance(vec2<f32>(uv_x,uv_y),vec2<f32>(0.70,0.55))<0.10)
            {
                return vec4<f32>(cloud_col, 1.0);
            }
            else
            {
                return vec4<f32>(sky_col, 1.0);
            }
        }
        else
        {
            return vec4<f32>(sky_col, 1.0);
        }
    }
}