Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860061D5606
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEOQ3G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 12:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgEOQ3G (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 12:29:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC980206D8;
        Fri, 15 May 2020 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589560146;
        bh=02a10HlRELSqC3xc/FlfsbLp83hhvpY7LD4P6Y7ikwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJjW5VDNDgiIsXymkUEuY27/7Zqo/bYh8p6pyISEj4OhawiZviWZw93VvMjlM0M+7
         iHDcJDcw34UlUI29JsVkvCYKO91N4thZaDhaErONviR8inXqvkMpcJ0fbkJyd05JyJ
         0481pqwvDIyo0Z4vfDJvz9MWVv+RrrXYv7RN7ETA=
Date:   Fri, 15 May 2020 17:29:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] spi: bcm2835: Fix controller unregister order
Message-ID: <20200515162903.GH5066@sirena.org.uk>
References: <cover.1589557526.git.lukas@wunner.de>
 <2397dd70cdbe95e0bc4da2b9fca0f31cb94e5aed.1589557526.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Content-Disposition: inline
In-Reply-To: <2397dd70cdbe95e0bc4da2b9fca0f31cb94e5aed.1589557526.git.lukas@wunner.de>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 05:58:02PM +0200, Lukas Wunner wrote:

> Fix by using the non-devm variant spi_register_controller().  Note that
> the struct spi_controller as well as the driver-private data are not
> freed until after bcm2835_spi_remove() has finished, so accessing them
> is safe.

Why not use managed allocations of clocks and DMA channels?  This is a
standard issue with the devm APIs, if you're using them you basically
need to use them for *everything* up to the point where you start using
them.

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+w04ACgkQJNaLcl1U
h9BF0wf6Ajz3aDrk3pYLSVXJ+s8F/JyfnNOvMRwtBPgjnmYAocvIvRQdrOfa75/d
QlzjIg6w8NV8cgW2FW6lRUwOoQxF58z2NrQcHL0nEhpsyRlwVMcDFVMcQyws1gnh
UpDzX/g+3ycua/YthTbkynmXk8F86YDbH9hmqbgDYfaXgM0AISlYiEz4XnGaIwmC
fKrFE/ubMdVxuodboexPdsZzTbAWRsB3lOKcBOUOBLikd+9tpE6n/0cr6PlI8o/y
r+ndLb7opAEdYnx1KtYilYjh0tT7mOb0bYqy2jxU3RkvB+8CbtJsEGxBGmLDRp+0
gvq9RGTtrfSmuhMgXXSk3bdnGM8Kpg==
=lVMZ
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--
