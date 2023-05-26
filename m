Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17571280C
	for <lists+linux-spi@lfdr.de>; Fri, 26 May 2023 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjEZOKI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 May 2023 10:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbjEZOKH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 May 2023 10:10:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B0CF3
        for <linux-spi@vger.kernel.org>; Fri, 26 May 2023 07:10:06 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1q2Y8c-0001f9-Q3; Fri, 26 May 2023 16:09:50 +0200
Message-ID: <d29db298-0484-ea6f-3554-fa02b3a077dd@pengutronix.de>
Date:   Fri, 26 May 2023 16:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] spi: imx: correct handling of MXC_CSPIRXDATA value
 endianness
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>, Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     jiada wang <jiada_wang@mentor.com>, linux-spi@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230526-spi-imx-endian-v1-1-98d4d4ef4afc@kernel.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20230526-spi-imx-endian-v1-1-98d4d4ef4afc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Simon,

On 26.05.23 16:03, Simon Horman wrote:
> The existing code seems be intended to handle MXC_CSPIRXDATA values
> which are in big endian. However, it seems that this is only
> handled correctly in the case where the host is little endian.
> 
> First, consider the read case.
> 
> 	u32 val = be32_to_cpu(readl(...))
> 
> readl() will read a 32bit value and return it after applying le32_to_cpu().
> On a little endian host le32_to_cpu() is a noop. So the raw value is
> returned. This is then converted from big endian to host byte-order -
> the value is byte-swapped - using be32_to_cpu(). Assuming the raw value
> is big endian a host byte-order value is obtained. This seems correct.
> 
> However, on a big endian system, le32_to_cpu() will perform a byte-swap,
> while be32_to_cpu() is a noop. Assuming the underlying value is big
> endian this is incorrect, because it should not be byte-swapped to
> obtain the value in host byte-order - big endian.
> 
> Surveying other kernel code it seems that a correct approach is:
> 
> 	 be32_to_cpu((__force __be32)__raw_readl(...))

How about using ioread32be?

> 
> Here __raw_readl() does returns the raw value, without any calls
> that can alter the byte-order. And be32_to_cpu() is called to correctly
> either a) swaps the byte-order on a little endian host or b) does not
> swap the byte-order on a big endian host.
> 
> Second, let us consider the write case:
> 
> 	val = cpu_to_be32(val);
> 	...
> 	writel(val, ...);
> 
> writel() will write the 32bit value, passed as big endian, after applying
> cpu_to_le32(). On a little endian system cpu_to_le32() is a noop and
> thus the big endian value is stored. This seems correct.
> 
> However, on a big endian system cpu_to_le32() will byte-swap the value.
> That is, converting it from big endian to little endian. The little
> endian value is then stored. This seems incorrect.
> 
> Surveying other kernel code it seems that a correct approach is:
> 
> 	__raw_writel((__force u32)cpu_to_be32(val), ...);
> 
> __raw_writel() will write the value with out applying any endian
> conversion functions. Thus the big endian value is written.
> This seems correct for the case at hand.
> 
> This patch adopts the __raw_readl() and __raw_writel() approaches described
> above. It also avoids the following, which stores a big endian value in
> a host byte-order variable.
> 
> 	u32 val;
> 	...
> 	val = cpu_to_be32(val);
> 
> Reported by Sparse as:
> 
>   .../spi-imx.c:410:19: warning: cast to restricted __be32
>   .../spi-imx.c:439:21: warning: incorrect type in assignment (different base types)
>   .../spi-imx.c:439:21:    expected unsigned int [addressable] [usertype] val
>   .../spi-imx.c:439:21:    got restricted __be32 [usertype]
> 
> Compile tested only.
> 
> Fixes: 71abd29057cb ("spi: imx: Add support for SPI Slave mode")
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/spi/spi-imx.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index bd6ddb142b13..99c1f76e073d 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -406,7 +406,10 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
>  
>  static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
>  {
> -	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
> +	u32 val;
> +
> +	val = be32_to_cpu((__force __be32)__raw_readl(spi_imx->base +
> +						      MXC_CSPIRXDATA));
>  
>  	if (spi_imx->rx_buf) {
>  		int n_bytes = spi_imx->slave_burst % sizeof(val);
> @@ -435,13 +438,13 @@ static void mx53_ecspi_tx_slave(struct spi_imx_data *spi_imx)
>  	if (spi_imx->tx_buf) {
>  		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
>  		       spi_imx->tx_buf, n_bytes);
> -		val = cpu_to_be32(val);
>  		spi_imx->tx_buf += n_bytes;
>  	}
>  
>  	spi_imx->count -= n_bytes;
>  
> -	writel(val, spi_imx->base + MXC_CSPITXDATA);
> +	__raw_writel((__force u32)cpu_to_be32(val),
> +		     spi_imx->base + MXC_CSPITXDATA);
>  }
>  
>  /* MX51 eCSPI */
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

