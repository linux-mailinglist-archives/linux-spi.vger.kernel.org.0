Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11901CB5FD
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 19:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEHRa0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 13:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgEHRa0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 13:30:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8225A2184D;
        Fri,  8 May 2020 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588959026;
        bh=0gKRQpi2KaSxsOl0ZhcPyYXDz/x9dFFAJqh3/p3z9WM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKqqyuvPjhkAzCGClJKkDSVKAyZwKhi6gaCRFPy7ElHjRQpeDtZHzw41IyWBqBPa5
         /LSR615uZXfQyokHoAD6fu8KO1d66CCehqEWBRv9oF84YEjQztZT1nbAXEKgQ6rJa9
         s7U4PQW1G+P/mZyBqZE/2eeNcZzIrjaH2LvCTis8=
Date:   Fri, 8 May 2020 18:30:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] spi: dw: Add Tx/Rx finish wait methods to DMA
Message-ID: <20200508173023.GO4820@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CbqR2XcyIs6OSP+I"
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-8-Sergey.Semin@baikalelectronics.ru>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--CbqR2XcyIs6OSP+I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2020 at 04:29:32PM +0300, Serge Semin wrote:

> Since DMA transfers are performed asynchronously with actual SPI
> transaction, then even if DMA transfers are finished it doesn't mean
> all data is actually pushed to the SPI bus. Some data might still be

This looks like a bug fix so it should really have gone at the start of
the series so it can be sent to Linus as a bug fix rather than waiting
for the merge window.  This makes sense to me, a couple of nits below:

> +static void dw_spi_dma_wait_tx_done(struct dw_spi *dws)
> +{
> +	int retry = WAIT_RETRIES;
> +	unsigned long ns;
> +
> +	ns = (NSEC_PER_SEC / spi_get_clk(dws)) * dws->n_bytes * BITS_PER_BYTE;
> +	ns *= dw_readl(dws, DW_SPI_TXFLR);
> +
> +	while (dw_spi_dma_tx_busy(dws) && retry--)
> +		ndelay(ns);

How deep can the FIFO be with this IP - could we end up ndelay()ing for
non-trivial amounts of time?

> +static inline u32 spi_get_clk(struct dw_spi *dws)
> +{
> +	u32 div = dw_readl(dws, DW_SPI_BAUDR);
> +
> +	return div ? dws->max_freq / div : 0;

Please write normal conditional statements rather than using the ternery
operator - it helps with legibility.

--CbqR2XcyIs6OSP+I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61ly4ACgkQJNaLcl1U
h9Ai2Qf/WPH1t7wgklh6vuMSUy2FBvsRnaDP6wc4mxtKqpcm+bsscPDA26ZnfSJE
Uw4yfOO0JLjtRN6ZGSzYIKcDl3k6y3upXZdGBjZB96bmqjSTgc52QqDrTiDCdaRg
C9zf5J5L/OXARSk20XHTHnqV/F0nKPMxMVUcUYrZodnARTpvq33BaEJFBfWfaUYC
oJJpZfKpHSXzQMrTTULOAGYKqJgLYTxObMai31W46Io2VCF+02Wk1RUeS42VFEt0
vbusbfJO0D0MqcUZ6HzHSwFfkWaUWguCYboe7dYf+A3goddE2QZgP7CSvV+0yvxM
h+q4ml5Yg4KZIFGg+tZZrCozvh2tOA==
=kVhk
-----END PGP SIGNATURE-----

--CbqR2XcyIs6OSP+I--
