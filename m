Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BCA6ECB83
	for <lists+linux-spi@lfdr.de>; Mon, 24 Apr 2023 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDXLqV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Apr 2023 07:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXLqV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Apr 2023 07:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479153A93
        for <linux-spi@vger.kernel.org>; Mon, 24 Apr 2023 04:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4F436133D
        for <linux-spi@vger.kernel.org>; Mon, 24 Apr 2023 11:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4C7C433EF;
        Mon, 24 Apr 2023 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682336779;
        bh=GxOTEZ4mrEoi+hKdxhOMZ9S7w/cm0pC791wpQL9b93s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPkWm39uLKarHdhU+rHY+G8eqVpU1GTFfVKc5CCBnEuJqwNqQ+Su6cTugiZHZBEQy
         aXVSdSninNrgefpqKcIxdb0tZX59rJRV5UngszKUt+YHfkkYztcvbw9JUQiAKpIidS
         gz0LRy8Y+A7HqOkD4xuMnjktIqNrRTeUtTrx/Ty9pk8F0IBICGb9f61H2nxrDvBlH4
         1jAAlK/jbmgjdkXYInZhvEySTukFdF5yx29at1bPxBV6aIlA41X23trqLU3zZdHOYd
         BND3zG3g7kZ+p6D5lTYkwyqqjPcfe7FwpVDjrzlLtlFBS71Khd/OZ2uTBqn03Me/KP
         vmSrcapvnwGTg==
Date:   Mon, 24 Apr 2023 12:46:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev, linux-spi@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Evgeny Boger <boger@wirenboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] drivers: spi: sunxi: Enable irq after the initialization
 is done
Message-ID: <2fe1f98b-9126-4245-bce9-d8fbb3da9ba8@sirena.org.uk>
References: <20230423023056.27929-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HoSjYou460whfHPF"
Content-Disposition: inline
In-Reply-To: <20230423023056.27929-1-qianfanguijin@163.com>
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--HoSjYou460whfHPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 23, 2023 at 10:30:56AM +0800, qianfanguijin@163.com wrote:

>=20
> The kernel error messages is as follows:
>=20
> [    1.362449] sun6i-spi 1c06000.spi: Failed to request RX DMA channel
> [    1.369654] 8<--- cut here ---
> [    1.372716] Unable to handle kernel paging request at virtual address =
fffffffc
> [    1.379928] pgd =3D (ptrval)
> [    1.382632] [fffffffc] *pgd=3D6bef6861, *pte=3D00000000, *ppte=3D00000=
000
> [    1.388907] Internal error: Oops: 37 [#1] SMP ARM
> ...
> [    1.784024] [<c0159c54>] (swake_up_locked.part.0) from [<c0159d9c>] (c=
omplete+0x30/0x40)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

>  	ret =3D devm_request_irq(&pdev->dev, irq, sun4i_spi_handler,
> -			       0, "sun4i-spi", sspi);
> +			       IRQF_NO_AUTOEN, "sun4i-spi", sspi);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Cannot request IRQ\n");
>  		goto err_free_master;
> @@ -506,6 +506,8 @@ static int sun4i_spi_probe(struct platform_device *pd=
ev)
>  		goto err_pm_disable;
>  	}
> =20
> +	enable_irq(irq);
> +

The usual approach would be to move the requesting of the interrupt
later.  Why do this instead?

--HoSjYou460whfHPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGbAUACgkQJNaLcl1U
h9CJJwf/VNOgCjbqjYTgMaVHVc2C9gviY6zsIwlQZG4/72QxhCpqIxro55eug/cD
ShKf4fwVT1lgR2AXw1mMvYZAYSiZI5fFFwn39P4ix3R3delx0Z9TdrFw7ifL6Qnz
LjR4kKJWm3JUfyOIKK8GGoCXQhTAF8ht8MQq9PbZ9n+cYDYkEeshVSyOWJN8ru6Y
FKkrJXTAXiLBnauW1bdk5+NIUWzi7XiUiilVctoS4gtwZekQgHNqZ52YEV2qGYCG
7WUtEsKLOH8URWqy689WESKYUowXHsovZak/Rx/pVDGRS6lFhl/dirKY2aczM/AI
5A0ZPzBflw+KhdlY6hcHrI+UcsbHeQ==
=UKfX
-----END PGP SIGNATURE-----

--HoSjYou460whfHPF--
