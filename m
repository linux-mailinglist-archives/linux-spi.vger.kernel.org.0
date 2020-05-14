Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244091D3090
	for <lists+linux-spi@lfdr.de>; Thu, 14 May 2020 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgENNDS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 May 2020 09:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENNDR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 May 2020 09:03:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECB7C20727;
        Thu, 14 May 2020 13:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589461396;
        bh=HWqK1vI6OeX/1/VBHbpjutL9JM9eqNWuPbHXffjYxis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OKuxprWtoEF6XGEz0RbupaAPXn45JEyfndEQ+ZcvMu2WGttpQ/NEjLorTXTCEN1XH
         ycJEdYW2yNOEeOHTuLgKSR32hkraSY/hpSuhzfVGFm63XbWohsPev+YiiAsbEJRial
         zTHbQ/wEnwy8bOqB1xicDaLNnMy4lsYhdKKSlA/s=
Date:   Thu, 14 May 2020 14:03:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/17] spi: dw: Fix native CS being unset
Message-ID: <20200514130313.GF5127@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-12-Sergey.Semin@baikalelectronics.ru>
 <CACRpkdY=wkgnYPcqSzyzNpS6ckJZs-9kXfTfdwa1E+POzOBQGA@mail.gmail.com>
 <20200513001347.dyt357erev7vzy3l@mobilestation>
 <CACRpkdZTH1DNHvi4r48nLNWp4rqyYDZTzT12hw0eTNcYmgSr3Q@mail.gmail.com>
 <20200514115558.e6cqnuxqyqkysfn7@mobilestation>
 <20200514122214.GC185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline
In-Reply-To: <20200514122214.GC185537@smile.fi.intel.com>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2020 at 03:22:14PM +0300, Andy Shevchenko wrote:
> On Thu, May 14, 2020 at 02:55:58PM +0300, Serge Semin wrote:

> > BTW I experience a problem with vger.kernel.org. For some reason a few =
days ago
> > it started bouncing my emails back sent to the GPIO/MIPS/SPI/kernel mai=
ling lists.
> > I've sent multiple backward messages to the postmaster (postmaster (dog=
) vger.kernel.org)
> > with the bounce text, but still with no response. Could you tell me who=
 should I
> > bother with this problem to get a help with its solution?=20

> Perhaps, helpdesk@kernel.org ?

vger is completely separate to kernel.org in terms of admin.  Usually
the bounce messages from vger say why things are being bounced, there's
a good chance that either mail to you is bouncing and Dave got annoyed
with you and is trying to get your attention or something you're doing
is looking like spam.

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl69QZEACgkQJNaLcl1U
h9D5ogf8C/EiMwHRshlZKNdpalnGbvOPBxX0ET1v6V4dI5JSovu/AskZxYHMNGfr
/wyCAAbJ8AjzQ8cCpizZ+KAAuhx5M3S9rr9FL+LcgofPLhGEoAMEQ4E6DuEnoy+h
kD7lq7uJi4dzeTZUw4yG6jXrYl9AOi1k/RWa4GEZ2lMT2g25I/BVC16ObwEwpc0O
281O7BEtXO4yEEHqLzFaAeK/eF3lu0wmc62ag98FCdXNuDyDHArKDnAZ+5Qi4R5x
HmErKYNlmJiFtKm+DgTuQA/a8aO52O6MX4k1dRLLplm5pFP0FcMa5+X5l0ZXbLgy
jz69X4t+H5PoqOBIXt1J9d6RJJrtfw==
=Cprm
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
