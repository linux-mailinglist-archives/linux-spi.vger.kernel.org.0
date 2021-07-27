Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A80B3D7A51
	for <lists+linux-spi@lfdr.de>; Tue, 27 Jul 2021 17:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhG0P6y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Jul 2021 11:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232549AbhG0P6y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Jul 2021 11:58:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6922D61B74;
        Tue, 27 Jul 2021 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627401533;
        bh=EPnm63BpuveC4otRjkPA+pNO+gJv9OB2xbmdo8NVYII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yv8ZHR1c/zX+PuXzMUzZJFl7/804OcnCWU9ugxa5/SorZGK9a5PWMIj1Mu7pl994L
         VSgA+x67FZjubCmPdDqPSf7Hh59+Lq3IEVfMYnBa4FG8JTMEpTWN82EBC7thhDukvG
         ZgmvWXoyU8AYkvHff1lu8pFVY0scjzbnb07P7Jh8/hVG7icbuQMndpVfdLzAFyy8R4
         k8br+kR6fQRBdctiyDqYgzNY43jmLMc6FP9kuNFjgSnGR0pGHj/5OkS61NiELDhv0l
         kXv7CTbnNr4zx+G6h7o8m7ryTj8Za1HhD1OpTUhvk5R4J9OlYbuUTw9K1ON3dQRkb+
         Vo6+5hHHCBQOQ==
Date:   Tue, 27 Jul 2021 16:58:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-spi@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
Message-ID: <20210727155844.GW4670@sirena.org.uk>
References: <20210726101502.6803-1-marex@denx.de>
 <20210727121554.GA42404@sirena.org.uk>
 <1bba632f-3558-7ded-393d-a054a26ce7ef@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+rRWuC8ZLvVekNoN"
Content-Disposition: inline
In-Reply-To: <1bba632f-3558-7ded-393d-a054a26ce7ef@denx.de>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+rRWuC8ZLvVekNoN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 27, 2021 at 05:55:26PM +0200, Marek Vasut wrote:

> So maybe I'll wait until this one gets applied and picked by stable, and
> then I'll send the comment fix ? That should make things easier.

Sure.  No need to wait for stable I guess, once it's applied everything
should be fine.

--+rRWuC8ZLvVekNoN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEALTMACgkQJNaLcl1U
h9CbtQf/ZPe+fDI1PLaHxG42WDDwCZBvvxvyjMFpWYkPugP58Q+aX/yTK4AjZDUe
XJXYnU305oucCGXgX45OwoMdAUWE1z9IMIxdQVU9B9kFxWiIB1vcoGw8eZ9SllCA
rAF+6kYBBaRFgeyVOIoprllVn1PHlpIqivJwvlmTsXYdP8BAlbxYd9FAe1iMfDgM
zyW0Al9h+2nKylstTickUkd67mrlbDUsfhqd9RH7Lc6AFwWR8p2djcGAVmrA3rAr
+/IKRtHdg+vRE7avwXs3CL6LdS4VDQayDVRyiFL0UtZHoOvTAn5AKxTyLbwkxVIC
1/lGxPh5ICxhIa/qNZ1T6y2ekXE9HQ==
=DxrV
-----END PGP SIGNATURE-----

--+rRWuC8ZLvVekNoN--
