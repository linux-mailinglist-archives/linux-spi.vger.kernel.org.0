Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5977B1A26FD
	for <lists+linux-spi@lfdr.de>; Wed,  8 Apr 2020 18:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgDHQQf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Apr 2020 12:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbgDHQQc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Apr 2020 12:16:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D9AB2072F;
        Wed,  8 Apr 2020 16:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586362591;
        bh=6hfSDzlNd3y1sAU9Jd6AakTZV7IxYTRVxEaxCRmGfg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOyaNOTlJ2XyyzWqchJBMbWruRXC7Q/NRjmPfx7WISfQlcmaFnOeJyKRgH6RsICTS
         IEg1yjKn4l8xZHu2G4rogmcYU9C8z8bxB2VbTFfchAh9HNf167lePH96C9wCbEIWqN
         V/mL6nhDbH7D2EMa6yiXlSL2Yj/C+Ucsao8umDLQ=
Date:   Wed, 8 Apr 2020 17:16:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 21/35] docs: spi: spi.h: fix a doc building warning
Message-ID: <20200408161629.GC5177@sirena.org.uk>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
 <d62f3f3536c0da2062bad87524fb184ad5a9a5f2.1586359676.git.mchehab+huawei@kernel.org>
 <20200408154925.GA5177@sirena.org.uk>
 <20200408181154.6c290772@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20200408181154.6c290772@coco.lan>
X-Cookie: Sank heaven for leetle curls.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2020 at 06:11:54PM +0200, Mauro Carvalho Chehab wrote:
> Mark Brown <broonie@kernel.org> escreveu:

> > Are you sure this is a sensible fix?  The following lines should be part
> > of the documentation for transfer_one, will that be the case after your
> > change?

> Without that, Sphinx will warn and may produce something unexpected.

Right, but if the warning is telling us something useful we want to
handle it rather than just shutting it up.

> If this patch is applied after 20/25, the output should produce the
> correct result:

> 	https://www.infradead.org/~mchehab/kernel_docs/driver-api/spi.html#spi-master-methods

OK.

Acked-by: Mark Brown <broonie@kernel.org>

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6N+NwACgkQJNaLcl1U
h9COfQf/RyWv5ouZMvEbQMIpNX5InGPPjbr0C27pLKeFq2wSUXNasDikm8a1bBEZ
Pi0AzsJgcZv1GPxAgrbBJ2zygGAWcZZChhKTLZoGVMKjLX5DFX5uTF3deH+bfvoG
mQHF+l96EIaAWQA1aCGb2iBnhLkTy0U902SAp8mYZgS00VNKLJMlaN/cEZVzX3Mt
P0NFR4b/gAW+1YiS5Ra7muv9mINJUo7esIOei6SSxqeJZJMHaWE+Dr/LCmaA3EFf
lIvp4u+uZQRGerdS8bZJVqfInf4wLwL/cPWvvaRnVBBwK1MRBAhuZniVN1TRfn8i
clWcDXFG40bUNJt4TyqTq2hrYFZ/9A==
=DOmV
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
