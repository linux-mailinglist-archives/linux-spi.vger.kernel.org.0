Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F67D9D81
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2019 23:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfJPVbD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Oct 2019 17:31:03 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:56907 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfJPVbD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Oct 2019 17:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201810; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YO4bstpSIjecSQN93QBK9/zVvOiMiUN5oIW04KmN4/A=; b=IcIeHDSRQuul79ivzJ+JabGJGu
        SsMJEgs7u1FZUKzHkg/s9uaBGl0b/wdJufUVoCFZxQ9OOYURsLGsfQ0bgP2XpQbdqC7DEUWBUAVhs
        2WxjuESz1+HAkLF7XJ9LA36DR6i41tqP2I2YaTTjinMD0NvCyVD5db6ZJunVzNrU/Wcszi4TiNs9k
        0CN5XRp5QGj5NacTZBzRCviic39kJuL03dOa7XY1kbfbotAqoWFm2yhmfS5QfuSuXeg2rLzXD8668
        M4UjgZgx0jFgIGu9qF4G9h4UIs+/ZnkrCFcPfzamzh2FCwtS9MteSX/MqzyJQhmMvHKuRtEIeA1A8
        vGdsHv7g==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:31020 helo=[192.168.10.177])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1iKqsm-0007Mz-Ap; Wed, 16 Oct 2019 23:31:00 +0200
Subject: Re: [PATCH] spi: pxa2xx: Set controller->max_transfer_size in dma
 mode
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
References: <20191016195721.3714-1-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <36610873-fa30-a286-d05c-5eceb3cbcb57@tronnes.org>
Date:   Wed, 16 Oct 2019 23:30:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016195721.3714-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Den 16.10.2019 21.57, skrev Daniel Vetter:
> In DMA mode we have a maximum transfer size, past that the driver
> falls back to PIO (see the check at the top of pxa2xx_spi_transfer_one).
> Falling back to PIO for big transfers defeats the point of a dma engine,
> hence set the max transfer size to inform spi clients that they need
> to do something smarter.
> 
> This was uncovered by the drm_mipi_dbi spi panel code, which does
> large spi transfers, but stopped splitting them after:
> 
> commit e143364b4c1774f68e923a5a0bb0fca28ac25888
> Author: Noralf Trønnes <noralf@tronnes.org>
> Date:   Fri Jul 19 17:59:10 2019 +0200
> 
>     drm/tinydrm: Remove tinydrm_spi_max_transfer_size()
> 
> After this commit the code relied on the spi core to split transfers
> into max dma-able blocks, which also papered over the PIO fallback issue.
> 
> Fix this by setting the overall max transfer size to the DMA limit,
> but only when the controller runs in DMA mode.
> 
> Fixes: e143364b4c17 ("drm/tinydrm: Remove tinydrm_spi_max_transfer_size()")
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Noralf Trønnes <noralf@tronnes.org>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reported-and-tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/spi/spi-pxa2xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index bb6a14d1ab0f..f77201915033 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1707,6 +1707,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>  		} else {
>  			controller->can_dma = pxa2xx_spi_can_dma;
>  			controller->max_dma_len = MAX_DMA_LEN;
> +			controller->max_transfer_size = MAX_DMA_LEN;

As Andy mentioned, ->max_transfer_size is a callback:

struct spi_controller {
	/*
	 * on some hardware transfer / message size may be constrained
	 * the limit may depend on device transfer settings
	 */
	size_t (*max_transfer_size)(struct spi_device *spi);

(I looked at its users and they all return a static or probe time value
so not sure why it's a callback.)

Noralf.

>  		}
>  	}
>  
> 
