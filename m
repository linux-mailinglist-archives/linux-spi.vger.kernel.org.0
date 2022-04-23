Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F131D50C2C3
	for <lists+linux-spi@lfdr.de>; Sat, 23 Apr 2022 01:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiDVWdT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Apr 2022 18:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiDVWcP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Apr 2022 18:32:15 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C777B1E71AA;
        Fri, 22 Apr 2022 14:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650655261; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHthjfTv/HM2Ti1svLIYl8G14Pjf02MoaKKk/9XvI/I=;
        b=RTAablMEtt4DpQgsVxkxPy1v71PS0fgkcF6hasRTRwZYKDuWZdrnerFxE3N69kxv2JD2be
        4J6L3JGrBFF/EVg0+Drxi6V/NWfSvkZOYe+8oehv5iGuejB9W7pJESBNHUutuTNZ96Nfqr
        ybU+u/ZMYzHGxmSuTYJLMs03lJWnjcU=
Date:   Fri, 22 Apr 2022 20:20:49 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] SPI: Ingenic: Add support for use GPIO as chip
 select line.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, contact@artur-rojek.eu,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Message-Id: <PQ9RAR.93DKCD4H5Q7G1@crapouillou.net>
In-Reply-To: <1650654583-89933-2-git-send-email-zhouyanjie@wanyeetech.com>
References: <1650654583-89933-1-git-send-email-zhouyanjie@wanyeetech.com>
        <1650654583-89933-2-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Zhou,

Le sam., avril 23 2022 at 03:09:41 +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou=
 Yanjie)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Add support for using GPIOs as chip select lines on Ingenic SoCs.
>=20
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> ---
>=20
> Notes:
>     v1->v2:
>     Use "device_property_read_u32()" instead
>     "of_property_read_u32()" as Paul Cercueil's suggestion.
>=20
>  drivers/spi/spi-ingenic.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
> index 03077a7..bb512ca 100644
> --- a/drivers/spi/spi-ingenic.c
> +++ b/drivers/spi/spi-ingenic.c
> @@ -380,7 +380,7 @@ static int spi_ingenic_probe(struct=20
> platform_device *pdev)
>  	struct spi_controller *ctlr;
>  	struct ingenic_spi *priv;
>  	void __iomem *base;
> -	int ret;
> +	int num_cs, ret;
>=20
>  	pdata =3D of_device_get_match_data(dev);
>  	if (!pdata) {
> @@ -416,6 +416,11 @@ static int spi_ingenic_probe(struct=20
> platform_device *pdev)
>  	if (IS_ERR(priv->flen_field))
>  		return PTR_ERR(priv->flen_field);
>=20
> +	if (device_property_read_u32(dev, "num-cs", &num_cs)) {
> +		dev_warn(dev, "Number of chip select lines not specified.\n");
> +		num_cs =3D 2;

The "num-cs" property is not required in the binding, so I don't think=20
the dev_warn() is warranted. Just silently set num_cs =3D 2.

With this addressed:
Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> +	}
> +
>  	platform_set_drvdata(pdev, ctlr);
>=20
>  	ctlr->prepare_transfer_hardware =3D spi_ingenic_prepare_hardware;
> @@ -429,7 +434,9 @@ static int spi_ingenic_probe(struct=20
> platform_device *pdev)
>  	ctlr->bits_per_word_mask =3D pdata->bits_per_word_mask;
>  	ctlr->min_speed_hz =3D 7200;
>  	ctlr->max_speed_hz =3D 54000000;
> -	ctlr->num_chipselect =3D 2;
> +	ctlr->use_gpio_descriptors =3D true;
> +	ctlr->max_native_cs =3D 2;
> +	ctlr->num_chipselect =3D num_cs;
>  	ctlr->dev.of_node =3D pdev->dev.of_node;
>=20
>  	if (spi_ingenic_request_dma(ctlr, dev))
> --
> 2.7.4
>=20


