Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3C25758
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 20:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfEUSQZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 14:16:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39654 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUSQZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 14:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HVziMftjpXjB+N5SeRAwtXlbBDBepO/NfMJehWTXQiA=; b=eNSG8jGAB3IfSzFMyboVP5a1y
        /bd11oH0QO2VWNxho3ZAKocdHVNn/wTmoWlQaZFil91VOLlt8koG19JJ9bBkQp/SqOW0yes88bq0i
        j+eK+Sy+MvejGK8RE/dJWjE36bmxBxR8bckFLdc27VMEvfQoq59Aj9YyaFJc2V8n3EGM4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hT9J7-0000TI-In; Tue, 21 May 2019 18:16:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 922F71126D13; Tue, 21 May 2019 19:16:09 +0100 (BST)
Date:   Tue, 21 May 2019 19:16:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        geert@linux-m68k.org, tpiepho@impinj.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        jaswinder.singh@linaro.org, masami.hiramatsu@linaro.org,
        okamoto.satoru@socionext.com, osaki.yoshitoyo@socionext.com
Subject: Re: [PATCH v5 3/3] spi: Add spi driver for Socionext Synquacer
 platform
Message-ID: <20190521181609.GB16633@sirena.org.uk>
References: <20190521115958.22504-1-masahisa.kojima@linaro.org>
 <20190521115958.22504-4-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <20190521115958.22504-4-masahisa.kojima@linaro.org>
X-Cookie: Do I have a lifestyle yet?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 08:59:58PM +0900, Masahisa Kojima wrote:

> +	switch (sspi->bpw) {
> +	case 8:

> +		{
> +		u8 *buf =3D sspi->rx_buf;
> +
> +		readsb(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
> +		sspi->rx_buf =3D buf + len;
> +		break;
> +		}

Please indent these properly.

> +	default:
> +		{
> +		u32 *buf =3D sspi->rx_buf;
> +
> +		readsl(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
> +		sspi->rx_buf =3D buf + len;
> +		break;
> +		}

It'd be better to explicitly list the values this works for and return
an error otherwise.

> +	if (sspi->rx_words) {
> +		val =3D SYNQUACER_HSSPI_RXE_FIFO_MORE_THAN_THRESHOLD |
> +		      SYNQUACER_HSSPI_RXE_SLAVE_RELEASED;
> +		writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
> +		status =3D wait_for_completion_timeout(&sspi->transfer_done,
> +			msecs_to_jiffies(SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC));
> +		writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
> +	}
> +
> +	if (xfer->tx_buf) {
> +		val =3D SYNQUACER_HSSPI_TXE_FIFO_EMPTY;
> +		writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
> +		status =3D wait_for_completion_timeout(&sspi->transfer_done,
> +			msecs_to_jiffies(SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC));
> +		writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
> +	}

I guess the TX will complete before the RX usually so I'd kind of expect
the waits to be in the other order?

> +	if (status < 0) {
> +		dev_err(sspi->dev, "failed to transfer\n");
> +		return status;
> +	}

Printing the error code could be helpful for users.

> +static void synquacer_spi_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct synquacer_spi *sspi =3D spi_master_get_devdata(spi->master);
> +	u32 val;
> +
> +	val =3D readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> +	val &=3D ~(SYNQUACER_HSSPI_DMPSEL_CS_MASK <<
> +		 SYNQUACER_HSSPI_DMPSEL_CS_SHIFT);
> +	val |=3D spi->chip_select << SYNQUACER_HSSPI_DMPSEL_CS_SHIFT;
> +
> +	if (enable) {
> +		val |=3D SYNQUACER_HSSPI_DMSTOP_STOP;
> +		writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> +
> +		if (sspi->rx_buf) {
> +			u32 buf[SYNQUACER_HSSPI_FIFO_DEPTH];
> +
> +			sspi->rx_buf =3D buf;
> +			sspi->rx_words =3D SYNQUACER_HSSPI_FIFO_DEPTH;
> +			read_fifo(sspi);
> +		}

This is doing things with the FIFO, that's completely inappropriate for
a set_cs() operation.  The set_cs() operation should set the chip select
and nothing else.

> +static irqreturn_t sq_spi_rx_handler(int irq, void *priv)
> +{
> +	uint32_t val;
> +	struct synquacer_spi *sspi =3D priv;
> +
> +	val =3D readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_RXF);
> +	if ((val & SYNQUACER_HSSPI_RXF_SLAVE_RELEASED) ||
> +	    (val & SYNQUACER_HSSPI_RXF_FIFO_MORE_THAN_THRESHOLD))
> +		read_fifo(sspi);
> +
> +	if (sspi->rx_words =3D=3D 0) {
> +		writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
> +		complete(&sspi->transfer_done);
> +	}
> +
> +	return 0;
> +}

0 is not a valid return from an interrupt handler, IRQ_HANDLED or
IRQ_NONE.

> +	ret =3D devm_request_irq(&pdev->dev, rx_irq, sq_spi_rx_handler,
> +				0, "synquacer-spi-rx", sspi);
> +	ret =3D devm_request_irq(&pdev->dev, tx_irq, sq_spi_tx_handler,
> +				0, "synquacer-spi-tx", sspi);

The code looked awfully like we depend on having interrupts? =20

> +	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
> +			    SPI_TX_QUAD | SPI_RX_QUAD;

I don't see any code in the driver that configures dual or quad mode
support other than setting _PCC_SAFESYNC, I'm not clear how the driver
supports these modes?

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzkQGgACgkQJNaLcl1U
h9DBFgf/ZEJY1USHsPodtkdrIPFyI+tpdBqpdq1nNiRh/Z9QYJvumdtxpKGNXxAG
m0vWwh3fdnW/W/1pilOmJgHiwp24KlhH31/SnLbbWR+svp+2wIHfbsfJMVTm1VwM
EYyVW0ZRtsuwbrdblt9wml1hX510CiWeKPJNqRXtCcQ8xYzD9Q/qsDfDQJ7ReAVW
eNft6Mhry1hBxORGnL15fO/1VLMHZoHysHnVDPiL4XYull++R0Lj3buayT6YKnRq
p8bQUbujSLw/5Z6IgKCMJ5yXgF8PGOqlmsc/n8OUqA0OOzkQrbWTGDJBDDAgN6ft
e678yeROZpZZmej8VRifwwLeDJc8xA==
=zAHJ
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
