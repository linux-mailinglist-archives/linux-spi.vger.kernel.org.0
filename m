Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF9319565
	for <lists+linux-spi@lfdr.de>; Thu, 11 Feb 2021 22:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhBKVub (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Feb 2021 16:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBKVua (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Feb 2021 16:50:30 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96049C061574;
        Thu, 11 Feb 2021 13:49:49 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p21so10252447lfu.11;
        Thu, 11 Feb 2021 13:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kx95rQc2Zpz76757QpOil3wNlv8GyzyyMZscHJbIHaQ=;
        b=X97cLbdraTOLKeTspCLsaP5Ig7988WZhWe4sDZQZm5XkIsddDayN3D+Aryhjy6/vOe
         +PbdMjCZwv69lrraeF7TUInlfWH0amaO8hIPZ/kJzCZrv1OIEmHBxIzrAoh4tRaCIoNk
         Ty2sjl0ZUyP/hA2XoqfA45gU/Jn+/X8AbuCXAgeAjUOzWXPWQTlr91aLYZeRysM/Vvuc
         dKaf5NAc6qRJGvERDFgiBhV0opgfp5zJCixBfy+I7wrauu1SZXgpZkMK8SZTBQyZds3H
         y7xE8D3h6ko0UqCFOF8sTSZcBt+2T56uCjC8vqzjAYjrJz/XFocJUsK9jV7NYe5+8hUt
         oi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kx95rQc2Zpz76757QpOil3wNlv8GyzyyMZscHJbIHaQ=;
        b=SRviJGkV/Ys/1HgxtOX7iqeSqRn0G0HF0lEOMJeCJVBJq7R2H7a8VPqVBhZxker6xW
         6MNMZbMq45ty4pq6L71oqLkKsNgnB4AZDXxcjLtR8n+A+3xPCwA5mFb4sNJpVwEvoe58
         XwKnv3vqnYMNqG2LTpKmvwCbN1u06H2FngPY6Ye+nprof99wEtOgMCC+kFVuwmZhzKEz
         OzRuXnIwsSjGRIHRx7y7MfXjumWGIzvAf0brvDmnBqBarsz0HPrZP6irEBtWswJgRXdP
         79DGBxqMH39pzq6AesAnbTyevlsilOAfRRUR5W2zxtKpmDZZg8dZ4/R6opkyR/WPFDxj
         Dw8Q==
X-Gm-Message-State: AOAM531bjlY6yfQf97sJR7Y2WFDhX6+jfTl6j15wBAXkK9ZnWQb00JBU
        Y577vWw/UaqKTAjyl6tJxy0=
X-Google-Smtp-Source: ABdhPJytKvsVCYe3sCTowy+qfySxV9ULpHBuDmW6qYvrT0PS9Eci3pClxHAJFU7Y52bRt85to5dvHA==
X-Received: by 2002:a19:6c7:: with SMTP id 190mr15088lfg.196.1613080188142;
        Thu, 11 Feb 2021 13:49:48 -0800 (PST)
Received: from mobilestation ([95.79.218.112])
        by smtp.gmail.com with ESMTPSA id j22sm16182lfm.29.2021.02.11.13.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 13:49:47 -0800 (PST)
Date:   Fri, 12 Feb 2021 00:49:39 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-spi@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Avoid stack content exposure
Message-ID: <20210211214939.bwzojhjhazyxbi7i@mobilestation>
References: <20210211203714.1929862-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211203714.1929862-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 11, 2021 at 12:37:14PM -0800, Kees Cook wrote:
> Since "data" is u32, &data is a "u32 *" type, which means pointer math
> will move in u32-sized steps. This was meant to be a byte offset, so
> cast &data to "char *" to aim the copy into the correct location.
> 
> Seen with -Warray-bounds (and found by Coverity):
> 
> In file included from ./include/linux/string.h:269,
>                  from ./arch/powerpc/include/asm/paca.h:15,
>                  from ./arch/powerpc/include/asm/current.h:13,
>                  from ./include/linux/mutex.h:14,
>                  from ./include/linux/notifier.h:14,
>                  from ./include/linux/clk.h:14,
>                  from drivers/spi/spi-dw-bt1.c:12:
> In function 'memcpy',
>     inlined from 'dw_spi_bt1_dirmap_copy_from_map' at drivers/spi/spi-dw-bt1.c:87:3:
> ./include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset 4 is out of the bounds [0, 4] of object 'data' with type 'u32' {aka 'unsigned int'} [-Warray-bounds]
>    20 | #define __underlying_memcpy __builtin_memcpy
>       |                             ^
> ./include/linux/fortify-string.h:191:9: note: in expansion of macro '__underlying_memcpy'
>   191 |  return __underlying_memcpy(p, q, size);
>       |         ^~~~~~~~~~~~~~~~~~~
> drivers/spi/spi-dw-bt1.c: In function 'dw_spi_bt1_dirmap_copy_from_map':
> drivers/spi/spi-dw-bt1.c:77:6: note: 'data' declared here
>    77 |  u32 data;
>       |      ^~~~

Can't believe I missed that. Thanks!
Acked-by: Serge Semin <fancer.lancer@gmail.com>

> 
> Addresses-Coverity: CID 1497771 Out-of-bounds access
> Fixes: abf00907538e ("spi: dw: Add Baikal-T1 SPI Controller glue driver")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/spi/spi-dw-bt1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
> index 4aa8596fb1f2..5be6b7b80c21 100644
> --- a/drivers/spi/spi-dw-bt1.c
> +++ b/drivers/spi/spi-dw-bt1.c
> @@ -84,7 +84,7 @@ static void dw_spi_bt1_dirmap_copy_from_map(void *to, void __iomem *from, size_t
>  	if (shift) {
>  		chunk = min_t(size_t, 4 - shift, len);
>  		data = readl_relaxed(from - shift);
> -		memcpy(to, &data + shift, chunk);
> +		memcpy(to, (char *)&data + shift, chunk);
>  		from += chunk;
>  		to += chunk;
>  		len -= chunk;
> -- 
> 2.25.1
> 
