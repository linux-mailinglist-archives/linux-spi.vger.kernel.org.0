Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5691EE353
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 13:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgFDLVP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 07:21:15 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:49817 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgFDLVP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jun 2020 07:21:15 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8C42E100E2006;
        Thu,  4 Jun 2020 13:21:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1A72A3B12FD; Thu,  4 Jun 2020 13:21:12 +0200 (CEST)
Date:   Thu, 4 Jun 2020 13:21:12 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH 2/3] ARM: dts: bcm2711: Update SPI nodes compatible
 strings
Message-ID: <20200604112112.b3k4wrftckndscu6@wunner.de>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
 <20200604034655.15930-3-f.fainelli@gmail.com>
 <20200604042038.jzolu6k7q3d6bsvq@wunner.de>
 <20200604111325.GC6644@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604111325.GC6644@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 04, 2020 at 12:13:25PM +0100, Mark Brown wrote:
> On Thu, Jun 04, 2020 at 06:20:38AM +0200, Lukas Wunner wrote:
> > On Wed, Jun 03, 2020 at 08:46:54PM -0700, Florian Fainelli wrote:
> > > The BCM2711 SoC features 5 SPI controllers which all share the same
> > > interrupt line, the SPI driver needs to support interrupt sharing,
> > > therefore use the chip specific compatible string to help with that.
> 
> > You're saying above that the 5 controllers all share the interrupt
> > but below you're only changing the compatible string of 4 controllers.
> 
> > So I assume spi0 still has its own interrupt and only the additional
> > 4 controllers present on the BCM2711/BCM7211 share their interrupt?
> 
> Regardless of what's going on with the interrupts the compatible string
> should reflect the IP version so unless for some reason someone taped
> out two different versions of the IP it seems odd that the compatible
> strings would vary within a given SoC.

Hm.  I guess it may be possible to search the DT for other devices
sharing the same interrupt line and thereby determine whether
IRQF_SHARED is necessary.  The helper to perform this search could
live in drivers/of/irq.c as I imagine it might be useful in general.
