Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBD01FBC54
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgFPRFN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 13:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729794AbgFPRFN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 13:05:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF6FC061573;
        Tue, 16 Jun 2020 10:05:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f185so3859064wmf.3;
        Tue, 16 Jun 2020 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Df4lS1a4Afgip6mUYwPxDAu7PfQ0SWY73b7vyFMbsdY=;
        b=CI3GXRng/K5RxhCOS2ZF34C0Ye8JxjrfxOlmQhW2IhqlU78cmj9vX2qakPBpyhaKCZ
         EPrtQxOXVVhNTmrfMvB6u7rPfCEdiaBROHPuqrCsuhN0ZnMFfiid/0hQXTDSpQ5mUHyC
         ZazlXCmEUzZoHaTgjbXV11ff2jaft3sQcWbiOJfJhStNCguLMBeM7HzwJ45SZbMReRyG
         +O5rdV7YmSbau/2jpbHx64yfKAnS4r79vqLfosIM7tiuGs22qPC0DG+Lo9uAGVrNeHvv
         XODkuQyVSl8Gv3F8WG88JXp9ZD75V5UnLPgYY38/uasWV76/p+Bhnl7BKcHgJ3tnxLlF
         3mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Df4lS1a4Afgip6mUYwPxDAu7PfQ0SWY73b7vyFMbsdY=;
        b=SiHqaxDlhZsrCxEGgVhw6XE4ykr1WxuVcfQtOfR0Fuuw6pQhF+o5WhvCZouL3DxDmo
         5YrfpipNL3+/JwW5hNkH8YB9BIPKYFhnJ22tF/cLweMshTZuc+l7BLl56eql4SZ5jAQ0
         oV3bWtihA5NIo4JUXlhyfOBfTIlWGhEse239ojNRLHs1y0i6Yd0UorE/81mkcTbyFgaq
         pnBgvX8KCMVDpGNMnpHoHKa7dqHj0qA3IRePmJyYFN4UsLzNS+YfN2jBUhbWRcDTSzUR
         XsefEE9sS4VBbQSD84dA0CRk6rVOaCaELknUNCWN8w2jP1iEKeMtcLzR+r3Fay4EIyKz
         JfGw==
X-Gm-Message-State: AOAM533kHbbvW5AZsI/3xTbnXXGX5HbqQyXtt9X97E7OXO23sggW0C/a
        0vLI9IPd6hOGtIbNqw5e1+I=
X-Google-Smtp-Source: ABdhPJxRRzNwKYMdzdDi5JUyzHnahhqSfODmYl+q3iopHnH3Wx2Jl5Fzl4J9jJsr+CkhwDCeg3nh7A==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12mr4346720wmh.111.1592327110274;
        Tue, 16 Jun 2020 10:05:10 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id w1sm4682818wmi.13.2020.06.16.10.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 10:05:09 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] spi: bcm63xx-spi: add reset support
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200616070223.3401282-1-noltari@gmail.com>
 <20200616070223.3401282-2-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d79c9e3d-fcf3-84ab-4a13-8ff00b4b2605@gmail.com>
Date:   Tue, 16 Jun 2020 10:05:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616070223.3401282-2-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/16/2020 12:02 AM, Álvaro Fernández Rojas wrote:
> bcm63xx arch resets the SPI controller at early boot. However, bmips arch
> needs to perform a reset when probing the driver.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  v3: use devm_reset_control_get_optional_exclusive
>  v2: use devm_reset_control_get_exclusive
> 
>  drivers/spi/spi-bcm63xx.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> index 0f1b10a4ef0c..92e88901189c 100644
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
> +	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(reset)) {
> +		ret = PTR_ERR(reset);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev,
> +				"failed to get reset controller: %d\n", ret);
> +		return ret;
> +	}

When the controller is optional, you don't need to do that manual error
checking, as it does that for you already. You can only do:

if (IS_ERR(reset))
	return PTR_ERR(reset);

and that's it. With that fixed in v4, you can add:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
