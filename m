Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A130C482F46
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jan 2022 10:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiACJSO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 3 Jan 2022 04:18:14 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49215 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiACJSN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jan 2022 04:18:13 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AF29C24000D;
        Mon,  3 Jan 2022 09:18:07 +0000 (UTC)
Date:   Mon, 3 Jan 2022 10:18:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 04/14] spi: cadence: Provide a capability structure
Message-ID: <20220103101806.581d1a4f@xps13>
In-Reply-To: <20220103093819.080e60fb@collabora.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
        <20211217161654.367782-5-miquel.raynal@bootlin.com>
        <20211220185515.wujhgn66mnwns7bw@ti.com>
        <20211221111605.352285f5@xps13>
        <20211221104108.t563gg2hulfqt2uh@ti.com>
        <20211221121947.5c779bfd@xps13>
        <20211221120458.4l7expkdznnw6u3u@ti.com>
        <20220103093819.080e60fb@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

boris.brezillon@collabora.com wrote on Mon, 3 Jan 2022 09:38:19 +0100:

> On Tue, 21 Dec 2021 17:35:00 +0530
> Pratyush Yadav <p.yadav@ti.com> wrote:
> 
> > > 
> > > Anyway, do you mind if we move forward first? Not that I don't think
> > > that this choice should be discussed further, but I think this can
> > > easily be changed in the near future if there is a desire to
> > > reorganize spi-mem objects. In fact, these capabilities are accessed
> > > through a helper so that hypothetic change would be almost transparent.    
> > 
> > Okay. I would still like to hear other opinions on this, but fine by me 
> > if you want to take this in as-is.  
> 
> I think we discussed that with Miquel, and I remember complaining about
> mixing function pointers and actual data in the spi_mem_ops struct, but
> honestly, it's just cosmetic concern, and I don't think it matters much
> in practice. So I'm fine either way, make it a field of spi_controller
> or spi_mem_ops, spi_mem is definitely not the right place though.

Yeah, I don't like the idea of leaking spi-mem information into the spi
controller structure, while there is a structure (so far only
containing hooks) that is dedicated to spi-mem operations. Extending
this structure to contain capabilities appeared the right choice to me.
But on the other hand this is a controller information anyway so if you
both prefer moving this data into the SPI controller structure I'll find
a way to do it.

Thanks,
Miquèl
