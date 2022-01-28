Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F9F4A03C9
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jan 2022 23:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiA1WfB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jan 2022 17:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiA1WfB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jan 2022 17:35:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45111C061714
        for <linux-spi@vger.kernel.org>; Fri, 28 Jan 2022 14:35:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09B81B80D79
        for <linux-spi@vger.kernel.org>; Fri, 28 Jan 2022 22:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E69BC340E7;
        Fri, 28 Jan 2022 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643409298;
        bh=Yq+NKmglCcJf6VxEKFIQ3uZi517ZRefZwBxdT7JtlIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4NFg/R0I4hO4OnN0XXhGYU6nnk1z9BgxojWESsJ1w7T/WnGmxGEI4LGtruaRYasP
         xxWVImUb87rY0l+GFIZambMoknvTBNIAzy2WOLNWBuF3t4vVf2PpwT+sF7IDx7jnIa
         cjxmpIeqMqqLcrbSCW4xzxFwGlwW7t/trDuJTuNaY5D5CHu/VupA2D/YDZT8mMiSCk
         y5nYnUAYFWI24ucgg5Rerk+rCSCGDh2kH/Dc6giMi+meIa7D5nWt+GCPmc1ucW2+fc
         yfTWaiskcpLhSVKAGlv4iZCj3QsybEwbqbwysvXhm4iz2rTp9jmAnCjCLwFLatUfNF
         l7jm15gmXd8fA==
Date:   Fri, 28 Jan 2022 22:34:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-spi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v10 00/13] External ECC engines & Macronix support
Message-ID: <YfRvjJf+6Db89RRg@sirena.org.uk>
References: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
 <YfL5ApsG7c619+R0@sirena.org.uk>
 <20220128090812.5b7a5982@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LgYrcwW1A+i1Y5Re"
Content-Disposition: inline
In-Reply-To: <20220128090812.5b7a5982@xps13>
X-Cookie: Torque is cheap.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LgYrcwW1A+i1Y5Re
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 28, 2022 at 09:08:12AM +0100, Miquel Raynal wrote:

> As three patches in this series were new/reworked I dropped your tag
> there. I should have asked you again. Shall I add them (back) to the
> following patches?

> 	spi: cadence-quadspi: Provide a capability structure
> 	spi: mxic: Provide a capability structure
> 	spi: spi-mem: Introduce a capability structure

Yes, please.

--LgYrcwW1A+i1Y5Re
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH0b4sACgkQJNaLcl1U
h9BXuQf/etoMdbvPgWgonTU6b8NUIY3ajlpqCNxICnnzCehv4KQf96azCUjthZ3S
HCksv3/bC2PAkfNPeMM3+mfZD0MPdHmkh6++c/GhFT8RzMvaXJBUEW7fCtLnaanG
v9DSaKA1ROaPjUnVy3dDbcE/sf9eY/O+tfWMNboEmuaWLnVIlzP83lrIqWBg9x+u
pKeD7jAOAqMHw4z1yVu75GXBMgMQ+exMEAshMc/dqsxvBczAbbS1ncNltI4bB3sT
6BYVFRFnqw5vxh+SX+l/kJKJocKQN2+dLrIEmykY/MhbKdfExgjwm/CsPzVzHhPR
7bQsA2YZjwj9idg9IQLWF6ZRuyeT+Q==
=dGGL
-----END PGP SIGNATURE-----

--LgYrcwW1A+i1Y5Re--
