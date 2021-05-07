Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81383767FE
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbhEGPbu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 11:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236987AbhEGPbu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 May 2021 11:31:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8ADEC61490;
        Fri,  7 May 2021 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620401450;
        bh=g0Uek6Gs9CSnkse4Z/lxWMK/xTjzgvu1If/zRYOXFiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZcZnE1PlUypeA/fiKORXeNA3WSMaIByBrjQ6Jea51GqJskQIOdWuy0F2cgkH3F09l
         NIxCb+5n1cm6LFw/0OfMSSbtj+K/xeqplBrlV9Vg73+PRv4LJVfOEh60EiBP9wIc7d
         r0KsdLfNGlUFFFztvKFVO/NkWCFZQO0vPOO+bQqx3AOX+2HrfF5vmkEusaHdh6pMvc
         viyC2DEtOyRiFhmSFxfF9oGJ658qaUdR0f6oHCiVLltiBEkLp44v9TGXB7OUeMoFJy
         WB5sukTqdFJor5hmbT94CDTrAtJi1/DNeUsk6BGg5QCHuzjV0momQn51h7D5t8HVje
         7RoO3Py+U2KDg==
Date:   Fri, 7 May 2021 16:30:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: set right CS polarity depend on gpiolib
Message-ID: <20210507153009.GB6383@sirena.org.uk>
References: <20210507145117.43221-1-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <20210507145117.43221-1-zhangliguang@linux.alibaba.com>
X-Cookie: Postage will be paid by addressee.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 07, 2021 at 10:51:17PM +0800, Liguang Zhang wrote:
> After a kernel upgrade from 4.19 to 5.10, we found that tpm flow control
> always causes TIMEOUT which caused by wrong CS polarity setting depend
> on gpiolib.

>  			if (spi->cs_gpiod)
>  				/* polarity handled by gpiolib */
> -				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
> +				gpiod_set_value_cansleep(spi->cs_gpiod, !enable);

Whatever is going on here it doesn't seem likely that this is a problem
in the SPI core given the widespread use of gpiod based chip selects -
can you provide more explanation of what you're seeing here, how is the
chip select configured, what is the hardware expectation and what
actually ends up happening?

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCVXQEACgkQJNaLcl1U
h9BJOAf/YxxDQ7dMouvaxwZxByVW2K4B4VQcnqKaEh1ZtMvj/QIQpld6kA0q0/o+
DHpG6nkWoCDi4J/J1vTVXNj5nBC/bPZwmYyC7uIe0FQThK/FnniIr8NW9Z0TUUOP
pCGofwcwuY3bZeI1dYpUvLnrPUgLSnnlE/9Sy6dYLnmTFbJZ5gA8hKK0k+84I6cE
bvL2BkG8AJ5Fnt8rGk3yiRmt5U+eQmGCqq2AuYzMAJdW7HDLuWr0IgNg7BigMxJW
I2IeE1IJQncA1pwAPTBQkfLFZ2uKrEDXhWEKF6/+5LGiBbCH5G1iaGUlSbtsLSJ3
NFffDzQHMe1jUQRPFzGrDcqOKUjtUw==
=c8EM
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
