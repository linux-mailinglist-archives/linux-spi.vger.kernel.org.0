Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6137172482
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 18:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgB0RHD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 12:07:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40094 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgB0RHD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 12:07:03 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 68AEA296385;
        Thu, 27 Feb 2020 17:07:01 +0000 (GMT)
Date:   Thu, 27 Feb 2020 18:06:58 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR
 capability
Message-ID: <20200227180658.58633141@collabora.com>
In-Reply-To: <20200227164425.GF4062@sirena.org.uk>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-2-p.yadav@ti.com>
        <20200227171147.32cc6fcf@collabora.com>
        <20200227162842.GE4062@sirena.org.uk>
        <CAMuHMdWMCDzQm0tjpybJZyHy4imbC9NqRXP5d4C0xgxQx-Pf8g@mail.gmail.com>
        <20200227164425.GF4062@sirena.org.uk>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 27 Feb 2020 16:44:25 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Feb 27, 2020 at 05:40:31PM +0100, Geert Uytterhoeven wrote:
> > On Thu, Feb 27, 2020 at 5:28 PM Mark Brown <broonie@kernel.org> wrote:  
> 
> > > It's what we do for other properties, and if this is anything like the
> > > other things adding extra wiring you can't assume that the ability to
> > > use the feature for TX implies RX.  
> 
> > Double Transfer Rate uses the same wire.  
> 
> But is it still on either the TX or RX signals?

There's no separate RX/TX pins when using xD-xD-xD modes (pins switch
from RX to TX) and I doubt DTR will ever be used on single SPI.

> 
> > But as you sample at both the rising and the falling edges of the clock, this
> > makes the cpha setting meaningless for such transfers, I think ;-)  
> 
> Might affect what the first bit is possibly?
> 
> > However, as the future may bring us QDR, perhaps this should not be a
> > boolean flag, but an integer value?
> > Cfr. spi-tx-bus-width vs. the original spi-tx-dual/spi-tx-quad proposal.  
> 
> > What would be a good name (as we only need one)? spi-data-phases?  
> 
> Sounds reasonable, apart from the increasingly vague connection with
> something that's recognizably SPI :P

Or maybe we should refrain from adding a new flag and wait a bit to see
if this DTR mode is actually used for regular SPI transfers (AKA not
spi-mem) :-).
