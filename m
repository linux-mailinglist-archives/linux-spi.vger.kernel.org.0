Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952B63CF03F
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jul 2021 01:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241548AbhGSXKi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 19:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387957AbhGSUiz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 16:38:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6021461004;
        Mon, 19 Jul 2021 21:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626729145;
        bh=lpo1v5ckLvhhZAti6ZE/KXHY/McZzcfPyprNOnEXslA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIq2irBJ3yL2H2wUJ7TEF/JWE5URK8fzuOaiUd+tioR0GWuCwnKKqGfN9uYbnDnFk
         3P5EOgn0IF1uSt2+S/7/S+DPb/Zh1HGCuZTQovjPmD10txTSu2Ol9W7tgbbRIaUZAq
         L7ZIHRwmWPkhvZnyt+UgVci3pmFJaBe4WVSovBZK0t6Rp4bkoP6+rGZfeOrkAv2gr3
         z9OxKLBqks8dVk4b7ev+tXM5GQ8Xrngb/YTAciJJCh8Vw8+/WkqWzl+Wj53EesGpq5
         +wFeGfYrvTgGTcjUmSnXZVAm1WwEn/e0pJjZC1xCgqjZm29PDvADlbO9OhcrxGhKaz
         77s7gtWYfeXVA==
Date:   Mon, 19 Jul 2021 22:12:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay
 calculation
Message-ID: <20210719211221.GA35544@sirena.org.uk>
References: <20210718211143.143557-1-marex@denx.de>
 <20210719082015.ud43iwg5rfdomlqi@pengutronix.de>
 <17bf62a4-af57-1706-f20a-35f9d6cbf9d0@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <17bf62a4-af57-1706-f20a-35f9d6cbf9d0@denx.de>
X-Cookie: Most of your faults are not your fault.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2021 at 03:38:55PM +0200, Marek Vasut wrote:
> On 7/19/21 10:20 AM, Uwe Kleine-K=F6nig wrote:

> > Can it happen that all transfer's spped_hz are zero?

> I don't think so, what kind of spi_message would that be ?

> And even if it was zero, the delay would be 2000000/~0U , so zero as well,
> which I suppose is the best we can do in such a case.

I can see that happening for a controller that didn't set any speed
information with a driver that also didn't set any speed information,
everything is just hoping that the default is fine but only the hardware
is actually setting something.  I've not gone and checked if anything
ever insists there absolutely must be something specified in software.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD16rQACgkQJNaLcl1U
h9Dnowf/aMDmdM7AH1JXe+tnCASs/5hpoMRg5ClwHrsXxzLKok69MlZC5JkuIUvu
cMpzuo2MuIrDgYvE0/8dVxxqzj92t44F0wnZ+G1AfMbbQa7MqQmNWMkLFLCT+RUi
+WIC4qO8WOFpHQC+ez1ITyYaIKYp8i0re2mJIWEg2L9BjItaQmX5vrUxtB5ESjry
VeVZ377vssNvdKvtaR+wELzIb9iPttwKVxVzdEYIVp7E10L8Ra19rvjcn2RJpx6K
6CYkAB+PiY+qFhO7w1ob001s7F86gWLwxPeaLk51ApzSRK/ehGsFXJtNd+hq3GMr
2PMIBsuQUvxtB8Kmo9lG7k1AoG5CFg==
=rgrl
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
