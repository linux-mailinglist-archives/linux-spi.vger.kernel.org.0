Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655771CB623
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHRgN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 13:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHRgN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 13:36:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62162184D;
        Fri,  8 May 2020 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588959372;
        bh=hRqx7QnwUzVVyfLcYGbbO44yyAmWkryLH6lR1hltF6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mu1u/yVegzhbRrgAnzmV32ElFBUzj2NSItbfkVO2f9Ki1cUZQTMkEUKZZAgWmR+Kg
         +2eiaX7rpB6B4k3uA03vmodvLsut3XtiiQR9OL3do7l4y6OPW+ce1wJ/G8WNKb2xhA
         C7uZYhwGSvnY9hPevB4wauPpaO/FRKrZH3sAnTFw=
Date:   Fri, 8 May 2020 18:36:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] spi: dw: Add generic DW DMA controller support
Message-ID: <20200508173609.GQ4820@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cxMSjUqMQBJIqbX5"
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cxMSjUqMQBJIqbX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2020 at 04:29:25PM +0300, Serge Semin wrote:
> Baikal-T1 SoC provides DW DMA controller to perform low-speed peripherals
> Mem-to-Dev and Dev-to-Mem transaction. This is also applicable to the DW
> APB SSI devices embedded into the SoC. Currently this type DMA device is

This basically all looks good to me (without any hardware specific
knowledge), I had a few comments but they were mostly procedural ones -
mainly getting these bug fixes you've done merged as such.  Nice work.

--cxMSjUqMQBJIqbX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61mIkACgkQJNaLcl1U
h9A+eQf/aX/eJQKNbtRlg1YQiR0kNEKfYb0h+4IxTWaR0D4O8huNg6Q6+5WvT2Yj
7mOeCIXspsfBGeaio/QMq7wEfJuA0WixGuipF+a6+fR+g46A4J33V0PlxawdRktx
IaTWop1c75yO+k2WMmIcKxl2njtyhCDrPqWPan1ZyNs/EdP9Yzjb9xjuj28ZbOB5
+Too1aZWhzYiRx0UI8wfgC7msBilLvcxmHd0jmSnnBE1nsgPZE1cPme0khU+trXt
XyNzPrOcMrqTJAKwkeU1ZQuYvvn07DMp+FzhjkYSfzrdC+luQwFLo6W0R0CK0aep
dv7bvZv/ilTh26Ht3/pAJFJ03kdlww==
=34XW
-----END PGP SIGNATURE-----

--cxMSjUqMQBJIqbX5--
