Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47DDF1832F9
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 15:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgCLO2p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 10:28:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42279 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgCLO2o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 10:28:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so6638275ljp.9
        for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2020 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wkUnkIL0e/rtPLFDdVkLiF07+cIlvDNfDcO1JSkyZI4=;
        b=WlUjE7eepBgGbA4RoEeoesjQgHfWlYXpCSFWO57dJ5D5WTglPRmgkTtessjbP7tjVu
         YzJo4NS1WtRUcvO/ZGPv0sXNpEXGyfYNJOUA3OsKcWZA4s75vSBOPvLGx4tmuLUa8R3T
         kAiquNcyy15hGvGi1IxIXXFokro4xVA6lrRW6QzI543Au22Ye57AeEYwdl0dbtV14plW
         3ibxOhDEcbSezDd4D/LQQdCjIYOSeDy7DcN7EbjwSVb/7NUq/sJ52g+aAULLrmAfcP4z
         smrGuivoeBRLW1mDqa4V0NA5uuKbeL5ScOIS2YqmYtvI5oCV8npdXZzPPmbe/JHKC3H6
         GE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wkUnkIL0e/rtPLFDdVkLiF07+cIlvDNfDcO1JSkyZI4=;
        b=e9OB7hvNjCNs0dtK2z+beDRM/kKhHUsF/jQKgv+m/P2YO2FqckJVnQoWsJmNGXBX8W
         gFW3TaKvBTgwhq4Dg2WG4VAtuG8EeSU7DeCYG0DE0ipZM2Ju+kiHk1N9OexteuBQPZk3
         qvy36L/AdnTp2JPuLNJ3NkYN9rgsRzu1KXtchV6IU365JQKN+DZui96KdRBfrKYHKhNq
         eab35c7WpK8tYLSfyrvjeSuFmjHC4hFJ9Vlw+Dde+/dpizRY0uDVCNXb4szLt4a1iEC9
         mMeqXhnJtP6BZRfOcz0+xRMFidILI/VUTwHnwcctvJEMMgZXde2RyaJc7LUDiR4utORG
         xgvA==
X-Gm-Message-State: ANhLgQ0E+uvk7x6VcHzZv3ZOX6AVV2MAE/pGeo9zMzM1y6Qq3K2bc2P9
        Kx/GrNtzvS/GsZhVkSCq2wovIw==
X-Google-Smtp-Source: ADFU+vtRZ9aSvDfEDAe4PWAVfE2EXngpJ4HRI4zpaR769zc92kWMK2r5W3q4475q4O5Ki8zlATdXyQ==
X-Received: by 2002:a2e:2e13:: with SMTP id u19mr4473390lju.3.1584023322663;
        Thu, 12 Mar 2020 07:28:42 -0700 (PDT)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id x13sm14807277lfq.97.2020.03.12.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:28:41 -0700 (PDT)
Date:   Thu, 12 Mar 2020 15:28:41 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] spi: acpi: remove superfluous parameter check
Message-ID: <20200312142841.GC791432@oden.dyn.berto.se>
References: <20200312134507.10000-1-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200312134507.10000-1-wsa@the-dreams.de>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2020-03-12 14:45:07 +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> to_spi_device() already checks 'dev'. No need to do it before calling
> it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> 
> Found while fiddling with bus_find_device_by_acpi_dev() in the I2C
> subsystem.
> 
>  drivers/spi/spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 755221bc3745..75978b6c5834 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4034,7 +4034,7 @@ static struct spi_device *acpi_spi_find_device_by_adev(struct acpi_device *adev)
>  	struct device *dev;
>  
>  	dev = bus_find_device_by_acpi_dev(&spi_bus_type, adev);
> -	return dev ? to_spi_device(dev) : NULL;
> +	return to_spi_device(dev);
>  }
>  
>  static int acpi_spi_notify(struct notifier_block *nb, unsigned long value,
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
