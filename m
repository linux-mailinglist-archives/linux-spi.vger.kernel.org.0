Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5556A40669D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 07:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhIJFFc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 01:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhIJFFb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 01:05:31 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C339C061574;
        Thu,  9 Sep 2021 22:04:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w6so401664pll.3;
        Thu, 09 Sep 2021 22:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d5eOmTxE1ZD/E42iqd3uKR/Y6MHuYpwLI55f3E0La5E=;
        b=D8jXj9DJpL/epFZdDk8+HpYXMdp57OTLkSPCkszhGUOuPyjnPP6Vbnal1jn4yQUTBT
         9nZdTQ6d+9CcIYBiCeVdZjN/2YANVlY/9mIGI7uCjKRrTs2DdN2cauGI/GERiGfDq/Ql
         e4XxaoCaGS7rexQA0wOf13jNJVXvJgTqxf2qwCO97lNCqpor+J36XaQNS0XUUSE5fbG7
         zXDOhg1lhiavFfLbS/paCIECSnMhn2x2zoU+34et0ZRZrYsYluYfmrNiWS/kiSkp5iHH
         M7anLDr4fSc0pYqtetsYftjfVdspeuxSNRjq/6pu04PJ5FnrQcl+nrc1Eb6F+40zq/Lk
         gH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d5eOmTxE1ZD/E42iqd3uKR/Y6MHuYpwLI55f3E0La5E=;
        b=jWvYP7DheRkzxx6a9fvqLPEo0pMUoIdJUOdAzfE2O5h6PBSPuGFxgxAb/qjucNw16r
         ZzgvljNFquGjeY/Zo8aJnZDAxVZk39eUajgK3JUtaZ4XBILUzuhkYr8NwMJP9jKSctPO
         gP9bKlT7AXYdhAzWlNzWiK5vyMFYP7QgA0421oLKgMN76/EK2x6+NnMjD1lX4QoF/Y9C
         PPAxFga8Qq5XBTb8QQU4y0NpL3oHSp/0eRDBHSNhaETbp6oDRAZF61oMMQomwp2nWO5O
         lQi22aU7Vzsf/GoUjTGEJSkgmPZJ5e0F+/RUhsZWzuiQg/7KSf5hM3nGkjBuY+blnWIt
         TM+w==
X-Gm-Message-State: AOAM533mBCDN64D1JojkZkytatr7pUScjom2vV39YY8ThF+9dDj/yz26
        bj+PatLbs6DHONJTgCnStq4=
X-Google-Smtp-Source: ABdhPJzHTI+b4/VBBzRYnWIhKBe6tQMwl0FszM9/LHsx0pAHwPEtWEcpLlfJ+ynZ5AoGCf0SWDW+Qw==
X-Received: by 2002:a17:902:8648:b029:129:dda4:ddc2 with SMTP id y8-20020a1709028648b0290129dda4ddc2mr5899371plt.4.1631250260605;
        Thu, 09 Sep 2021 22:04:20 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:acdc:1d22:e20a:2796])
        by smtp.gmail.com with ESMTPSA id s192sm4053556pgc.23.2021.09.09.22.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 22:04:19 -0700 (PDT)
Date:   Thu, 9 Sep 2021 22:04:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH v1] Input: ads7846: ads7846_get_value - fix unaligned
 pointer value warning
Message-ID: <YTrnUFI53iwvwxrj@google.com>
References: <20210707124115.20028-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707124115.20028-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Oleksij,

On Wed, Jul 07, 2021 at 02:41:15PM +0200, Oleksij Rempel wrote:
> Fix warning reported by the kernel test robot:
> drivers/input/touchscreen/ads7846.c:705:24: warning: taking address
> of packed member 'data' of class or structure 'ads7846_buf' may result
> in an unaligned pointer value [-Waddress-of-packed-member]
> 
> Fixes: 6965eece2a89 ("Input: ads7846 - convert to one message")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/input/touchscreen/ads7846.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index adb4c2230c31..1987dedac94f 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -702,7 +702,7 @@ static int ads7846_get_value(struct ads7846_buf *buf)
>  {
>  	int value;
>  
> -	value = be16_to_cpup(&buf->data);
> +	value = get_unaligned_be16(&buf->data);

ds7846_buf is declared as packed so I believe using be16_to_cpu(buf->data)
will suffice.

I can adjust on my side if you agree.

Thanks.

-- 
Dmitry
