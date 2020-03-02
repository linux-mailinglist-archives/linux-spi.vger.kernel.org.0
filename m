Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE0175839
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 11:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCBKUK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Mar 2020 05:20:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43340 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCBKUK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Mar 2020 05:20:10 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F239229480B;
        Mon,  2 Mar 2020 10:20:07 +0000 (GMT)
Date:   Mon, 2 Mar 2020 11:20:02 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 02/11] spi: set mode bits for "spi-rx-dtr" and
 "spi-tx-dtr"
Message-ID: <20200302112002.4e3aaffd@collabora.com>
In-Reply-To: <20200302094829.opazalwldrdn4s7y@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-3-p.yadav@ti.com>
        <20200227172247.0e8ec459@collabora.com>
        <20200302094829.opazalwldrdn4s7y@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2 Mar 2020 15:18:31 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> > > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > > index 38b4c78df506..25c8ed9343f9 100644
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -1927,6 +1927,13 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
> > >  		}
> > >  	}
> > >  
> > > +	/* Device DTR mode. */
> > > +	if (of_property_read_bool(nc, "spi-tx-dtr"))
> > > +		spi->mode |= SPI_TX_DTR;
> > > +
> > > +	if (of_property_read_bool(nc, "spi-rx-dtr"))
> > > +		spi->mode |= SPI_RX_DTR;
> > > +  
> > 
> > If this DTR mode is only used in spi-mem, maybe we shouldn't add those
> > flags. SPI mem devices are usually smart enough to advertise what they
> > support, and the subsystem in charge of those devices (in this specific
> > case, spi-nor) will check what the controller supports
> > using spi_mem_supports_op(). The only case we might have to deal with
> > at some point is board level limitations (disabling DTR because the
> > routing prevents using this mode).  
>  
> Yes, being able to handle board-level limitations is the main reason 
> behind this change. There should be a way to over-ride the use of DTR 
> for a given board. And IIUC, SPI allows doing the same for Rx and Tx 
> buswidth. So I don't see why we should deviate from that model.

My point is, maybe it should be expressed as a limitation, rather than
made mandatory for the non-limited case (default to supported, unless
stated otherwise). I think we already had this discussion with Rob and
Mark regarding the QUAD/DUAL flags, which made conversion from spi-nor
to spi-mem non-backward compatible for some controllers (some spi-nor
controller drivers were considering the absence of spi-{tx,rx}-width as
'use the max supported by the controller if the device supports it'
while the spi subsystem goes for the more conservative 'use single SPI
if spi-{tx,rx}-width is missing'). If we introduce a new property, maybe
it'd be a good thing to think twice before taking this decision. FWIW,
I'd vote for a 'spi-no-dtr' property to express board-level
limitations.

Orthogonal to this is the question of where we should put those flags,
and I'm still not convinced we need that at the spi level (at least not
yet).
