Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47BE1F9D52
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgFOQ0N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgFOQ0M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 12:26:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F74C061A0E;
        Mon, 15 Jun 2020 09:26:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w20so7811194pga.6;
        Mon, 15 Jun 2020 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TYrNTlrmIzbmT7MQbSQ47vQPQ5UxVm04h6DXBVDeZMk=;
        b=ijbkIRJfR21AwWxSRpF2fPyfu+JgSXoqpg7BmQmxgvoM7zti3LiBimpS4AEwtdyY55
         xypmr1+arzjntgNcn8BifWdwyNGBolrcWxrgri+Rq3uLYBvCwiZfGeA7+BLSnb/fy2be
         GTHrhW0REwqwYg2xZhm7tf3St94Z2t5+1nE7yf66eNuKEuRPA+lGIQ+kHd4pa4nAwmP6
         tahDicEruLVheNLCyh3SG6p2ZAP7NxAyKeHCptEw8W6ObQeSi7m5ONbTExjsZh2FWfwE
         W6rpshIrvSPAgtcqJfEDcNsYiYEdQvpDn/ery5vt5EaEd3JTtfuU5rOPVvEk+Q0ypBnx
         4vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TYrNTlrmIzbmT7MQbSQ47vQPQ5UxVm04h6DXBVDeZMk=;
        b=hXsWVLcIjxlgJDJAscz1FQlPIhOGGzMZeiZV7WElUrRovZBemMphRuoDMtP2Ml9sD1
         Ym15RjEHq6+WoOi6EApsmKg2ooEChbWX6LorSQv1l40dTYhxFMkG8iUCMTpN+TcfjW1a
         jD6Ks/qrv7F/EuedA0DZYlJLXoROFws8pfFzWK0Nc6NLafuzARTOAGmRTlHscGS35YNB
         vduoX/Ek5HlBRbWfy3ImeKQr+Iz1+YD5yLz4aDYW3r4Gp+RmtOA0V/PYGcOzgj9+742c
         Ea1x+RHHek58gsZRv64T6L0eYsJpBp52eGEOZKiwMwDEB0FPwZeSGRDe1owGAAMc/9ZN
         3HNQ==
X-Gm-Message-State: AOAM532fdxBTpse374AIMQO296XbY2JDBYym3pyFJLOPmZNlUU8QDpzP
        DjdrQdUUpVVYeeH3+6ePMDS85GdV
X-Google-Smtp-Source: ABdhPJwptr8oelZoC62cLr/hOohunZtdiJ/EY2r0Xvs0/j/PYTVVxj2vditwJiciJRH6Y1Gf/EzpLw==
X-Received: by 2002:a63:d54b:: with SMTP id v11mr21330284pgi.198.1592238371811;
        Mon, 15 Jun 2020 09:26:11 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g21sm14232286pfh.134.2020.06.15.09.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:26:10 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] spi: bcm63xx-spi: add reset support
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200615080309.2897694-1-noltari@gmail.com>
 <20200615090943.2936839-1-noltari@gmail.com>
 <20200615090943.2936839-2-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <16650d01-7c5a-21be-35a8-c74ad0a47b45@gmail.com>
Date:   Mon, 15 Jun 2020 09:26:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090943.2936839-2-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/15/2020 2:09 AM, Álvaro Fernández Rojas wrote:
> bcm63xx arch resets the SPI controller at early boot. However, bmips arch
> needs to perform a reset when probing the driver.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  v2: use devm_reset_control_get_exclusive
> 
>  drivers/spi/spi-bcm63xx.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> index 0f1b10a4ef0c..8ab04affaf7b 100644
> --- a/drivers/spi/spi-bcm63xx.c
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -18,6 +18,7 @@
>  #include <linux/err.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/reset.h>
>  
>  /* BCM 6338/6348 SPI core */
>  #define SPI_6348_RSET_SIZE		64
> @@ -493,6 +494,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
>  	struct bcm63xx_spi *bs;
>  	int ret;
>  	u32 num_cs = BCM63XX_SPI_MAX_CS;
> +	struct reset_control *reset;
>  
>  	if (dev->of_node) {
>  		const struct of_device_id *match;
> @@ -529,6 +531,15 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
>  		return PTR_ERR(clk);
>  	}
>  
> +	reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(reset)) {
> +		ret = PTR_ERR(reset);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev,
> +				"failed to get reset controller: %d\n", ret);
> +		return ret;
> +	}

This should be devm_reset_control_get_exclusive_optional() for a number
of reasons the first one being the most important as it reflects reality
of the HW:

- not all BCM63xx platforms have a dedicated reset line for the SPI
controller (like the ARM-based SoCs)

- until you also update all Device Tree sources to have a 'resets'
property in their SPI controller node, this is likely going to be failing

This also applies to patch 3.
-- 
Florian
