Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6B936851A
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhDVQn1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 12:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhDVQn1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Apr 2021 12:43:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A69D61421;
        Thu, 22 Apr 2021 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619109772;
        bh=VWYw7Sltah44/Ja+aYGG6HIokHXaqHuG1J2aj6+8UXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kkjlkA5BwtIFA0Y+oBUR75w0/8UGTUne77MWvBJ1Tp2WuttOhmmJB/TBJZAixXYA5
         BK3yjl+Rio2Bpv3vsvCUSliRdOcElGAL4Gh2QUQcd5WTirA7BN6BoM36fHBuQoe/2o
         U7+1KAsMt1eQvLAOeOc2ZeN0mDFvszZHWYnkiz8daQLKWmDZGKYufgiFqd2fWxGrNk
         5xnWfCsVYNXjdSZgZLVkOzWZG1+JCTOXT8QGjUnmXG4//XdbcwTAwXt4ucXEAvQU7h
         lOgOG1SXOY02wHMbe7vo6/UacWIaGDm1xRlO3r9SDvUJpmqwLqbBtEcWkJz7z3K3/D
         hu8YTXI0YylGA==
Date:   Thu, 22 Apr 2021 17:42:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joe Burmeister <joe.burmeister@devtank.co.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: Fix buffer overflow with CS able to go
 beyond limit.
Message-ID: <20210422164223.GA36209@sirena.org.uk>
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
X-Cookie: When in doubt, lead trump.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2021 at 09:34:02AM +0100, Joe Burmeister wrote:
> It was previoulsy possible to have a device tree with more chips than
> the driver supports and go off the end of CS arrays.
>=20
> This patches inforces CS limit but sets that limit to the max of the
> default limit and what is in the device tree when driver is loaded.

This doesn't apply against current code, please check and resend.

Also s/previoulsy/previously/ and s/inforces/enforces/

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCBp28ACgkQJNaLcl1U
h9D2oQf/dFMngIVq1ZtQumO+zpDp+HuYqh2dCl8/it2x59tSXNC4kp9W3IxDOlTm
n7Dkzo+NaHCFXWs1gwPIFlxBMGXnDDeFvX0Bmhd1lb/1MYvxEjrECMnGvYh8bcTG
YoLIAX1lkQ+ycPb5zWZnKgMtk6jAAtFFDPIswtMGxR0tmqLHVDUO8WVHcwLGLivf
A4qRhMW+QW2jGTQcVq3HJTcpNp//K7azHa805wvZ5odjanf6kT3mKxCY2lkl4ogl
3KoHk0TThoCd9B1PmpQmgWFf4OROAL3zYJFbqe6hVvTns4YgYb/siX3MsWGGt1k9
RgQH64s0I+XfsUjL8K5kt3w+ETA/OA==
=L/zF
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
