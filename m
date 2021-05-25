Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9D39045C
	for <lists+linux-spi@lfdr.de>; Tue, 25 May 2021 16:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhEYO4D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 May 2021 10:56:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50466 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhEYO4C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 May 2021 10:56:02 -0400
X-Greylist: delayed 1132 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 10:56:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ki/UxVATrYCQetouX/QmwaQIst2UWIZZsnwpm15gHok=; b=oo9ObZfUthqW/IFjCDipZkNAxn
        y4Z1mRP6aPZgLGBUSXINQjADeUh0E0t2FsWhntgy2pQG7LLdpCwryPpuayZsTmEuFfqSCeSzgYIL+
        2SmyUja9Kj9v1V+JNCPRS1N9l3KTu9QbjFb+h+eLr89sE0qwjocN4TMXqVTowhaapaYI=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1llY9O-005lfK-EW; Tue, 25 May 2021 14:35:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 333F8D00B19; Tue, 25 May 2021 15:35:51 +0100 (BST)
Date:   Tue, 25 May 2021 15:35:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mirko Vogt <mirko-dev|linux@nanl.de>
Subject: Re: [PATCH 1/1] spi-sun6i: Fix chipselect/clock bug
Message-ID: <YK0LR3077RUsSYti@sirena.org.uk>
References: <20210520100656.rgkdexdvrddt3upy@runtux.com>
 <20210521173011.1c602682@slackpad.fritz.box>
 <20210521201913.2gapcmrzynxekro7@runtux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eQZK+OgGNZ+kM+zd"
Content-Disposition: inline
In-Reply-To: <20210521201913.2gapcmrzynxekro7@runtux.com>
X-Cookie: The wages of sin are unreported.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--eQZK+OgGNZ+kM+zd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 21, 2021 at 10:19:13PM +0200, Ralf Schlatterbeck wrote:
> From: Mirko Vogt <mirko-dev|linux@nanl.de>
>=20
> The current sun6i SPI implementation initializes the transfer too early,
> resulting in SCK going high before the transfer. When using an additional
> (gpio) chipselect with sun6i, the chipselect is asserted at a time when
> clock is high, making the SPI transfer fail.

Please don't send new patches in reply to old threads, this makes
it hard to follow what is going on and creates confusion as to
what the current version of things is and means things can easily
get missed if the earlier thread gets discarded - this goes along
with the thing Andre mentioned about flagging the version of the
patch in the subject line.

--eQZK+OgGNZ+kM+zd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCtC0YACgkQJNaLcl1U
h9AY5QgAgcWYI2VA7WPTIjHk9SuXExgIBAH1SNcW2KwVRbBcesxqHH3Dzlfg9vqc
C6luchIJ7CILJTdw5h1F4j3UhDtGEnQAyq5eecZ0la/eS5POfkWdObtdnWgW8qVj
9nddoYKV/goXt9jc4VqtOZSKdl9/yY3aK44xFvLZ3k2HJUSCBsr7aGuONUGVjX6Z
uOYROLl4x6wKUugWfrLANl1PRZBf8fSUOa426DdpWpw+FkLWnaJLAKqQQT2YJPfQ
vNBe4PjQ9Czqr/8R+FFBAgF005PHX6l/ek2A8lWZ/YuSZGM94qoPIHF5OYLpwSQZ
x/6RCx9aCRKKd4rU1g9Mlobv8p4Zdg==
=ZFjA
-----END PGP SIGNATURE-----

--eQZK+OgGNZ+kM+zd--
