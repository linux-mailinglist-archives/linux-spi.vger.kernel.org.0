Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36C21F1801
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jun 2020 13:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgFHLlx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jun 2020 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgFHLlw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jun 2020 07:41:52 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75210C08C5C2;
        Mon,  8 Jun 2020 04:41:51 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 04F81100A8787;
        Mon,  8 Jun 2020 13:41:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 99FFD43A8E1; Mon,  8 Jun 2020 13:41:48 +0200 (CEST)
Date:   Mon, 8 Jun 2020 13:41:48 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200608114148.4bau4mdcvwgf25ut@wunner.de>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <142d48ae-2725-1368-3e11-658449662371@arm.com>
 <20200605132037.GF5413@sirena.org.uk>
 <2e371a32-fb52-03a2-82e4-5733d9f139cc@arm.com>
 <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
 <d3fe8b56-83ef-8ef0-bb05-11c7cb2419f8@gmail.com>
 <a6f158e3-af51-01d9-331c-4bc8b6847abb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6f158e3-af51-01d9-331c-4bc8b6847abb@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jun 08, 2020 at 12:11:11PM +0100, Robin Murphy wrote:
> And all in code that has at least one obvious inefficiency left on
> the table either way.

Care to submit a patch to overcome that inefficiency?


> This thread truly epitomises Knuth's "premature optimisation" quote... ;)

The thread came about because it can be determined at compile time
whether the interrupt is going to be shared:

On the BCM2835 (Raspberry Pi 1), CONFIG_ARCH_MULTI_V6 is set and this
SoC doesn't have multiple bcm2835-spi instances, so no shared interrupt.

The question is how to discern BCM2836/BCM2837 (Raspberry Pi 2/3), which
do not have multiple instances, and BCM2711 (Raspberry Pi 4) which does.

The Raspberry Pi Foundation compiles BCM2711 kernels with CONFIG_ARM_LPAE=y,
but Florian considered that kludgy as a discriminator and opted for
runtime-detection via the compatible string instead.  If you've got
a better idea please come forward.

Is "optimize shared IRQ support away if IS_ENABLED(CONFIG_ARCH_MULTI_V6),
else leave it in" the best we can do?

Thanks,

Lukas
