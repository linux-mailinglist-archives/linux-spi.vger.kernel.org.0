Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE4388EA8
	for <lists+linux-spi@lfdr.de>; Wed, 19 May 2021 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhESNMs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 May 2021 09:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236567AbhESNMr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 May 2021 09:12:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1ABC60FF1;
        Wed, 19 May 2021 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621429888;
        bh=Ti983VGWJVGNmKGtZpeQI6MvM1IrNB91fNHehWkK1W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=caRF+02v0nzkietYt+rlD1Gdx0cxAbKB3PqL53G9RChvvo0BPqPOc9zd2GaIDc35Q
         acA8Is13HjWpecwwd2Qpjyre/ShZJq+YSqWy5op5Bg80MkBMrPQ4vLynqeazkAVQ8O
         TjXzujOkMbBUZf874mlVyrd0QBc043jwNKEBsdKavWaDudhSwrkau5iadb9ZXexD7U
         2FF9vnG7BC4d+MkZLlKD/Gcg7dYa01b9V6PsziNp4VOcho7XKIuEsMfYCJJHcjhvh4
         kvrhDYj1UaGlLc0UZ/Wn8Bz6K6cPe2HT7DOZxJ0Rt4vbZFZAqDV8HRcmV7yfhIGG7g
         FItgN5xhS3YRg==
Date:   Wed, 19 May 2021 14:10:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: fix some invalid char occurrences
Message-ID: <20210519131043.GD4224@sirena.org.uk>
References: <e606930c73029f16673849c57acac061dd923866.1621412009.git.mchehab+huawei@kernel.org>
 <ff8d296e1fdcc4f1c6df94434a5720bcedcd0ecf.1621412009.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <ff8d296e1fdcc4f1c6df94434a5720bcedcd0ecf.1621412009.git.mchehab+huawei@kernel.org>
X-Cookie: There's no time like the pleasant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 19, 2021 at 10:15:36AM +0200, Mauro Carvalho Chehab wrote:
> One of the author names got an invalid char, probably due to
> a bad charset conversion, being replaced by the
> REPLACEMENT CHARACTER U+fffd ('=EF=BF=BD').

I only have patch 2 here, what's the story with dependencies?

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmClDlIACgkQJNaLcl1U
h9AxWwf8DePV1mGIpuKQwDbezu3i7C8iL1zMh0JBH9t6rJRjy0Q+HNLKj2zQ0RFJ
peThVFBWEe0xGVGrC7+aXEc5SbAulymdYJhaXicSMzKGO51CSfirEi3wnzE7i3XF
3yIJoy5D5sTddqMy700NEfOQ6UHL5FozTpYH8pca1L5lXOP8lsC9BE+lkCJr17oI
fqp/xELuYSzuZwWbu1oTQnFPrIL0R8s8ANkCD/nMpFDDwg6OCvcZFgN9Hqo401kY
n93yeZui8BXVh3ho/OTvSAXQ/bs/zUC1Sr7pP9bhRViCRu66frbdwFXlyHLTwQzv
2QB+3FtOUlLzBjgmdmd5Puz8ggzLmQ==
=GwQR
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
