Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C56A2AF88E
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 19:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgKKSwA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 13:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgKKSv7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 13:51:59 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF22C0613D1;
        Wed, 11 Nov 2020 10:51:59 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id r9so1149908pjl.5;
        Wed, 11 Nov 2020 10:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l1Pegl0AGNVKaWQlJGzbmp8EJmfVq5zNsJCWYXHqOnQ=;
        b=Sma0B//i35MjdI7HCYP+08L7s9F239NGmzphbelfWa2ENFCQpLLXlUAe/x+rjedsc6
         TN+lVpjjqEDnl8+S0iZ9yMEzpBhMl5fsd5c58bomv+UyWH/687H7nkHD0TdeMVM3uTiZ
         wi3zkTu6uazExkFK/R8FQeJUrhOrFd4rRoyQgA0m8XFEEuQFykA1uPP96y3dIEon9A/N
         KC0zThADnhzemVUeqw1HtK/p7TqhPM5784XAMpECJJ4Hr1AM0LV+Pa+FfGLe9qnRIKbi
         Z4d8oGK7j/bCc7FjqRt2I0NQC8CWxCC16nYIoi07nkO2QONKakdpxzTBFJhi9A8Nav90
         YI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l1Pegl0AGNVKaWQlJGzbmp8EJmfVq5zNsJCWYXHqOnQ=;
        b=YFcZZ9YOuc85yuwDNvCLtrEk0RtYOMOvoxOUIAjqKqElWgCKMo80ezV0ruSdS/HDT4
         35dWB7gUFIkH0GNg0wJXU/3GHF3/urSfWdjnuTu4NOBP2c5NKfMpcT8pVoJmaNU6/I6O
         Vqao/nvAxkbq6/5zh3WqJzPUPcWXpj/Tkc/MFs+91GdiwBlmkv5O/RKruHzrjZbVGahe
         1PDJ2sNZXWQG1XEOaac82YK1zze+ZStjS5eHXOHRhVhnqqikkW1M4URv5g+yq7xrtTby
         lsMQ0hjMyT34Ad2/AqHO02o6zXkFdDjlkhdzgav08bqP4PY5SRpEcBxUa7h3nQuFu9JC
         ATxg==
X-Gm-Message-State: AOAM5336sVi2bXgE7ZaIRTsnxGwP8I895qWgK93IyM4U8uTv/8A4RWTH
        v2Gu2Tldiz0Oj42lhDrSNxE=
X-Google-Smtp-Source: ABdhPJyVUxQq2cBj6TbT7F1VtW6AHWOcUSdgcCYuaWRLgf846LUydwLec7E5iGdGUkH1FvYA9TxFWg==
X-Received: by 2002:a17:902:bd01:b029:d4:d73d:7644 with SMTP id p1-20020a170902bd01b02900d4d73d7644mr22293923pls.69.1605120718101;
        Wed, 11 Nov 2020 10:51:58 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id v18sm3367522pfn.35.2020.11.11.10.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:51:57 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:51:55 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 2/2] Input: ads7846: do not overwrite spi->mode flags
 set by spi framework
Message-ID: <20201111185155.GX1003057@dtor-ws>
References: <20201027095724.18654-1-o.rempel@pengutronix.de>
 <20201027095724.18654-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027095724.18654-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 27, 2020 at 10:57:24AM +0100, Oleksij Rempel wrote:
> Do not overwrite spi->mode flags set by spi framework, otherwise the
> chip select polarity will get lost.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Mark, could you please pick up this one through your tree as well? I do
not believe that outstanding patches that I have in my queue for this
driver will clash with it.  

Thanks!

> ---
>  drivers/input/touchscreen/ads7846.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 8fd7fc39c4fd..f2dc2c8ab5ec 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1288,7 +1288,8 @@ static int ads7846_probe(struct spi_device *spi)
>  	 * may not.  So we stick to very-portable 8 bit words, both RX and TX.
>  	 */
>  	spi->bits_per_word = 8;
> -	spi->mode = SPI_MODE_0;
> +	spi->mode &= ~SPI_MODE_X_MASK;
> +	spi->mode |= SPI_MODE_0;
>  	err = spi_setup(spi);
>  	if (err < 0)
>  		return err;
> -- 
> 2.28.0
> 

-- 
Dmitry
