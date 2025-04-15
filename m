Return-Path: <linux-spi+bounces-7593-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C085A89603
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 10:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED84177C40
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16A27466A;
	Tue, 15 Apr 2025 08:06:55 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77378634;
	Tue, 15 Apr 2025 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704415; cv=none; b=ZF+1++cKIHfjr41rUITofCYzwk2rOTUWiaL6t9FylafC+aszwGgPuEpqedNsVMJuusp8DISSufKBkUlqYEqNw/pdADT+4k/LbbTNkcSUYN1f2abh5SkRiJ1jJYVhfeCiQhhKj0YK59hyNGHOVYxDamWkXm3pE2pXHDrGYAS5CaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704415; c=relaxed/simple;
	bh=awYdlis9cPibtfloHg93X0xSUHByIq02xs3+kKcj3B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgolaQHQVc7AXgGUZCX3D0pw6/IT5kDxeqcKK0msJ5CyS7ck3rhWUzroiitM9RLF0dVxQDTS6QfXIxxO81NPx7iysXtHeybiRao4A15z2XDgzAC4Nhk1/V+v6WikovOCmZcQtc1rXYtwQoca4IyhAm1s4+6nMuqIvD29VOqu/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-523ffbe0dbcso5319211e0c.0;
        Tue, 15 Apr 2025 01:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744704412; x=1745309212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoE7Sk3NEK10ejGR4MyJLM/QRd7ud4cKRNAMK4SJy3M=;
        b=vjZ71TShD/60d2TF4bk8PC9zwbYZTKOdudCOkcidI7eltBp0jPQgXkYEqxqTteAIwO
         7jpcmHkT/kB7TOwooKefnYGWMl7q3Ki31cdUu35DzucKozfRBt+q04N+Peh91MUiWW3e
         9GU7sZ/Oqv1Wop9dqfA0sgHgaJbuFCik6hij2ukrTScZN8jDiYKz84B7CeFQEd540IVE
         g9kNpt8/5EnbBCsXbmKm77jcMCNbm6wODbWV3xuTO6iz17C+pFz5tlF7LecFK8uPu/sH
         YdqxIJNgibs+QK0trBsHF9YuvO8VYQ2FotWgBAdAGG2mEIJKZfxzx1QJHN5gA4maYAfN
         IRBA==
X-Forwarded-Encrypted: i=1; AJvYcCVTXZ8Qz3ZVW5g7LVh7dQVpzmYf4ShVnLf/HVSwLvV5PqY2/nFH+agm0YgZhFS6Xjhh3nyONRsY28Yw@vger.kernel.org, AJvYcCWYnszFm/dQAYrjbJdQi6h9uR+0ffo/8sW8ncJ8YqRiV99gB8U2TdVrOxl+P/vxWvNaNz50zn2VCk9k@vger.kernel.org, AJvYcCXL7/PH65V73oYgg6OKT1nzIHSVHLwJU4ah8PTlUiLBf/57afQWNH1DNr2rM9Kpo8Tih9c2cSG9Sxox1F0Y3rGvZnA=@vger.kernel.org, AJvYcCXk9+jDep9qAt8q9HSobNZ6q6zaa3yY47SqNhEwhyF5W0o7rVITs9v8I68L74DX82klCiOf3u82vH6aoYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqz1XC6+J1j6qC86+G9/0oPMdBXZKUPBGZfiMBRPtMd8JsWap6
	ksxRr9ilXGK2o5s1HvfQny0aIzWNHRsOquDhJaDxYJpwb1Lj/9ZyeqcTbKR+
