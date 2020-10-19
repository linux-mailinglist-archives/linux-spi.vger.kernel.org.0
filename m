Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C364729238A
	for <lists+linux-spi@lfdr.de>; Mon, 19 Oct 2020 10:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgJSIVg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Oct 2020 04:21:36 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46773 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728781AbgJSIVg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Oct 2020 04:21:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C4FB5C00A5;
        Mon, 19 Oct 2020 04:21:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 19 Oct 2020 04:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=XTmgxObblxDSzINzf+hlaODgpg+
        rdkjKpiOLWaGp4ho=; b=OazQWh6fObFP81S9ZwenHPQ3PGSboiLsslkHHbIaMcS
        +Mctv4hPBRwI6cJgjvMEH9lAkQB+DSNHeR2xSHaw7r+ZlyGLH7kZouyzICuHaEW0
        ul9bu48hs2KG/rWG8qsN4Wfg6Ybq0yIatNtuJFwf9cHlJ9qWooH4tK3i/B7vMyZi
        bQKn0tZJTjTD8Y6M3MVKP6sI1wxyEjsSH/1QfMER3SYKmcFcHeCjAOfv/GBD8vdb
        BcKB9Q/o7mUS8muMl3TaOwRvRzgvwbWkN5KOOypnmZHUKQTAgvOWx/26Ld9GwWVk
        sUTodU1s9+mZzkUz3hJupM4Z25fjXtS9viRFQSN70ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XTmgxO
        bblxDSzINzf+hlaODgpg+rdkjKpiOLWaGp4ho=; b=SxVLs6tbh3QJ0PgccNxM2A
        ZOqHufVA8N/aF4ZL279cxFVYZmFzF+PCFq/LyLM5MKN3QTcOkx6p2Lv1qXzirVZZ
        o9ObioV3NZJ86sZF1np4CYtpEJvPZW0JMpOKxHrhbMNlTRDrD4o9OFqfbfKDSXIa
        x6QRllv07NB7tozjuoBwepZa1SZEyQ30TS9dPH2xLh2nrStfL38FPXtGKTp12H2S
        DXWy0oZi8m1eO9FjUDXrlo4/C1hsHosxH1wENE6rbDg/Xr/OQo7w7LxrdbVegH3a
        /iXP8q6OhOvgS5FJQ18NpwDYCtaOP6DFnoPc/TWKrvKbvUPwlF1wj3LrJtUVBhlQ
        ==
X-ME-Sender: <xms:i0yNX5axG5vn0GQWUCLPJSSnFyBoNtkLOnVrgfnuMFgF4JFB1f_WdA>
    <xme:i0yNXwZ9lf6ju3YykeKiXAEHl4r6nS9vhtggKSu46blr0mC8ipnT6XzRw7XUaxw22
    i6P2k15cnXhQXFSI0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeffuedugfdvjeeihedvgefhieeikeelteehteekffetudeiueeggfduueevffet
    geenucffohhmrghinhepphhinhgvieegrdhorhhgnecukfhppeeltddrkeelrdeikedrje
    einecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    gihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:i0yNX7_34SAVyx89grgYa8FG2xIX0MhBNw1Jeh8V3IwwhWOvhgjuFA>
    <xmx:i0yNX3qCw0--JYy4ObfWQ0xisNT-pam9qaR4bEbv5AKPnTjrdOvqbQ>
    <xmx:i0yNX0ruM-70WVhlR0EN3MMuNkvMKcsQCgNOWpWFt21rNfKi9rdHXg>
    <xmx:jkyNX_VZ5s92HW5ayHhZvMCdT_QwdsCLpxIlggw5Pbyr1TpHw3L_0A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3BB89328005A;
        Mon, 19 Oct 2020 04:21:31 -0400 (EDT)
