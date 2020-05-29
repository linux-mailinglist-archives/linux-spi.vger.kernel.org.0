Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B271E8577
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgE2RoB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:44:01 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:54299 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgE2RoB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 13:44:01 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id E157C2800A291;
        Fri, 29 May 2020 19:43:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B102810D0CE; Fri, 29 May 2020 19:43:58 +0200 (CEST)
Date:   Fri, 29 May 2020 19:43:58 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200529174358.som3snunfxch6phi@wunner.de>
References: <20200528185805.28991-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528185805.28991-1-nsaenzjulienne@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 28, 2020 at 08:58:04PM +0200, Nicolas Saenz Julienne wrote:
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -379,6 +379,10 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
>  	if (bs->tx_len && cs & BCM2835_SPI_CS_DONE)
>  		bcm2835_wr_fifo_blind(bs, BCM2835_SPI_FIFO_SIZE);
>  
> +	/* check if we got interrupt enabled */
> +	if (!(bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_INTR))
> +		return IRQ_NONE;
> +
>  	/* Read as many bytes as possible from FIFO */
>  	bcm2835_rd_fifo(bs);
>  	/* Write as many bytes as possible to FIFO */

This definitely looks wrong.  The check whether the interrupt is enabled
should be moved *before* the conditional calls to bcm2835_rd_fifo_blind()
and bcm2835_wr_fifo_blind(), i.e. to the top of the function.

Otherwise if an interrupt is raised by another SPI controller,
this function may perform read/write accesses to the FIFO and
interfere with an ongoing transfer in DMA or poll mode.

Also, instead of performing an MMIO read, just use the "cs" variable
which was assigned at the top of the function.

The code comment should explain that the check is necessary because the
interrupt may be shared with other controllers on the BCM2711.

Finally, it would be nice if the check would be optimized away when
compiling for pre-RasPi4 products, maybe something like:

+	if (IS_ENABLED(CONFIG_ARM_LPAE) && !(cs & BCM2835_SPI_CS_INTR))
+		return IRQ_NONE;

Thanks,

Lukas
