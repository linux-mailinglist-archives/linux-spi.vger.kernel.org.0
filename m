Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A823110004
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 15:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCOTy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 09:19:54 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLCOTy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 09:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/CDlfnPoepj5xBGb25Vr91OKvHcFns89CSr5ZTmJxuo=; b=HUIIRWozvP+6ahxe+WI0KkGLU
        0xPE74mDFqOrPvPvIYwrU0XsMydq8dlnSxVfd9q2F+brAVeBRFAKmnvtV4MkVC7mxPAv8ImKV+cM5
        U8gtFs0EszaslwMUDaT6Ce3ew2MQBuO9nrEznQ5F9kfs7FnRPVfG8fx5KLwxbx1EiRLwM=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ic91l-0002iA-AB; Tue, 03 Dec 2019 14:19:45 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id CEFD6D002FA; Tue,  3 Dec 2019 14:19:44 +0000 (GMT)
Date:   Tue, 3 Dec 2019 14:19:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chris Brandt <chris.brandt@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/6] spi: Add SPIBSC driver
Message-ID: <20191203141944.GI1998@sirena.org.uk>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-5-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Content-Disposition: inline
In-Reply-To: <20191203034519.5640-5-chris.brandt@renesas.com>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2019 at 10:45:17PM -0500, Chris Brandt wrote:

> +config SPI_SPIBSC
> +	tristate "Renesas SPI Multi I/O Bus Controller"
> +	depends on ARCH_R7S72100 || ARCH_R7S9210

I'm not seeing any build dependency here, please add an ||
COMPILE_TEST for build coverage.

> +++ b/drivers/spi/spi-spibsc.c
> @@ -0,0 +1,609 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SPI Bus Space Controller (SPIBSC) bus driver

Please make the entire comment block here a C++ one so things
look more intentional.

> +static void spibsc_write(struct spibsc_priv *sbsc, int reg, u32 val)
> +{
> +	iowrite32(val, sbsc->base + reg);
> +}
> +static void spibsc_write8(struct spibsc_priv *sbsc, int reg, u8 val)

Blank likes between functions, please see coding-style.rst.
Looking at a bunch of the stuff here it looks like you could
benefit from regmap, it's got lots of debug infrastructure.

> +	if (tx)
> +		pr_debug("spibsc: send data: ");
> +	else
> +		pr_debug("spibsc: recv data: ");

dev_dbg() if you're going to do tis.

> +
> +	for (i = 0; i < len; ) {
> +		sprintf(line_buffer + line_index, " %02X", buf[i]);

snprintf()!

> +static int spibsc_transfer_one_message(struct spi_controller *master,
> +				       struct spi_message *msg)
> +{
> +	struct spibsc_priv *sbsc = spi_controller_get_devdata(master);
> +	struct spi_transfer *t, *t_last;
> +	u8 tx_data[MAX_CMD_LEN];
> +	int tx_only;
> +	u8 tx_len;
> +	int ret;
> +
> +	t_last = list_last_entry(&msg->transfers, struct spi_transfer,
> +				 transfer_list);
> +	/* defaults */
> +	ret = 0;
> +	sbsc->last_xfer = 0;
> +	tx_only = 1;
> +
> +	/* Analyze the messages */
> +	t = list_first_entry(&msg->transfers, struct spi_transfer,
> +			     transfer_list);
> +	if (t->rx_buf) {
> +		dev_dbg(sbsc->dev, "Cannot Rx without Tx first!\n");
> +		return -EIO;

These errors should probably be -EINVAL, you're failing on
validation here.

> +	}
> +	list_for_each_entry(t, &msg->transfers, transfer_list) {

Blank line here please as well.

> +	if (spi->bits_per_word != 8) {
> +		dev_err(sbsc->dev, "bits_per_word must be 8\n");
> +		return -EIO;
> +	}

The core will validate this for you.

> +	master->num_chipselect	= 1;
> +	master->mode_bits		= SPI_CPOL | SPI_CPHA;
> +	master->setup			= spibsc_setup;
> +	master->transfer_one_message	= spibsc_transfer_one_message;

Set bits_per_word_mask here.

> +	dev_info(&pdev->dev, "probed\n");
> +

Remove this, it's just noise.

> +static int spibsc_remove(struct platform_device *pdev)
> +{
> +	struct spibsc_priv *sbsc = dev_get_drvdata(&pdev->dev);
> +
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);

There seems to be no purpose in the runtime PM code in this
driver, there's no PM operations of any kind and the driver holds
a runtime PM reference for the entire lifetime of the device.

> +	spi_unregister_controller(sbsc->master);

You registered the controller with devm_, there's no need to
unregister it and if you do you need to use a matching devm_
unregiser.

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3mbwAACgkQJNaLcl1U
h9Dzcgf/bPKKtl+0UszS1c1X9/HBdRfcH6vnPEp8R9IbwYRR71OmtqteR27re0WC
rUf5W3IKQ9q8jPd5zUsBBLifHg3Oj8WCuMogg4E946QUMdsnY/517wlBQ6cavxhq
q+Ky2Dp3Iz29lLyiwTOMSUkHndbhY3Q7oHmpx8akowtcVcdegBrg+gNaYU6152+C
l+Zy+fG4R8FndhiGgUMto1kkvq6NZXfGzKzFvY5ANrPtD2N4Vd5m0RVYmBxjO3r5
hGjQPPrJ3LQ5JhWr9MZhXEzf3X1zd1z9tQFFnx9nMU8AZeCgKyedNoA1cCLTxgt6
vkN5C/dBQyj2EzWI/D3UhVTY9t/Wvg==
=7Jzf
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--
