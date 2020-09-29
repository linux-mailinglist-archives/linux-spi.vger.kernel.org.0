Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A527D1AA
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 16:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgI2Oov (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 10:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbgI2Oov (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Sep 2020 10:44:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3862074B;
        Tue, 29 Sep 2020 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601390690;
        bh=KuUDPd07ZUCkGwOTQxUQXbDwoFA7723w2z2hG3+G5dE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mG0iIRKcG/3qHSx04Kyiweul3cr9HfSLJuUDWUUTspZlYmtugRaqomEltIKJhEAUV
         ZtswAEqOg8qCq+CRsj5HQ4X11TyB7koAi3a1Oe+oq030qjKmW3d433/iK2QiOYAmnE
         NB2W493ZjzbXdIZ10UnmlkU5wPbB1yEg4wk/BIdI=
Date:   Tue, 29 Sep 2020 15:43:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] spi: dw: Add full Baikal-T1 SPI Controllers support
Message-ID: <20200929144351.GH4799@sirena.org.uk>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AzNpbZlgThVzWita"
Content-Disposition: inline
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
X-Cookie: I left my WALLET in the BATHROOM!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--AzNpbZlgThVzWita
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 20, 2020 at 02:28:44PM +0300, Serge Semin wrote:

> First two patches are just cleanups to simplify the DW APB SSI device
> initialization a bit. We suggest to discard the IRQ threshold macro as
> unused and use a ternary operator to initialize the set_cs callback
> instead of assigning-and-updating it.

> Then we've discovered that the n_bytes field of the driver private data is
> used by the DW APB SSI IRQ handler, which requires it to be initialized

This is a *huge* patch series which is a bit unweildy to review
(especially given the other 10+ patch series you sent at the same time),
once you start getting over 10 patches it's time to pay attention to
series length and the fact that you're outlining a bunch of tangentially
related areas which could have been split out easily enough.  It is much
better to send smaller sets of patches at once, or if you're sending a
lot then to split them into smaller serieses.  This will tend to make
the review more approachable which will in turn tend to make things go
faster, people are much more likely to put off going through a huge
series.

--AzNpbZlgThVzWita
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9zSCYACgkQJNaLcl1U
h9CxCwf8CbZT+iN4nAUHqLiTecG9wg4ekQiosiG6okukMMyarbUv3HtPDCDGxSI1
paDuBbmPJuzmTZ7mpmy/lyLadEYw4ZPssvOxKwxB6FdrUnr0cZ49RA16246Yml0R
Mc7zoRnib5+CjaMF9PAZhLm9tIKj9nTmcGzya1UbqSrBjVh1Zbo7l0Px3vXVadxd
2CqvUNNGVC29zXmVary9mv26696nbC/gixmvv8kjzI0PuY/0/PVkFnuqUxtPYfbf
MRW6fQ+rX3mB5ymXU94SpuDP3pMF1JZpWlhlBlUNdAXUAm5aOu4GMdRezPcXTXq4
VQUu9FKH8Flq7PMWXO0wRPHcc8X54A==
=eyc/
-----END PGP SIGNATURE-----

--AzNpbZlgThVzWita--
