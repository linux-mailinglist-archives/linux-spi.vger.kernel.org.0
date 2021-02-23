Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA88322B7B
	for <lists+linux-spi@lfdr.de>; Tue, 23 Feb 2021 14:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhBWNan (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Feb 2021 08:30:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232764AbhBWNam (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Feb 2021 08:30:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C197564DF3;
        Tue, 23 Feb 2021 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614087001;
        bh=XMII5kJzF7P9FxJ9CvB6Kb/iAx5gPX6SPCTr8wxUToI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/2c7Jr0i2cEGSo8V2amsKBVRAV6mNpS/psXrEudjgQ/lsCwrOUwtoYZ4qsvdY8LC
         ibwVO5m4c08C/eRBoQCN54vKT1JTlFA0YkHlgJEtkpeAa4UdmL4dJsqe8phQ/Yh4UO
         20rvCY4xY28vkdpsyUkBZSYnwuJIGEOxLT9znqusybwzvKkfj7kXzNCOSMKqZMgXY1
         0eWVkECp68PsuI5CIYWvJ+ct++3NhYYsGPf9IA5/uONkl6vlcvAcAh4OMMOrpyJo/H
         DeIQSCG0k8HXJz7ESL47PQQoZWvG2jlncSLv/IW+tTEDwNfecAbH/emGLoYt5/BOiL
         6GjIpupH9Gavw==
Date:   Tue, 23 Feb 2021 13:28:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     zhengxunli@mxic.com.tw
Cc:     juliensu@mxic.com.tw, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, miquel.raynal@bootlin.com,
        vigneshr@ti.com, ycllin@mxic.com.tw
Subject: Re: [PATCH v2 2/2] spi: mxic: patch for octal DTR mode support
Message-ID: <20210223132859.GC5116@sirena.org.uk>
References: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
 <1612517808-10010-3-git-send-email-zhengxunli@mxic.com.tw>
 <OFBB82A762.591077E7-ON48258681.001E4996-48258681.0020D66E@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <OFBB82A762.591077E7-ON48258681.001E4996-48258681.0020D66E@mxic.com.tw>
X-Cookie: Kilroe hic erat!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 19, 2021 at 01:58:40PM +0800, zhengxunli@mxic.com.tw wrote:
> Hi Mark,
>=20
> I see that Pratyush patch "spi: spi-mem: add spi_mem_dtr_supports_op()"
> has been accepted, can you help review this patch and make some=20
> suggestions?

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

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA1AxoACgkQJNaLcl1U
h9B6Bwf9GnAWDCLhkL077YNgjFnDFCuzhAt6om6Yji6MYlAAt56e0QzQkpWJy1Xl
Bs9srHZjitYzUCHo5IIMWqZ3k33sDQTzbcvDCkI+yeBtM0wU50ZdkyU60YDfE7uA
06Uvccd67GUDRaQERy9E/TtACdz9QZjng2nSUt1SWXp2MM/J7kx9HRsF6Yr6FCbj
442q61xckluL74culRVIVhIFv04b5nEGBYdxau/FIMzxtnY1wh4649r7CU8GaDSu
xeSdMXFHzPJxX5SdgfCX7MMi+07QXH2SYZ2cgrVtgzqeO3eHT1u2Za3qBtXkJbEX
uImtztKFJd+UVVj09gPkzEKajBfW0A==
=TICk
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
