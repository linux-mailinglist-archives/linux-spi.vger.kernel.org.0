Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBDD1B7301
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 13:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgDXLZJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 07:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDXLZI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 07:25:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48B7B20736;
        Fri, 24 Apr 2020 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587727507;
        bh=jMRabbOYU0+i+Mp4IDehVLSW1V5c3YcEuzYz82B8Yuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7VhYJRYu2T4R8Z+FwEBdzfkZJaUQ697sedXWWcK80RJOIOIYHrPDacNCU1CL2hf4
         PZMQ3B7egTzq8Ww/QMpP+mUwiJQ2yAn+8bVynnpTMCYjHrES57+RsVQMFSyivduqpA
         CL4L/bnhEGchXUCF/trNAU0YG8fShliPWsdWsJZc=
Date:   Fri, 24 Apr 2020 12:25:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.schwierzeck@gmail.com, hauke@hauke-m.de,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
Message-ID: <20200424112505.GD5850@sirena.org.uk>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
X-Cookie: Information is the inverse of entropy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 06:42:30PM +0800, Dilip Kota wrote:

> Synchronize tx, rx and error interrupts by registering to the
> same interrupt handler. Interrupt handler will recognize and process
> the appropriate interrupt on the basis of interrupt status register.
> Also, establish synchronization between the interrupt handler and
> transfer operation by taking the locks and registering the interrupt
> handler as thread IRQ which avoids the bottom half.
> Fixes the wrongly populated interrupt register offsets too.

This sounds like at least three different changes mixed together in one
commit, it makes it quite hard to tell what's going on.  If nothing else
the conversion from a workqueue to threaded interrupts should probably
be split out from merging the interrupts.

> -static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
> +static irqreturn_t lantiq_ssc_err_interrupt(struct lantiq_ssc_spi *spi)
>  {
> -	struct lantiq_ssc_spi *spi =3D data;
>  	u32 stat =3D lantiq_ssc_readl(spi, LTQ_SPI_STAT);
> =20
> -	if (!(stat & LTQ_SPI_STAT_ERRORS))
> -		return IRQ_NONE;
> -

Why drop this?

> -	err =3D devm_request_irq(dev, rx_irq, lantiq_ssc_xmit_interrupt,
> -			       0, LTQ_SPI_RX_IRQ_NAME, spi);
> +	err =3D devm_request_threaded_irq(dev, rx_irq, NULL, lantiq_ssc_isr,
> +					IRQF_ONESHOT, LTQ_SPI_RX_IRQ_NAME, spi);
>  	if (err)
>  		goto err_master_put;
> =20
> -	err =3D devm_request_irq(dev, tx_irq, lantiq_ssc_xmit_interrupt,
> -			       0, LTQ_SPI_TX_IRQ_NAME, spi);
> +	err =3D devm_request_threaded_irq(dev, tx_irq, NULL, lantiq_ssc_isr,
> +					IRQF_ONESHOT, LTQ_SPI_TX_IRQ_NAME, spi);
>  	if (err)
>  		goto err_master_put;
> =20
> -	err =3D devm_request_irq(dev, err_irq, lantiq_ssc_err_interrupt,
> -			       0, LTQ_SPI_ERR_IRQ_NAME, spi);
> +	err =3D devm_request_threaded_irq(dev, err_irq, NULL, lantiq_ssc_isr,
> +					IRQF_ONESHOT, LTQ_SPI_ERR_IRQ_NAME, spi);

It's not clear to me that it's a benefit to combine all the interrupts
unconditionally - obviously where they're shared we need to but could
that be accomplished with IRQF_SHARED and even if it can't it seems like
something conditional would be better.

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6izJAACgkQJNaLcl1U
h9A9gAf9EAGD07QOzDrXXolg+XQmkRiTF70XBpUwy3VJ1Xi6JMYAHUNA3/Z2ssS5
RrMUMyrJy+um1y4Zx+8+XV/+EfOmEPFVNeM+7cZ9hWrjtYpoIkaDonksboZz+T8h
Q7cn2CDyQ4VRXbo8cc5Q4yApbKISswcMzf5UolZojAVWVNhMR7nQ5HUuwNWuuP7V
08pOBLsc3/GtOWuXA5OGLF287UuMsWkiK9ySbxw8ppLN9wvQOOs2t7izOFVeLGJE
4YnmncNquDPLjB9OdTEF/V2kmxvUoxNt8Nyn+kR/TX7xZYZ+i7L0Bb865IbaL0yl
F17jaNiJyOzmR/CyFiyKoK+yq8GEvw==
=2prX
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