Date:   Mon, 19 Oct 2020 10:21:29 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Alexander Kochetkov <al.kochet@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-sun6i: implement DMA-based transfer mode
Message-ID: <20201019082129.myxpxla5xwoqwldo@gilmour.lan>
References: <20201015154740.20825-1-al.kochet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qboiznam3rkxrap6"
Content-Disposition: inline
In-Reply-To: <20201015154740.20825-1-al.kochet@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qboiznam3rkxrap6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu, Oct 15, 2020 at 06:47:40PM +0300, Alexander Kochetkov wrote:
> DMA-based transfer will be enabled if data length is larger than FIFO size
> (64 bytes for A64). This greatly reduce number of interrupts for
> transferring data.
>=20
> For smaller data size PIO mode will be used. In PIO mode whole buffer will
> be loaded into FIFO.
>=20
> If driver failed to request DMA channels then it fallback for PIO mode.
>=20
> Tested on SOPINE (https://www.pine64.org/sopine/)
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

Thanks for working on this, it's been a bit overdue

> ---
>  drivers/spi/spi-sun6i.c | 171 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 159 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 19238e1b76b4..38e5b8af7da6 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -18,6 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> +#include <linux/dmaengine.h>
> =20
>  #include <linux/spi/spi.h>
> =20
> @@ -52,10 +53,12 @@
> =20
>  #define SUN6I_FIFO_CTL_REG		0x18
>  #define SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_MASK	0xff
> +#define SUN6I_FIFO_CTL_RF_DRQ_EN		BIT(8)
>  #define SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS	0
>  #define SUN6I_FIFO_CTL_RF_RST			BIT(15)
>  #define SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_MASK	0xff
>  #define SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS	16
> +#define SUN6I_FIFO_CTL_TF_DRQ_EN		BIT(24)
>  #define SUN6I_FIFO_CTL_TF_RST			BIT(31)
> =20
>  #define SUN6I_FIFO_STA_REG		0x1c
> @@ -83,6 +86,8 @@
>  struct sun6i_spi {
>  	struct spi_master	*master;
>  	void __iomem		*base_addr;
> +	dma_addr_t		dma_addr_rx;
> +	dma_addr_t		dma_addr_tx;
>  	struct clk		*hclk;
>  	struct clk		*mclk;
>  	struct reset_control	*rstc;
> @@ -92,6 +97,7 @@ struct sun6i_spi {
>  	const u8		*tx_buf;
>  	u8			*rx_buf;
>  	int			len;
> +	bool			use_dma;
>  	unsigned long		fifo_depth;
>  };
> =20
> @@ -182,6 +188,66 @@ static size_t sun6i_spi_max_transfer_size(struct spi=
_device *spi)
>  	return SUN6I_MAX_XFER_SIZE - 1;
>  }
> =20
> +static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
> +				 struct spi_transfer *tfr)
> +{
> +	struct dma_async_tx_descriptor *rxdesc, *txdesc;
> +	struct spi_master *master =3D sspi->master;
> +
> +	rxdesc =3D NULL;
> +	if (tfr->rx_buf) {
> +		struct dma_slave_config rxconf =3D {
> +			.direction =3D DMA_DEV_TO_MEM,
> +			.src_addr =3D sspi->dma_addr_rx,
> +			.src_addr_width =3D 1,
> +			.src_maxburst =3D 1,
> +		};

That doesn't really look optimal, the controller seems to be able to
read / write 32 bits at a time from its FIFO and we probably can
increase the burst length too?

> +
> +		dmaengine_slave_config(master->dma_rx, &rxconf);
> +
> +		rxdesc =3D dmaengine_prep_slave_sg(
> +				master->dma_rx,
> +				tfr->rx_sg.sgl, tfr->rx_sg.nents,
> +				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);

checkpatch --strict complains about this one (your line shouldn't end
with a parenthesis).

> +		if (!rxdesc)
> +			return -EINVAL;
> +	}
> +
> +	txdesc =3D NULL;
> +	if (tfr->tx_buf) {
> +		struct dma_slave_config txconf =3D {
> +			.direction =3D DMA_MEM_TO_DEV,
> +			.dst_addr =3D sspi->dma_addr_tx,
> +			.dst_addr_width =3D 1,
> +			.dst_maxburst =3D 1,
> +		};
> +
> +		dmaengine_slave_config(master->dma_tx, &txconf);
> +
> +		txdesc =3D dmaengine_prep_slave_sg(
> +				master->dma_tx,
> +				tfr->tx_sg.sgl, tfr->tx_sg.nents,
> +				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
> +		if (!txdesc) {
> +			if (rxdesc)
> +				dmaengine_terminate_sync(master->dma_rx);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (tfr->rx_buf) {
> +		dmaengine_submit(rxdesc);
> +		dma_async_issue_pending(master->dma_rx);
> +	}
> +
> +	if (tfr->tx_buf) {
> +		dmaengine_submit(txdesc);
> +		dma_async_issue_pending(master->dma_tx);
> +	}
> +
> +	return 0;
> +}
> +
>  static int sun6i_spi_transfer_one(struct spi_master *master,
>  				  struct spi_device *spi,
>  				  struct spi_transfer *tfr)
> @@ -201,6 +267,8 @@ static int sun6i_spi_transfer_one(struct spi_master *=
master,
>  	sspi->tx_buf =3D tfr->tx_buf;
>  	sspi->rx_buf =3D tfr->rx_buf;
>  	sspi->len =3D tfr->len;
> +	sspi->use_dma =3D master->can_dma ?
> +			master->can_dma(master, spi, tfr) : false;
> =20
>  	/* Clear pending interrupts */
>  	sun6i_spi_write(sspi, SUN6I_INT_STA_REG, ~0);
> @@ -216,9 +284,17 @@ static int sun6i_spi_transfer_one(struct spi_master =
*master,
>  	 * (See spi-sun4i.c)
>  	 */
>  	trig_level =3D sspi->fifo_depth / 4 * 3;
> -	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
> -			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS) |
> -			(trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS));
> +	reg =3D (trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS) |
> +	      (trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS);
> +
> +	if (sspi->use_dma) {
> +		if (tfr->tx_buf)
> +			reg |=3D SUN6I_FIFO_CTL_TF_DRQ_EN;
> +		if (tfr->rx_buf)
> +			reg |=3D SUN6I_FIFO_CTL_RF_DRQ_EN;
> +	}
> +
> +	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG, reg);
> =20
>  	/*
>  	 * Setup the transfer control register: Chip Select,
> @@ -300,16 +376,28 @@ static int sun6i_spi_transfer_one(struct spi_master=
 *master,
>  	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, tx_len);
>  	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG, tx_len);
> =20
> -	/* Fill the TX FIFO */
> -	sun6i_spi_fill_fifo(sspi);
> +	if (!sspi->use_dma) {
> +		/* Fill the TX FIFO */
> +		sun6i_spi_fill_fifo(sspi);
> +	} else {
> +		ret =3D sun6i_spi_prepare_dma(sspi, tfr);
> +		if (ret) {
> +			dev_warn(&master->dev,
> +				 "%s: prepare DMA failed, ret=3D%d",
> +				 dev_name(&spi->dev), ret);
> +			return ret;
> +		}
> +	}
> =20
>  	/* Enable the interrupts */
>  	reg =3D SUN6I_INT_CTL_TC;
> =20
> -	if (rx_len > sspi->fifo_depth)
> -		reg |=3D SUN6I_INT_CTL_RF_RDY;
> -	if (tx_len > sspi->fifo_depth)
> -		reg |=3D SUN6I_INT_CTL_TF_ERQ;
> +	if (!sspi->use_dma) {
> +		if (rx_len > sspi->fifo_depth)
> +			reg |=3D SUN6I_INT_CTL_RF_RDY;
> +		if (tx_len > sspi->fifo_depth)
> +			reg |=3D SUN6I_INT_CTL_TF_ERQ;
> +	}
> =20
>  	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
> =20
> @@ -332,6 +420,11 @@ static int sun6i_spi_transfer_one(struct spi_master =
*master,
> =20
>  	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
> =20
> +	if (ret && sspi->use_dma) {
> +		dmaengine_terminate_sync(master->dma_rx);
> +		dmaengine_terminate_sync(master->dma_tx);
> +	}
> +
>  	return ret;
>  }
> =20
> @@ -343,7 +436,8 @@ static irqreturn_t sun6i_spi_handler(int irq, void *d=
ev_id)
>  	/* Transfer complete */
>  	if (status & SUN6I_INT_CTL_TC) {
>  		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TC);
> -		sun6i_spi_drain_fifo(sspi);
> +		if (!sspi->use_dma)
> +			sun6i_spi_drain_fifo(sspi);

Is it causing any issue? The FIFO will be drained only if there's
something remaining in the FIFO, which shouldn't happen with DMA?

Maxime

--qboiznam3rkxrap6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX41MiQAKCRDj7w1vZxhR
xURAAQD2D/f4gllUD42fAjpjkz5DH/BOU3aL8doWmHSnE2PF8QEAscqzE9DFSfI/
Onc8zzd+eSxCXsLif90Bx7puB6Ifugg=
=lObj
-----END PGP SIGNATURE-----

--qboiznam3rkxrap6--
