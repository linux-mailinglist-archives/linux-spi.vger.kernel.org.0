Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2548117579E
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 10:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCBJtI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Mar 2020 04:49:08 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57576 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCBJtI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Mar 2020 04:49:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0229mXWF024857;
        Mon, 2 Mar 2020 03:48:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583142513;
        bh=8mylNuvbMkUyD9rWCtIxmMJyS7kJVNxinoSR3QWr/xU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=E5RZ1AVSpIt/g0rMSH1E6MehYBpDwLns1mbervza/PIeplJ/3i903D3JChyiflGUX
         udlfjay7F8V2/RogkH2QR8gpgPPUSDVAyV8VCx635HWvo4m+57IZG6HL1O5VrIkKb8
         Vc0e5C7HscoOC/jll4acVVh5spjQslWWCkjSgA/I=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0229mXHC032787
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Mar 2020 03:48:33 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Mar
 2020 03:48:33 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Mar 2020 03:48:32 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0229mWaZ019765;
        Mon, 2 Mar 2020 03:48:32 -0600
Date:   Mon, 2 Mar 2020 15:18:31 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
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
Message-ID: <20200302094829.opazalwldrdn4s7y@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-3-p.yadav@ti.com>
 <20200227172247.0e8ec459@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200227172247.0e8ec459@collabora.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

On 27/02/20 05:23PM, Boris Brezillon wrote:
> On Wed, 26 Feb 2020 15:06:54 +0530
> Pratyush Yadav <p.yadav@ti.com> wrote:
> 
> > These two DT properties express DTR receive and transmit capabilities of
> > a SPI flash and controller. Introduce two new mode bits: SPI_RX_DTR and
> > SPI_TX_DTR which correspond to the new DT properties. Set these bits
> > when the two corresponding properties are present in the device tree.
> > Also update the detection of unsupported mode bits to include the new
> > bits.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/spi/spi.c       | 10 +++++++++-
> >  include/linux/spi/spi.h |  2 ++
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 38b4c78df506..25c8ed9343f9 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1927,6 +1927,13 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
> >  		}
> >  	}
> >  
> > +	/* Device DTR mode. */
> > +	if (of_property_read_bool(nc, "spi-tx-dtr"))
> > +		spi->mode |= SPI_TX_DTR;
> > +
> > +	if (of_property_read_bool(nc, "spi-rx-dtr"))
> > +		spi->mode |= SPI_RX_DTR;
> > +
> 
> If this DTR mode is only used in spi-mem, maybe we shouldn't add those
> flags. SPI mem devices are usually smart enough to advertise what they
> support, and the subsystem in charge of those devices (in this specific
> case, spi-nor) will check what the controller supports
> using spi_mem_supports_op(). The only case we might have to deal with
> at some point is board level limitations (disabling DTR because the
> routing prevents using this mode).
 
Yes, being able to handle board-level limitations is the main reason 
behind this change. There should be a way to over-ride the use of DTR 
for a given board. And IIUC, SPI allows doing the same for Rx and Tx 
buswidth. So I don't see why we should deviate from that model.

> >  	if (spi_controller_is_slave(ctlr)) {
> >  		if (!of_node_name_eq(nc, "slave")) {
> >  			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
> > @@ -3252,7 +3259,8 @@ int spi_setup(struct spi_device *spi)
> >  		bad_bits &= ~SPI_CS_HIGH;
> >  	ugly_bits = bad_bits &
> >  		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
> > -		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
> > +		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
> > +		     SPI_TX_DTR  | SPI_RX_DTR);
> >  	if (ugly_bits) {
> >  		dev_warn(&spi->dev,
> >  			 "setup: ignoring unsupported mode bits %x\n",
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> > index 6d16ba01ff5a..bf1108318389 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -183,6 +183,8 @@ struct spi_device {
> >  #define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
> >  #define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
> >  #define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
> > +#define SPI_RX_DTR	0x10000			/* receive in DTR mode */
> > +#define SPI_TX_DTR	0x20000			/* transmit in DTR mode */
> >  	int			irq;
> >  	void			*controller_state;
> >  	void			*controller_data;
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
