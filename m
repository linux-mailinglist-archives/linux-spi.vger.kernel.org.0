Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106F7356AC2
	for <lists+linux-spi@lfdr.de>; Wed,  7 Apr 2021 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbhDGLDV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Apr 2021 07:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234304AbhDGLDU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 7 Apr 2021 07:03:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CB6761362;
        Wed,  7 Apr 2021 11:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617793390;
        bh=82+Ke67nXsRlgfDXibtCLxr7nc+kcU4a1nvx8D2L2+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+RJXx9pSY7CwHT75bRn1ZZDjp2CAlTyguo1aTk/zHpIcVNgL/yKQqzM0ZNnAo0zf
         pQ2zEL8Zpzhbvo98SMmCSUvXRdmcq4EW+QJBirP4N9a1MyMuWa+jIlBQ5aPwif6ZO8
         Zx6u2IvDLpF1LImb9ywSru9x+FWMhk+soVRyWk6+8iPuqHbGOydzg2c/G77Ao4ZIlw
         S7ReG22w2KhqVI/AnrMjv/LkUNBz0BbDEk15MabKmfBJANkg8bkGlMX8Py9rlFUu0J
         r7/roXvRC0oHxk8PT5va2+zQzqC3Obo7BSp/ZddiecAyadFL1kK5mTsD5og5ZCn0qV
         a/sfq6fApXqNA==
Date:   Wed, 7 Apr 2021 12:02:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 6/6] spi: davinci: Simplify using
 devm_clk_get_enabled()
Message-ID: <20210407110253.GA5510@sirena.org.uk>
References: <20210330181755.204339-1-u.kleine-koenig@pengutronix.de>
 <20210330181755.204339-7-u.kleine-koenig@pengutronix.de>
 <20210331120212.GB4758@sirena.org.uk>
 <20210406065727.i7wbve2ihdblq24p@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20210406065727.i7wbve2ihdblq24p@pengutronix.de>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 08:57:27AM +0200, Uwe Kleine-K=F6nig wrote:

> Thanks. I wonder what you think about this series. Is it more "Well, ok,
> if you must, the change you did to this spi driver looks correct." or
> "This is a good simplification and a similar change for nearly all other
> spi drivers that make use of a clk is possible, too. Dear clk
> maintainers, please go forward and apply this useful series."?

Well, I know there's demand for devm enables of things and for some
simpler drivers it is actually the pattern people use but I find it hard
to get enthusiastic about the pattern, it really only works for the
extremely simple case where things get turned on in probe and never
touched afterwards.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBtkVwACgkQJNaLcl1U
h9DdHwf/WKEDiEh2ExvwazfUB4lex7AIBRchBXYShrFk7ZQ6N49VDccVSsSGOBBM
UpbO8P6ltky3EJZSA5KGZ+SkctHpUEJcuuBFhhkEEOME0EO0VxXoM/0rf7MA4K7i
Y11vAnsL/M+YYpmCcLRZB2V915ZOL59hv2yPwKw38ktgHUxuiQwBOxTyf1gfDM/v
rwcpZ/TEre9hRIzyqCnYZ4kk4HHOyz/idHpTvjeHR3h5/fZyKMpqcEiNqL2wjRtV
DR9RPUgyD5p9ni35jSrSUiU3CIgCRfJGmILQ5HOv3SEz4b5UWWUvyjLlomv3V2lN
O2v8nNMxL+An9Ofp57Tv6vWZSPGZdQ==
=e1qz
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
