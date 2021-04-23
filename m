Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03504369778
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhDWQ5f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 12:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhDWQ5f (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 12:57:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FA89611AE;
        Fri, 23 Apr 2021 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619197018;
        bh=LfID890VAjx1GZR+zOrDOxEjOHzkC+fZhl1uOkQgHsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5veA+XwtEUJElzT1v6yOIVjcnYgfLhLHRdA/om5LzaouZiCO5kAYjkTP1F2/MQ+g
         0yyG03jy82r4Ix6/aqifdqt2fg50ItCwKTNxi3eM8gkLvo+72oFxgZcUjLnc7FQkxT
         jvOWV5pgX1FTP0wrCGMUEgo/gRBkWzkCr0r2iCcDon0sgEDfsGGN8BKERulBIdSgVp
         CJHDeIjag9Q31U6GZnPxnlW6k0TUSNHPs/lE2zIobgahDbb6tEyzmjGcsAOgBDLt+n
         eCfDuJ/9ngfXzXuGvv/3vkrnfk/zy8nPq+Z1ZOZo1pgIgrdEaGSg27/5hx1zU4YJjl
         yIG8RNvTnJhng==
Date:   Fri, 23 Apr 2021 17:56:30 +0100
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
Message-ID: <20210423165630.GH5507@sirena.org.uk>
References: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
 <20210423163437.89306-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
In-Reply-To: <20210423163437.89306-5-andriy.shevchenko@linux.intel.com>
X-Cookie: This is now.  Later is later.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 23, 2021 at 07:34:28PM +0300, Andy Shevchenko wrote:

> We have two headers split between include/linux and include/linux/spi.
> Consolidated them under SPI realm, i.e. in the latter folder.

Why?  Isn't the point to maintain an abstraction between the general
purpose use of the SSP IP and its application as a SPI controller?  I'd
check the cover letter for the series but there doesn't seem to be one.

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCC/D0ACgkQJNaLcl1U
h9CLHAf/eyWaZV/yF5wLiXo/wOpqfrx3e/NqVjLRELGlZE+ar0ILQQ9eW9MXKr1d
dY8YMPYTi95D/hs2pHwY+69eqE/jSVqiDXg0ClNqfcNE+T/u+AJP5AjN8vxkHgA1
2D5kguaPu/cBUZgByp4oDlAVTdFlT44mLDNwgjBaJR+/zMUl35CTKqzLYD2XB7+6
vj9KiXPatFJLphF9XoDc0s8Z2lZZkUWhVG3hku2pvH8E2X+zJpAQYFKtxwXAKSrt
zjuR7BvYrlIRgZnYT6ct3gtl+fPoBXimyvWDH86cxopeAsiHcFg7Jq7+TqlOYtPY
ZEwe0ACiO9v2GD60nmZC4JwhDTSMgA==
=0Eci
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
