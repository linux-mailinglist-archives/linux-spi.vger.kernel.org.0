Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409B02A4614
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 14:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgKCNSO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 08:18:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgKCNSO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Nov 2020 08:18:14 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3529206B2;
        Tue,  3 Nov 2020 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604409493;
        bh=FjctFotAp/vRQPEs9jCmy4tzJoGhbt/ygnsQ3jbmMb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqCY9m10jcayNnzxDcWt1NzrGCt7b0n42lEJHc119RKFXyKT4afoHB5G+Ug0XeQ6B
         p93Nq0npuQO058wtvAXs0vFeZY6ZJQUbmeye7suSgUuxZOektBeVlg0yZEhzo7cOVs
         qRHra2I5A/BTfHP+oKXGsdNJB2ha8sEQqIkJqLzA=
Date:   Tue, 3 Nov 2020 13:18:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bangzheng Liu <bangzheng.liu@unisoc.com>
Subject: Re: [PATCH] spi: add runtime PM for transfer_one_message
Message-ID: <20201103131804.GB5545@sirena.org.uk>
References: <20201102112239.19218-1-zhang.lyra@gmail.com>
 <20201102181655.GC5014@sirena.org.uk>
 <CAAfSe-tLpfFzCTzANspxAUVLus2UbWRZ3e6Ut0dx-geoKiuNEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <CAAfSe-tLpfFzCTzANspxAUVLus2UbWRZ3e6Ut0dx-geoKiuNEw@mail.gmail.com>
X-Cookie: I don't get no respect.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2020 at 03:30:24PM +0800, Chunyan Zhang wrote:
> On Tue, 3 Nov 2020 at 02:17, Mark Brown <broonie@kernel.org> wrote:

> > the error situation here?  This code has been around for a while and I'm
> > not aware of reports of issues here and I can't see anything unusual
> > that the Spreadtrum driver is doing.

> With further tests and looking into this part of code, the problem we
> found recently on our platform which runs kernel 4.14 can be fixed by
> this commit [1].
> In a word,  there's no issue here indeed, this patch should be
> ignored, sorry for the noise and thanks for your review.

Ah, great - glad it's sorted.

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+hWIsACgkQJNaLcl1U
h9D0MAf/QlbfuFCLsmNALSFAPqyTbyBatVDZXWKCr+OACXVh1J/jcWzAkm8kAiUN
vzmqEIW/cDP2KQd4qSOXxaeUJZAn3dDacb4Hx34diHBx2cwK5D6R/cGKkkcyVT6m
rqsSUqgxtFmjDUbLOx7h2vzLKcxTGLSQ/Wo5L1WkeSNEzaHGP4RAj8ig6Ku8+g7S
7pCO5wtRF9owUkCQJ6T9Ppo1goZkLVAxaaYs+WGL+XZeREKOdsKsJFzTFRE0qY7R
+rQBsEDKfCXlqxAMTc3o2hll8GvgVk1pnv6UmAH7gnURUYgNbxKZQKmo/Lfgul7D
8xT4fmpz3BHai0zKq8FIzjYxYOnnpQ==
=DbL1
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
