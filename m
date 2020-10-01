Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B6C2807FA
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 21:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgJAToj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 15:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgJAToj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Oct 2020 15:44:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B6220759;
        Thu,  1 Oct 2020 19:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601581478;
        bh=2V7HlSyNEslc1covxiaFiHZZqdlJlvt46hDyXQkVCA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJtnGfOAkZWCTKRePMT7l9YhEV6zYwI8uN8ywntl6jogf79hNNlUEeoWHbYWpjFC8
         nMiJc2FX2JzivOgcjnlbQO6bDjaLHbjFr4oGjmBIrFLwxRF2BbOQaEEWkUn1lD1MIC
         iRwVhjWf6say2NuFPsEZuZ0Z/Caxnn/B6DxPi8dc=
Date:   Thu, 1 Oct 2020 20:43:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lukasz Stelmach <l.stelmach@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 RESEND 0/9] Some fixes for spi-s3c64xx
Message-ID: <20201001194339.GX6715@sirena.org.uk>
References: <20201001161340.GM6715@sirena.org.uk>
 <CGME20201001182315eucas1p1b1fc9d5d0ea91db6e56e92d5cf2583e5@eucas1p1.samsung.com>
 <dleftjft6xg60r.fsf%l.stelmach@samsung.com>
 <20201001190257.GA11048@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y974o0GblB/Ae/yP"
Content-Disposition: inline
In-Reply-To: <20201001190257.GA11048@kozik-lap>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Y974o0GblB/Ae/yP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2020 at 09:02:57PM +0200, Krzysztof Kozlowski wrote:

> That is correct. We did not provide final comments on the list so they
> could be added here - in change log. This would also be an explanation
> why there is a resend. Another solution would be to extend the commit #7
> description - why only CMU case is covered.

If there's a new changelog then it's not a resend, the changelog is part
of the content so I'd expect a version bump for that alone.  IIRC the
changelog needed some clarification anyway?

--Y974o0GblB/Ae/yP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl92MWoACgkQJNaLcl1U
h9DkUwf/Q5mZrBgWiJ7OR5eXyU6SNeIUcRLdLbFiKgF+3qvxJ1woZzsRRhKnRIMX
oIF1Pdls2/dYfciM0H50BkbEp9HS8RALDbyx0S33yzU6tnzyd/lQx2GTXfiwzaOv
fXlFteC36RYVbKD0iFBVEzVFph8xLXxGwqYFkoeLuTMAFLwI7Jm9CJyYG7O8/wYm
R+gIjO20BYA/43uRbXz1zWT75zWYOaq/wRHv/NKsvb8IeFnaM19rXt9pKKa6h+xM
admrHi4BPQW5MSoxMl0n1DWknzAUFbAcGOewBhDT5O5BosQiw7b0HC802hzZbKw3
sN1l4PAqHgmJ9MHZPX7iWFvArD1iEQ==
=oJPR
-----END PGP SIGNATURE-----

--Y974o0GblB/Ae/yP--
