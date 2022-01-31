Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144794A4904
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 15:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376367AbiAaOJy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 09:09:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51246 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348422AbiAaOJx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 09:09:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D493612D0
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 14:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7088C340E8;
        Mon, 31 Jan 2022 14:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643638192;
        bh=jXGJkyT3Rvu+8wHDV5OUpz8/9nynn1UrsKk8WN+zxPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXsZQQ+ijZQ19BrA/qng+VAzKfN+Hj0dcHDyYgR9RO07CpMJW6J6Ghsh16rh50xce
         IHrU6WvzTeKGD0/9C8VaiCD6snvJUDGZJpiHHenTDJmGoPBKttahmZTtJnQllSt2J/
         U+0j4QDqHKMsN1Gcb9LWvddQuKVeQZ6Vr4gbvigDIL0jbWaqOeYLzIOvcRIwrgHAEJ
         dnYLADoXGCGlIFFKLfbWF3hxDYJgPzDrn4qLdhStMjGRGflHXCoCopmqS96Kiwhe05
         K16aUIf2Lm98mOJpixHiOdm/ru3YLC+5MwStplDWMAPXLAwasE7fw2D264VCO/kcp5
         913oDn/oDuhjg==
Date:   Mon, 31 Jan 2022 14:09:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH] spi: bcm2835aux: Convert to use GPIO descriptors
Message-ID: <YfftrEMHCyWg5dNh@sirena.org.uk>
References: <20220121224126.312227-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SKyiL5JoAmUa0TKN"
Content-Disposition: inline
In-Reply-To: <20220121224126.312227-1-linus.walleij@linaro.org>
X-Cookie: I never did it that way before.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--SKyiL5JoAmUa0TKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 21, 2022 at 11:41:26PM +0100, Linus Walleij wrote:
> This one is pretty straight forward to switch over, the driver
> already relies on inspecting cs_gpio just check cs_gpiod instead
> and stop the special handling of requesting the GPIO and stuff
> the core will take care of.

This breaks an x86 allmodconfig build:

/mnt/kernel/drivers/spi/spi-bcm2835aux.c: In function 'bcm2835aux_spi_setup':
/mnt/kernel/drivers/spi/spi-bcm2835aux.c:447:6: error: unused variable 'ret' [-Werror=unused-variable]

--SKyiL5JoAmUa0TKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH37asACgkQJNaLcl1U
h9D75Qf8DeJWohziomSuaHD74izrX6wM9VomqAwBVRYNZgYb1uIterHvGTgGi/4I
GJ/mXlRSVIV0LlMZOlHBTpaJzRScr5FPCL4F9xRZ5t50xCyRhRTyk+/S7ScLVizF
O6BhK126MxU4cTSJDtVzoFhQRq/IAJTpOIJmudAMiqqrMZi9VqPynlCspxZRY9vG
ljW6iUXapWmLcGn+amb+wtHekBGCfYppSmbbnJFCrGRZuprNkZBjX9KRoQGjHn8H
xL5MKo5z1F3RagqqYOIaEh9P5uyvjnUKM+osjTcXDqpLK2ow1YSpBHIP1qAX84kX
UymXB2prhQpiNRjBWbu+asnJ9y17oA==
=tvkZ
-----END PGP SIGNATURE-----

--SKyiL5JoAmUa0TKN--
