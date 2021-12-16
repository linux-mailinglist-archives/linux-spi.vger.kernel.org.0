Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAE54773EC
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 15:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhLPOEb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 09:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhLPOEa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 09:04:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D516CC061574
        for <linux-spi@vger.kernel.org>; Thu, 16 Dec 2021 06:04:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F8A261DD8
        for <linux-spi@vger.kernel.org>; Thu, 16 Dec 2021 14:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2096CC36AE0;
        Thu, 16 Dec 2021 14:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639663469;
        bh=Luhq9Qub5yOdRpagbotKjMjuKOEuUYM1ukB/Tmmo5RA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qsa9sVPzdQq/HkMY6vGodXXyY/gHr3/pknTbXrKYwcb1l5xOvT78eU6utH9phJsfv
         0FCz/+WrII3lvmZqv1sBAIS4ySRdJw+g4WhSC4oaf6BP6b0wTU/qD7rKzlMGLgOI7D
         2r9ntikOZ0M1pb42NrlTzCrMv20nW0lxdMUaqRs7XXHfjd3bVxBSIj0nIlK94Jo8+X
         l2YWsYNmaLCmK59txBpeLmQVqRh8uFcf1JBC/jFCsIiB08eeD/1fZMycpXKCB/1jUO
         8+oInW62gyn2wNz15oIUDTUpOAKzonLW9Ri0oqCVDrwm+9gg9X9qdgC25zLY31cGcR
         4vLi+teuXwAuQ==
Date:   Thu, 16 Dec 2021 14:04:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v5 12/13] spi: mxic: Use spi_mem_generic_supports_op()
Message-ID: <YbtHYtcYsyrl5HaR@sirena.org.uk>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
 <20211214114140.54629-13-miquel.raynal@bootlin.com>
 <20211214172410.2b26c17e@collabora.com>
 <20211215184426.67fd3912@xps13>
 <20211215200548.75630b61@collabora.com>
 <Ybo/r8neydqTxN6N@sirena.org.uk>
 <20211216100147.46c307ff@xps13>
 <20211216105739.395a174d@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5fSdzfmMYl/ZYorm"
Content-Disposition: inline
In-Reply-To: <20211216105739.395a174d@xps13>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5fSdzfmMYl/ZYorm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 16, 2021 at 10:57:39AM +0100, Miquel Raynal wrote:

> Actually as the spi-mem.h header is not included in spi.h, it makes
> defining a static mem_caps entry harder. I'll go for another approach.
> Maybe putting the capabilities within the spi_controller_mem_ops
> structure, as these are highly related.

Yeah, or putting a pointer to a static declaration of the caps in there
rather than the caps directly.

--5fSdzfmMYl/ZYorm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG7R2IACgkQJNaLcl1U
h9B2PAf+K0NVwjqkRGd2gFYHI+j38MwOND2szrpxpvuAzaheD/m0XGUf3IyHHo4B
XOMkGUJRHfPXDBubovb7Qi2bfk27wPGtwPYrPGY8M44n8+1qThOZ8d+5jb+0WqXV
DR15kfAO6BtfrQfp4f7oQwB0N/8G0h3zccEUGtJEDKY4r2MFapQ3qthwtovqWNCV
8wMKvhQ7h+KJS6HSF/NJLGDJ+Dg19eBxKQeG9BQnZ/akhfUIIr7/83+nkH5tkrWK
VD8ezK+frReFgvu/bAgR4EoUhhLCXGi8r5Qimwhci2Dfn91LVLjpmIjgoO5SbVYO
vrqcZFQD+C4cnI2SCjWT5Si31cLpdQ==
=VVs0
-----END PGP SIGNATURE-----

--5fSdzfmMYl/ZYorm--
