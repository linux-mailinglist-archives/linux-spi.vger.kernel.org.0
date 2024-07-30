Return-Path: <linux-spi+bounces-4075-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A5940BA9
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 10:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD6F28B37E
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E99B193096;
	Tue, 30 Jul 2024 08:25:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AED193090;
	Tue, 30 Jul 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327933; cv=none; b=XOT6SJcr1S7/MHAn3Ss6OHllbzA8SrfRj34BHZ6BmdA2qaBK4hW0l9i2dxbwNNPOig45TO9PiQ5lf+0vgd03m+MiZtVblPZM2iFjPbzlEMl65UvgGlcUoRvEJzOfXJWgAzQpeTJSH20uVPZgMxWbGTkgMQI74Q7XYx3mOllyXSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327933; c=relaxed/simple;
	bh=HA2AEVmLo6WLmKFEAZVSWNnIY2vEVriFdmKqHFysBDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dr+I4xQ9VTvI3dBQ79m0ci6g+xB7ekGkdIcp82Il9DcnFcp7p49Geqkppj1r33yfcqUhHsPCaSb4llRFP/BUs3X26m+TJTw+mEY1FRjGYGqqZR7cEmsJzLUQFv/4UZ0D0gPRVCe9xjXmh25WBDnS3CMBZZDo8ulVpxPAqW3ez+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e05f4c63de6so3172853276.0;
        Tue, 30 Jul 2024 01:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722327930; x=1722932730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTwyRfbnL3Vd2nInjbowAn/v82AChyBb6zdgSzsmtyE=;
        b=Lm7raiadCuWnIu15QXQCcQDB1w2Zb4ZPOO1FGbyoIywcHO88mHDkqk8GbvfL/hdBA5
         bdn07Yzv/lsazP41uHwk5ggf6zFWw9k/iIR/tIzrLwfZ/bhTaZUkKu2k4JITsgft5BSL
         eWdEM6rgExX9h9kNVsOz0tpFHmSdLwCoDEOS2NZrke/YgM5VApPARBajqMyEw8VSf7SK
         k0pmux9kKKuAwhvHJTPpr8RKCEm9SbFV6dp/hoJ1lpofSg5NVjsa1zFGuJAr9wO3SgPv
         HmCLqJ93Cna3Niuikin4+hqQNEg4mfxe3Z4cTQ1JZwOEGWY9jRD64B7PL6tmmYDsKfc3
         IN9A==
X-Forwarded-Encrypted: i=1; AJvYcCVn96POQb9EhhH6MNWl6VRymBJc5oXMwU/l0Em9MK45jAktfcuyZbzoaTYVp+tfv9cINOuANIVYnJwR6pXUKMe8xmRGf/LRxT6R9zmbmozsusZznS0dEsEqhnQWu09EZPkf71yNPA==
X-Gm-Message-State: AOJu0YyTUQZVh03a1aYuZwZiYjzAjB4DM33qPv0Mkqz0UtuK7CIZIseF
	V/ffrAaDFvMbr+JrhrPYGeaSnRwJt6eQJyz68UCIM55w4LGwLx+37zpVRSUG
X-Google-Smtp-Source: AGHT+IFSx5DGA3mTPkIeYe7a0xhSc2o+1XUYbzhyZevmBjJrKV0FlsAlZd1UtgDUGTuPZkrcYhK3fQ==
X-Received: by 2002:a05:6902:1549:b0:e04:e298:3749 with SMTP id 3f1490d57ef6-e0b5451bc9dmr10248157276.33.1722327929703;
        Tue, 30 Jul 2024 01:25:29 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f1afaesm2208322276.13.2024.07.30.01.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:25:29 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6634f0afe05so32363807b3.0;
        Tue, 30 Jul 2024 01:25:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVT+w10ejT9BHxXRZ/MMiIoa+dOJ1e4oZ+ran/wobyMLXGgt310EMuVnAE+abfFavYRP+HZQlnUxeQT3AHxgXWYi8JNPiuRs1uCz162w/pPAkx2KtNMCTz2ldU+WHThn1ViTAd6qw==
X-Received: by 2002:a05:690c:c92:b0:65f:e4f0:8347 with SMTP id
 00721157ae682-67a0672876amr125652927b3.13.1722327928932; Tue, 30 Jul 2024
 01:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724154739.582367-1-wsadowski@marvell.com> <20240724154739.582367-5-wsadowski@marvell.com>
In-Reply-To: <20240724154739.582367-5-wsadowski@marvell.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jul 2024 10:25:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWnd8BOLVXpAy8CoFqKzYhp+vj6un=w7Umpo6OQ=Nxqng@mail.gmail.com>
Message-ID: <CAMuHMdWnd8BOLVXpAy8CoFqKzYhp+vj6un=w7Umpo6OQ=Nxqng@mail.gmail.com>
Subject: Re: [PATCH v11 4/9] spi: cadence: Add Marvell SDMA operations
To: Witold Sadowski <wsadowski@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, broonie@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, pthombar@cadence.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Witold,

On Wed, Jul 24, 2024 at 5:48=E2=80=AFPM Witold Sadowski <wsadowski@marvell.=
com> wrote:
> In Marvell xSPI implementation any access to SDMA register will result
> in 8 byte SPI data transfer. Reading less data(eg. 1B) will result in
> losing remaining bytes. To avoid that read/write 8 bytes into temporary
> buffer, and read/write whole temporary buffer into SDMA.
>
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>

Thanks for your patch, which is now commit 75128e2a14a9f443
("spi: cadence: Add Marvell SDMA operations") in linux-next/master
next-20240730 spi/for-next

> --- a/drivers/spi/spi-cadence-xspi.c
> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -310,6 +310,7 @@ struct cdns_xspi_dev {
>         u8 hw_num_banks;
>
>         const struct cdns_xspi_driver_data *driver_data;
> +       void (*sdma_handler)(struct cdns_xspi_dev *cdns_xspi);
>  };
>
>  static void cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
> @@ -515,6 +516,78 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_d=
ev *cdns_xspi)
>         }
>  }
>
> +static void m_ioreadq(void __iomem  *addr, void *buf, int len)
> +{
> +       if (IS_ALIGNED((long)buf, 8) && len >=3D 8) {
> +               u64 full_ops =3D len / 8;
> +               u64 *buffer =3D buf;
> +
> +               len -=3D full_ops * 8;
> +               buf +=3D full_ops * 8;
> +
> +               do {
> +                       u64 b =3D readq(addr);

noreply@ellerman.id.au reports build failures on 32-bit (e.g. [1]):

drivers/spi/spi-cadence-xspi.c:612:33: error: implicit declaration of
function 'readq'; did you mean 'readb'?
[-Werror=3Dimplicit-function-declaration]
drivers/spi/spi-cadence-xspi.c:638:25: error: implicit declaration of
function 'writeq'; did you mean 'writel'?
[-Werror=3Dimplicit-function-declaration]


readq() and writeq() are not available on 32-bit platforms, so this
driver has to
depend on 64BIT (for compile-testing).

> +                       *buffer++ =3D b;
> +               } while (--full_ops);
> +       }

[1] http://kisskb.ellerman.id.au/kisskb/buildresult/15210014/

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

