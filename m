Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34D91E8B38
	for <lists+linux-spi@lfdr.de>; Sat, 30 May 2020 00:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgE2WV1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 18:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgE2WV1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 18:21:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 062EF207BC;
        Fri, 29 May 2020 22:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590790886;
        bh=zE5uzU19m0pvatj8qRKWQ+L08cB/4C39ZAFzJ3Diqsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ldh74xr8kkWapRAhdxnXhUPsuF9FvG8ez3ETTiwYPCUVQDMLJAT77UKBLRxprRQ47
         2gBG/lN5yXmkoNW5f+ya+so1mURUGt2zy5z3FMUm4/6rJ4DibFFKHDi0B5D60V03Di
         LSobglpxU6tQTq9N7xhsW9kSLZfiQFd9R0gGwPUs=
Date:   Fri, 29 May 2020 23:21:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Feng Tang <feng.tang@intel.com>, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-mips@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Subject: Re: [PATCH v6 00/16] spi: dw: Add generic DW DMA controller support
Message-ID: <20200529222123.GY4610@sirena.org.uk>
References: <20200529131205.31838-1-Sergey.Semin@baikalelectronics.ru>
 <159077271266.17043.13820488074564153429.b4-ty@kernel.org>
 <20200529172642.hcnvyzv2ocizsvpy@mobilestation>
 <20200529173325.GR4610@sirena.org.uk>
 <20200529212226.GA2984630@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rmLdANEyqdgxlbgR"
Content-Disposition: inline
In-Reply-To: <20200529212226.GA2984630@bogus>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--rmLdANEyqdgxlbgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 03:22:26PM -0600, Rob Herring wrote:
> On Fri, May 29, 2020 at 06:33:25PM +0100, Mark Brown wrote:

> > Please rebase.  TBH I'd not noticed Rob's review so I just left it
> > waiting for that, there's such a huge backlog there it didn't occur to
> > me that it might've been reviewed.

> Hey, I'm down to about 10 patches now. I think I'll take the rest of the=
=20
> week off.

Ah, nice!  Good to hear.

--rmLdANEyqdgxlbgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RiuIACgkQJNaLcl1U
h9C7jQf/Z57Kv84+ztnhLNAI5UvT9dlc2garmNuUnhFRMmS2uGo6K7Sto4+dKXMx
hhpKWExsonrfYf2D83mobBJy7EtkndH6mtOP5y/CnC1uqm6jr+hyxnQKPinO50qQ
iJwnMBEFLYbkTJcwpNOrHBaDcKnYglmyq6LH/hYesNq1jhm5lX2dEx49377wYbQC
SD+TshbPGYnjyuBJBVVfY8cFXkkS8EuhJ3jcD/gqUF24kQOn4bnbrV8KRMkvQK/Q
KpLxgM+tVhjFFNLLLSgFrqzon4rLmEevuIoXBnT9e+CyidB5+cg6ZHHkVesW+Xdz
1mBSz3GO8QILfpuXAnZ+cQhS1/Yaxw==
=Fa2c
-----END PGP SIGNATURE-----

--rmLdANEyqdgxlbgR--
