Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC242A8D1
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhJLPxy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhJLPxx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:53:53 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FFFC061745;
        Tue, 12 Oct 2021 08:51:51 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id a17-20020a4a6851000000b002b59bfbf669so6513063oof.9;
        Tue, 12 Oct 2021 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nIV4GMcFXO2FfQExgtOGvu70adhVEKRJ+yAiGKrtQzA=;
        b=ZKI8gpM+7XBek6AF91bc2UjvD16P9rqvVBXad5c/kzcTIcfx/3Bz4QnH0lRLz0FqFn
         516CUc++KtmnCJfbBkPCH/0LoMr7hP8xG0lgJYvb7fITmlAGJhLn1SEFNTdtfRYpHA+C
         gpdTXYpB2m0ecjC9oiP8A1Dxly0VBAXwMyewc500KaFnU105LLykyUBJ5OrlJOf4jXAA
         1fdpcnySniXwdRKuw4rM8vbMhXjWLHP+NKdRV3VR4bhCV3Xex17Sk6szLJhKgKZ2RCts
         GI3iEf2AVSmYa2Kr+9IOPNxiludEyQmerBiy3Rfq9Lr6g1wonTbk5mX5siyOKxjjvh/A
         b4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=nIV4GMcFXO2FfQExgtOGvu70adhVEKRJ+yAiGKrtQzA=;
        b=HPIFI2F2FOE/+Ix2YuY67TN4MLDSH3t7FBGkks4Rh9DoBk5XUceqvW+4+1gEN/yAGy
         7Umn7CkvYgjWtyy2/pW9mBD1r2EIsxw4PXqiXI3MoCldnjOhCh/WAsp2aYHhl4YjGlOo
         tVsfMJ8u4cPMceOvCPuso5mR5zMwh99IAHsQblmP6uxwfKYFtUfePWwonD+DaSYW6Oq8
         3Ogly0WVi0HjYSNHeI928goZ673j7ZpaBJ76YkwfRGNurlXirdQeR02BHbyVkHh4lpy4
         2GogqRCYGjTx7KiJQanLtWPBP62n17B+3jqBnGXHM5z0S17kz8ITZyGxsLqf5NHJf/ox
         VmYg==
X-Gm-Message-State: AOAM531y6Yihqe07dqmKNHvzGvrWoly48wz3v9k26ND3ictgyvdFKm6v
        U17Tmc0rb8eL7NuEsM8jV3rsbDEUmBs=
X-Google-Smtp-Source: ABdhPJzUoef/HXvXFPp3AgKcvBiodNI/8phQ99mRRqpsBg/X1w4bobpSmr1giwmwyNbr2/XE3SOLUA==
X-Received: by 2002:a4a:e867:: with SMTP id m7mr6890342oom.5.1634053911104;
        Tue, 12 Oct 2021 08:51:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g92sm2408655otb.17.2021.10.12.08.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 08:51:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Oct 2021 08:51:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jean Delvare <jdelvare@suse.com>, Mark Brown <broonie@kernel.org>,
        kernel@pengutronix.de, linux-hwmon@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v2 04/20] hwmon: max31722: Warn about failure to put
 device in stand-by in .remove()
Message-ID: <20211012155149.GA4051737@roeck-us.net>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012153945.2651412-5-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 12, 2021 at 05:39:29PM +0200, Uwe Kleine-König wrote:
> When an spi driver's remove function returns a non-zero error code
> nothing happens apart from emitting a generic error message. Make this
> error message more device specific and return zero instead.
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/max31722.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/max31722.c b/drivers/hwmon/max31722.c
> index 613338cbcb17..4cf4fe6809a3 100644
> --- a/drivers/hwmon/max31722.c
> +++ b/drivers/hwmon/max31722.c
> @@ -103,10 +103,16 @@ static int max31722_probe(struct spi_device *spi)
>  static int max31722_remove(struct spi_device *spi)
>  {
>  	struct max31722_data *data = spi_get_drvdata(spi);
> +	int ret;
>  
>  	hwmon_device_unregister(data->hwmon_dev);
>  
> -	return max31722_set_mode(data, MAX31722_MODE_STANDBY);
> +	ret = max31722_set_mode(data, MAX31722_MODE_STANDBY);
> +	if (ret)
> +		/* There is nothing we can do about this ... */
> +		dev_warn(&spi->dev, "Failed to put device in stand-by mode\n");
> +
> +	return 0;
>  }
>  
>  static int __maybe_unused max31722_suspend(struct device *dev)
