Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20DF3698A5
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 19:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhDWRub (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 13:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWRua (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 13:50:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DFEF6144E;
        Fri, 23 Apr 2021 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619200194;
        bh=EKqQdd3JsvHGu+wfjLmk/wXeSZjWsLUz+vRrJVYcYHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MEVCkxIIEj+FggSVINLpIuRBDGoTlhn4ETwvVna2cyxpw2MibiEJBmiogqqHfuEyC
         647JM0Q2XK67xTPlPrx655ONzBn/E65Eo1jMG8f/MIFMa8tv5a1IDk5oN7c4AuquLI
         QX+39uKRwdCQbN9+gQ0bxHb+VkyclsvwRCuEZWz5kirqHeKu3rTmCvp52YB+jxc3eC
         /WmDQIR+W3P+sgY/EXlcKEBDgMysWyIKoAFl7aX8F7k0JdgnGseSLVQ04V9QcTQ/7Q
         yuTD7uUiTD8qNrs1AeaRSvmPxoc1MkMLKsvTyUKoxHXQuCAIetah/deIBZCD5Ni/8g
         Yk5jM9M+RVD4g==
Date:   Fri, 23 Apr 2021 18:49:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 05/14] spi: pxa2xx: Consolidate related headers under
 include/linux/spi
Message-ID: <20210423174924.GI5507@sirena.org.uk>
References: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
 <20210423163437.89306-5-andriy.shevchenko@linux.intel.com>
 <20210423165630.GH5507@sirena.org.uk>
 <YIMEIEnt4meMP6Hx@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8/UBlNHSEJa6utmr"
Content-Disposition: inline
In-Reply-To: <YIMEIEnt4meMP6Hx@smile.fi.intel.com>
X-Cookie: This is now.  Later is later.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--8/UBlNHSEJa6utmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 23, 2021 at 08:30:08PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 23, 2021 at 05:56:30PM +0100, Mark Brown wrote:
> > On Fri, Apr 23, 2021 at 07:34:28PM +0300, Andy Shevchenko wrote:

> > > We have two headers split between include/linux and include/linux/spi.
> > > Consolidated them under SPI realm, i.e. in the latter folder.

> > Why?  Isn't the point to maintain an abstraction between the general
> > purpose use of the SSP IP and its application as a SPI controller?

> Aren't the General Purpose of the SSP IP is an SPI controller either way?
> What you are talking about is probably GP SPI vs. private (dedicated) SPI.

SPI and any other serial protocols that happen to come up - these
generic serial IPs also often get used for audio for example.

> > I'd
> > check the cover letter for the series but there doesn't seem to be one.

> Set of cleanups here and there related to the SPI PXA2xx driver.
> It's hard to add something else here.

It doesn't need to be much more than what you just wrote.

--8/UBlNHSEJa6utmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCDCKQACgkQJNaLcl1U
h9AtYwf9ExEjCIqGM+Q3BnqwznDy/zJKu8//lEQgEI1UwO9mrRzH4hRPYDJlKQzb
BBvSCChNpY6BiXRvYAL+Rou8kNRvo+XPUr/m+gFmY9hFhSK+k3zFsAlXVuyVgnVc
/E8k7PBZsyDCK3EJsX7G6o+uVcqJI7YzQYobrGRmpWy78xkrgr9nDEELZqFSUzJj
rmMkxWH8CLawROulDBbQVFNzip2rniOk8NnD6k4x8XH0hRSS/bTYBSEx/2vPhWuq
d8OHhKcZgdCzvDQZroG/VkpXLd3ZOujucL+qo7UiOGXGmu1P2wA87wp+ny0b4zIL
bLrbblN3MR5zkYi1zYi6JKbiISi2MQ==
=VD8t
-----END PGP SIGNATURE-----

--8/UBlNHSEJa6utmr--
