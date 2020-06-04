Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1D1EDC25
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 06:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgFDERg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 00:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgFDERg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jun 2020 00:17:36 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD72C03E96D
        for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2020 21:17:36 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1A940100DA1B3;
        Thu,  4 Jun 2020 06:17:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AA79527E8AE; Thu,  4 Jun 2020 06:17:32 +0200 (CEST)
Date:   Thu, 4 Jun 2020 06:17:32 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH 3/3] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200604041732.7ijkvad2yadtgjid@wunner.de>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
 <20200604034655.15930-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604034655.15930-4-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 03, 2020 at 08:46:55PM -0700, Florian Fainelli wrote:
> +static const struct of_device_id bcm2835_spi_match[] = {
> +	{ .compatible = "brcm,bcm2835-spi", .data = &bcm2835_spi_interrupt },
> +	{ .compatible = "brcm,bcm2711-spi", .data = &bcm2835_spi_sh_interrupt },
> +	{ .compatible = "brcm,bcm7211-spi", .data = &bcm2835_spi_sh_interrupt },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, bcm2835_spi_match);

Maybe I'm missing something but I think you either have to reverse the
order of the entries in this array or change patch [2/3] to drop
"brcm,bcm2835-spi" from the compatible string:

__of_match_node() iterates over the entries in the array above and
calls __of_device_is_compatible() for each of them, which returns
success if the entry matches any of the device's compatible string.

Because "brcm,bcm2835-spi" is checked first and that string is
present on the controllers with shared interrupt, they're all
deemed not to use shared interrupts.

If you opt so fix this by dropping "brcm,bcm2835-spi" from the
device's compatible strings, then you have to move patch [2/3]
behind patch [3/3].


>  static int bcm2835_spi_probe(struct platform_device *pdev)
>  {
> +	irqreturn_t (*bcm2835_spi_isr_func)(int, void *);

A more succinct alternative is:

	irq_handler_t bcm2835_spi_isr_func;

Otherwise this patch LGTM.

Thanks,

Lukas
