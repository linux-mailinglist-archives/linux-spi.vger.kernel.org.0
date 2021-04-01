Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4D33519EF
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 20:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhDAR5C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 13:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235304AbhDARw7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Apr 2021 13:52:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4694160BD3;
        Thu,  1 Apr 2021 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617286421;
        bh=+wXPixi0fZQhbgz0Af17sNTonL00PbC+xrFzRa/JnjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4vm1k3Ek5jAd4sggNicGQCzz0W+Oj2XwkJsxB9gjTd2wD/J45we94vgwS8ruaMxU
         5qdCtV9bd1pOTO6EyTcjMo09Ry+SipcQlsr1xpiWIzjHPBix9bRTGpS2NtYlpTx8/m
         KZMc8e/C4hdl1qgamRyxHD6Iw5O737WXjiSTcmDTChXw5pV6217OsoyPbyGp97oBzp
         Wl5j+LNZvylapBX0Rkjd0YqioJa2sqo8XMFF3zfWsQ3N9GhUW1Iw4EnQAdcUsj/kkR
         9cBNh5vCPQTZByHMG8t1IN3zhQy6P1wPhOuz0aiBIOSCv0LJsAS6V/vXsz5cazo+o4
         kAJ+BMpUphB2Q==
Date:   Thu, 1 Apr 2021 15:13:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 4/4] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20210401141328.GH4758@sirena.org.uk>
References: <20210331193930.tzsvbjup3wpxmh26@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Content-Disposition: inline
In-Reply-To: <20210331193930.tzsvbjup3wpxmh26@ti.com>
X-Cookie: You can't take damsel here now.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2021 at 01:09:32AM +0530, Pratyush Yadav wrote:

> I did take a look by running git log on=20
> Documentation/devicetree/bindings/spi/ and there is no single style=20
> being used. Using "dt-bindings: spi:" is a popular choice. Some other=20
> commits just use "spi:". And then some use "spi: dt-bindings:". The last=
=20
> commit to touch cadence-quadspi.txt (fcebca39938f) used the prefix=20
> "dt-bindings: spi:".

Yes, lots of people pick unfortunate subject lines for DT patches - that
doesn't mean it's good.  I'm looking to see spi: same as for all other
SPI patches.

> So on the prefix front I think the subject is good enough. Of course, if=
=20
> you have any other preference then it can be re-worded but let's first=20
> be clear on what the expectation is. And then let's make sure to apply=20
> it to all future patches uniformly. This way future contributors won't=20
> have to take a guess on what the expected prefix is.

I do edit some percentage of patches, but some do slip through for
various reasons.  There's also some things that just get completely
missed, especially if there isn't also a code patch nearby.

> Apart from the prefix is there anything else to improve? IMHO the=20
> subject is good enough but I'm open to suggestions.

There was the thing with constraints.

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBl1QcACgkQJNaLcl1U
h9CWgwf/Sdw0YaskIA8e6qr7BHlJiZql3DhSyt1wcWgbNN2qbSSrhLyvlhbImcbl
1r5g9Qa7X78tWxcmO3PEzfNW7dSM/PAzihAkubVvbgcQZvjf1FI5RIEtYoPBe4G7
xcUJJppGIDRvz1+gMBIra6+Fokk93C0LJL+fyu1fuCOQ6jiH+sYA7ZCTG+/QeHFJ
u9d0mdjPNRO1IRLitbSLH8rBjEmYliQtoOT/vEgtLpvLSOVcWk2/9okveu+dElQ7
96tU6YSMWlJNagBKbJja8lqXpvwdeja42aTEodtJs3Ru/RNQEYV/E4BXttWCwKfN
Cqpi11mjqlq+FU+qBNTpgVb3hTbEvg==
=XkPv
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--
