Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32B83585CB
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhDHOFx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 10:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231901AbhDHOFw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 10:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D048461130;
        Thu,  8 Apr 2021 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617890741;
        bh=c/qgNDwkcocIuy/eJhJGCaujFtddkd4baMyo7n1aums=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ns7+gXE2w1OZn9jYpdIJWjit9ZZNsYeSuJW0uCfDubH9WxaFHMVJu/sURWi8vPrIG
         4TmLX//CxkxFWmTGiaWRe+PTju1ZXj9KhlpJVqWCB9UaivlPp4ogyv9yxzz8shn5kv
         uPSEu6a5H0bmsZYK/MDxQS5qQvVtqifBt7W3JuRcpRbmF7ASA2cNA+zcwryyTThAZ+
         nnxOtJUw/XW6Fy0WR55AURmpMMhkRNSEatsiwIwul4BexTwPkgzswndY6HWic5sGoM
         6TuIfWoUs8RSsmFf6/7goM9nJ/HxPYdfoDBKjQcljR5sR4Tbos9NzVsNWTilzPEBJe
         T1R/fLC3ktdPQ==
Date:   Thu, 8 Apr 2021 15:05:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: imx: add a check for speed_hz before calculating
 the clock
Message-ID: <20210408140523.GH4516@sirena.org.uk>
References: <20210408103347.244313-1-xiaoning.wang@nxp.com>
 <20210408103347.244313-2-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Content-Disposition: inline
In-Reply-To: <20210408103347.244313-2-xiaoning.wang@nxp.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 08, 2021 at 06:33:47PM +0800, Clark Wang wrote:
> When some drivers use spi to send data, spi_transfer->speed_hz is
> not assigned. If spidev->max_speed_hz is not assigned as well, it
> will cause an error in configuring the clock.

Please don't send new patches in reply to other threads, this makes it
harder to follow what current versions of things are and causes problems
for tools.

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBvDaIACgkQJNaLcl1U
h9DpFwgAhu6kubADli5uS9eG0/RYPI4U2CNpsUZ+kwYdfdoNvEecSr9Qi16J+BG3
/UB7gUUx0vszDmJoECWgeuJjRw05iAJJgyZmmo6V3V+0AwcdhDTaNxAZOJy3eYUF
Lt/R/Prz3KFS8PReOGJ6tlZWjZ3FdSF7nzyQBcqkHqGAyLEBgE6j/r/2oeY6KSps
L7BXJrOHrzZL6K8ahmtD5cm69uIg3M74f21Un+ndGVoZf8m0XpZR16ivf0G1zfLg
Ci+301tdOHk/UjbBQkhlVO80WQyr9U+e8daNV2WwxPLUdR4tY9ZvQxqWKM2/uNQa
zTOJu2uF2otRJ8SDqrXs6MIlIDhJMA==
=58bV
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--
