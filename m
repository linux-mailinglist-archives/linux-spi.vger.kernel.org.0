Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C5876552B
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jul 2023 15:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjG0NfE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jul 2023 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjG0NfB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jul 2023 09:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3B12728
        for <linux-spi@vger.kernel.org>; Thu, 27 Jul 2023 06:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81E2F61E88
        for <linux-spi@vger.kernel.org>; Thu, 27 Jul 2023 13:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81350C433C7;
        Thu, 27 Jul 2023 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690464899;
        bh=ub3Ru2u4FgF2jnEfV/jZZTeojhMCgK49KeNRHdZNOKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAwT2d+6QEh1uThhtytBrxaplR7FnJdX/sXrZSJqKtD7dRNrWiNH2GeWvawbV/Z6T
         TbY7CIM/qsmty0CsyxLJMqCnjTrigwVs/gz7GfE58diVZY7BZ6sH83ldTRzlz9Myb2
         4XPsEVfqvRGdC1e59nU5OPvfLxgYT6/lNpEegceNyvwIuCEB6sBH8hWIzFn9m5TDoi
         S9y5bex7BMe9x57sNiBQwD8VltG9uZ6dkh0rf1xyCG8RLjWTv2H1B0/kc7kcs0kkK4
         vnmMkuk6EQx2omfloK6fSOmmo6CYWheeC2lzcID0ya3yi1OX24xPkM0rvYAaoWFoEU
         PjBcoo3sW1fCw==
Date:   Thu, 27 Jul 2023 14:34:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        broonie@kernel.org, linux-riscv@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next] spi: microchip-core: Clean up redundant
 dev_err_probe()
Message-ID: <20230727-curvature-register-6eb0a2c60a8b@spud>
References: <20230727130049.2810959-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pCz3CLMzY8Oet4m5"
Content-Disposition: inline
In-Reply-To: <20230727130049.2810959-1-chenjiahao16@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pCz3CLMzY8Oet4m5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 09:00:49PM +0800, Chen Jiahao wrote:
> Refering to platform_get_irq()'s definition, the return value has
> already been checked if ret < 0, and printed via dev_err_probe().
> Calling dev_err_probe() one more time outside platform_get_irq()
> is obviously redundant.
>=20
> Furthermore, platform_get_irq() will never return irq equals 0,
> removing spi->irq =3D=3D 0 checking to clean it up.
>=20
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> ---
>  drivers/spi/spi-microchip-core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip=
-core.c
> index b59e8a0c5b97..ac3b7b163db4 100644
> --- a/drivers/spi/spi-microchip-core.c
> +++ b/drivers/spi/spi-microchip-core.c
> @@ -530,10 +530,8 @@ static int mchp_corespi_probe(struct platform_device=
 *pdev)
>  		return PTR_ERR(spi->regs);
> =20
>  	spi->irq =3D platform_get_irq(pdev, 0);
> -	if (spi->irq <=3D 0)
> -		return dev_err_probe(&pdev->dev, -ENXIO,
> -				     "invalid IRQ %d for SPI controller\n",
> -				     spi->irq);
> +	if (spi->irq < 0)
> +		return -ENXIO;

platform_get_irq() returns an ERRNO that can now be propagated since
the special case for 0 no longer requires handling, no?

> =20
>  	ret =3D devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
>  			       IRQF_SHARED, dev_name(&pdev->dev), master);
> --=20
> 2.34.1
>=20

--pCz3CLMzY8Oet4m5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMJycQAKCRB4tDGHoIJi
0vbKAQDMIGi7PA8ESbPR70ip9vtX/4dk1Xr2XaPRMdGNy4cXggEA8+0oD8meN1hd
QVSVVnCn0vufkZQ9aTOA4rvJIa9OFgk=
=jbY1
-----END PGP SIGNATURE-----

--pCz3CLMzY8Oet4m5--
