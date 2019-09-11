Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A07AFB55
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 13:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfIKLZZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 07:25:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59162 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKLZZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 07:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3Df3eterHPko1fJYtCg62V5UY5JvoWScy0tz5L4pK9g=; b=iNWdZLA05cpWDoUSgBNY1yvqz
        CQnX1lVpU0q2wCqO/Bddag4y0imQt9JPHtRpwK6rhS5UUQJeXZ52VNBrNDMmVEJzmGi90y72WtsxR
        0Anf8svj27r4zW5IwJ9VPgtbCNaFXCDF6DYdxZuJrVgASfNP0cPsZJrwZxrsjuxw3l6Zg=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i80kV-000082-53; Wed, 11 Sep 2019 11:25:23 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 7D56BD00486; Wed, 11 Sep 2019 12:25:22 +0100 (BST)
Date:   Wed, 11 Sep 2019 12:25:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 04/10] spi: bcm2835: Work around DONE bit erratum
Message-ID: <20190911112522.GD2036@sirena.org.uk>
References: <cover.1568187525.git.lukas@wunner.de>
 <7ceb98f154cdcf72c577615fa312df41adea5f47.1568187525.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qXCixuLMVvZDruUh"
Content-Disposition: inline
In-Reply-To: <7ceb98f154cdcf72c577615fa312df41adea5f47.1568187525.git.lukas@wunner.de>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qXCixuLMVvZDruUh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 12:15:30PM +0200, Lukas Wunner wrote:
> Commit 3bd7f6589f67 ("spi: bcm2835: Overcome sglist entry length
> limitation") amended the BCM2835 SPI driver with support for DMA
> transfers whose buffers are not aligned to 4 bytes and require more than
> one sglist entry.

You said in the cover letter that this was at the start of the
series but it's actually patch 4 (or patch 3 in terms of the
order they were sent), and in any case it was already applied so
I'm not clear why you're resending it.  If there's any difference
=66rom the previous version please send an incremental fix for it
instead.

The entire series has arrived but it looks like this in my inbox:

    749 r T 09/11 Lukas Wunner    (1.6K) [PATCH v2 00/10] Speed up SPI simp=
lex t
    750 N T 09/11 Lukas Wunner    (4.0K) =E2=94=9C=E2=94=80>[PATCH v2 05/10=
] spi: bcm2835: Drop
    751 N T 09/11 Lukas Wunner    (3.5K) =E2=94=9C=E2=94=80>[PATCH v2 09/10=
] dmaengine: bcm2835:
    752 N T 09/11 Lukas Wunner    (3.6K) =E2=94=9C=E2=94=80>[PATCH v2 04/10=
] spi: bcm2835: Work
    753 N T 09/11 Lukas Wunner    ( 17K) =E2=94=9C=E2=94=80>[PATCH v2 07/10=
] spi: bcm2835: Speed
    754 N T 09/11 Lukas Wunner    (5.2K) =E2=94=9C=E2=94=80>[PATCH v2 06/10=
] spi: bcm2835: Cache
    755 N T 09/11 Lukas Wunner    (2.1K) =E2=94=9C=E2=94=80>[PATCH v2 02/10=
] dmaengine: bcm2835:
    756 N T 09/11 Lukas Wunner    (1.3K) =E2=94=9C=E2=94=80>[PATCH v2 01/10=
] dmaengine: bcm2835:
    757 N T 09/11 Lukas Wunner    (2.6K) =E2=94=9C=E2=94=80>[PATCH v2 03/10=
] spi: Guarantee cach
    758 N T 09/11 Lukas Wunner    (1.1K) =E2=94=9C=E2=94=80>[PATCH v2 08/10=
] dmaengine: bcm2835:
    759 N T 09/11 Lukas Wunner    (8.6K) =E2=94=94=E2=94=80>[PATCH v2 10/10=
] spi: bcm2835: Speed

which is really not good, the random ordering you're using when
you send things means that it's a hassle to even figure out that
I've got the entire series.  Please look into what you're doing
here, other people's patch serieses don't have this problem so
there must be something unusual with your tooling.

--qXCixuLMVvZDruUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl142aEACgkQJNaLcl1U
h9DfPAf+OYtqXMV5gYBzU4XTKR08XD1PV2nI4GT7e675+/MifpQk2bPDDqVQYYQw
lysfjslqQAmGX8aHnoyaPPIyiGkT1aCUG7j8DdqgWPdXPRoGWNnknhVc7Lwko5+v
9nOxr3Zft3KmhKr50btHGengwyNJNlZlhvEi4nSmwKYyJLR8+nK3HmvIHew+yABM
DppyiPrwx7Q4JNKYPj3zS8rz8vUUp0mUpdYv2e377jLilQYuhlvvP8DfADc52zhN
S0dXlGpjChPSBfzK/nM8mP+l8txFax/ERE/g7w9APK1gAJ/HUhniJp13Q1PFTNF3
AWYr1YSUDj94ktqrczb+BgyDd4YrrA==
=h6tk
-----END PGP SIGNATURE-----

--qXCixuLMVvZDruUh--
