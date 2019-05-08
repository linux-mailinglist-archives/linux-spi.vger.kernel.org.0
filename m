Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA81175B8
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 12:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfEHKNE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 06:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHKNE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 May 2019 06:13:04 -0400
Received: from earth.universe (dyndsl-091-248-052-181.ewe-ip-backbone.de [91.248.52.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8929320578;
        Wed,  8 May 2019 10:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557310383;
        bh=ErD1/VVKRF8b62CZRklMab94FhD0FCMFP5weYO0YEes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8NUrwNH5Hlt8uCH8AeYGh7YXEMXYP5oI00keFeekOJpu/Wbb3z6+2P2wStcduXmR
         Zw3y9N5+cXGe4sxU4jTzFlr9jKl8gh44GQOx07Tl21dwwW0UT4meaX80Kms3/xYark
         RIiUMPExHrd/AycUJTjWmTpGiYOMIqthg2jjFRLI=
Received: by earth.universe (Postfix, from userid 1000)
        id 4077C3C0CBD; Wed,  8 May 2019 12:13:01 +0200 (CEST)
Date:   Wed, 8 May 2019 12:13:01 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Message-ID: <20190508101301.lxwt4e6eziujdfit@earth.universe>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
 <20190507030241.GC14916@sirena.org.uk>
 <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
 <20190507110345.GF14916@sirena.org.uk>
 <20190507120730.5ylk6v4yvzxuzqld@earth.universe>
 <20190508060936.GH14916@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="67wcu6z2guvpdeh7"
Content-Disposition: inline
In-Reply-To: <20190508060936.GH14916@sirena.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--67wcu6z2guvpdeh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 08, 2019 at 03:09:36PM +0900, Mark Brown wrote:
> On Tue, May 07, 2019 at 02:07:30PM +0200, Sebastian Reichel wrote:
> > FWIW, I send out kernel.org mails via mail.kernel.org. Konstantin
> > added that service in 2014. You can get a password with
>=20
> > ssh git@gitolite.kernel.org getsmtppass
> >=20
> > and then use the following settings for (example for git):
>=20
> I'd have to send all mail out via kernel.org to do that, or persuade a
> MTA to route mail differently based on contents which seems interesting
> - I inject most of my mail via /usr/sbin/sendmail rather than SMTP
> (including a bunch of scripts).

I have a locally installed postfix in sender dependent relay
configuration, which does that for me:

http://www.postfix.org/SOHO_README.html#client_sasl_sender

-- Sebastian

--67wcu6z2guvpdeh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzSq6gACgkQ2O7X88g7
+pp6khAAmZ5my97oTpts1tAYrnA+mzSWdA+fvZAdfRUfIlIH7Xgwg6nH5Ll8CQyO
BEcChOdj1Ph6bMgWnpZczOb9UW2rCMXqA27Rsucj8VtQPK7Ipdz92fXoigi5N64P
Nr2KInKFS8chQYf0wNklhl0vE+/zpYlohL54QyGZrTr2/XgdZl4ytBqZvQK2LEJU
lLSdHH87nTXqKnNVtUd3shezT/rOGB3BpYTqhtW2hIn1VUFZEeDpdC6iGLCILGMb
dqG6MLNCa3JKtmALxXS4hWAeRa7EohHoxwPFXP1uvA6K09GYhBeyZla3yxyjYWHI
QUaY4TUvqaTCr5I8BUihQFhb4yGLdXhzgnTKMWX5asgPw2+Dy6CpxiWLgO8hnDpf
s2Qgb2B+KIyNC/onAUt5CDlCxpG16YrRLiX/7h4riKvzTMmavIFx4HgifmwbiLoO
UugIu0TU08xGvJbmiJiUOGeXXLOPS61faBcKF1GFWLkEwO0PXpw9TsVoJVB4+Pvx
V+4KZj/TdtP4CR5rkngHu+3jxU5T+eb6KFZYTu546QNIhNixEB68inYVcP2tV/QY
5q0FIHAISvKz95rzuxIW6WZ8OyC+ZVccROSpcL6hs/heoUamsSexRzOf3eXCtndg
STlX6FelVrUXgHXKY4h+gIFANOfr04wYq7miZYqV41Pab4L5oYI=
=CZEI
-----END PGP SIGNATURE-----

--67wcu6z2guvpdeh7--
