Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FD51D4DA6
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 14:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEOM1T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 08:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgEOM1T (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 08:27:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6C7120709;
        Fri, 15 May 2020 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589545638;
        bh=rTEWsgn+qCr9lplWq/BIcCkxBpW4/f/dy/uL3g7unUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZ0XzhL8p2NCTGctGWmwun3ymZUbYbHsmiHdqyr+OephbMGINv4Y1JTRz+Pjitf+w
         ecLlzSyDe1U0XP417i1aTXtOoZNX/KiTdm0E4Q3mTw515OY9iFrMXlNc0YdvSwo6KW
         J6CUbDvzbUxWyFNkhJ7+7reIpysL3jofoF3UYIZg=
Date:   Fri, 15 May 2020 13:27:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-mips@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/19] dt-bindings: spi: dw: Add Tx/Rx DMA properties
Message-ID: <20200515122715.GC5066@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-2-Sergey.Semin@baikalelectronics.ru>
 <20200515115151.GU185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <20200515115151.GU185537@smile.fi.intel.com>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 02:51:51PM +0300, Andy Shevchenko wrote:
> On Fri, May 15, 2020 at 01:47:40PM +0300, Serge Semin wrote:

> > Since commit 22d48ad7bfac ("spi: dw: Add Elkhart Lake PSE DMA support")
> > the spi-dw-mid.c module supports a platform DMA engine handling the DW APB
> > SSI controller requests. Lets alter the DW SPI bindings file to accept the
> > Rx and Tx DMA line specifiers.

> I'm wondering if these properties are implied by the SPI generic one?
> (forgive me if I'm not understanding all DT schema relations)

Which SPI generic DMA bindings are you thinking of here?  There aren't
any in spi-controller.yaml.

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+iqMACgkQJNaLcl1U
h9Dp6gf9E0FZAmLIwqiCItWiZVEDddJB64GzjCuY0mIub+iSPJjn2/MqY4VDU97d
SZQ/QA9pVDqJLIoHwykq2AI/M/q7B3l7cuWV12Y+eDyhAFxSVeHNqt1CBWwRgeId
3fRq6p2ujk7Xv9rlwU7MVgGh0ybueBHu5Rin1SsWahRrrzNmeZOJWAP3bsY5BFcc
GajMzUnq4e3KqeW6Rr8eraFh8RCRqFmmHhaujzhQ57LnG9dVelnU8IicNL5i0so4
z5c802PN//YIL8vKe+NyoPvbzvE3qTBrKZVU5GnAZjoGP/6dMSDeEgtkYkLvimOR
D0F1/FR4iWhIOyr2DDqp69yBEb+taA==
=j+6g
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
