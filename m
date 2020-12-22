Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDFE2E0D9A
	for <lists+linux-spi@lfdr.de>; Tue, 22 Dec 2020 17:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbgLVQ5s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Dec 2020 11:57:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgLVQ5s (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Dec 2020 11:57:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EB0E22571;
        Tue, 22 Dec 2020 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608656227;
        bh=mqhMpDFa5UNKZIjdidfSTuC+cQFZgjzE/T8sPcadBjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lEnN3TNca3BhL0TznZIWrxn6zNqhlKSsVFYfinejDhiaLigQhfmEtlp0UMGGA7cJE
         mHf11Kyfl7mpxb+qlj+1g5Z6GGExHXR+l2URlV14y1PnJASDteXLydZ++HxRRlaGOx
         oPEefYr6vVnzerocM2MW7wC8rmBkKC3uU9LTfCrTYSl0qyjMNyiuwPyJfrGfFB4RyF
         rJRi7gEKGYVqBUH06ydAn0eyDGvyjeeNY2muxFy91udZyaG4khtl2tyGf7zd5KiqCj
         R6+WAvUr8jtByX/Mx/74+Mrbmv0FzZDU6Yhkdj2IIN/JmJDr0nE7IcEtL3D/Zmz3Sf
         fe32FMFTw0nvA==
Date:   Tue, 22 Dec 2020 16:56:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kostya Porotchkin <kostap@marvell.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Ben Peled <bpeled@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>
Subject: Re: [EXT] Re: [PATCH v2 1/2] spi: orion: enable clocks before
 spi_setup
Message-ID: <20201222165651.GA5269@sirena.org.uk>
References: <20201217170933.10717-1-kostap@marvell.com>
 <20201217170933.10717-2-kostap@marvell.com>
 <20201217172528.GG4708@sirena.org.uk>
 <DM5PR18MB1452458F0C11FECF40023060CADF0@DM5PR18MB1452.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <DM5PR18MB1452458F0C11FECF40023060CADF0@DM5PR18MB1452.namprd18.prod.outlook.com>
X-Cookie: Truth can wait
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 22, 2020 at 12:46:01PM +0000, Kostya Porotchkin wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > There's no matching disable here so we'll leak the enables every time
> > setup() is called - we should unwind the enables after calling
> > _setup_transfer().  It may be more sensible to just take a runtime PM
> > reference rather than do the raw clock API stuff, one less call and means if
> > anything else gets added to runtime PM it'll be handled.

> [KP] You mean we should call here to orion_spi_runtime_resume()
> instead of clk_prepare_enable() and make this PM function available
> regardless the CONFIG_PM option?

That's one part of the suggestion, yes - the other part is that you need
to have a disable matching the enable here.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/iJVIACgkQJNaLcl1U
h9DO/gf+PeVmtm71zeeqidY/d8pwS26xapZ/62i8jX5yYLIvo0kGcVMdncf8vH43
qih06rIorHII7Hzza48qg/Jk7SS8uHSyCYnXzFPRK7gJcju9djTnYLDAaQuMgSbr
GjJLIg7+QkfODYxxrj+lsgv55eWzniYD8/DMdNh/y74xgDTQevaV6o7Kodip0/Ng
bMNpBMuCT7eTzLlYZxzC+m68sFF9VANyBY4P1cNBZyyBjjaGNanhmNnsAiRSugif
17qN1m3/QeUmplSAhiZYxiPoORXAz9p/wOzaTb/IndYueGGrWDRDVroBx6J6mPvX
9lTtiEnEnYB5DOtmkb8ZfQUh8Uc1yQ==
=EQxT
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
