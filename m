Return-Path: <linux-spi+bounces-11587-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48629C898E6
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0091B3AF9A8
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C1A324B0C;
	Wed, 26 Nov 2025 11:38:49 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247613242AC
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764157126; cv=none; b=pg7EJq3Jrsgfv5ZUwPQXOtwcRVyhUtLzm3Ajp27dHxP0mBXcVolNXZth2RLrRg0n/+rXKcmRD2VAItWk6Cm/xBLV6ihSeQOAuHrvr0pbyyx2MqadVaEBreuHLIRw2uk83gphwo0O7RA1MiJyVxqboCYnh4vPupnf+ydY3foCOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764157126; c=relaxed/simple;
	bh=6vXU8XpgJra2p/A0mAz7uHu58fBrCRCKvus9KzogLac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mks8kx6qjYhTSQz1m3x2atggsEu7r9YtWHw9/w/MwhrSR40hGlKwHquXTdHg6NUscSFGZOe27kzzgeDx4+RTOabg8tMGBTPSCR/7ljPs8OwKFNT1W359T+jt7ZwGG+40oGEox6FCkAduFPFwQplN7w0S1UrPdZ8ydWPHt7pL2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5599688d06dso1748541e0c.2
        for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 03:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764157122; x=1764761922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPs+Pvsscvl4vbT5PrYvt5m/TvwButtAFGURqG2jLmo=;
        b=TO+i67rwCEvfxbkkwcN+A5+r60XIm3p/KD9SsP0/UvN06ACNyFb7/qqZeWnfsgWRjn
         M2QGb4GRpou6OdXoKl+H3UJe9T5WFmSmYDAEyidb5gdEt3BMMhy/C63d4C1qrtYoC7ZC
         adl84Imb7o+YlqB1FMWbbW3zq2AERLzseoSucu/+Iueoyt6a+Q02c8mr3rV2pFBsgVhK
         QGO5+AwXnzWUicIqooYga6HAx28ASSOKBZz+KyI5memhNZo454TSwvdlxcGeiiUTfZTj
         udPYo7Xu0X8k2apzIIgJzl7xGPYBHLlrEbaVM/zgNwKWDcltlqgUTyzfdP5PaRRODbXA
         fHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLE0J3FFlqgkRADya0t/xOoszZhQa/AkAUOJDraHg+9oNUACA8vZvkTTo+yJof1uH15X+K8XU+ybE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBiCNRm2S8WgTRUhtYQhSCaBn+NyA2On6CpEq+gCqZnx0NeZE
	EiK9uVrp/pe2lEusiFzICv1w9Ise1TrcH0EGW+zuFvE3FCxkeb9XyZf+UDGn/KDr
X-Gm-Gg: ASbGnctveg2cWayuE2VvUPyGRxXT9SA5fGNLR3BTXOHGOJZM+b6FScHWxLCTOUj5Bb1
	XoXfV2uFUz0/gBc+wvEHt7JmMupOE8IM8hX9gOFtz4+ikKIKbFreqAgN1SzEfCIfA8WEWuj8KAy
	hFpYAj97f/duhoBj18MRGqRUsz6/G8QdYWNCLXsxoyKvR1yo8yaPvJDqZlyjcEwLVWVfFmHWIEI
	p+0dnFl/jls7Lr947XhTHiJfqa/HTGz68LNGg9sgCC/Qz5pxcojcXVo+a0ph3PEHWXSQXjshQOL
	mQeknqkf3zLjYmGxsQ9WC6Jy0RLdv8vAKXe8xPU8OZ90KWclrqLOWM+KKwjHpzoUTzY+2wkCLJ4
	5sJvYMPDTgptPmANj6G/Mcb1RPyMUbked9FZxRaz5GZeSH4vgn2JLj5pR2kYlHHLjY9ZcqEWaVk
	u6qQy6pqw7W0sNIHtaxiPhxqsEDHltf36xXHByu7NtClzEE92+
X-Google-Smtp-Source: AGHT+IEIQjtguBemMvuWiF3XDpA0lP2w2VfWx3FVS+rgCpjiqu+PxWu/9pWvQEVtaMyyLZIkfVYsaw==
X-Received: by 2002:a05:6122:1829:b0:55a:2b12:8022 with SMTP id 71dfb90a1353d-55b8d6bb6aamr5393592e0c.2.1764157122043;
        Wed, 26 Nov 2025 03:38:42 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f774612sm8787634e0c.14.2025.11.26.03.38.41
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 03:38:41 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-93c6628c266so1651742241.1
        for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 03:38:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgAshA6SOFEoVjlh6gvwF2ICy2njzbs5ukvxz7+KMTYIfNLDyf1vmLeqr/XIXCpFvPHOZiexUckA0=@vger.kernel.org
X-Received: by 2002:a05:6102:38cd:b0:5dd:c545:9ddc with SMTP id
 ada2fe7eead31-5e1de374e36mr6204808137.37.1764157120891; Wed, 26 Nov 2025
 03:38:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Nov 2025 12:38:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXD3f3jN2F7c+yHmEb1C5Byc-e=sEXt_s=UpBQLv_F=Pg@mail.gmail.com>
X-Gm-Features: AWmQ_blOpWFtldK0K7YO1Ee1EikL9Htm5FAvVFMl7KnZuWbZjrq2LybKioyiZEw
Message-ID: <CAMuHMdXD3f3jN2F7c+yHmEb1C5Byc-e=sEXt_s=UpBQLv_F=Pg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/V2N SoC support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Tue, 25 Nov 2025 at 22:45, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document the RSPI controller on the Renesas RZ/V2N SoC. The block is
> compatible with the RSPI implementation found on the RZ/V2H(P) family.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> @@ -12,6 +12,9 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - const: renesas,r9a09g056-rspi # RZ/V2N
> +          - const: renesas,r9a09g057-rspi

I am a bit intrigued too read that the initial value of the SPI
Transfer FIFO Status Register indicates 4 empty stages on RZ/V2H,
and 16 on RZ/V2N, while both variants have a 16-stage FIFO...

>        - enum:

Please don't bury the enum between two items.  Put it at either the
top or the bottom of the oneOf list.

>            - renesas,r9a09g057-rspi # RZ/V2H(P)
>            - renesas,r9a09g077-rspi # RZ/T2H

For the content added:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

