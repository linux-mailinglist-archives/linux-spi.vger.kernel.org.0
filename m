Return-Path: <linux-spi+bounces-8321-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79304AC630E
	for <lists+linux-spi@lfdr.de>; Wed, 28 May 2025 09:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068CB7A2005
	for <lists+linux-spi@lfdr.de>; Wed, 28 May 2025 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884CB1FDE01;
	Wed, 28 May 2025 07:32:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017C1F6694;
	Wed, 28 May 2025 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417537; cv=none; b=t12ANywzjxXngIgqGxtj7uAfY+Gew215uS8MnsXdXo2g+iTn4EJKy29j1mBE5Xw1SUOuvbFxE9PWL+uzWrHkafNtftCv8SRCqlEtvnu/rKjyIByPJHmv1k0qA67phIPvOycqYs18fbIzwrlGSNeI0OfAVsfNKsYa1cLoVDBgeqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417537; c=relaxed/simple;
	bh=tl4HJyy9z6gJQEYRpfp/dQ7sqfOoUaZIh6MPeISWTB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXI8L4/LyRrW1M4L87dlGvvmidUQ1/PENI97lP91s4ICxe4lE5+j15sJYU1ZwKRKajH3K/y0h2UlX9ttIp4SMOOTQTh/6YYBKturuMPuwY9+yxR60BfZaG6GSGkEQT3WtF0y5sHAqUPO69o3/TafJsFLwVy40/kkN6z2dUeNhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e45c4d0f54so798622137.3;
        Wed, 28 May 2025 00:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417534; x=1749022334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgxGWQtzFo6kc3Pzo0NbHsLbzvVma89U0TG3zIMdKj0=;
        b=k1yfH3+Moh/z+tJyF3qHVYGoNJAfl1dQXZ8UrQERYVKsJkCLUtPw41u1g0PFx6oEiT
         kFxz35uC/aPZ/s9CWeJGM2OdQpe1FrqCThDW5BPy19210W4rCrb9Zg02H3J+9V5ChIvo
         5Q3PCn/s5F0NMd/QHw0dKJg4C4KlLnv4QBXcc3D+3nPnNj4RVNMXyPK6OwcpWGBFNaO5
         gdZ6pdUE1jJA2VEc0W6522WR6B4wBHgtskOHDwgkRY82njG3nzmk9QkrCwC+Xq93h/2r
         HO5OWMYKNCKAudEvD4y19doq+0l7n1ZMNBacBU+Df5/MIxvfOO8/qaPsBMme9jmdbn3m
         YOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Zj4sol5AyF+GeF8kahPc/QKGACrMyFEdFIIpznuZSe//b8/9vtqCezaM+Zw9uuX3QB12dUCywVku@vger.kernel.org, AJvYcCWy/ZWXbJiSQJTIRC72d9c1nnRwzh7bKq7a4nCt15drpo6DH3Fx7c9gdRPt0EafNbCj/BuNNhwpGpQ+Ld0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw717h+u+sjUIs1nzu0zT92WB8NQaaiztJv9q3sT5NYSScWuXIK
	6qeZ4h3338QdUQKz24E8edfA2McUoDLhSZF/zYDQKuAXcYaAfd+muJ2fEjt06Trl
X-Gm-Gg: ASbGncvhxB8vt57/ucoDaGjag1IBCo4T8qAoLEUoYY1EBgBhHY+e0B0odtS028/ZJyR
	gGozEzwde1cxeARpMdYQP4hbHLnvjELLbQYY56EUKbOV8t3WHd1pu/xjoDZ5o5RYD2bY7J21UCR
	0xOhG0DRDLB1ilPLsMlNvpHYGaYIaxJkhcvv1iWrDKp9DT82GOLJDf5JJlsYQ4BvXKsHtj0jYHk
	lneIjRGArAPq7kNMcHa5YUqfzHJ/BHoUv4ZKhg3CWE5Dy3uoyqjb/s4US+rgbgkWRjSCrHsfeDS
	IjJlP9Q5LRmJFLtp5suewYF+ljnUHtb91W6gd5s6fhRA4lxj93wPvJKw105CXvZetcYAk8LRTOf
	wj18xT2FxmKQQRA==
