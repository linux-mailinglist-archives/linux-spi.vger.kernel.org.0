Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299996BA077
	for <lists+linux-spi@lfdr.de>; Tue, 14 Mar 2023 21:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCNUMO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Mar 2023 16:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCNUMN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Mar 2023 16:12:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A042622DE8
        for <linux-spi@vger.kernel.org>; Tue, 14 Mar 2023 13:12:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eh3so11037886edb.11
        for <linux-spi@vger.kernel.org>; Tue, 14 Mar 2023 13:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678824731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRAW+s3YRlQq9ELNdyAribiRoHUxDdhi6TfZn0sTs4U=;
        b=an/WrmIBb1xG0QZHI4bFzwDDiU4LoZagCTuDLCMZq4SGTA7QhTyJMXewtP/nJt3R5j
         Bp1+mwcGA7Dgs7dXcMNTz3mpqWNSPMyuLxuFrSqIPlQ1ypJ+jw6SDassBderY+eXdIio
         YlqOr44qiXSz9eVxW7HMw3tEaEWNCfnNIdr9h9dAzQZ4IQaJRHF9tV7RJLOXej+ImfYr
         vb68azsqM2oTLBP5qoHGzXzzoVZPf1AS1jpi4FUo30KNscwR9reTSYz5+/WUoR0gEOWA
         SyjuEq/p+QWUWmpKLqn2+maQFSlm8aB7U/TgxJmQNAUN+9L3mxAMdbRcUQfxMgRA4WUZ
         YgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRAW+s3YRlQq9ELNdyAribiRoHUxDdhi6TfZn0sTs4U=;
        b=ICj1xkUe2U+aax/gMUvHwaDbMqF/t+Zqrm7pCpvwYbSPffY8i9vLVquLjdK/Qt+ntG
         7VuMX7QKkzra+dtOd7H91kSemfGiY9hlWdY1ube5VKrbvCs2oo1Xk2+yjgseBE0DI+vQ
         EUhQD1OUvoFQ2GFtiiXvNqXS+4s3ltd9bXdcIH7t5TCASy32xpad6Pb4J9gLMvtmfi6K
         IJ0t/y5/6FwqsrNqEqQOlMMMh9Vu7f3b0fjfKn8PARqnsrtcPSVNsm9sYFNSqNhFpSLF
         ra/NbzcNQ7P/Kbufrr6htkL4pGRHKcbr3tsqjIprXe48qi/U0aVJYJ4iZCRcj+jCeAXg
         i6mA==
X-Gm-Message-State: AO0yUKVF/p+Mcd9R1O6fj6zfueKykzOOtdjv83m9gAlWU/NBi4ejxtsq
        UWFmCOcQBkbaTQGnD0WRb0A=
X-Google-Smtp-Source: AK7set/atfmmI/iiWSLj+6Q8qdeuejUSglqHN4Ir/kY6mIHUaNZh5/6ToQiam39SOdRa/z5WUQPoIA==
X-Received: by 2002:a17:907:2d93:b0:8aa:33c4:87d5 with SMTP id gt19-20020a1709072d9300b008aa33c487d5mr4590746ejc.10.1678824731247;
        Tue, 14 Mar 2023 13:12:11 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id qa14-20020a170907868e00b008f702684c51sm1528290ejc.161.2023.03.14.13.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:12:10 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH 75/87] spi: sun6i: Convert to platform remove callback returning
 void
Date:   Tue, 14 Mar 2023 21:12:09 +0100
Message-ID: <8231800.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20230303172041.2103336-76-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-76-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dne petek, 03. marec 2023 ob 18:20:29 CET je Uwe Kleine-K=F6nig napisal(a):
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/spi/spi-sun6i.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 23ad052528db..43c29afea6bb 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -683,7 +683,7 @@ static int sun6i_spi_probe(struct platform_device *pd=
ev)
> return ret;
>  }
>=20
> -static int sun6i_spi_remove(struct platform_device *pdev)
> +static void sun6i_spi_remove(struct platform_device *pdev)
>  {
>  	struct spi_master *master =3D platform_get_drvdata(pdev);
>=20
> @@ -693,7 +693,6 @@ static int sun6i_spi_remove(struct platform_device
> *pdev) dma_release_channel(master->dma_tx);
>  	if (master->dma_rx)
>  		dma_release_channel(master->dma_rx);
> -	return 0;
>  }
>=20
>  static const struct of_device_id sun6i_spi_match[] =3D {
> @@ -710,7 +709,7 @@ static const struct dev_pm_ops sun6i_spi_pm_ops =3D {
>=20
>  static struct platform_driver sun6i_spi_driver =3D {
>  	.probe	=3D sun6i_spi_probe,
> -	.remove	=3D sun6i_spi_remove,
> +	.remove_new =3D sun6i_spi_remove,
>  	.driver	=3D {
>  		.name		=3D "sun6i-spi",
>  		.of_match_table	=3D sun6i_spi_match,




