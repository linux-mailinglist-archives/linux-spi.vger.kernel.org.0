Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0223749EB7
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 12:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfFRK5Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 06:57:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43816 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729507AbfFRK5Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 06:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/0kawDnoeabspFEl713X3TUBuCDeHdIFLsXY3POkLkg=; b=smSqlhv8dMwSpWXRVEiU1Zf+Q
        5nrblfre9S7973KPusIG7rqnEz+Q5bqXWa7JKtmtnoH/XkCqkavG1sYkTzJvhnWx2L5XMZ7IHWjOn
        atTMLkdNNogZuWLiTX8deYiH/qJvvX65n4u6Wh2mOVKXNpGMFK/QLRUvRHZOrS42O4mbU=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdBnf-0004vp-Ev; Tue, 18 Jun 2019 10:57:15 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id C399E440046; Tue, 18 Jun 2019 11:57:14 +0100 (BST)
Date:   Tue, 18 Jun 2019 11:57:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Jaswinder Singh <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] spi: Kconfig: spi-synquacer: Added ARM and ARM64
 dependence
Message-ID: <20190618105714.GL5316@sirena.org.uk>
References: <20190617060957.16171-1-masahisa.kojima@linaro.org>
 <20190617101741.GK5316@sirena.org.uk>
 <CAKv+Gu-DYzRRG82t27nFZKeLOPzCYphY=AQCQy78=m591rXs_A@mail.gmail.com>
 <20190617114630.GO5316@sirena.org.uk>
 <CADQ0-X_1kNChYr_vvOiafghk8h1AcERaGYWjo61ATLXy0_f_UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkljSoo+ux+fbUAa"
Content-Disposition: inline
In-Reply-To: <CADQ0-X_1kNChYr_vvOiafghk8h1AcERaGYWjo61ATLXy0_f_UA@mail.gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--vkljSoo+ux+fbUAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 05:13:57PM +0900, Masahisa Kojima wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> There was a patch to address same compile error.
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1982194.html
>=20
> Does it preferable solution to use iowrite32_rep() series?

If there's a patch that removes the need to have a hard dependency on
the particular architectures that'd definitely be better.  Separately a
patch adding a depends on the architectures with || COMPILE_TEST would
be OK though and potentially useful like Ard says.

--vkljSoo+ux+fbUAa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Iw4kACgkQJNaLcl1U
h9DWLAgAgm9rAWQwqO27ddJWYH1gYvHu+8Rbh6Cmk5vIxUrMQ+epc/he4WSVHGm0
HO5o1NOJHGKEVy/8StaeZ5qUlCPwcCDZBs76dpryksM+Mm2Sko+G/qO+kYWJK1Wn
FH06obFRgL4sP3XDwKtyJCSu6H0XUq3+coSO1l3GVsKwoUZvg5a9zEB34ISGzJoL
DrezYjpoKjFSioFeUxI6g7+qrseUS7GMboNxF1ijpEEt0SjEnEck8gFEPQUzZFSN
SSLUBiuMix+pLG8Q/TWOwOo4Kp6BucpqAICbUMSHTm6Vctzd6yug1vEBO9M56trl
xpkZZSanmUzcaXSpDgBEFU7u01LL5w==
=A4Sm
-----END PGP SIGNATURE-----

--vkljSoo+ux+fbUAa--
