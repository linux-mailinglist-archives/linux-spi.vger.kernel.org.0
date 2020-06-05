Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1911EF676
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 13:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgFELgB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 07:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgFELgB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Jun 2020 07:36:01 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F07C08C5C2;
        Fri,  5 Jun 2020 04:36:01 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 820A0300020B3;
        Fri,  5 Jun 2020 13:35:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5361E2913BD; Fri,  5 Jun 2020 13:35:59 +0200 (CEST)
Date:   Fri, 5 Jun 2020 13:35:59 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20200605113559.oia5xmc2r5n7e2fd@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21772111-fa1f-7a50-aa92-e44b09cff4eb@gmail.com>
 <8c8d6007-e4c6-8484-9d40-3b679842be27@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 04, 2020 at 01:24:54PM -0700, Florian Fainelli wrote:
> So we do need to know for the first time we install the interrupt
> handler whether we will be in a shared situation or not, I cannot think
> of any solution other than counting the number of available DT nodes
> with the "brcm,bcm2835-spi" compatible string.

In principle it would be possible to iterate over the entire DT using
for_each_of_allnodes() and call of_irq_parse_one() on each device_node
if it's enabled and not the one we're probing.  Then check if any of that
device_node's IRQs is identical to that of the device_node we're probing.
That would give you a generic method to test for sharedness of an
interrupt.

However the solution you've found is simpler and cheaper than such a
brute-force search, hence seems perfectly valid to me.


> I appreciate that
> Lukas has spent some tremendous amount of time working on this
> controller driver and he has a sensitivity for performance.

Thanks!  Indeed I think spi-bcm2835.c is by now among the best performing
and most featureful SPI drivers in the kernel.  I've recently had a
discussion on netdev with someone testing an SPI-attached Ethernet
chip on iMX6Q and on STM32MP1 and couldn't get it to work.
With a BCM2837 no problem at all:

https://lore.kernel.org/netdev/ac0f7227-a4ae-b6cd-36ec-3bcb02b1adbe@denx.de/

Lukas
