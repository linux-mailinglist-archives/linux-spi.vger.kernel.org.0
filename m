Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8BA1E85D3
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgE2Rxw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:53:52 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:43311 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgE2Rxw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 13:53:52 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id CA78C30000D1D;
        Fri, 29 May 2020 19:53:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9D537FA4C1; Fri, 29 May 2020 19:53:50 +0200 (CEST)
Date:   Fri, 29 May 2020 19:53:50 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200529175350.2wtoqttipa354m2m@wunner.de>
References: <20200528185805.28991-1-nsaenzjulienne@suse.de>
 <20200529174358.som3snunfxch6phi@wunner.de>
 <36dd65bb-18a9-9697-b9b6-76eaf8cbe45c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36dd65bb-18a9-9697-b9b6-76eaf8cbe45c@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 10:46:01AM -0700, Florian Fainelli wrote:
> On 5/29/20 10:43 AM, Lukas Wunner wrote:
> > On Thu, May 28, 2020 at 08:58:04PM +0200, Nicolas Saenz Julienne wrote:
> >> --- a/drivers/spi/spi-bcm2835.c
> >> +++ b/drivers/spi/spi-bcm2835.c
> >> @@ -379,6 +379,10 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
> >>  	if (bs->tx_len && cs & BCM2835_SPI_CS_DONE)
> >>  		bcm2835_wr_fifo_blind(bs, BCM2835_SPI_FIFO_SIZE);
> >>  
> >> +	/* check if we got interrupt enabled */
> >> +	if (!(bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_INTR))
> >> +		return IRQ_NONE;
> >> +
> >>  	/* Read as many bytes as possible from FIFO */
> >>  	bcm2835_rd_fifo(bs);
> >>  	/* Write as many bytes as possible to FIFO */
[...]
> > Finally, it would be nice if the check would be optimized away when
> > compiling for pre-RasPi4 products, maybe something like:
> > 
> > +	if (IS_ENABLED(CONFIG_ARM_LPAE) && !(cs & BCM2835_SPI_CS_INTR))
> > +		return IRQ_NONE;
> 
> Rather than keying this off ARM_LPAE or any other option, this should be
> keyed off a compatible string, that way we can even conditionally pass
> IRQF_SHARED to the interrupt handler if we care so much about performance.

But a compatible string can't be checked at compile time, can it?

The point is that at the least the Foundation compiles and ships a separate
kernel for each of the three platforms BCM2835, BCM2837, BCM2711.  It's
unnecessary to check whether an interrupt was actually raised if we *know*
in advance that it's not shared (as is the case with kernels compiled for
BCM2835 and BCM2837).

Thanks,

Lukas
