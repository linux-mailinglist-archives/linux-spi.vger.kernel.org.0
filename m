Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6211B46BBFE
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 13:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhLGNBh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 08:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbhLGNBg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 08:01:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DC2C061574
        for <linux-spi@vger.kernel.org>; Tue,  7 Dec 2021 04:58:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15936CE19BC
        for <linux-spi@vger.kernel.org>; Tue,  7 Dec 2021 12:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7697C341CB;
        Tue,  7 Dec 2021 12:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638881883;
        bh=DpVYegXuhfiKgJAvLNYtONC7nbWTMN1Qm1I4v3PWvCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TfPwW8Ix1B3GhatuGgmTW2zQmnTeMZel4jpIru6z1FpqRIR6aL0aNqMX4rZ8dPi5l
         PsIQyP9UaBOkEsKCXfbF8jophwwXEmuXC+y3Z5fD9q+SFjMmuvrzsQMe8pdv+Dvgxd
         lmK9zdjZo6wCXqOFvQK0IWeXLj88EYOVyhm9C34Sa1WuhTnLgo3wSw8Ehm7sCmuaUm
         dhQR52KT8L81rnZip9mSBeKq6i59p6zM/pWg77qMtJjYyRATbCm5g9dyxYf10ErXYO
         Vf4Nag5z4axLDU9M13Bs5N0dtLG9lAbr2nbMzJfIwjZazAW+DdiLT9ToQO2sGnYH32
         uZkvrbGntbsUg==
Date:   Tue, 7 Dec 2021 12:57:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: lpspi: Add support for 'num-cs' property
Message-ID: <Ya9aV9yAEt9aWUQz@sirena.org.uk>
References: <20211207104114.2720764-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LpzO8yCAAW8or/cu"
Content-Disposition: inline
In-Reply-To: <20211207104114.2720764-1-alexander.stein@ew.tq-group.com>
X-Cookie: Only God can make random selections.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LpzO8yCAAW8or/cu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 07, 2021 at 11:41:14AM +0100, Alexander Stein wrote:

> +	if (!device_property_read_u32(&pdev->dev, "num-cs", &num_cs))
> +		controller->num_chipselect = num_cs;
> +	else
> +		controller->num_chipselect = 1;

Do we need to use the num_cs property or can we just set num_chipselect
to whatever the maximum value that can be set is?  I've never been 100%
clear on why num-cs is in the binding.

--LpzO8yCAAW8or/cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGvWlcACgkQJNaLcl1U
h9DdrAf+LPgItkQgDR28DyA8aYzd3C6YX87But62u+v2/OygCi3xWtSCZKj8D61c
d7qZOyxUgT+l0nIr28esFtUNv4RLo3ijPJ+Eg00GSOLgQ68lSiJrt0MUAvJP/wDC
0dKYSU685ZopjhoSzaucxX77YdYyydZbiyIBIft5kI44HaRCubA+s2KFgMEGOAsN
OQZ3fIOp6of5xvRvvU5mmINEnSJtvZvRS/VY/a+kZUEL2DXo2jcJVeg8s9IubrSx
TCMxQKX9E3UdMyDcIBgfU7HC1DBeYYK9sXxcfvICm0lO707AkrMCYs04xtdiaKH+
cU8DjdnMqAV5kwWSSEYOOPvYVOa2dA==
=XVDB
-----END PGP SIGNATURE-----

--LpzO8yCAAW8or/cu--
