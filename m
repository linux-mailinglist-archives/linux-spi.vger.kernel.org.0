Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778D35E25D
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2019 12:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfGCKxj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jul 2019 06:53:39 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40235 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfGCKxi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Jul 2019 06:53:38 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jul 2019 06:53:38 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2A99E100AF5F7;
        Wed,  3 Jul 2019 12:43:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CCA622F790B; Wed,  3 Jul 2019 12:43:38 +0200 (CEST)
Date:   Wed, 3 Jul 2019 12:43:38 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kernel@martin.sperl.org" <kernel@martin.sperl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "wahrenst@gmx.net" <wahrenst@gmx.net>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "eric@anholt.net" <eric@anholt.net>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
Message-ID: <20190703104338.m5vfkbyq4fhqmjh4@wunner.de>
References: <20190628123023.4696-1-nuno.sa@analog.com>
 <1b932c61-982b-aae0-1fef-3c574e7d17eb@gmx.net>
 <20190628190022.vya4h2lihm6x2xpb@wunner.de>
 <54323339606a36febc6a8633a8d3a7db84b975c4.camel@analog.com>
 <20190701115506.42rr4o4hbuvwytjc@wunner.de>
 <42a533cbf1e47ab8c8a44c5e865ec15193a2e956.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a533cbf1e47ab8c8a44c5e865ec15193a2e956.camel@analog.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jul 01, 2019 at 02:21:21PM +0000, Sa, Nuno wrote:
> On Mon, 2019-07-01 at 13:55 +0200, Lukas Wunner wrote:
> > I see.  In that case, try:
> > 
> >  	/* handle all the 3-wire mode */
> > -	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf))
> > +	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf != ctlr->dummy_rx))
> >  		cs |= BCM2835_SPI_CS_REN;
> >  	else
> >  		cs &= ~BCM2835_SPI_CS_REN;
> 
> This worked fine. Also, I did a quick backport of the state of your
> driver's (both spi-bcm2835 and bcm2835-dma) in revpi_staging and it
> also worked fine with my device.
> So, as far as I understand, the above suggestion (or my patch) is not
> intended to be upstreamed, right? It is just a temporary fix that I can
> use while your patchset gets upstream.

Thanks for testing.  I've just submitted the above as a fix for 5.3.
(Actually with a small change, the check for (tfr->rx_buf) needs to
be preserved in case DMA is disabled.)

The patch can be backported to 5.2 and older stable kernels if "ctlr"
is replaced by "master", we can inform Greg about that once the patch
lands in Linus' tree.  And I've amended my patch set to revert this
patch when dropping MUST_RX.

Thanks,

Lukas
