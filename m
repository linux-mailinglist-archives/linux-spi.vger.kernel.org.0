Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56A2E9F8F
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 22:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbhADVbX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 16:31:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbhADVbW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 16:31:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A87221D93;
        Mon,  4 Jan 2021 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609795832;
        bh=CZGZG34DbWC5gsN2Vh0sggMMgMDglmyHaa/JpxJ4QFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXBgzn1Wvhb9UmpKOLOwAJ0JpwUniCSSzHISpcQhcn4va9lsmoBys8Aw/jE3Zpfat
         wYXcAai72ledErLlh79FgoSkGRmAziO1In6N5hXw5ad12tkP2sZNwiKEmYQH7dOL05
         0J/JGc+oTex1kdN52OS0kSAuGpvSV2VS6MhJKuyTNgEvLHkTLg7I+H3w/Oa4LKoKhq
         A7AnvYvFhcq2xpLL8XAAtlLHmO7sj+t7KWkKtjLoK2DLhmmMoHD/dUo5iMRYbblRpZ
         ZJZ1avuw6bisMcp/lVX2KfTCQBBpkk5IJrwIDcUfY8MzWEMPCCJlymy9whFMgJp/Fl
         UUAQUyHoN1rVw==
Date:   Mon, 4 Jan 2021 21:30:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Pavel Machek <pavel@denx.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jiri Kosina <trivial@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>
Subject: Re: [PATCH 2/2] spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery
Message-ID: <20210104213005.GK5645@sirena.org.uk>
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201230145708.28544-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVCD52-eTnEwftGz8ExMkZkJRyM=3M8zU11yhn1UNPxxA@mail.gmail.com>
 <CA+V-a8tHVkGxCECspfcV9c1UW81bod4N4YzRLJwU8zJ0+awJUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vk/v8fjDPiDepTtA"
Content-Disposition: inline
In-Reply-To: <CA+V-a8tHVkGxCECspfcV9c1UW81bod4N4YzRLJwU8zJ0+awJUw@mail.gmail.com>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--vk/v8fjDPiDepTtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 04, 2021 at 09:25:17PM +0000, Lad, Prabhakar wrote:

> > >                 .name   = "rpc-if-spi",
> > > -               .pm     = DEV_PM_OPS,
> > > +               .pm     = &rpcif_spi_pm_ops,

> > You're aware rpcif_spi_pm_ops is now always referenced and thus emitted,
> > increasing kernel size by 92 bytes if CONFIG_PM_SLEEP=n?
> > This may matter for RZ/A SoCs running from internal SRAM.

> Hmm didn't realise this would be an issue on RZ/A.

> Mark, could you please drop this patch from your branch.

Please send an incremental patch with an appropriate changelog.

--vk/v8fjDPiDepTtA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/ziNwACgkQJNaLcl1U
h9AiDQf+NWLL5kYwXv2qsnNIGJfyYBlpbr2ha6Uhdk6t8uVWUtRMGhrK2HrEN+qt
bh7DXtD92HVLW/88Mzq7tW8IzVjpM63dA3V7DlY4PO+iRjHFXsHcjR7OuhMTDxti
2Bra/G29guzIP2J703fbYq059L/uxAbhf2wMoiVvYSdf8V6O8dZrR4UMzdTLiHsF
98dR+Jlp9hX9IWKfnBqqzSe6g0Nina62lAEzXyAJaaX3sBa2lTUSC4jlX5KVyo5z
RLMqlxHrX6sOGrio6SMnYVlQ9RHUVLFn0Y6nojxanRG+blxRqCN68JwWNASLmZT3
F5P9WDjT2FKJCc1ZhxrBW9vdzT2kZA==
=tYtr
-----END PGP SIGNATURE-----

--vk/v8fjDPiDepTtA--
