Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7ABD1CDDCA
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgEKOx1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 10:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbgEKOxZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 May 2020 10:53:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 357E020736;
        Mon, 11 May 2020 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589208804;
        bh=AYhDvod9nbCHA/bULmju1oTd3bMlLvpXFTEjrTYtibM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQXPdOqRsCKFPkcM8uaWvpoPeWFeD16/uCo96bJsLuWVqFcVoC3Lvd/YKAajzEKpH
         7L14ijj8OlDNIuJXcIfuVyzQ8zOvMbHeJ4r0AaGTJYu5cPF4l6DLdEVAaJO7VRlhTT
         zGz5p3udlLnloZkIsN3n71pCtGKjoWOnydSQzGvI=
Date:   Mon, 11 May 2020 15:53:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-spi@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>,
        linux-kernel@vger.kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, alistair23@gmail.com
Subject: Re: [PATCH v2] spi: sun6i: Add support for GPIO chip select lines
Message-ID: <20200511145321.GH8216@sirena.org.uk>
References: <20200511045330.690507-1-alistair@alistair23.me>
 <158919630591.8372.404655401498379497.b4-ty@kernel.org>
 <20200511124245.j5pdnpsuhixzvs32@gilmour.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <20200511124245.j5pdnpsuhixzvs32@gilmour.lan>
X-Cookie: TANSTAAFL
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2020 at 02:42:45PM +0200, Maxime Ripard wrote:
> On Mon, May 11, 2020 at 12:25:35PM +0100, Mark Brown wrote:

> >    local tree asoc/for-5.7

> Are you sure this is the proper tree?

b4 seems to have grown a bug :/

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl65ZuEACgkQJNaLcl1U
h9DG2Af/d3GLvqRVx3OU87X/ee8QKnzpdk92r1kOKIfbzpKT2ig5TTitLAuzMqu/
Bt3yc9nVe97aZaCDrK18VjO2zhwhKsC6ztew3GExiDmD5tVaqEmrO3kQE38znATY
NBNjvhRRU0bQNQn+eVL/Zd0sm53wP3Zh4x/wNSaes0grabov7f5AyaRB27zCz57y
1/TCKj8WkUiO5Pjmr121NJOSjwtCA/RwIMZt+l7IGkMFR76ytYtuPNFTjI9Wdgp9
3DGFhF4lE2cIJJt44YPU0rnWCD9vReZw13awY1jmdIqUMkZPBHi9Jw2bWWOSQ02a
tofRzH/OWkFf2/2+TQ0mUWTVlPUWUw==
=+1Zk
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
