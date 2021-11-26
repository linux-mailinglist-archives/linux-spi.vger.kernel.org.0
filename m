Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99A545F011
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 15:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353586AbhKZOpu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 09:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377796AbhKZOnu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 09:43:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47886C07E5E1;
        Fri, 26 Nov 2021 06:13:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A7A362266;
        Fri, 26 Nov 2021 14:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1C5C93056;
        Fri, 26 Nov 2021 14:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637936021;
        bh=DkN9LUQB10lRmYffxcuhdD1rPsxQocXanrCARKMrHqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Br5cILNPWxkaryyIlI7WJ1n38qvJ80mvPUt1pi3ladxEz4bQHJLEOZyGNVTV4HeO2
         lcV/lDTRVN+NM7IXDK46l25lIANFV+lbfRy+NRp1nSBNNam2HcF0Mj0eJuv/a5wJiO
         HtdmrcAZgcoIl5KqQgyDRw+sMkWId9mIrq4jB+XUJwh8XhSkLkAdY1n8m89NJkCkrk
         ItariRi6sscbV25GguYXeTihDyerSfunaqIGkz7HFAGq0JvF9a6mW/oRdCunouJFcP
         +7bDQcrcWt9RUYh3UZCJ5YWWh0zM+qf6xzMTGdIFvVkYyuRKVEy1Dy8/j5Xnvoo4t1
         +Rc95lN34PJHQ==
Date:   Fri, 26 Nov 2021 14:13:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 00/20] External ECC engines & Macronix support
Message-ID: <YaDrjkjfK/y/n+BO@sirena.org.uk>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
 <YaDjDhOhpHMdxiqA@sirena.org.uk>
 <20211126151059.10c19ec7@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g+gorfJwnR4/9QA4"
Content-Disposition: inline
In-Reply-To: <20211126151059.10c19ec7@xps13>
X-Cookie: You fill a much-needed gap.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--g+gorfJwnR4/9QA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 26, 2021 at 03:10:59PM +0100, Miquel Raynal wrote:

> If you acknowledge the SPI bits I believe I can carry the entire series
> through the MTD tree. If you fear conflicts and need an immutable tag I
> can also do that.

It'd be good to have the tag just in case, there's generally a lot of
work in this area.

Reviewed-by: Mark Brown <broonie@kernel.org>

--g+gorfJwnR4/9QA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGg644ACgkQJNaLcl1U
h9BIrQf/avs8oHB8MeypsEpJO2gSyoTvspKH1wvFzuT2pKwVXXS3u0m2kHHxssDs
+oICXDdOyIyfNmJZvL9hl7TcIkoJFqVL/xMNrfV/5wcaJULDq8GAx1lS/wxeWgHs
00ECYEa043dyYg5KX0TQzuXgc2CT/q/p/RiCH3Eal7EGgcnC0/T5UEJorNHcyYIT
ld9UAUoT6mZs8+wtYFUAGrbgAGeudaJ5ovpF8o2E625AaujjATvz5SvYQNuk1YP9
VtdiJfVEye+rSJpGecR2891W3rkHLR1Opvlrx6shd5P0pbZ5xnZXDsn6GCSUi3NU
V5Cdhwg+4Wzo1s7hdPIo5XY4OGNopA==
=oNr3
-----END PGP SIGNATURE-----

--g+gorfJwnR4/9QA4--
