Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3366BA076
	for <lists+linux-spi@lfdr.de>; Tue, 14 Mar 2023 21:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCNUMC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Mar 2023 16:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCNUMB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Mar 2023 16:12:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A9C27D69
        for <linux-spi@vger.kernel.org>; Tue, 14 Mar 2023 13:11:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x3so66881133edb.10
        for <linux-spi@vger.kernel.org>; Tue, 14 Mar 2023 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678824715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Psn+ZNsvz+f0rmdAxM3umOGfhwT8TclOdJfGLvd1awU=;
        b=kn2N25+ZV2LJk+6Q8gXk5Piw+tlJzE3G6tcycy73tBvEv6yTaWxMc6PPO8SWiJ1kUX
         IO1XuElrqYEmiQ20elOKMnRL+wuTZw21TgzEI1/KSyvc0TxxUzqJhfgGrkkDpmGfgsTu
         ymJjKCF5p29DlEvQJCYPO/lYkb2Vnylj3aV0L/Ca/EyUCs2Ieiaf/7rGYVCHakUztSud
         AiaHcnueqiHNtzRXfSPMj4/+LQq5jrhXzAgj+d6I9L030W9RuZqSQOYzG6xMv7wIsun0
         FJj09/5ufbcVBiO66Di7L/snpOVUYWYREkAZKfiyQNI9Os6i20yTbkZQffoP4SvDRdHN
         vosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Psn+ZNsvz+f0rmdAxM3umOGfhwT8TclOdJfGLvd1awU=;
        b=u4aaR5mJcQnAg+QUiNhbLM7MelpIDr7m0BVz9rFGYIrs/DaZ09/Rq1sRo9iv7l3aHz
         rMoTWsXYgGuAqzm4Auk3yaKOmRIVoj/76YRNJBazjqhJ0EDi4OINi9iqZ8MoLeTHzwy4
         88XqRoS5VUN9G6LzBsVere8IudvU/LQfR/SSeR4cVAuqPAg4B+8p5+1nATMeGZ6rBqZt
         iSYUNrXMcIB+XPjWure8UcXFw/c0ftT8re77ClyVdLNmSGK4p4WufAumOQnRmKFx7gOp
         a+NJQvNT+7r2ibWBNK2lGMZsfQM+uuQJ3wp7bUKDgifs7j+XhQlrFGd2FgOqTFa2TYqH
         C3sg==
X-Gm-Message-State: AO0yUKVKDZ9XbCRxWtNpW3jue1pSIee3vIg1vUujDEOp0jHte0wza1yO
        oYiVBHTYQRoqrOPyQ8/ckXxZaeVp0rsw4+k8
X-Google-Smtp-Source: AK7set81Sdi8Ag2OLXzypBycmwWBYTYONBGYNe393ehQSP6TWWFhDRJaFujDkZqUi3eH6EGl8ZgfWg==
X-Received: by 2002:a17:907:2097:b0:8af:1a8c:f13f with SMTP id pv23-20020a170907209700b008af1a8cf13fmr4045889ejb.71.1678824715561;
        Tue, 14 Mar 2023 13:11:55 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id n10-20020a50c20a000000b004fb542dd8cdsm1520471edf.29.2023.03.14.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:11:55 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH 74/87] spi: sun4i: Convert to platform remove callback returning
 void
Date:   Tue, 14 Mar 2023 21:11:54 +0100
Message-ID: <5811350.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <20230303172041.2103336-75-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-75-u.kleine-koenig@pengutronix.de>
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

Dne petek, 03. marec 2023 ob 18:20:28 CET je Uwe Kleine-K=F6nig napisal(a):
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

>  drivers/spi/spi-sun4i.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 6000d0761206..994d0fb50e68 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -516,11 +516,9 @@ static int sun4i_spi_probe(struct platform_device
> *pdev) return ret;
>  }
>=20
> -static int sun4i_spi_remove(struct platform_device *pdev)
> +static void sun4i_spi_remove(struct platform_device *pdev)
>  {
>  	pm_runtime_force_suspend(&pdev->dev);
> -
> -	return 0;
>  }
>=20
>  static const struct of_device_id sun4i_spi_match[] =3D {
> @@ -536,7 +534,7 @@ static const struct dev_pm_ops sun4i_spi_pm_ops =3D {
>=20
>  static struct platform_driver sun4i_spi_driver =3D {
>  	.probe	=3D sun4i_spi_probe,
> -	.remove	=3D sun4i_spi_remove,
> +	.remove_new =3D sun4i_spi_remove,
>  	.driver	=3D {
>  		.name		=3D "sun4i-spi",
>  		.of_match_table	=3D sun4i_spi_match,




