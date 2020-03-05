Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162D417A632
	for <lists+linux-spi@lfdr.de>; Thu,  5 Mar 2020 14:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgCENQh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Mar 2020 08:16:37 -0500
Received: from foss.arm.com ([217.140.110.172]:48452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgCENQh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Mar 2020 08:16:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 531AE1FB;
        Thu,  5 Mar 2020 05:16:36 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAD263F6CF;
        Thu,  5 Mar 2020 05:16:35 -0800 (PST)
Date:   Thu, 5 Mar 2020 13:16:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Esben Haabendal <eha@deif.com>, angelo@sysam.it,
        andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>
Subject: Re: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times
 as necessary
Message-ID: <20200305131634.GD4046@sirena.org.uk>
References: <20200304220044.11193-1-olteanv@gmail.com>
 <20200304220044.11193-8-olteanv@gmail.com>
 <20200305121202.GB4046@sirena.org.uk>
 <CA+h21hq8c50AjuzgpxyPQDCFiAdezJuqgY0+u26qBRx9FnYnig@mail.gmail.com>
 <20200305130448.GC4046@sirena.org.uk>
 <CA+h21hrSe-jT_R9jCW1XA6aZ=vjMX=b7HLq3KJdfxi9OOFW5ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <CA+h21hrSe-jT_R9jCW1XA6aZ=vjMX=b7HLq3KJdfxi9OOFW5ag@mail.gmail.com>
X-Cookie: When among apes, one must play the ape.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2020 at 03:13:53PM +0200, Vladimir Oltean wrote:
> On Thu, 5 Mar 2020 at 15:04, Mark Brown <broonie@kernel.org> wrote:

> > That's mostly all true but it's still better to pull fixes like this (or
> > the patch limiting the size) forwards and not have to think if it's safe
> > to not apply them as a fix, it's less effort all round.

> So do you want me to do something about it now?

No, it's fine for now but please bear this in mind in future.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5g+7EACgkQJNaLcl1U
h9CuIgf8CPmhlqhfcee9Ci1AvSvSQ6xlsVV5/vgUDE46caYf+o0lvc3iJNPqnLvK
a0ZXaSs9mpkONPWpmXfsgk+BVbAb+4ykuipEHVp0G9py+KOxkzcXQRXiyjCGlqn/
PTGIhIq/gjJaN1CwSELFoL2MTNWWh64H+yCISBRIKMU6ttcKKpQ830LTWbdpTohP
Fgai52ynNFsOKA/JwfLrUcgjSNWXXSm+Bec2UcBWPWjrgYGkdQafoyjGCjfzSFL4
Ezrm3ye7do1VRFf/UJ6v02miFG4o+lEZv+FyVvCI/SWD2nu8m3yAVBdnWcZM5LVV
+E0vjsXEtwJu/XSCCQ2g2ao20+oveA==
=Ct73
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
