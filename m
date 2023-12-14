Return-Path: <linux-spi+bounces-270-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E28125B6
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 04:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE18B21352
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 03:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EF710E8;
	Thu, 14 Dec 2023 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiPV4soA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DE5AF
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 19:04:20 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so7003550b3a.3
        for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 19:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702523060; x=1703127860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eZiO0gk+5KKMfeGJ9O5brNObpLtTn3Dnco490GuJUg=;
        b=kiPV4soAarMz62Gk1LNxyXw9hodsDieYfIFQi/udKuSYXon3NoAHaGDNsiTNsJRVAC
         5bqtINrAKgljEhxyjEsmNpi0IF+iIv9tkcjHnVeta0t7gIi2i5zc+wCkPf8kjLxPCPlL
         tIFV/A+eqOBS68vyYE3PAptL7Am5fs/Chdm81F6yBIr0+5kegytwuaOcv6+4/oyezJK+
         b5lhHl75NgEuzjqPJI3On5ZJG0w4PMojCcIOMowpATK/p/6K3PCrGiHYUOf3TZTHhg4t
         Xx7PLzkCKhuCoBhIj/gYjZYzLZE1gMK9BOveH7wti2ErHDrEPg1h+0mgZFtuqMQaddX9
         Fotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702523060; x=1703127860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eZiO0gk+5KKMfeGJ9O5brNObpLtTn3Dnco490GuJUg=;
        b=asRAi6ryje/en+5zFvB6b3bVg4+ltxVqNlZTg1wOwKIeH/+pm62qQPvDMxQqcjbekg
         jkcxZRWNdtI9rYvYswkn/Mw9s72Mt2CqXCIhpxt1oQI061QVyPmD6bPTgOm4QWul9G8i
         EiqtvL/KZY/IWuNQTLo8ca3CeaiHduLE2s3EzA4NKQLix3xLlcQqgRSnaPo4ue5MiiXL
         rtyoVvUacj/vCweUUL4wjucbDccRgAUQvcdWJ+gs/2sczMx+Iq8bY33Qvpf/w71M13MY
         xqFW4rb6YZbRDpfUhNbCeJ8I3+iST+Zypg1Li7PEzZYsC3sf4SI8QCD9avzFJ02jDhL0
         aBFg==
X-Gm-Message-State: AOJu0YwVnFgSGCP33damfoXWUjOXMe+8ew5Qs5yzBByqkhvXLMZaxmTa
	/Rfgv4Qf6eMyq+vNKKjgtBLbeAU0jpCdsMwaE/4=
X-Google-Smtp-Source: AGHT+IGKTOOIa1SyV6onMKssajgbP3x9MAbeu7BySrxkEGLUJjYuvtU/Q53a1qJsMn3q2IUkZFaw+QzeryasB7yYjIs=
X-Received: by 2002:a05:6a21:3284:b0:18f:97c:8a14 with SMTP id
 yt4-20020a056a21328400b0018f097c8a14mr12166619pzb.63.1702523059852; Wed, 13
 Dec 2023 19:04:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213091346.956789-1-haibo.chen@nxp.com> <20231213091346.956789-2-haibo.chen@nxp.com>
In-Reply-To: <20231213091346.956789-2-haibo.chen@nxp.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 13 Dec 2023 21:04:08 -0600
Message-ID: <CAHCN7xJc+2fSCsU_Ff=8eUh9qtZku_rxTdvQxgXu9oced=b8Tw@mail.gmail.com>
Subject: Re: [PATCH 2/5] spi: spi-nxp-fspi: change the default lut index
To: haibo.chen@nxp.com
Cc: broonie@kernel.org, yogeshgaur.83@gmail.com, linux-spi@vger.kernel.org, 
	linux-imx@nxp.com, han.xu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:08=E2=80=AFAM <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> The fspi dynamic lut use the last lut for all IPS operations, the
> imx8ulp only supports 15 luts, so change the last lut index from
> 31 to 15.
>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 0feecf5ba010..9d6b4d22263c 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -64,9 +64,9 @@
>  /*
>   * The driver only uses one single LUT entry, that is updated on
>   * each call of exec_op(). Index 0 is preset at boot with a basic
> - * read operation, so let's use the last entry (31).
> + * read operation, so let's use the last entry (15).
>   */
> -#define        SEQID_LUT                       31
> +#define        SEQID_LUT                       15

What impact does this have on other SoC's with the FlexSPI with 32?

adam
>
>  /* Registers used by the driver */
>  #define FSPI_MCR0                      0x00
> --
> 2.34.1
>
>

