Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF163C8479
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhGNMeD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 08:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhGNMeD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 08:34:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AB10613AA;
        Wed, 14 Jul 2021 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626265872;
        bh=nahy1W015l8+NhORm4BEbvW8qG/FZwQ32UwrQ/3E9og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2JH3F/wyhQpiX+Lq2nND/IV88dsNGNmOhUV36omP5YnYP9z+DkXsADdc2uLfQC/Y
         5MRSwhzqFYVlJopbtoLIwSxcrBIu6ckk8urT1HlcEk+fYvuyeB/M7PkcCulQhjv0uc
         GLjoBy7XTielDHFkBnobVe95UbC1zNW+IuWNdzSII018HzLm7NRGXFoAInKD0yzys3
         +a267ToRoI/VpP4DxKE+BFZUHi4iNGi6qDgzz24HObP37Xlao+V6tsPNrjUm1Syd50
         rV2W0tmBVN6D/66J0K2KS6WjhaVpYv5vBz3SEPHXSZY1WNImfX6kLCn0Zu1/tXHqTV
         xQEnKkzz+lnmA==
Date:   Wed, 14 Jul 2021 13:30:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?5rGg55SwIOe+qemahg==?= <ikeda@nskint.co.jp>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        =?utf-8?B?5rC06LC3IOmbheijlQ==?= <m.mizutani@nskint.co.jp>,
        =?utf-8?B?5qaR5p2+IOeglA==?= <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Fix division by zero warning
Message-ID: <20210714123034.GB4719@sirena.org.uk>
References: <1406d756-1edb-6294-116b-91c7a9d29b71@nskint.co.jp>
 <20210713122528.GB4098@sirena.org.uk>
 <3b9745c1-ec32-793f-41c2-98c9f60057cc@nskint.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <3b9745c1-ec32-793f-41c2-98c9f60057cc@nskint.co.jp>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2021 at 02:10:51AM +0000, =E6=B1=A0=E7=94=B0 =E7=BE=A9=E9=
=9A=86 wrote:

> Indeed, I too think that the tracing part should be limited to the useful=
 range.
> I would like to modify the tracing part as follows and repost it.
> Do you think I should narrow it down further or do you think it is too na=
rrow? Or unnecessary?

That looks good to me.

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDu2OkACgkQJNaLcl1U
h9CaVAf+NeCiYK7pHv+YF4z7bUNfLkPrdkq4uDXu4jSiD9GNrfBvUN2u6Hw39AJ5
xf3KK2F0CmCPMhoPAX83EWlAUmw4aGPCDF7lmH1CZX8Dix0xxeopplUp+p3RAQat
+eEAnAef1vKBC1FwAmNAafwWzQD6aDbmz2aT1bwP+PdK4+NjATtZLCILFlhU6ye6
9HRNnJS3Ayqs4QK+QF8+BKS5NmBrRutyjodXzr8eWExPbyl2YxIYlvWgoTcMI9Sc
3Qf5Gi789wUB5kFgjgmpLS+KNv2qwxoW01yukNjjIMM5oZ9lL0AOzPsIMtNaJb/X
xRrCF9aDt+FX6rZJH1mbiQltfUF2Uw==
=kz9x
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
