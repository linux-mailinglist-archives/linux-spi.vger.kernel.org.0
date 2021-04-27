Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E38436C4AD
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhD0LNt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 07:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhD0LNs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Apr 2021 07:13:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D011F613E2;
        Tue, 27 Apr 2021 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619521985;
        bh=kp054zVcx7NkBNagP5MDckKe6a4zIhkTdKkBdOoYciE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQCAmOe8ncoo+RW6WRY3kGrKZ1k4g2J3rZcwZ9YeqPAVF+JKNjcEkcgZnx7vkun75
         aMN4aeDec+uaaGpDqAjvxkD82lEmf/9Cc+MwwCLhidwyAp31eEvNjxwI5XahTGCmhm
         NjVwmmdMOxRD/iVJws9Kh+JbaiXdo5nMD2lv4yZBruHnQPNIJuGB1hRsI/0a1TR010
         fUw8jZefvS08Usy9y/BBR7ipXEpBV3bwXn4ByUtQg5gRJbub3jEtiqM/SsoTwCH7PC
         7OrsE5k/FW8EBXtPVS2bTfLgPw69mySEtxjnWnOkX7bh47g8Yqk2bUZyeWd20C9IN2
         gJCjIR5NJtKqw==
Date:   Tue, 27 Apr 2021 12:12:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] spi: imx: add a check for speed_hz before
 calculating the clock
Message-ID: <20210427111233.GD4605@sirena.org.uk>
References: <AM6PR04MB56233BE0FFF7E5D80527B54CF3419@AM6PR04MB5623.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Content-Disposition: inline
In-Reply-To: <AM6PR04MB56233BE0FFF7E5D80527B54CF3419@AM6PR04MB5623.eurprd04.prod.outlook.com>
X-Cookie: Don't feed the bats tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 27, 2021 at 08:33:06AM +0000, Clark Wang wrote:

> However, I notice that you have applied this patch to the next branch?
> Will you revert this patch?

Well, it's redundant but not harmful.

> I think you may want to apply this patch I sent before.
>=20
> Author: Clark Wang <xiaoning.wang@nxp.com>
> Date:   Mon Dec 14 17:05:04 2020 +0800
>=20
>     spi: imx: add 16/32 bits per word support for slave mode
>    =20
>     Enable 16/32 bits per word support for spi-imx slave mode.
>     It only support 8 bits per word in slave mode before.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCH8aAACgkQJNaLcl1U
h9DH8Af9E4sVktmInWgPheZd4RZloM2pfJ2Zzgcn7TY9IytpznxzCbbXcZx0VFgi
ixHVQzjH9FIrhindvTxRL2wuT7ZouOSMkHzd3zmCbOhvrrMkNtPzcEBncJdNU83e
JtrY2lGj/OeCkwkGOh7kGWDWKByplQBznh6vO1oWcRC4r45q9z3dnFtWaCLqiy6r
gxeCbhVYb+xTWCjvsSM4ps+dCu5gqoJVusI43CxTRKoN5Hwgx91seg/ixxLZGE0r
dlulVUBJBfrRxsn6OyvPq4aJUWgyH1G2MmJMFhS/HmwoQY43pSzR35+HDN4SHSEE
SjdxL3uCokOuz8UPseMbF8kfStQxwA==
=9qYK
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
