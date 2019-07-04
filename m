Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B855F773
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2019 13:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfGDLto (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jul 2019 07:49:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60732 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfGDLto (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jul 2019 07:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gyCs/nA5eKBN9nIxIZxciZu6wf47aLszN/2CVvW3ASA=; b=v/D7JWrVzCjax5ynTEho8BdpN
        O8UkyS0eKK7edyvD6uEz17IUpUa+OpnHeIZGfho5Yis65r6ZYaN4d4JVMozSszrB6k3HCPGlLVbqB
        gadGw3VgFx/tWuDfuCfsbMDUQCbjXXVHLiX3aNUerKFqN0sMiitTArKXCde51rSawSJQU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hj0FC-0000fR-Ff; Thu, 04 Jul 2019 11:49:42 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E29D72742D99; Thu,  4 Jul 2019 12:49:41 +0100 (BST)
Date:   Thu, 4 Jul 2019 12:49:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] Revert "spi: gpio: Don't request CS GPIO in DT use-case"
Message-ID: <20190704114941.GA4513@sirena.org.uk>
References: <20190701172517.31641-1-linus.walleij@linaro.org>
 <CACRpkdaUTvMJ3tbuA7moyLjn_+6QbfJwm3UhLxA1-nh+A5y_KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <CACRpkdaUTvMJ3tbuA7moyLjn_+6QbfJwm3UhLxA1-nh+A5y_KA@mail.gmail.com>
X-Cookie: The revolution will not be televised.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2019 at 09:00:17AM +0200, Linus Walleij wrote:
> Hi Mark,
>=20
> the proper fix is now upstream in Torvald's tree so you can drop/revert
> this patch.

Great, thanks.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0d59UACgkQJNaLcl1U
h9DVGggAhOf9BX6fiO/I7j3sJPMmbRatr3ZmJg7CKL/9D7fuOd2QXAM/+ngmNuI2
qKPLnNgSx/1QloSgMAdHHjnLruQPJJP7to6FiloKl40m67oygmHAznr+cWLlzDbk
O4jPVV4sS/bmCBSxI3VCgVtVZXqojRQNkEulxyjo5AJDq9+Kt3rtbX2IOAijYHn2
FsumJhxGNH1/5+4yaSmZG7E+f3TZ+CNwNi9ExnEqLnr3onAP9HeKp//3N3DQlbrh
2/YGs9MGibxgbGvxk6l8T5ndMAOGhpjmFsHFu58qgv2JFWmK+0+Liw9EJ0eoFWyE
X8+UYvov4FpZSvNOUZBVaKEv5eYjqw==
=j8Jp
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
