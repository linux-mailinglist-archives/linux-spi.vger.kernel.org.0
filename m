Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA5336239B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbhDPPQR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 11:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245397AbhDPPN7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 11:13:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C69EE61166;
        Fri, 16 Apr 2021 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618585979;
        bh=vRTu21aTAGPsQ0NwM6AMDJ+Nc41b7EFjriw0cXrcLxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VBauDUbkra3OUcK+3rWa9RGPHeETx1Xes3Y/hE/J15heIabrFo8hjxYUPBD+6mFOQ
         EexGpFt33P+pMgiZSsOFP16BzkBTqvPZnemJDX4k8+yjPHtVYFNpjhbGcrnmpLtR4a
         asrgKuHQZCgioyurIlObEhBSjb6tOaLZy+K+1eq0vBNcuFYxsI5edWI19St71s9B93
         /rJa3Cxpo5TMQ12Eu6LAQR7W2nseXMJWg5yMQ0+K/fs4vfHaeZpZ7R2wuUbhq3pxSF
         wjwZwePciJ5miS1OkAW5hGgRgLndGZaC8CjtscMnqMyK2ktFdvxyE1P5bRbjOAx8x/
         tPuIUWFlcsCPw==
Date:   Fri, 16 Apr 2021 16:12:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "quanyang.wang" <quanyang.wang@windriver.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: spi-zynqmp-gqspi: fix clk_enable/disable
 imbalance issue
Message-ID: <20210416151235.GC5560@sirena.org.uk>
References: <20210416004652.2975446-1-quanyang.wang@windriver.com>
 <20210416004652.2975446-2-quanyang.wang@windriver.com>
 <20210416125558.GA5560@sirena.org.uk>
 <03f4152a-e66e-6b4a-5b4a-5f79f9ce2302@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <03f4152a-e66e-6b4a-5b4a-5f79f9ce2302@windriver.com>
X-Cookie: Snow Day -- stay home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 16, 2021 at 10:04:30PM +0800, quanyang.wang wrote:

> I am sorry. These patches should NOT be with "Fixes" tag since they base on
> the patches

> which are not with "Fixes". May I send a V2 patch series which remove these
> "Fixes" tags?

Well, if they're fixing bugs that were present in the named commit then
the the tag makes sense, it's just a question of if they are actually
for that commit or if they are fixing things for other commits like the
runtime PM enablement.

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB5qWIACgkQJNaLcl1U
h9ArnAf/efPHWmHEf6MbNCWOJgi+PQaQpqHKi3GyYbbeQ5cnRGObWE7GbiRM/A2p
TGpudbDmneHszF+avzLsSCWjDjOhKuW2prch0dz4uO5bo+eac5f6nCFeZT+nzIU8
50yQPAmHpZb6pqhXfbQwDqv6RU+s104DjLo8XdnxiWDnxIkWYsmiCVcP3kgAoJ5w
y5bl2sWN1FiLGNX7lUOXMEDhpeLpFKO3q5PyfB6CPpULIcwNRUGILfxfzMZDmUXm
3TfTjUK8vh4s3qbUT/s3S2Vy3QNAEG548EMr561IAdiThdaY/MmXYMf9xuWBw1lo
Wfs+0J2/sLs7lDZNbMPFeoeq7LH0Mw==
=LjTP
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
