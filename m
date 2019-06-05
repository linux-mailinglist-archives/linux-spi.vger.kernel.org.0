Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8635B4C
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2019 13:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfFELcA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jun 2019 07:32:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfFELcA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jun 2019 07:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pm/mmoeGqcCBZtcmDvislyEyEeKGBoCAKEAcpjvYEpE=; b=tkDq1kZK6wQ5D5HrrpNNuC9x5
        b/ImcQzihIUN2qW62pGaITPf0ZyUAv/5ac69XeHRylr2EoAzbiIARBC3YZFQmucx8DCOxfFWv/cjh
        vK47bbHXuIYha9ul400Ka78qhSvUHUVAbKGnNGzAbYWf4FzVMpzV5PB7ojqan9pVFS25M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYU95-0000Gd-Ox; Wed, 05 Jun 2019 11:31:55 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 25317440046; Wed,  5 Jun 2019 12:31:55 +0100 (BST)
Date:   Wed, 5 Jun 2019 12:31:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: Re: [PATCH RFC] spi: add Renesas RPC-IF driver
Message-ID: <20190605113154.GP2456@sirena.org.uk>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <beb35895-f531-977b-4766-d1e17f9b1d13@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lPoaUxpIfuIzBujk"
Content-Disposition: inline
In-Reply-To: <beb35895-f531-977b-4766-d1e17f9b1d13@cogentembedded.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lPoaUxpIfuIzBujk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2019 at 11:24:04PM +0300, Sergei Shtylyov wrote:

> +config SPI_RPCIF
> +	tristate "Renesas RPC-IF SPI driver"
> +	select MFD_RPCIF
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	help
> +	  SPI driver for Renesas R-Car Gen3 RPC-IF.
> +

Why are we selecting the MFD rather than depending on it like normal?

> @@ -0,0 +1,339 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RPC-IF SPI/QSPI/Octa driver
> + *

Please make the entire header a C++ one so this looks more intentional.

> +static void rpcif_spi_transfer_setup(struct rpcif_spi *spi,
> +				     struct spi_message *msg)
> +{
> +	struct spi_transfer *t, xfer[4] = { };

Don't mix initialized and non-initialized declarations in a single line
(as per coding style).

> +	u32 i, xfercnt, xferpos = 0;
> +	struct rpcif_op op = { };
> +
> +	spi->totalxferlen = 0;
> +	spi->xfer_dir = SPI_MEM_NO_DATA;
> +
> +	list_for_each_entry(t, &msg->transfers, transfer_list) {
> +		if (t->tx_buf) {
> +			xfer[xferpos].tx_buf = t->tx_buf;
> +			xfer[xferpos].tx_nbits = t->tx_nbits;
> +		}

xfer is hard coded to 4 elements but I'm not seeing any validation that
we don't have more transfers than that in the message, and there's lots
of assumptions later on about the number of transfers.

> +		if (list_is_last(&t->transfer_list, &msg->transfers)) {
> +			if (xferpos > 1) {
> +				if (t->rx_buf)
> +					spi->xfer_dir = SPI_MEM_DATA_IN;
> +				else if (t->tx_buf)
> +					spi->xfer_dir = SPI_MEM_DATA_OUT;
> +			}
> +		}

Transfers can be bidirectional...  if the device can't support that it
should set SPI_CONTROLLER_HALF_DUPLEX.

> +static inline int rpcif_spi_xfer_message(struct rpcif_spi *spi,
> +				       struct spi_transfer *data_xfer)

This has exactly one caller and contains a single statement - why have a
separate function?

> +{
> +	return rpcif_io_xfer(spi->rpc,
> +			   spi->xfer_dir == SPI_MEM_DATA_OUT ?
> +			   data_xfer->tx_buf : NULL,
> +			   spi->xfer_dir == SPI_MEM_DATA_IN ?
> +			   data_xfer->rx_buf : NULL);

This is really hard to read.  Why are we abusing the ternery operator
here, especially when there's other places where we already set things
up based on the direction?

> +static int rpcif_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> +	struct rpcif *rpc = dev_get_drvdata(pdev->dev.parent);
> +
> +	rpcif_disable_rpm(rpc);
> +	spi_unregister_controller(ctlr);
> +
> +	return 0;
> +}

Shouldn't we unregister the controller before we disable the RPM?  The
probe was the other way around and this means that we might still be
processing messages while the hardware is disabled which doesn't seem
good.

--lPoaUxpIfuIzBujk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz3qCoACgkQJNaLcl1U
h9BSgQgAhQdPlZ2rue0td8PdKv/pFt9C9vDxzKBOdbIW3pmbon//irv+A4IVgO0F
dwbC9uuiGTUIO8MokwXnnealEHVSMIctrQ6BvEyuppgfhlAmQzPeTboAuNYmGHZr
tPVRWBlsSG0rY+67BE+vThL1342p+P9AOeUP1QLNxQnCUK0tf6L3CZbKPaU3LTln
cHrR4o8xcmHoH8etYxykJNWwgIj6AHVJe3BE7pjBSy3TI51E2sn792ISfVKFuqeT
idCCoaEFIpx2WIRdJNHOXF1pnESJviybOIFZYj/YG+d93zjHcgotqx8yQGZFjdsn
OkU3vLu4xVGGtqFxNkUSA/zM313p1g==
=Dj5i
-----END PGP SIGNATURE-----

--lPoaUxpIfuIzBujk--
