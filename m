Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7821E859B
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgE2RrW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:47:22 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:42463 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2RrW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 13:47:22 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 10E47102F54BE;
        Fri, 29 May 2020 19:47:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 906A018297B; Fri, 29 May 2020 19:47:19 +0200 (CEST)
Date:   Fri, 29 May 2020 19:47:19 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: bcm2835: Implement shutdown callback
Message-ID: <20200529174719.5tvchnoov747fm2x@wunner.de>
References: <20200528190605.24850-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528190605.24850-1-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 28, 2020 at 12:06:05PM -0700, Florian Fainelli wrote:
> Make sure we clear the FIFOs, stop the block, disable the clock and
> release the DMA channel.

To what end?  Why is this change necessary?  Sorry but this seems like
an awfully terse commit message.

Thanks,

Lukas

> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/spi/spi-bcm2835.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index 20d8581fdf88..237bd306c268 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -1391,6 +1391,15 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void bcm2835_spi_shutdown(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = bcm2835_spi_remove(pdev);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to shutdown\n");
> +}
> +
>  static const struct of_device_id bcm2835_spi_match[] = {
>  	{ .compatible = "brcm,bcm2835-spi", },
>  	{}
> @@ -1404,6 +1413,7 @@ static struct platform_driver bcm2835_spi_driver = {
>  	},
>  	.probe		= bcm2835_spi_probe,
>  	.remove		= bcm2835_spi_remove,
> +	.shutdown	= bcm2835_spi_shutdown,
>  };
>  module_platform_driver(bcm2835_spi_driver);
>  
> -- 
> 2.17.1
> 
