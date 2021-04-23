Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC2A3691DD
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 14:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhDWMUC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 08:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhDWMUB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 08:20:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C56E161164;
        Fri, 23 Apr 2021 12:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619180365;
        bh=dog/xLpQqowTjGHGJP07KiadhPbfqltRniXkM2vOlrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNtxBSIOB6wwJuefe79wQs8JtYvDcHIomkXTdZzXbtcrS14ktbaRnqJ67gQMUnm6H
         hNC1gURi91HMPZP6MaV24w70ZAcX5CzdHTLT9f+1Pm4bO38f36F8wHu2aCsPQncZDU
         U3RTgMMFghaBYIsqVfmA/b8wsNChZ9AoiZSy80fo5b2SjxijhMTx0bGquopFSJs4Ny
         vyM/SNTxTNFm8D+Z/5//1wFFw2hNiPYY1XX1EpwHUSx/bjVZjGwGeIvlwyCXtQgzSJ
         7XikMoheXf5I01ZdUFtmFVDUPXSgLnqeIlF333w1funMZUblrnsatEozPhH0uLF49V
         FhmYsIMvxWwPQ==
Date:   Fri, 23 Apr 2021 13:18:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@esmil.dk
Subject: Re: [PATCH v1 6/8] spi: rockchip: Set rx_fifo interrupt waterline
 base on transfer item
Message-ID: <20210423121857.GC5507@sirena.org.uk>
References: <20210423084155.17439-1-jon.lin@rock-chips.com>
 <20210423084750.18533-1-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <20210423084750.18533-1-jon.lin@rock-chips.com>
X-Cookie: This is now.  Later is later.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 23, 2021 at 04:47:48PM +0800, Jon Lin wrote:
> The error here is to calculate the width as 8 bits. In fact, 16 bits
> should be considered.

Bugfix patches like this should go at the start of a series so they can
be sent as fixes without any dependencies on earlier patches.

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCCuzAACgkQJNaLcl1U
h9AAAQf/Qjm/+4+LzO33oO9cV6hO6Qouo3JWI+uca9JvRsgPC6FYe4Ajmmw8b8WZ
PRoYsyzo4vOVeUp+rLJRjyQn1tY5H24YC82WcjxmA1BYEF0Nk0JHU8iZIgFU4sj7
f5yte8EOXePjXnXsqfK0DqoPH2UZv6VISlI8Cc4Up8dMd7PYHwMmG+eB0DPvfZhw
u5KoFmT4nEN2uI5+NkcYr70JKfsowcgPceOqpv4HKwPGgeiASTLq0m2hpTyDedv+
V8sUu19feaaG416yuEenLFzpGFbo9DO0WWvZuZY3bmIVWuGWhCX5p5niLJn0iWnk
bRfd1AGKRw7eR8JJ1bXXGPRSD+T1zg==
=23Tg
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
