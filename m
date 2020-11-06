Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F522A94F2
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 12:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgKFLBI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Nov 2020 06:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgKFLBH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Nov 2020 06:01:07 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADB6B2072E;
        Fri,  6 Nov 2020 11:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604660466;
        bh=kKi/yiZAgnA1BiE1B40I9aILlNyDfD2Wha97DV0eknY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wTFe3827Eu3ZBo4ZNABSY8HHdpmJYvv5mWU+t88Tj2tNC46Xr/ieMD6CYl8HaEY1V
         ctctl0b23cXnyt/MI+DMadJnnK9utHFutln0rtxg2RNuLXQpWxKE/Tqhpd4+eNY4y2
         wSyZJd0tD+0+nS+0YCFK1EebR/LHw0SHzm96ni0U=
Date:   Fri, 6 Nov 2020 11:00:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] SPI fixes for v5.10-rc2
Message-ID: <20201106110053.GA5532@sirena.org.uk>
References: <20201105164607.AD20021734@mail.kernel.org>
 <20201106101815.GA1403068@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20201106101815.GA1403068@ubuntu-m3-large-x86>
X-Cookie: Allow 6 to 8 weeks for delivery.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 03:18:15AM -0700, Nathan Chancellor wrote:
> On Thu, Nov 05, 2020 at 04:45:46PM +0000, Mark Brown wrote:

> > Martin Hundeb=F8ll (1):
> >       spi: bcm2835: fix gpio cs level inversion

> Why did this go in with two outstanding reports?

> It looks like there is a fix for it now:

> https://lore.kernel.org/linux-spi/20201105090615.620315-1-martin@geanix.c=
om/

> Although I guess it is going to require a resend...

Erk, sorry - I remembered the issue being fixed but got confused and
thought that it was an incremental patch on top of something applied
rather than something that got fixed in a patch revision (got it
confused with another issue I think).  The incremental fix is queued
now, I should send it out later today.

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+lLOQACgkQJNaLcl1U
h9C16Qf8DO4L2yXoumesDVQVM3WZobrBRz/AXEiIaBFptIwKotpR30ESrdpzGXMp
4m3j9NL5/cNqTAVZCGXkBf/w20ZFaubfgIf2eAAiES6pn1j5UkluaiWvzGg4Jkgf
ZENe9XH80r8pZDkSUnMaItELUjb1GqTUlHFi09KkZFpThh4YWSsDxFopS+w41OBm
bjTjcvWImEBvL5a+/r14Kdw3L2x+xbaVtaKP4cf4XS2DasiLuaIodQe7ICRV4RVi
tnZJANpORa1b7RDLLLwSkZ1kGd7WzaJsxcO4gAcJ+SAQi+FqEEzis7JXwYNPzTiT
BehLp3FwLwjWFl9NPNpPTMHmKFKfPw==
=cbOM
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
