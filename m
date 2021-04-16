Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F63625B8
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhDPQec (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 12:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235698AbhDPQeb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 12:34:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A55E61002;
        Fri, 16 Apr 2021 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618590846;
        bh=Cuq2qJDVEyHN4LK1pCgJEum4rzMfHiP7uycM9J35CJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7XYQX06CzwDaLx0xh0n15LhCioAkAY9VVkBSNh521nNTLts/Mrh+XH630dBMWspM
         vc2DhuRcuegGtpy2H/IbtOh+mrhxHbPuA1tWTF1QKYv23+Qn5XpSsTSP+r5oPk670Z
         CTxv15GL1MYZlDvJrLeLpTPV34zDnIOv+YG5grcgymdqoqPJgUhNs142pprqbiowJi
         1jJ0QT68ih/EH5heazfrw8dhE1uTI7VbfKbcC0EEM1HUJetuKefhepXeTnIFsuNThi
         vU96RN0eLsUaPLpAfMxVKhFeMdST2uHN2Vcua1uCQTWaWOvOsf5SOtwKT5SNPDvW63
         XVsh/CGrtG83g==
Date:   Fri, 16 Apr 2021 17:33:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Quanyang Wang <quanyang.wang@windriver.com>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 0/5] spi: spi-zynqmp-gqspi: fix spi issues
Message-ID: <20210416163341.GJ5560@sirena.org.uk>
References: <20210416142047.6349-1-quanyang.wang@windriver.com>
 <161858883110.29027.5432599534762847384.b4-ty@kernel.org>
 <fb308dee-6ca4-e2de-964a-f67684f15e54@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YPJ8CVbwFUtL7OFW"
Content-Disposition: inline
In-Reply-To: <fb308dee-6ca4-e2de-964a-f67684f15e54@windriver.com>
X-Cookie: Snow Day -- stay home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--YPJ8CVbwFUtL7OFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 17, 2021 at 12:31:44AM +0800, Quanyang Wang wrote:

> Sorry for any confusion caused.

No worries, it's mainly just an issue for anyone doing stable backports
- hopefully they'll figure things out.

--YPJ8CVbwFUtL7OFW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB5vGUACgkQJNaLcl1U
h9Cf0gf+PXPfs0kUioBsZoQ5Y4KbrpGrA4iEvnF5B1g+VyMTH0mlAzl55gzuYiDw
kF2j18mLbTWBq28VC00y2h66sLH5p0mzlMRtKEjsvcMxG2kBQaj8BXOEP79WJhKH
0Yn/aIJGWtfKnd0sUIn8Ub6gOgqlx2alfSk6I1/2xn3RfhC9+nDvkyAavDLhgC0U
FW6PuJoywqjrzBCU5zFwb9ZGCbdVNCFMRJMtUfiAFRp7JH52PuSDtuXSZAJPE2W4
J5EbDoFnuWeoQggTJ2wqZr1qCcE/AitDxgyMtY8Yd6dDQu3Iuy39qT9AGZztDOvg
Au5DIacH8z9u8u6wDS9Z5/irLZGYfA==
=vI3k
-----END PGP SIGNATURE-----

--YPJ8CVbwFUtL7OFW--
