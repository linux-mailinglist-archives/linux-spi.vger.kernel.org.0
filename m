Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B018364FE
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2019 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFETzR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jun 2019 15:55:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56140 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFETzR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jun 2019 15:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KgTOG/MCFpTyXVOTj1ZuKkvtNmZGpkEpbnA949wWplg=; b=poiGgtvcOkWfzAHuVL95Men3L
        RyJsJbFdF5jvyHsVDjz+UFH1VX2AFLCeFGFxTcLT7kjna8inPhPEgFcf0DOSnNNim+PkYMgCrol36
        DXwfUOlPsXCYCu7DZy33rjRGAMDP7O8GtkdpVHMIYq6VWHk8G4ZZw+69OPy4tTmCUTJzk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYc08-0001Q6-5G; Wed, 05 Jun 2019 19:55:12 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 90214440046; Wed,  5 Jun 2019 20:55:11 +0100 (BST)
Date:   Wed, 5 Jun 2019 20:55:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-spi@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>
Subject: Re: Applied "spi: rockchip: turn down tx dma bursts" to the spi tree
Message-ID: <20190605195511.GX2456@sirena.org.uk>
References: <20190412105320.2924-1-kernel@esmil.dk>
 <20190508103358.5C7EB440010@finisterre.sirena.org.uk>
 <CANBLGcxiXR7KqKn4U-2PgefuxpBFX=yR06cw6A5GEALuqa54FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dkgfGZfPp4OU3Le7"
Content-Disposition: inline
In-Reply-To: <CANBLGcxiXR7KqKn4U-2PgefuxpBFX=yR06cw6A5GEALuqa54FA@mail.gmail.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dkgfGZfPp4OU3Le7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2019 at 09:36:44PM +0200, Emil Renner Berthing wrote:
> On Wed, 8 May 2019 at 12:34, Mark Brown <broonie@kernel.org> wrote:

> >    spi: rockchip: turn down tx dma bursts

> I've tried looking in the for-next and for-5.x branches here, and I
> can't seem to find this patch.
> Am I missing something?

> It fixes a problem introduced in 4.19, so it'd be nice if it could
> make it to stable trees eventually.

47300728fb213486a830565d2af49da967c9d16a is in my tree.  When it reaches
Linus' tree send a request to Greg for it to be backported if none of
the stable automation picks it up.

--dkgfGZfPp4OU3Le7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz4Hh4ACgkQJNaLcl1U
h9BxQgf+Ljplf8ZxX4pzMeNgr9s/Oik21N9dYZN14eGepFYn3eC2JAJ66qWR5ZDX
q18JwvA6GyMsvntlko2y2HjEIJltQ06YGplOfVLtKkwtDWSbiBlV1nkkxpZGjmJd
AC7LI2yRkoD35/DXj4r2x8ZatFl1W+i3isANRYtSFHUeKElyYCQ+fV4YTm8xUHjP
zpRYGv65CG88hJmzygheI3viO+zlwsUxaJaz/jcNkoyZ4etUpz8FEYjtMeBV3SXX
MxUncjiMX3d7HlRU4CY03FyMkUJ4d+8Pfw7YMyNbF2SMDqEbApXGhBG4XS1RcE6x
ujRznnS4Wk9Lc6MdQbWFBAMoYrCUcw==
=Y9+I
-----END PGP SIGNATURE-----

--dkgfGZfPp4OU3Le7--
