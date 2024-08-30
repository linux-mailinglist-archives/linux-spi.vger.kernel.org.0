Return-Path: <linux-spi+bounces-4455-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BB1965C2B
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 10:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F231C23513
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A478F16D4C2;
	Fri, 30 Aug 2024 08:55:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D0165F03;
	Fri, 30 Aug 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008122; cv=none; b=MrL8mACNLfi7DtRR/mrakTUMZkSVYtmJ7NXmK1ZQ27mJExCX2a8Ps43ROz2GcNtqSzkAlNUp2xdW96V+ajMX7Eya0xahZbXbS1CIGly/iKVqGZWHevVz1ltxL3+BQwMvl5Ela/hsgzVSOjxuF0rGm6jAzUId0/pcsKdYR2DXUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008122; c=relaxed/simple;
	bh=I51cX0mNEBF+yF4nyVvBseIEltym+R6b8Ds6s9PW/0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuflRzs2HQv0udbo9T3Ds/LT2SFm2WH2UvTg6LXZ6ueyR9uk688fyAaIz3BnYTIaUweRX1rjDuFeAuQ8eYYNuALVKhYCgg2U8fXnoUhKvwHx8/Q0ngSl8XENuSO0XNI4z8x+HF1PlSmJAFwu9/EY8EMdknlPwN0VjkwJDo3g/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ca1d6f549eso18395087b3.0;
        Fri, 30 Aug 2024 01:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725008119; x=1725612919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZFU6rYuadGeqRmLmwZtURIzSIfiZeSin6SJ4WwjBTc=;
        b=qY4GEkM4mj7Pen/u7lCfEYKhmZk3yl4wIQUBhbafhOQRjf7mNtLVfO3DrICsOF9+8u
         m2QgQLnLL7zETT8az+l66gUVCSDd3h/Ihba/J+FEyj6oc7VC4DihuaZuq1TwvWnKjZBb
         spz70pP3v3jA977xc35dYiJgPawhFx5adpL7s45i9ZgupiB3oPn0BpT/TiB92qnA9GMk
         vPha4TC9qmw9pzKx2t64e2o0ciu0XNuMqm0yv4A7fW0FPdVdaCI8ebWglsNj80s6kPST
         7iZmYkea0PepovUzQaIJcBVyKZAZCWfio0zYBv0V/LyNl1W+irvtHcjF0ddlA6+Fo/G1
         ijlg==
X-Forwarded-Encrypted: i=1; AJvYcCV9+Z17lJ5/VEVFL9Z+dWxDtkFHA301EK1KGWXIer+NyObpPxonSuia9FGA69E9TYLDAt8ap2J5leC5ZWo=@vger.kernel.org, AJvYcCWOo+CkEOhXg0hrKROWo3ZZY/ozzKbmuou0wzpiJ7N03vZ0d1D88ODWSLA1f2Da9ZV0XSK+PqMgOfKI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjzw2GXwcBlk6DP0Eah8kViI2ai9ZLhdI1cr6ytMdThdr64c/A
	WNLiFT8LUgo/qs6rr23xmU4y8EWfpqYzwtXMYApEd6wYU9buMVPKh/KJSX3X
X-Google-Smtp-Source: AGHT+IH/S7K5mnABLaG7rZuDA1vdxDPReL8xX1gc3VgbJvWextnBXjX3P8vqBtsK3d9EEbdO4yiGfA==
X-Received: by 2002:a05:690c:6609:b0:615:8c1:d7ec with SMTP id 00721157ae682-6d40f81e3f0mr11185547b3.33.1725008119382;
        Fri, 30 Aug 2024 01:55:19 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d39c739fsm5497017b3.23.2024.08.30.01.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:55:19 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ca1d6f549eso18394697b3.0;
        Fri, 30 Aug 2024 01:55:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVM42paUX/nuBluq3puPQ32va8aZ18+R30F7qVI4x6QVM8vKxeocjIZJdMMULguBM3QhSpWlw9d8VlXCt4=@vger.kernel.org, AJvYcCXUIUc2cZGH1ycZRSUW7FYT62of1lE2k+Lo+RPVFKizw0S6IwsEWRlScj6ZX5lplJuQlLUv/fYfReWk@vger.kernel.org
X-Received: by 2002:a05:690c:fca:b0:6d3:f51b:38c3 with SMTP id
 00721157ae682-6d40d88d522mr17244407b3.7.1725008118882; Fri, 30 Aug 2024
 01:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033511.1917015-1-11162571@vivo.com>
In-Reply-To: <20240829033511.1917015-1-11162571@vivo.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Aug 2024 10:55:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
Message-ID: <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: spi: Insert the missing pci_dev_put()before return
To: Yang Ruibin <11162571@vivo.com>, Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Thu, Aug 29, 2024 at 5:35=E2=80=AFAM Yang Ruibin <11162571@vivo.com> wro=
te:
> Increase the reference count by calling pci_get_slot(), and remember to
> decrement the reference count by calling pci_dev_put().
>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>

Thanks for your patch, which is now commit 8a0ec8c2d736961f ("spi:
Insert the missing pci_dev_put()before return") in spi/for-next.

> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c
> @@ -146,8 +146,10 @@ static int lpss_spi_setup(struct pci_dev *dev, struc=
t pxa2xx_spi_controller *c)
>         c->num_chipselect =3D 1;
>
>         ret =3D pxa2xx_spi_pci_clk_register(dev, ssp, 50000000);
> -       if (ret)
> +       if (ret) {
> +               pci_dev_put(dma_dev);

dma_dev is still uninitialized at this point.

>                 return ret;
> +       }
>
>         dma_dev =3D pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn)=
, 0));

dma_dev is initialized only here...

>         ret =3D devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, =
dma_dev);

... and freed automatically by lpss_dma_put_device() in case of
any later failures since commit 609d7ffdc42199a0 ("spi: pxa2xx-pci:
Balance reference count for PCI DMA device") in v5.18.

> @@ -222,8 +224,10 @@ static int mrfld_spi_setup(struct pci_dev *dev, stru=
ct pxa2xx_spi_controller *c)
>         }
>
>         ret =3D pxa2xx_spi_pci_clk_register(dev, ssp, 25000000);
> -       if (ret)
> +       if (ret) {
> +               pci_dev_put(dma_dev);
>                 return ret;
> +       }
>
>         dma_dev =3D pci_get_slot(dev->bus, PCI_DEVFN(21, 0));
>         ret =3D devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, =
dma_dev);

Likewise.

Hence this patch is not needed, and introduced two bugs.

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

