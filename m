Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F380D5797BC
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 12:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiGSKdw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 06:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbiGSKdv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 06:33:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540C53FA3B
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 03:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A9D6120D
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 10:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7286DC341C6;
        Tue, 19 Jul 2022 10:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658226829;
        bh=Xn83ecU2wCOaHNwWG6uiKyygv0VhxGuq5EZQClqbeZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GnMufvbhx6r3czB1f8jD0DbncihLBN2VFYbCmn9j0r7SGLzuWqV3mGrdXJwUPuoSj
         yIPQw0ss3fAMgKj/racccvOLr47XWnKjds5xJ88INDzNMaSWKMcdhFRSuEbGkIEsow
         ZDoL1WuYot8VU3jLw4jcMN7zIGSS0/ClBOgVVAID9Zr2h1t1mnfAfklwCuAOg6nMLT
         8ctBnQrqGjTyH7QR0BTF7/UT56zyc7u4G9h4CM0ADgCzuq3zO9A/XrLDfGPPlBgIIZ
         VH+ZLLNvb6QHQkTdRsvyKV7EiL6AEjfExyC2vQ8DJtHbL4NIzTtf2iwKS0VaQphLVl
         SCOr9MQ9crt6A==
Date:   Tue, 19 Jul 2022 11:33:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Lindahl <jensctl@gmail.com>
Subject: Re: [PATCH] spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer
 deref for non DMA transfers
Message-ID: <YtaIh41xhArXaxJS@sirena.org.uk>
References: <20220719072234.2782764-1-mkl@pengutronix.de>
 <20220719074701.GA26268@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5WyeXN0ok3S/mr94"
Content-Disposition: inline
In-Reply-To: <20220719074701.GA26268@wunner.de>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5WyeXN0ok3S/mr94
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2022 at 09:47:01AM +0200, Lukas Wunner wrote:
> [+cc Jens, Florian, Stefan, Mark]

Can someone send me the actual patch please?

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--5WyeXN0ok3S/mr94
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWiIcACgkQJNaLcl1U
h9CD8Af/UMfUaOmRTHKdlErilMuw9Qs2vuWSeCiEIk0ZoHE/6jLoqGSzfwv/4xjf
FdvCh2x3pyT9xOlAW6qC/zBp0cx6GileQ+SljUjJGjoKo7OQAngcA1458fAEvkr6
LTFzllvqIHTfqPBu15TMebvc7Gp/5SefrFfzVIgGvipQh+MrjlCJYPkGL8Dk1fjQ
ut4Ji69M1xtxDUt71hbZR/AUlJw+Ov2p75jbgrblKz7QC9CVhiqCMZGjwg4IuGi3
rR+97yHZxZb6mai96g2el/89t/15lwJt0hl0VVxWGvJJ6pWzcIbBPwtuRyLj/PWi
ylrTXOCkBcoMn7aVJo0zYooebyXIYQ==
=tApv
-----END PGP SIGNATURE-----

--5WyeXN0ok3S/mr94--
