Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBFF3B86A5
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbhF3QBO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 12:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235852AbhF3QAf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 12:00:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23641611CA;
        Wed, 30 Jun 2021 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625068686;
        bh=tiIJ5PyZJqrBsKRFL2EaUdVihpfRGtwSSFpuetSCRSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T0zcfVfn5zWcpmi15GyUfV3llnKCjuPRnDd4vb3+YoeuyY2hslQDlPrOIr7wE/XWL
         87zc6vwCk+Np3nMCdVte7vVnhIElyE9uHeH6JP+pX/eSmMidSxNUm47AJvC8+WUXun
         jRKbrC7Ej3aUqA62CAYJZ50TpKU5FmQp54PiLmWP4XyP47XCo4gcyvzbS1l1VKZ7G6
         2MrTqlTh2a3nkn1fvi6XYrWxK/krOdFYSZ24AxLshAcdweKGd6AHOWCjSyW5+8/FRg
         xzHTAfhoUMCBJiOsFiq9c20NXfJWigrTGnFxAiVAlpHpY+Rb4vBf23z+0Bns+ef6wL
         UWiX+hQVfWPyA==
Date:   Wed, 30 Jun 2021 16:57:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Liang Liang <liang.liang@amd.com>
Subject: Re: [PATCH v3 3/3] spi:amd:Fix for compilation error for non X86
 platforms.
Message-ID: <20210630155738.GH5106@sirena.org.uk>
References: <20210630120425.606957-1-Nehal-Bakulchandra.shah@amd.com>
 <20210630120425.606957-4-Nehal-Bakulchandra.shah@amd.com>
 <20210630124717.GE5106@sirena.org.uk>
 <fc174349-d2f6-6721-51e4-a23ae5a8262f@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Content-Disposition: inline
In-Reply-To: <fc174349-d2f6-6721-51e4-a23ae5a8262f@amd.com>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 30, 2021 at 08:14:12PM +0530, Shah, Nehal-bakulchandra wrote:

> > everything.  I don't recall anything from 0day that looked like it was
> > anything to do with dependencies though.

> so now should i RESEND this patch with suggested changes,i.e removing ACPI
> depedency
> change and removing COMPILE_TEST?

No, you should fix the actual problem - like I say it looked like just a
regular coding error, not something due to an actual dependency.

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDclHEACgkQJNaLcl1U
h9BbmggAhkXcLrofo+SltejCho6YL7RWBUdPM/e6k1au2ymIfkEBxcbZDz2LJPRC
xbRIyYQ6BVbqoSqn7lQzGlP3l+4X6N/yWV2hbUIGQ2CfMLI+2d+zWwZm6shiAGa+
lfc9wKUff9w/xx/rE5mATmIv+Yu72nAHCNRsbJalmdN52ROR6L6B0yE6yEXJLcTx
HQRW1CrGGfsHUteFXWx14eQdCDbl/FLqxgllWG5+vdxmMsSiS0HGFILCKkiku46h
MdL/eqmzbCqW8bmYTU7zLi/jAQb20MpualjAAsIENz0zu9hQgTHncG1rkWcMS2Ti
s5+paovfq6ogD26PfM0c64P1tNCqqQ==
=Hwda
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--
