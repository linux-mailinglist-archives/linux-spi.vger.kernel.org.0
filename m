Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E519B5BB03
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2019 13:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfGALzJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jul 2019 07:55:09 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:43321 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbfGALzI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jul 2019 07:55:08 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7BB763001531F;
        Mon,  1 Jul 2019 13:55:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3BE7E23EF52; Mon,  1 Jul 2019 13:55:06 +0200 (CEST)
Date:   Mon, 1 Jul 2019 13:55:06 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "wahrenst@gmx.net" <wahrenst@gmx.net>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kernel@martin.sperl.org" <kernel@martin.sperl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "eric@anholt.net" <eric@anholt.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
Message-ID: <20190701115506.42rr4o4hbuvwytjc@wunner.de>
References: <20190628123023.4696-1-nuno.sa@analog.com>
 <1b932c61-982b-aae0-1fef-3c574e7d17eb@gmx.net>
 <20190628190022.vya4h2lihm6x2xpb@wunner.de>
 <54323339606a36febc6a8633a8d3a7db84b975c4.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54323339606a36febc6a8633a8d3a7db84b975c4.camel@analog.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jul 01, 2019 at 07:24:23AM +0000, Sa, Nuno wrote:
> The problem is in spi_map_msg() which
> allocates dummy buffers (because of the ctrl flags). As a result, in
> bcm2835_spi_transfer_one() we set "cs |= BCM2835_SPI_CS_REN;" when we
> want to do tx only. I believe this was the actual problem...

I see.  In that case, try:

 	/* handle all the 3-wire mode */
-	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf))
+	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf != ctlr->dummy_rx))
 		cs |= BCM2835_SPI_CS_REN;
 	else
 		cs &= ~BCM2835_SPI_CS_REN;

Use master->dummy_rx instead of ctlr->dummy_rx prior to commit
5f336ea53b6b ("spi: bcm2835: Replace spi_master by spi_controller").

This could be something that users of your cape might use on older
kernels in lieu of my upcoming patch set to drop MUST_RX / MUST_TX.

Thanks,

Lukas
