Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B3A73A65A
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jun 2023 18:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjFVQqd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jun 2023 12:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFVQqc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jun 2023 12:46:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0591FD2
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 09:46:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31126037f41so7311195f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687452389; x=1690044389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKit6Klf35rtcWHSIsJEh9KnVVuihBfd/gsE/ykCfpY=;
        b=phQWvSPuaYnNlU+46Qik1M+5nKmkQTwYV8Ere3SGn0v+hKTe+TIGvjvsNSOFLC0HxL
         pSdiTuXPS0mF5zoSMti/0Co8aqa2aHh+i2WwtYFRnKV5TIWj6GXpsR1S0qCDVjGPKVNm
         GypQlGLPRKQ01Zn8MTNOraan8A0PTRiH7gOfvQcgflHXE9qWya5lf+eqnE4b1PFh0J5J
         MX/e741A8Nrkg16xJPbEatRL626tJkwWpCAvk5WVITp9ZCk9HJoqczyjZLAWQSk2znrY
         DqAjpayr+J2MwCxOhzgPaC/Fu6JwIwkdzcsyN28U2lRxMatGmE66ES/2wK0orwVOQo+U
         wyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687452389; x=1690044389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKit6Klf35rtcWHSIsJEh9KnVVuihBfd/gsE/ykCfpY=;
        b=E4s6613Y15pQcl/ffpmW5fX3WcgKryDLxOxUbzh58rj7ZQTR95h7E4r1u4+nhniK3l
         sRkUcYxdUMzlhPGG8wXoKid5WxT9Jx1aKd/EpQquI9wlPJ9P1797ca/Qx4zy6Iy+JJFk
         H80+6oOZ5QRhbdzJjaPdazg70x7k7zoJMbBE791J0OxkjhezH1LNUElPVNrA35znm4dR
         tLxmRBo+vHITImiP/QQHZUf9hQwyL5Zt5ZcYUIuNnOsUZqOKn6fZpojziAU8UhAsoK/v
         riHTvffMHGDyuMphZfuyNqkA12mQBRAfVkAJvbO1CYTcilNfM6nGrTbIJxH5MV3uBOI7
         bAjA==
X-Gm-Message-State: AC+VfDwYkbCdNv9LyHKRxqKDnLIdJRR/zl1fxxOZWT02N51zeEbGYDf4
        lK/m9ode5V13uWRn4eZvgAo=
X-Google-Smtp-Source: ACHHUZ6Sq2IKozzNl7QnjPp8mSJ69iSL/h7oGhxEZxQrMMvX4i7rQs6fmuB61fSi2z11RbLXR6PmoQ==
X-Received: by 2002:adf:ffce:0:b0:30a:ec3b:58d8 with SMTP id x14-20020adfffce000000b0030aec3b58d8mr15179860wrs.3.1687452388981;
        Thu, 22 Jun 2023 09:46:28 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id d4-20020a5d5384000000b003112b38fe90sm7447602wrv.79.2023.06.22.09.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:46:28 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 0/3] spi: Helper for deriving timeout values
Date:   Thu, 22 Jun 2023 18:46:27 +0200
Message-ID: <2686152.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230622090634.3411468-1-miquel.raynal@bootlin.com>
References: <20230622090634.3411468-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dne =C4=8Detrtek, 22. junij 2023 ob 11:06:31 CEST je Miquel Raynal napisal(=
a):
> Hello,
>=20
> I recently came across an issue with the Atmel spi controller driver
> which would stop my transfers after a too small timeout when performing
> big transfers (reading a 4MiB flash in one transfer). My initial idea
> was to derive a the maximum amount of time a transfer would take
> depending on its size and use that as value to avoid erroring-out when
> not relevant. Mark wanted to go further by creating a core helper doing
> that, based on the heuristics from the sun6i driver.
>=20
> Here is a small series of 3 patches doing exactly that.
>=20
> Cheers,
> Miqu=C3=A8l
>=20
> Changes in v3:
> * Collected a tag.

Did you? I don't see my a-b at patch 3.

Best regards,
Jernej

> * As my platform runs on 6.1 currently, I cherry-picked a mainline patch
>   changing s/master/host/ in the atmel controller driver and modified the
>   series to fit the new naming. I then cherry-picked my three patches and
>   verified it compiled correctly against a v6.4-rc1.
>=20
> Miquel Raynal (3):
>   spi: Create a helper to derive adaptive timeouts
>   spi: atmel: Prevent false timeouts on long transfers
>   spi: sun6i: Use the new helper to derive the xfer timeout value
>=20
>  drivers/spi/spi-atmel.c | 18 +++++++++++-------
>  drivers/spi/spi-sun6i.c |  2 +-
>  include/linux/spi/spi.h | 17 +++++++++++++++++
>  3 files changed, 29 insertions(+), 8 deletions(-)
>=20
>=20




