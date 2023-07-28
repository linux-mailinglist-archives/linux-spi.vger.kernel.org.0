Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CDA766661
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjG1IHL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 04:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjG1IGn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 04:06:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB423592
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690531583; x=1722067583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SHUZYQO6I8cVTLfFfVfxEsqHEAFJj+u3PnGVlT1Z+/k=;
  b=ONWtKRHCCRsH7k3laclUxKRepuMJhcT40BMMj/f6/JyxogMp61p/lsyU
   WDrhkRlm7JZmywoHeUuUSyTAPfqHm1agC/vNGcttS4EFu0IITpTK0aK0k
   b5NFQQCrDqe//y+3iZQa7DvzwHNmWUwm/8tzgJTwPdBUukaloHVsWfiU8
   Xz7KyVQj1qQjMamGXHf1r04lY0ZjENP8aMO0Ivm4D6bwEyz84EHGXwjIH
   WmWz++365Ruhw092tE9pbQRotOvkrDHVabsiO4ae72aTIOeLjl/sYAeDb
   Ostn0ASixQBKBQMIpbLRn/SI5Gdt8TO14DGdVLOHTjfnN11yidW8SJshs
   A==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="asc'?scan'208";a="225794246"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 01:06:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 01:06:22 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Jul 2023 01:06:21 -0700
Date:   Fri, 28 Jul 2023 09:05:46 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Chen Jiahao <chenjiahao16@huawei.com>
CC:     <daire.mcnamara@microchip.com>, <broonie@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH -next v2] spi: microchip-core: Clean up redundant
 dev_err_probe()
Message-ID: <20230728-edging-undesired-8dd77cfa0330@wendy>
References: <20230728075729.3451867-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xfgaa1yNGbNZT1OK"
Content-Disposition: inline
In-Reply-To: <20230728075729.3451867-1-chenjiahao16@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--xfgaa1yNGbNZT1OK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 03:57:29PM +0800, Chen Jiahao wrote:
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
> index b59e8a0c5b97..b451cd4860ec 100644
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
> +		return spi->irq;

Thanks for the update, looks fine to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> =20
>  	ret =3D devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
>  			       IRQF_SHARED, dev_name(&pdev->dev), master);
> --=20
> 2.34.1
>=20

--xfgaa1yNGbNZT1OK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMN21wAKCRB4tDGHoIJi
0sAwAQDnj0+ttqnLueX6n0q0DbDhQ3nrniPNgyvRkUcfsxXdLwEA5s97UjrOSkXE
WP007kXXp8V/t2KflZMXq/LJpjCwvgk=
=1AWn
-----END PGP SIGNATURE-----

--xfgaa1yNGbNZT1OK--
