Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2696B2242
	for <lists+linux-spi@lfdr.de>; Thu,  9 Mar 2023 12:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjCILGR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Mar 2023 06:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjCILFd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Mar 2023 06:05:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5781BEB88F
        for <linux-spi@vger.kernel.org>; Thu,  9 Mar 2023 03:00:40 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7291966003B0;
        Thu,  9 Mar 2023 11:00:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678359639;
        bh=JSM/onmWuhsexsFzCDi5hXyjmL/ZSFGnsUuxT22kfWE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TQ6Lq21YiAfNab+c89pa21k1sdmo3xUJRRYLVOSzNj+c0rkQd6hMO7tynBI/n5G6E
         nVHYV+T39fNBe8xFMTV6SgRcQbpVbecSXKoCV5afjiXCH/jFAaK30MSnwlP5XRYGVZ
         5BAIVZaZOG2V0lNw+zYGG80SZm8vui4t0HvVrtfYSZQi9h+eEw/0CxY3U9e3IKsd1+
         ZHOgokNODgppRwU0phhJuVjS7SRdThHsIhoXlgQlbyx1f6GhjHht7t5SEgfaxDqu6w
         AQCYKqRxJhDmRWOThdzApG6NKH5SUWq6XnFHedseQktdAr6xqNHZxgfUZ3tMOmIh0i
         //oswa6ygrQ4A==
Message-ID: <8d845834-db8f-be0e-93a4-30f27617dd0c@collabora.com>
Date:   Thu, 9 Mar 2023 12:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] spi: mt65xx: Properly handle failures in .remove()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>
 <20230309094704.2568531-2-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230309094704.2568531-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Il 09/03/23 10:47, Uwe Kleine-König ha scritto:
> Returning an error code in a platform driver's remove function is wrong
> most of the time and there is an effort to make the callback return
> void. To prepare this rework the function not to exit early.
> 
> There wasn't a real problem because if pm runtime resume failed the only
> step missing was pm_runtime_disable() which isn't an issue.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/spi/spi-mt65xx.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 9eab6c20dbc5..b1cf7bbb2c08 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -1275,15 +1275,20 @@ static int mtk_spi_remove(struct platform_device *pdev)
>   	struct mtk_spi *mdata = spi_master_get_devdata(master);
>   	int ret;
>   
> -	ret = pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	mtk_spi_reset(mdata);
> +	ret = pm_runtime_get_sync(&pdev->dev);

> +	/*
> +	 * If pm runtime resume failed, clks are disabled and unprepared. So
> +	 * don't access the hardware and skip clk unpreparing.
> +	 */

This comment is counter-intuitive: you're saying in words "if this failed" but
in code "if this didn't fail".

Please, either invert the branch so that it looks either like

/* if negative */
if (negative) warn
else /* positive */

or like

if (ret >= 0) {
	do_things()
} else {
	/* if it failed ... */
	warn
}

Functionally, though, looks good to me.

Cheers,
Angelo

