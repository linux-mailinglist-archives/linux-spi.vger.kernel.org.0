Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB231E8670
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 20:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2SQm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 14:16:42 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:36393 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2SQl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 14:16:41 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 51AF828004ECF;
        Fri, 29 May 2020 20:16:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 281E12A66; Fri, 29 May 2020 20:16:40 +0200 (CEST)
Date:   Fri, 29 May 2020 20:16:40 +0200
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
Message-ID: <20200529181640.47dt6bfy3wkxbb34@wunner.de>
References: <20200528185805.28991-1-nsaenzjulienne@suse.de>
 <20200529174358.som3snunfxch6phi@wunner.de>
 <36dd65bb-18a9-9697-b9b6-76eaf8cbe45c@gmail.com>
 <20200529175350.2wtoqttipa354m2m@wunner.de>
 <b832eaed-b480-b3b6-4df0-75abcc11f08a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b832eaed-b480-b3b6-4df0-75abcc11f08a@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 11:03:48AM -0700, Florian Fainelli wrote:
> On 5/29/20 10:53 AM, Lukas Wunner wrote:
> > On Fri, May 29, 2020 at 10:46:01AM -0700, Florian Fainelli wrote:
> >> On 5/29/20 10:43 AM, Lukas Wunner wrote:
> >>> Finally, it would be nice if the check would be optimized away when
> >>> compiling for pre-RasPi4 products, maybe something like:
> >>>
> >>> +	if (IS_ENABLED(CONFIG_ARM_LPAE) && !(cs & BCM2835_SPI_CS_INTR))
> >>> +		return IRQ_NONE;
> >>
> >> Rather than keying this off ARM_LPAE or any other option, this should be
> >> keyed off a compatible string, that way we can even conditionally pass
> >> IRQF_SHARED to the interrupt handler if we care so much about performance.
> > 
> > But a compatible string can't be checked at compile time, can it?
> 
> No, but you can have a different interrupt handler that it set at
> runtime if you want to completely eliminate this comparison.

Good idea.  In fact the IRQ handler for platforms with shared interrupts
could just be a wrapper which performs the BCM2835_SPI_CS_INTR check
then tail-calls the existing IRQ handler.  The compiler would just
inline it and everything would be fine.


> My point is that CONFIG_ARM_LPAE is just too brittle, there is nothing
> that prevents you from using a non-LPAE kernel on the Pi 4, even PCIe
> could be made to work if using super section mappings to map the PCIe
> outbound space. Even on models with over 4GB of DRAM, if you are willing
> to lose some of it, it can work.

Agreed.

Thanks,

Lukas
