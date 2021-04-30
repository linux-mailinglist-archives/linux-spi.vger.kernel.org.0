Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D9F37001D
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 20:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhD3SCf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Apr 2021 14:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231373AbhD3SCf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Apr 2021 14:02:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B74761481;
        Fri, 30 Apr 2021 18:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619805706;
        bh=eAR+xhSb4s1B6tCxGTMHtsSZAg/KO8Jwq88qvH4ZTp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKNqRBSj+/r0FDGLc2d69LiF2DFZqQauXAdXy9SdqQEYwxmZqpw+3XJXKYMQZ/ZH3
         BxWoBtiwTQQy+EmRt3UD0JBitAVtncgXxz+Sj5Pd2+AXcaXK3MwStyefBESjl5hXWq
         PeOWDUvvVzU6azXxZFAbynK+gkjVzq5NpNYuhMwr/ISGFXgR7C/TAOcFmh8ud8/qXp
         LPCRYapq8jAW5CItPAkivs9yFLckysKCpiKwhjTUcT19+NNfHS0EE5+83BKdIpj3Ga
         YhfXTv7icmPhuPs2EO7Fg+2TJAHwDcfMYyKx87Q9BzMrZADld0nuDLufOHTg0zgt8S
         wcFf+GvpRO5+w==
Date:   Fri, 30 Apr 2021 19:01:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Message-ID: <20210430180114.GF5981@sirena.org.uk>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VeiHsk15QoG3X-OV8V8jqzCNeKkif9V=cx4nvKVHaKbKA@mail.gmail.com>
 <20210427143457.GI4605@sirena.org.uk>
 <YIglWpz8lSidXmDd@smile.fi.intel.com>
 <CAHp75VfBSjHP1LJZJTdwXzGuE2YjxdW6r7Zf6ofHsquJBPMyWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline
In-Reply-To: <CAHp75VfBSjHP1LJZJTdwXzGuE2YjxdW6r7Zf6ofHsquJBPMyWA@mail.gmail.com>
X-Cookie: QOTD:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 30, 2021 at 07:29:48PM +0300, Andy Shevchenko wrote:

> One item is still unclear to me. I noticed that you started already
> applying patches for-next release cycle (if I understood it
> correctly). Hence the question should or shouldn't I resend this

No I haven't, I'm only applying things to for-5.13.  I've not even
created for-5.14 yet, that will only get created once -rc1 is out and
nothing for it is fixed yet.  If I look at it and find an issue I will
tell you, if I've not said anything and I've got through my first batch
of v5.14 stuff it's gone AWOL and you should resend.

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCMRekACgkQJNaLcl1U
h9DGsQgAga0H+vmLX/93TTc/hepJINQX8s8kTSyvJCoOO+q1rlf0udjdUvQLrQqO
wA+VsJ+h72RIEmIAKdPbHMBR16N/e9kYvWb7edSIhgIAbJTYCfra8ie835Ab+HJ/
940AfNU6jFC4k1Ot4g9TkvjcL3mFjN4NYoUdFJTiLK7huhacheX8gmCF5XmrlwAZ
w3CMCpuWocOWji2MO/w+m+2yjTelU6sQPnlT4Hfnk6l+eNJF8WcRNNM1OlX9kciX
47Ja6kMLll/XX7kQsXJ3dz86Fv5Bz8jmQMynPS3fMe1cGS69+sxfa1ubiSRxs9gI
+YfKmy1ffamHjymkV8jSY/vN2Ud0cQ==
=FhSI
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