X-Google-Smtp-Source: AGHT+IG7XRR3EqylAKJ6sLGw/h+8CbALYDVblczaxm6paqfZy9gLY9nNywfDUlk1LOsPclGn0mHHxw==
X-Received: by 2002:a05:6102:3f56:b0:4e2:aafe:1bde with SMTP id ada2fe7eead31-4e4240b0ed0mr12621581137.9.1748417534359;
        Wed, 28 May 2025 00:32:14 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e59fc11485sm386837137.6.2025.05.28.00.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:32:14 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87de33ccdb4so1263133241.2;
        Wed, 28 May 2025 00:32:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYl20OZls5C7aSJpmRAt98UmyAtxqY8Bn+b4ghM1XKBjzg7UeeHCTPkZ3ORfuZMmY7n9u5KTIV2d17@vger.kernel.org, AJvYcCXlwqPfx4mTAuzQgi6dWMRkRAO+gyKncQu5vdtenlDxEKyo04PoroJ7Q0Zp2KznL3iQR9Jq0lGCcYYuK48=@vger.kernel.org
X-Received: by 2002:a05:6102:5092:b0:4e2:bacd:9efa with SMTP id
 ada2fe7eead31-4e424176757mr11597420137.20.1748417534023; Wed, 28 May 2025
 00:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516100658.585654-1-Raju.Rangoju@amd.com> <20250516100658.585654-4-Raju.Rangoju@amd.com>
In-Reply-To: <20250516100658.585654-4-Raju.Rangoju@amd.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 May 2025 09:32:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWTwcoFQz39uF0gJUT=X4yC=wn0gYGU5L+jW_JBj0WnGA@mail.gmail.com>
X-Gm-Features: AX0GCFvzmsaL3yoHuU2hM8b7YC4FLoUGtHs5ezJWOusHVPb2odYjFwbLUW_CYcg
Message-ID: <CAMuHMdWTwcoFQz39uF0gJUT=X4yC=wn0gYGU5L+jW_JBj0WnGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] spi: spi_amd: Update Kconfig dependencies
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, krishnamoorthi.m@amd.com, 
	akshata.mukundshetty@amd.com
Content-Type: text/plain; charset="UTF-8"

Hi Raju,

Thanks for your patch, which is now commit dbb79974193a2932 ("spi:
spi_amd: Update Kconfig dependencies") upstream.

On Fri, 16 May 2025 at 12:09, Raju Rangoju <Raju.Rangoju@amd.com> wrote:
> Add X86 and SPI_MEM as dependencies for the spi_amd driver to ensure it is
> built only on relevant platforms and with the required SPI memory
> framework.

This sounds like you are restricting the driver further (BTW, what are
"relevant platforms"?)...

> Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
> Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1267,7 +1267,8 @@ config SPI_ZYNQMP_GQSPI
>  config SPI_AMD
>         tristate "AMD SPI controller"
>         depends on PCI
> -       depends on SPI_MASTER || COMPILE_TEST
> +       depends on SPI_MASTER || X86 || COMPILE_TEST

... but this broadens it instead?
And how can it be used on X86 if SPI_MASTER=n?

Seeing an ACPI match table in drivers/spi/spi-amd.c, perhaps you wanted
to have a dependency on ACPI (or X86 && ACPI) somewhere?

BTW, as you now have a single Kconfig symbol gating both spi-amd.c
and spi-amd-pci.c, this means you can no longer build spi-amd.c if
CONFIG_PCI=n.

> +       depends on SPI_MEM
>         help
>           Enables SPI controller driver for AMD SoC.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

