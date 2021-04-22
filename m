Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0025836841F
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhDVPq7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 11:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236594AbhDVPq6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Apr 2021 11:46:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFCD560FD7;
        Thu, 22 Apr 2021 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619106383;
        bh=5wuJRfbMCsCCjkM9s9M1nBLXOjEsvSWtEiDEUi5jm+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nGOcl2LlvLr7+Tl0B1l3Ua+fi162i1kPjjxjgXu9wnDjpN9wzTqSzS5kP2R/3kAfP
         CxoNK9hP93qYwNYybEYBeH8pv1vE+wDuA4ltDO6Pm5WhaSLYUmL90HHwJs2U2R0JIB
         NpzlvpmJZX8qyZzKOTwAGrKbpj3GyxFTjMLzceH2/JjBgpqih9+2LksR/OfSnETvdX
         tfr8NmItm15uflxB668UdQuFJ83rsVmbn0hAcz6bscKgHdhN5wVzosiulK7t9XqICj
         AoXFIM6Gk08B96L7BijaE2Vvt0+Sm8JFXU6cLuVbGibH1kqoIZNH/XIur4ztbNsRgp
         FfsBmQRiUjy/w==
Date:   Thu, 22 Apr 2021 16:45:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     Han Xu <han.xu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale QSPI
 binding to json schema
Message-ID: <20210422154555.GJ4572@sirena.org.uk>
References: <20210312054038.3586706-1-kuldeep.singh@nxp.com>
 <20210324152420.GA3093662@robh.at.kernel.org>
 <DB6PR0402MB275836552946D34CBEA47C48E0469@DB6PR0402MB2758.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PEkEgRdBLZYkpbX2"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB275836552946D34CBEA47C48E0469@DB6PR0402MB2758.eurprd04.prod.outlook.com>
X-Cookie: Jesus is my POSTMASTER GENERAL ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 22, 2021 at 11:09:19AM +0000, Kuldeep Singh wrote:

> Apologies for content free pings.
> This patch has already been reviewed by Rob and can be accepted if no fur=
ther changes required.

Whenever I complain about content free pings I also point out that
resends are helpful, it's not just don't ping it's also that having a
copy of the patch helps if anything went wrong:

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--PEkEgRdBLZYkpbX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCBmjIACgkQJNaLcl1U
h9BvQgf5AVLciabft5X6466v4Dge6sLOoOT8wulxXKj82y72udIad15u39P9LyPd
YwQMNu9ySd9x5a0yCrYAie83dIAF+D1J3GmgnhbpomISfpQ6TuyzAce9TqXrq0+S
MVXSKynpZWJAePgjUhUo/IO/XHZgvE47AMmGK8GQuvnUaqWIGCT5UeIxQQopHbPQ
W4l0guE1yNEVvCF5aM4PfY2vXWcUpC7Hqhq6AAXYL3YhmnVbLOEW/+gupoCJgVWo
sDX7qp45aS4oNM6ZGpXZXzH8TTA03FTtExGg9ch+vHlLSct3E9w5tM66IkAeW/mn
Xd8Ttl6p30JSDX8qj1+XNIyFkGGYWg==
=TmjE
-----END PGP SIGNATURE-----

--PEkEgRdBLZYkpbX2--
