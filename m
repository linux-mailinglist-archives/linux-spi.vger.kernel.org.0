Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011845CE8A
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 13:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfGBLjR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 07:39:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37424 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGBLjQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 07:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OeJyqZ8O/b4tWngv95TUiGJZxl/uPYdbUSFGHdi/V4Y=; b=r6qbrkotRli6CCdMTc4PJDu/R
        N+PWemevshPuumpXsa92QB0bx3BJHM0rhcgN9pGIicuVmYthFaEHEs9x/6aZ5Hu9mibRGvckxu4xe
        CP4CeT6Z9YbaKcSHFIDUwbfys304sWCuxz3RuBnRJyt2NDSs1dMtumQ86vQMyQ+8ZB1X4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiH7y-0002A2-NS; Tue, 02 Jul 2019 11:39:14 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 37C59440046; Tue,  2 Jul 2019 12:39:14 +0100 (BST)
Date:   Tue, 2 Jul 2019 12:39:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] Revert "spi: gpio: Don't request CS GPIO in DT use-case"
Message-ID: <20190702113914.GH2793@sirena.org.uk>
References: <20190701172517.31641-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q6STzHxy03qt/hK9"
Content-Disposition: inline
In-Reply-To: <20190701172517.31641-1-linus.walleij@linaro.org>
X-Cookie: This sentence no verb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Q6STzHxy03qt/hK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2019 at 07:25:17PM +0200, Linus Walleij wrote:
> This reverts commit 249e2632dcd0509b8f8f296f5aabf4d48dfd6da8.
>=20
> After this commit drivers/net/dsa/vitesse-vsc73xx.c stopped
> working. Apparently CS is not working because the reads
> from the device is just returning just 1:s or just 0:s at
> all bisection points, so it is a complete regression and
> I think spi-gpio CS is essentially broken.

Also I'm a bit concerned that nobody else noticed this - do we=20
have any understanding of what the actual problem is?

--Q6STzHxy03qt/hK9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bQmEACgkQJNaLcl1U
h9B8tgf/RFfUD38JqkGTi/tovSYpfEFpHAGBmPmbw1/4jEgn0K4R1Xt8wQqpgB7i
Xz6O7pA3tLmvC9XwmjIYRW+7Z9EJSpGTlxxTPPtVMtANGsv2HjpQtilWIvHCu3MU
Ri/EhBIOtUlho1ip2Tth2L/6EKuZ3nOFs+IsvFyhCdd9dMYzAmTFZzhKfH/SCgL+
O4+jPIdhhbTOA8dWUFa4fCKWKg02LsNQzVd39QfP4tLiNKfoct55MtWHQxRGEK81
X0S3z5WGzqJ7dW8dv7A+h4hXK5dA9LpIaF7zO/wzmI7X/hUMm55hASJ7rZvt5gji
1UufUHem/CRkM4DEFgn1UZOWTe+nRg==
=oCm/
-----END PGP SIGNATURE-----

--Q6STzHxy03qt/hK9--
