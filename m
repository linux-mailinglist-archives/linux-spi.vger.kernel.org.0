Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D764E2B7E2C
	for <lists+linux-spi@lfdr.de>; Wed, 18 Nov 2020 14:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKRNQ1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Nov 2020 08:16:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgKRNQ0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 18 Nov 2020 08:16:26 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 385BC241A5;
        Wed, 18 Nov 2020 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605705385;
        bh=nTNTsy3xL/gdqy1AFHbIdrzBXhJhxmiLNAzDiJMibX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/3fR4bxrWAtVPLAy/gorf0yvxu74ioU6EQeCPzHG60j8ReAMM5AOCQZmXSyigOVx
         iX6gPnoCGy3blwvPQL+/pBz6Wv/6LZoDlyWiNRllMcU8OdaCXjk2EgdrEk/ZdmBPoW
         AV3QX8xQIZOjENq+7wVMW8P30xR0W4T/XV7edH3U=
Date:   Wed, 18 Nov 2020 13:16:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] spi: Take the SPI IO-mutex in the spi_setup() method
Message-ID: <20201118131604.GC4827@sirena.org.uk>
References: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
X-Cookie: A nuclear war can ruin your whole day.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2020 at 12:45:17PM +0300, Serge Semin wrote:

> method being called at the same time. In particular in calling the
> spi_set_cs(false) while there is an SPI-transfer being executed. In my
> case due to the commit cited above all CSs get to be switched off by
> calling the spi_setup() for /dev/spidev0.1 while there is an concurrent
> SPI-transfer execution performed on /dev/spidev0.0. Of course a situation
> of the spi_setup() being called while there is an SPI-transfer being
> executed for two different SPI peripheral devices of the same controller
> may happen not only for the spidev driver, but for instance for MMC SPI +
> some another device, or spi_setup() being called from an SPI-peripheral
> probe method while some other device has already been probed and is being
> used by a corresponding driver...

It's documented that a driver's spi_setup() operation is supposed to
support being able to be called concurrently with other transfers, see
spi-summary.rst.

> Of course I could have provided a fix affecting the DW APB SSI driver
> only, for instance, by creating a mutual exclusive access to the set_cs
> callback and setting/clearing only the bit responsible for the
> corresponding chip-select. But after a short research I've discovered that
> the problem most likely affects a lot of the other drivers:

Yeah, problems with it are very common as the documentation has noted
since forever.  IIRC there was some problem triggered by trying to force
it to be serialised but I can't remember what it was.

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+1HpQACgkQJNaLcl1U
h9C10wf/UL7gHcOtEornz8CUpn8gXROVBLHD829V29n5B5EAiRDHuF/B5TrIbNfE
Ciaeb81Gonxu2/gXNWHJB09neBhzC338vZGnfQumD8iR2HJmjqtfP/vpdxu+pxt1
XBZhKfhpqrwKgZbERk87QJfv10YV4x3CIsQOqgBK1C5TwmBotCTgX11bsERfLclj
vssooAxtI/R8J3EQrt99SczUNfEZZHxIU5ZtrEd4s1to/PLFO0yLQshro5fhlIMj
z2jFS4lkgaOVZEEZU2xOaOMGSGYUdRRbO4UlT1n3wGRMWV+nXBh9W+34RFfVMMcN
VKWlt2Rv7Soaqecr2x87L0qVETf4ww==
=70uB
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
