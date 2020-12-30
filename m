Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BE12E79C5
	for <lists+linux-spi@lfdr.de>; Wed, 30 Dec 2020 14:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgL3Nrs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Dec 2020 08:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgL3Nrs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Dec 2020 08:47:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F6A92220B;
        Wed, 30 Dec 2020 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609336027;
        bh=N/CDU10elT67zssZ6FeukjU1lKJappTeG4r930mdP5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8kdOH7wwuKnstg8ZYmOFc/uSL+UHO4iuWRt0K4G6ompQcej2y4TMowRf7+IxUXSA
         8sDYQO7p+NYthPoy7Xhy2XVWZznqgPkgygxQGHLFa2yai1H/JK+b5jT4h9TPG6w63O
         pdFhYr2ZsVJzkmQVTm6K0JWs3tZ77OJOhO1KwKRH79M/neKcDyUSY4aTpED8j4ei/l
         cmA1kZTBSsI6DTFTvQJb1h9WyvZYQGpbXe2KyLsk0rtTT5QxzWsKMTyjUK26CTfpxH
         ovMY9QhtAPmW0seRF4GnR3vMDOYx9JUGVXhSs3yamlaqkCM6eLIqatHbq4mFw673Xh
         IULe/gvcsW2oA==
Date:   Wed, 30 Dec 2020 13:46:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-spi@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: fix the divide by 0 error when calculating xfer
 waiting time
Message-ID: <20201230134644.GE4428@sirena.org.uk>
References: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
 <1609219662-27057-3-git-send-email-yilun.xu@intel.com>
 <20201229131308.GE4786@sirena.org.uk>
 <20201230022420.GF14854@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <20201230022420.GF14854@yilunxu-OptiPlex-7050>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 30, 2020 at 10:24:20AM +0800, Xu Yilun wrote:
> On Tue, Dec 29, 2020 at 01:13:08PM +0000, Mark Brown wrote:

> > Does this still apply with current code?  There have been some fixes in
> > this area which I think should ensure that we don't turn the speed down
> > to 0 if the controller doesn't supply a limit IIRC.

> Yes, there is chance the speed is set to 0, some related code from 5.11-rc1

Please check the code in the SPI tree and -next.

> BTW, Could we keep the spi->max_speed_hz if no controller->max_speed_hz?
> Always clamp the spi->max_speed_hz to 0 makes no sense.

Right, that's the fix.

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/shMMACgkQJNaLcl1U
h9AZygf/V8eX/Z5K+rBltX2NDwpCs/PlAdwwfFA9o2VIqJuHwTx2CUdR+R5t07m4
xj0xtFYlhBPkpCvSxBU84lW6YB5CzUuHP9KiHdPiyqaPHiL+/5JrsaNyIc0S/Hme
3KLZA/DWuA8ErjH6A6uOuoC/jz1P3usHuqSc5kB6F13DX4P2WQjT7ga+ijaYq7+v
2rxie9gLiZ0zMItqQnCgXffYh9+JVUnr7KybNC76uSHQ8WJPlevAGSQDeAN5OLM2
Ns1JIJuPhxLHOQsFo69+EqIjbsI/go7cYjgODnDiB3AuyigCiixzPbKDESuZEYbu
CR5+XqDCF1T0h9X08iPCClKNhwkjhA==
=a5cZ
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
