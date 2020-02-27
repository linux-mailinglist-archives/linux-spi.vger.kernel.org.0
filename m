Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC4C172337
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 17:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgB0QXJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 11:23:09 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39360 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbgB0QXJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 11:23:09 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 524F12963D9;
        Thu, 27 Feb 2020 16:23:07 +0000 (GMT)
Date:   Thu, 27 Feb 2020 17:23:04 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 02/11] spi: set mode bits for "spi-rx-dtr" and
 "spi-tx-dtr"
Message-ID: <20200227172247.0e8ec459@collabora.com>
In-Reply-To: <20200226093703.19765-3-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-3-p.yadav@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Feb 2020 15:06:54 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> These two DT properties express DTR receive and transmit capabilities of
> a SPI flash and controller. Introduce two new mode bits: SPI_RX_DTR and
> SPI_TX_DTR which correspond to the new DT properties. Set these bits
> when the two corresponding properties are present in the device tree.
> Also update the detection of unsupported mode bits to include the new
> bits.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/spi/spi.c       | 10 +++++++++-
>  include/linux/spi/spi.h |  2 ++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 38b4c78df506..25c8ed9343f9 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1927,6 +1927,13 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		}
>  	}
>  
> +	/* Device DTR mode. */
> +	if (of_property_read_bool(nc, "spi-tx-dtr"))
> +		spi->mode |= SPI_TX_DTR;
> +
> +	if (of_property_read_bool(nc, "spi-rx-dtr"))
> +		spi->mode |= SPI_RX_DTR;
> +

If this DTR mode is only used in spi-mem, maybe we shouldn't add those
flags. SPI mem devices are usually smart enough to advertise what they
support, and the subsystem in charge of those devices (in this specific
case, spi-nor) will check what the controller supports
using spi_mem_supports_op(). The only case we might have to deal with
at some point is board level limitations (disabling DTR because the
routing prevents using this mode).

>  	if (spi_controller_is_slave(ctlr)) {
>  		if (!of_node_name_eq(nc, "slave")) {
>  			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
> @@ -3252,7 +3259,8 @@ int spi_setup(struct spi_device *spi)
>  		bad_bits &= ~SPI_CS_HIGH;
>  	ugly_bits = bad_bits &
>  		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
> -		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
> +		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
> +		     SPI_TX_DTR  | SPI_RX_DTR);
>  	if (ugly_bits) {
>  		dev_warn(&spi->dev,
>  			 "setup: ignoring unsupported mode bits %x\n",
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 6d16ba01ff5a..bf1108318389 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -183,6 +183,8 @@ struct spi_device {
>  #define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
>  #define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
>  #define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
> +#define SPI_RX_DTR	0x10000			/* receive in DTR mode */
> +#define SPI_TX_DTR	0x20000			/* transmit in DTR mode */
>  	int			irq;
>  	void			*controller_state;
>  	void			*controller_data;

