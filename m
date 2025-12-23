Return-Path: <linux-spi+bounces-12089-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2D7CD99D1
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 15:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D0C3007256
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB1132A3CF;
	Tue, 23 Dec 2025 14:24:53 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC39322B92
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499892; cv=none; b=H/9n56oqYkhMb65TecKCPxr6/092hSJLYzSFxz89aSHdz8dR20wGqx2ZSHi0unRpJvOhWzkOJQJiRwUD+K/Y+OIvdAv+MUr/F4DHbvsysZo5NjdlO4ulJ4h/Xid2pTRRSM/3mwzD3oOON3CbGTUQMGDZGKwm8SBxKFIovtRZc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499892; c=relaxed/simple;
	bh=ogzBvS29Ue/2IXvBzeRNG78it29lv+6MNhav5HFyVj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SefYuseX2T4lMPbXF1bB2WFTTXyks5sdncac6KaARtd4u3adgP4mENlSnRPx1lHW8q+s7izPk8DMNMtO5ZVgQKUc6h2OZVRAxlqPUnagnJaqlNzvxyZNZhSX9C0qP2G2EEHYYE5eJDR42L0qpTGrMHPmSvWWAK1MPsrncVj650M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94240659ceaso1412367241.3
        for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 06:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766499890; x=1767104690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqy4upQ5W7t+jp1G+g2SJ1qrfxpgarALeWZ6iD6XhOI=;
        b=U/QOAuJRK9XwYy9g6hX8Iep5i5fFfe60Ji0WkZDLSf6lHHcxNd8EBuf2Qr32PjDxzm
         vHkRpfIuZJdQCrjGu+Vd/DnkGdWHbE0epW3Y1lFWKV/TJWq+ehGrXuGhuwSIQcigE+oQ
         I4d6iB/lTYs4cUc5QEadz0Y3Mbbv9ZR6+tuRncvQjfJJ0qFJhTm0O1nrz0PhdouJGUpw
         v8LqKrotVAfGFfOg3Olvt7BUPs8DPxFrLEiLdLIE3t70p4CNnHWbcgcqqdCj1khJSXiR
         kj3l4RTzjY9m4+Jdg7geE3+MO1jZybNYVnf/R0f9UPnVGSHwxbzf/ReYOQHEHi1VdOUi
         JXmA==
X-Forwarded-Encrypted: i=1; AJvYcCVCASWca+zudKT73Aux9DBgYce+xOVeODbBST3L609AFTBcdaibwihvr5XdaM5j243luVqLPbXRSAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcrAi+bDByvIj+U5r6WzMEi/uSz8CtgXfZq4OMJpu7+Q+iW3BQ
	PfV+bW1aHJ4bkqH8FsduQylcIMBMMhMyXUvnKKwXAwgKuyluDe2x4vFrXmphBpssQxM=
X-Gm-Gg: AY/fxX6cPuFWbdi3EXr2KTUmkRDDdQmjz4rLfzr9s/lPwfq8QbgTZRmQmLlaDJXp44m
	dKkL9GrH7ROEvaflKkVpUGQmrV5H4rjvPqKezAxGMggUrLxq34g3QkNO8UJRK27BhKxJ+1P9DLx
	aoqIUk3lmYIlVHFxKGk/VycNNwsKNYE9GouMbegudMFPHToauhboympXAD9Vn2QU8nEAyfU2oyw
	GqoVaWHkyhJm5+DxjJGovkeieGGwkQ+zM1m7TRavs3nnerciD/2YQSHYT67UP90iHiEmTPYtC3h
	XghhfQUYs2GGUNl8ATni20CHSTYMZi4COmdBP+B9E2ro660iwEGB2T8VjVgdNkmbsUDnZMpypXt
	NEWqZehMNWBBninjYPY/lGWlBBkw+QSzcICMgfbSWjaRr1MZ6LzfYMV/hJcbpuv14c3Gl69KOTT
	gHXTPwinSZfwNuwMBNo4oXdAu5G9NMS1zZscQQZEKX8qKwm87+
X-Google-Smtp-Source: AGHT+IFXGWnhrfGrS1r2LmHz/XMf0yeTOvra7g1JMGMScypKhNy3IyhyigQr96dVG9k2TFYuscOERw==
X-Received: by 2002:a67:e70d:0:b0:5df:b5d4:e463 with SMTP id ada2fe7eead31-5eb1a848df3mr4081553137.43.1766499890210;
        Tue, 23 Dec 2025 06:24:50 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-943417972f5sm3853820241.14.2025.12.23.06.24.49
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 06:24:50 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-941275fece4so1177945241.1
        for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 06:24:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyHTG7i4EFhS72eUEwM/0d6W39G+jqSxei0aU/Jhk7jUB02YjNSsniK1DzCxRi9hHliRxFTvRVfPI=@vger.kernel.org
X-Received: by 2002:a05:6102:5e81:b0:5dd:8819:e68a with SMTP id
 ada2fe7eead31-5eb1a8122f2mr4383697137.36.1766499888811; Tue, 23 Dec 2025
 06:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251201134229.600817-13-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251201134229.600817-13-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 15:24:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWUPM=q7J_S_x7=CZoYxKm-v=7GGGkq9Nv0T14b8MBtpA@mail.gmail.com>
X-Gm-Features: AQt7F2rOMWs-9fKqfhdAbKXqn60pJqEJhnj5TNYUFWGKrGSfLOShXq2lSJzOfRE
Message-ID: <CAMuHMdWUPM=q7J_S_x7=CZoYxKm-v=7GGGkq9Nv0T14b8MBtpA@mail.gmail.com>
Subject: Re: [PATCH 12/13] arm64: dts: renesas: r9a09g077: wire up DMA support
 for SPI
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Mon, 1 Dec 2025 at 14:44, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> RZ/T2H (R9A09G077) has three DMA controllers that can be used by
> peripherals like SPI to offload data transfers from the CPU.
>
> Wire up the DMA channels for the SPI peripherals.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> @@ -200,6 +200,8 @@ rspi0: spi@80007000 {
>                         clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
>                                  <&cpg CPG_MOD 104>;
>                         clock-names = "pclk", "pclkspi";
> +                       dmas = <&dmac0 0x267a>, <&dmac0 0x267b>;
> +                       dma-names = "rx", "tx";

RZ/T2H does not seem to have restrictions about which DMA controllers
can be used by which SPI instance.  Hence shouldn't these point to
all three DMA controllers?

    dmas = <&dmac0 0x267a>, <&dmac0 0x267b>,
           <&dmac1 0x267a>, <&dmac1 0x267b>,
           <&dmac2 0x267a>, <&dmac2 0x267b>;
    dma-names = "rx", "tx", "rx", "tx", "rx", "tx";

Note that this requires updating the DT bindings, as they currently
restrict dma to two entries.

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

