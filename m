Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8F1EF5C2
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 12:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgFEKvF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgFEKvE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Jun 2020 06:51:04 -0400
X-Greylist: delayed 109823 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Jun 2020 03:51:03 PDT
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D81C08C5C2;
        Fri,  5 Jun 2020 03:51:03 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 04986300020AA;
        Fri,  5 Jun 2020 12:51:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C284822B009; Fri,  5 Jun 2020 12:51:00 +0200 (CEST)
Date:   Fri, 5 Jun 2020 12:51:00 +0200
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
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200605105100.kxe6wgh5itmhrgl2@wunner.de>
References: <20200604212819.715-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604212819.715-1-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 04, 2020 at 02:28:19PM -0700, Florian Fainelli wrote:
> The 4 SPI controller instances added in BCM2711 and BCM7211 SoCs (SPI3,
> SPI4, SPI5 and SPI6) share the same interrupt line with SPI0.
> 
> For the BCM2835 case which is deemed performance critical, we would like
> to continue using an interrupt handler which does not have the extra
> comparison on BCM2835_SPI_CS_INTR.
> 
> To support that requirement the common interrupt handling code between
> the shared and non-shared interrupt paths is split into a
> bcm2835_spi_interrupt_common() and both bcm2835_spi_interrupt() as well
> as bcm2835_spi_shared_interrupt() make use of it.
> 
> During probe, we determine if there is at least another instance of this
> SPI controller, and if there is, then we install a shared interrupt
> handler.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
