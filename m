Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473821E3E0A
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgE0JvM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 05:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgE0JvM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 May 2020 05:51:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B3520B80;
        Wed, 27 May 2020 09:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590573071;
        bh=0vToCKDKiiwhvCQ/ZH06T4deAF0FOse4LBq9EGr0Hdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVI+eY/sUvYRSX+c+Adp5mbuGsFalnf0pXTPCNoiZDzr18dCfz9a0UVW1SQjVdQOT
         +GPqBAiQlp1MZCLnbvrTSC1VicjdfKmeCzHwVVwfMOOVW1nCw1H+fYqzrff1b1L/MY
         tRakSOtkBjQYqVrvvfLbmRmqcEhRvThMG5/cDsK4=
Date:   Wed, 27 May 2020 10:51:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        andy.shevchenko@gmail.com, noralf@tronnes.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillonhua@gmail.com
Subject: Re: [PATCH v6 8/9] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX'
 support for stm32f4
Message-ID: <20200527095109.GA5308@sirena.org.uk>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
 <1590564453-24499-9-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <1590564453-24499-9-git-send-email-dillon.minfei@gmail.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2020 at 03:27:32PM +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
>=20
> in l3gd20 driver startup, there is a setup failed error return from
> stm32 spi driver

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7OOAkACgkQJNaLcl1U
h9BjiAf9Ffv3ggcuNoWfvMQqMqMQaCF/81yq+JEuOCOw+nSFwBift/d6Q7Z7HWCh
k0/gPFT+7ED90XyQWUYuDOrUuQWiqQn8UP5p2IhQDAbvY9Zr3jnDTScTPx4FSf9m
xGGbKV0iWy7z78mHngcLf++zQtDzzZLjhK+U4CxVz5htfuOkTdDeIorLUZJnYdBH
tZKEYJ92tDX3perBnTRtca5zIEIo7JWv6ITSh6UTFELxx0D44W6NOS7z2W3kZ7HO
KeUa7lsUfxWs5hF11j959HVj5BG0CFVa/cA4o2dGd5aaDwXjeASUzngGM0DqNPhY
KPzFjTZ70Yj4eNCZVnKrXNGoe9KAoQ==
=8sEd
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
