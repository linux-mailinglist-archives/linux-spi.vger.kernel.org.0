Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A0317192
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 08:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfEHG3C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 02:29:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42462 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfEHG3B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 02:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ACcVO+QgX8/hnf5X9AfkY7Q6dOvn+DWth/HRiArV/jw=; b=gL3RfBPJQ3IpBCvdvn3s3wi/9
        7JUoLpZ2EBwKG714Z3vRZdeLRam9t0SNv/1EXHQt6UJ7PvcsBrIEiuPc5/AUVvpwglIQTINTbzC+o
        +azUMc4VN8u1jdOj/BLzGm0y7Kca+5DYnEQzk0T3Uv0JUYdo+Vi/6bFNB8Dx87dv6e9EQ=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOG4Y-00077q-Fx; Wed, 08 May 2019 06:28:58 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id A182444000C; Wed,  8 May 2019 07:09:36 +0100 (BST)
Date:   Wed, 8 May 2019 15:09:36 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Message-ID: <20190508060936.GH14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
 <20190507030241.GC14916@sirena.org.uk>
 <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
 <20190507110345.GF14916@sirena.org.uk>
 <20190507120730.5ylk6v4yvzxuzqld@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q+W+CH9ft+eKPnpy"
Content-Disposition: inline
In-Reply-To: <20190507120730.5ylk6v4yvzxuzqld@earth.universe>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Q+W+CH9ft+eKPnpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 02:07:30PM +0200, Sebastian Reichel wrote:

> FWIW, I send out kernel.org mails via mail.kernel.org. Konstantin
> added that service in 2014. You can get a password with

> ssh git@gitolite.kernel.org getsmtppass
>=20
> and then use the following settings for (example for git):

I'd have to send all mail out via kernel.org to do that, or persuade a
MTA to route mail differently based on contents which seems interesting
- I inject most of my mail via /usr/sbin/sendmail rather than SMTP
(including a bunch of scripts).

--Q+W+CH9ft+eKPnpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzScpkACgkQJNaLcl1U
h9DXhAf/XzfJdDG22K/iKDUuJvjWUO59zufCy4BxgEJGK8HPBSlopkDNIsaQGTZW
WQZGulm0jnTefDYruWieHqZclQhbIpIa6n7KbLOGtwVDH4XdLWXMkxi3SgpG9vi1
WTb5ytQUhtcr+W5cjDFM4vfv5InrtFHB0PtOQPSFX9JrGLZuhGU3P8LiW71JyH6Q
Ov52ilihNnxsVjFe/lmVhs3whgLAUYalhi9HAz9tDZjFdGZKW+zfSGlx1KRLUBMQ
2fWuzXc1vweZJDLSmz0Wvyx7OR0a54e8nw3QFge+EdYRMJd+eAOZNTNwBTzxW0Mw
8faWeNojbsEvwiajqy1wS8zkRiF71w==
=EQvQ
-----END PGP SIGNATURE-----

--Q+W+CH9ft+eKPnpy--
