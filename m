Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94EF1D59C4
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 21:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgEOTOY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 15:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgEOTOX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 15:14:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 197F020728;
        Fri, 15 May 2020 19:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589570062;
        bh=iFZrsBOV5jxnh/yPWq+OY/IgbdgMMbs9ic1+MA1vN5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNbqQqT5SvWpet8F0Kw8U3xSAcmt8/8h9BuLxjSyDK7Z5Kkonm+2Y8CM7MI5AvZPh
         PBDm5NZEJMm1mxzpzvh0bRtM29WJnod4FI0Ycn9scdQJx62Qh+vXxiUTa2LfAxVCMt
         gZn3w5JkKkXet0lbnnrMTrGSdVIaKnE17AJwZGCQ=
Date:   Fri, 15 May 2020 20:14:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] spi: dw: Clear DMAC register when done or stopped
Message-ID: <20200515191419.GQ5066@sirena.org.uk>
References: <20200515174856.1406-1-Sergey.Semin@baikalelectronics.ru>
 <20200515175100.GL5066@sirena.org.uk>
 <20200515175420.qgejailgnzswxtdz@mobilestation>
 <20200515181219.GN5066@sirena.org.uk>
 <20200515182322.mmsfe5zu5tqmovmf@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jigfid2yHjNFZUTO"
Content-Disposition: inline
In-Reply-To: <20200515182322.mmsfe5zu5tqmovmf@mobilestation>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jigfid2yHjNFZUTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 09:23:22PM +0300, Serge Semin wrote:
> On Fri, May 15, 2020 at 07:12:19PM +0100, Mark Brown wrote:

> > Unless someone explicitly gives you a tag for something you shouldn't
> > usually assume that one applies, especially with maintainers giving acks
> > on their own trees since that has process meaning - it's saying that the
> > maintainer is OK with it being applied to some other tree which is
> > something it's worth being careful about.

> Hm, it depends on maintainer and sub-system then. I did such "looks good" ->
> Acked-by conversions before. Not that many, but noone argued. [1] also says it's
> sometimes possible. Anyway, sorry for inconvenience. I'll get to remember that
> I'd better ask explicit acked-by from you, no assumption.

Like I say it's much more important when it's a patch that someone would
normally apply themselves since it makes a much bigger difference
process wise if you ack or apply a patch.

--jigfid2yHjNFZUTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+6gsACgkQJNaLcl1U
h9Avagf/Xb3F6H6X5IP7yjmBuKktC6p+Hx1s7HzygvLrU75AyWVAP7lEjiDT+JtA
o4rV6qCvmn7zmQkotmpSZ8niRyM6MM9dbsTVpkMkE3RZLFgR1R+YIsj3mpADGBvs
Y14bbA69A9yTJ9dzdE+Xtls8fq6FBBbh1iYPvT6bsoR7hv6kqpsHVQlZhqyf/++T
vesikNxpbFN3goTfSkewzqce/vr7VUNlQ8Gf+M9yVZZrHQFN+D/TXECX7UmXTSez
Z7nEcI9sC1Gv8+zQSV5+WwM3Og2FnvLfuSKWlPUfSuQB5k2PFtWMfzM82xuTQBKP
s0yzXo4ZxK9yUxagoifuBabXOrWlXg==
=1rhX
-----END PGP SIGNATURE-----

--jigfid2yHjNFZUTO--
