Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533A644BE8
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2019 21:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfFMTOk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Jun 2019 15:14:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52008 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfFMTOk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Jun 2019 15:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XusiFTXNYQTgic9TVHl9vDobQTLjL/8WBaiJ9jHmCUY=; b=Jt3+wogChSwIBpsEwq/iDzoKv
        UGb+V9EAy3x9o4QtWBFBYxZ1lzCA+zR8vcoMGFNFWfnLFb3c6DUQNS0IRCjnaOkRhbKrpd+xG1MwB
        DzR+rXkwR9uyYk3Zju8wvpoEdyoTavBewahwpXVKwnkv6P84t5Zbmdaa46Do5g6tsWFqI=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hbVBE-0005UD-40; Thu, 13 Jun 2019 19:14:36 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 8E4B4440046; Thu, 13 Jun 2019 20:14:35 +0100 (BST)
Date:   Thu, 13 Jun 2019 20:14:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-spi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] spi/acpi: enumerate all SPI slaves in the namespace
Message-ID: <20190613191435.GY5316@sirena.org.uk>
References: <20190530111634.32209-1-ard.biesheuvel@linaro.org>
 <20190603110832.GA2781@lahna.fi.intel.com>
 <CAKv+Gu8rTernjct93rsWo0X3FTp6bsV=0JvNGQr8C8OaqB1S7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3IWFuR7/O9KKcN6"
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8rTernjct93rsWo0X3FTp6bsV=0JvNGQr8C8OaqB1S7A@mail.gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--g3IWFuR7/O9KKcN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 05:56:00PM +0200, Ard Biesheuvel wrote:
> On Mon, 3 Jun 2019 at 13:08, Mika Westerberg
> > On Thu, May 30, 2019 at 01:16:34PM +0200, Ard Biesheuvel wrote:

> > > -     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> > > +     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,

> > Would it be simpler to differentiate here between Apple and non-Apple
> > systems? Then we don't need all that special code and the above becomes:

> >         depth = x86_apple_system ? 1 : SPI_ACPI_ENUMERATE_MAX_DEPTH;
> >         status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, depth,
> >         ..

> > Probably requires a comment explaining why we do it like that, though.

> Yes, but note that both the root and the depth are different in this case.

> I'll play around with this idea, to see if it simplifies things.

Given that this works and got some testing I've applied this now, if
there's a simplification it can always be done incrementally.

--g3IWFuR7/O9KKcN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0CoJoACgkQJNaLcl1U
h9CsSgf/ct5qv0UqPxaWfJKOm8GT3NBa0M/seyJphcRzfO/WQrlDOz8HC4iGV6AE
v3NZWqcmzuQPtu477cXwOc5NqHqzUVHOOrWk+D7Pe5/urIS37xh8wSeY9mINlwim
YZzzpPQCXVEcO8GeijfooBSsSSpuuCq6EmOowOLuO58WlY1yx0h9BvgCwWWO0Dlx
B76uCITIixiZRoWME5PuucBDTMjFp7RrtCNvVt6xjBFHCrFEIC7UKCK931AbicTM
G2tXuMYjxteIWeZ4jYLDHGu/OFzQg7bTOcdQrhU8sybBsdek+FhBYdVTukS55Hxd
MMfuw861PELtqd3OW7oxpUQpQ/AcMg==
=Gd1/
-----END PGP SIGNATURE-----

--g3IWFuR7/O9KKcN6--