X-Gm-Gg: ASbGncv8gebf9o7/zuKdKpDJkm1MPHUgkiPAzrPIqY+4q5b7ixgdUdXAioKOsBlZr7P
	6TvNGgPWs8WLPAeV3+mRHZ9tYhtxuVOn1H0X9ZodMKgwxJ+sJYTtodBFinm8v2JB9PC/79R2Rpb
	enOZUV9BM5tZVuBGyqd/J0Myxm4LL+77oFqWiie59w8BPSb430KPSKpnz0ZeQNV22w73FqM7QHy
	m3t9B6cKivd7/JtSQoNL2PXyGdUT9vxkIBNp33Vhj0AJ5cQDaGaVBHLcXmsLUwL8ez/iLhvppQe
	BGnd1XFliH5hnx3qHg0WWFa6CuMHKfivFOZwPMu1BGA27qm+3TgFAs4zhNhI7kFOwBB4lAqML0m
	qxXc=
X-Google-Smtp-Source: AGHT+IHkVgit3zGoO4zwXJVvkQr2Y1PlvE1YgURPwmmKl+7re032t461pzPyiYRkWB6UTtz3lV2NjA==
X-Received: by 2002:a05:6122:d95:b0:520:61ee:c7f9 with SMTP id 71dfb90a1353d-527c35b020amr9138502e0c.7.1744704411649;
        Tue, 15 Apr 2025 01:06:51 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abd9b999sm2577221e0c.26.2025.04.15.01.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 01:06:51 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4c6cf5e4cd5so163202137.2;
        Tue, 15 Apr 2025 01:06:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9gQ/+mHAmN7eVliyf0u0mbZO4/slJ+hasj8Q1XMKo2q4bt6Hx/ooX9jd93az2KKKl6MrF8pFZsUpK@vger.kernel.org, AJvYcCWBxYVKou3zOPYNwuftGRutgHNArfgEkfSYTovtAgOXCw6JH0djd5utFIj3L+ZCnOlF+d6KcsbgPAAX@vger.kernel.org, AJvYcCWgt6C046I9p7JU/WTzS+EDtlQDuI/NKtcx7pub+BF1jCJpk2oGSl+ZYZk6TZZjBwpj9dbca9dVhkZDdwU323ueFuM=@vger.kernel.org, AJvYcCXTsBSR3pmaWrWGp3TQ6UYWkdkd9zK895wR9KzVP+QwgeXRyIF2w2EOeCEot6Byzs58EUqBtXUkELr3GY4=@vger.kernel.org
X-Received: by 2002:a05:6102:3e92:b0:4c5:1bb6:8165 with SMTP id
 ada2fe7eead31-4c9e4f12ee4mr11188743137.12.1744704410919; Tue, 15 Apr 2025
 01:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com> <87wmbm1a4b.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wmbm1a4b.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Apr 2025 10:06:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU3ieWELcj8Z2zQRJ4gsjz25nK+CZi1qDJByUUS9f1teg@mail.gmail.com>
X-Gm-Features: ATxdqUECV1MuAkt2dYlWZdeAGp9tizsog1IG4v0PoorYJ-_KQ05iwfNaUiWR2-U
Message-ID: <CAMuHMdU3ieWELcj8Z2zQRJ4gsjz25nK+CZi1qDJByUUS9f1teg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] spi: sh-msiof: use dev in sh_msiof_spi_probe()
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

Thanks for your patch!

On Tue, 15 Apr 2025 at 03:34, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> sh_msiof_spi_probe() is using priv->dev everywhare,

everywhere

> but makes code long. Create struct device *dev and use it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c

> @@ -1334,15 +1333,14 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
>                 goto err1;
>         }
>
> -       ret = devm_request_irq(&pdev->dev, i, sh_msiof_spi_irq, 0,
> -                              dev_name(&pdev->dev), p);
> +       ret = devm_request_irq(dev, i, sh_msiof_spi_irq, 0, dev_name(&pdev->dev), p);

Looks like you missed one instance ;-)

>         if (ret) {
> -               dev_err(&pdev->dev, "unable to request irq\n");
> +               dev_err(dev, "unable to request irq\n");
>                 goto err1;
>         }
>
>         p->pdev = pdev;
> -       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_enable(dev);
>
>         /* Platform data may override FIFO sizes */
>         p->tx_fifo_size = chipdata->tx_fifo_size;

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

