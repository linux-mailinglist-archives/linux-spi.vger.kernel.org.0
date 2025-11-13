Return-Path: <linux-spi+bounces-11188-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7661C598EE
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 19:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CFF34E8A19
	for <lists+linux-spi@lfdr.de>; Thu, 13 Nov 2025 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577CB31196F;
	Thu, 13 Nov 2025 18:39:39 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C8030CD9E
	for <linux-spi@vger.kernel.org>; Thu, 13 Nov 2025 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059179; cv=none; b=I3E7NDlhDqtZx9zaFZnajKQdOzcuv4X0tymUaRp7Xwx+szlkb9qrDlJm9u6E2NTHzcCn0ukGRMnR2ChIhdQ92GWq7EYG2MVk+nLw5JVGL5oFxOy2oGO1t2gUrBqi0ic8cZgpUmvF3AmyMwH4EhVI5VRRCc4adSUZY+fUyp184q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059179; c=relaxed/simple;
	bh=3c0sAkDQu1qBVzE7td1x+QSCl8WUFk7pNS0yIvPZ3RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcYyS/+kNR8BQlrf7zEgVEm+oUIv/4voCRhAyehpoturYkyCY4cMTrh1KrRxIksPkJR6+kifPorJkUahTIfeUQBopbsz18LDZoyk1sbX4o+C16+1AZthIKpJWtRm/6RuLyDvJXjA+3AZutaVNiy4GZHJrWj94KsL7HMcWy3xl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5d61f261ebfso418692137.2
        for <linux-spi@vger.kernel.org>; Thu, 13 Nov 2025 10:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059176; x=1763663976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn33ddPk9bS9PgY509eYuCfPPBWfLh0ylYRDGrpE/Zo=;
        b=o3rYElDgDPP4OG40mc5TvbR2KHmSaTcexe1E8bk54vGCih4k/iAuOMbIUSBtMNVkfk
         iEto8uQJBD2xwHLvQXrM97MCwoMZLEMYx+gS3yXNpgv+mKliaLolmv3mYi/MLBcWetjP
         l/esYIaIUy+G/WFLSc2DYpSErM4hNv53apK/Y28tQt0EEA9avgTfOEtFdtDrcVfofNXf
         1nnrBZv2FhIXoCdQ3KBwlWlIkW7fQtI5+NhziEfKMgA7UXtXxBmeftUOF2+vvNSehHmb
         kQ/tvrN2ueT4z5oOrh085c/54lUbunMykoQo53FrUUNLQnPZWQjvK2uo7AnWn2CcCNeI
         DP2g==
X-Forwarded-Encrypted: i=1; AJvYcCVgAE4baYFYZ10Jv5eXTqoLtx7M2ueCD1vnLlGiE0W3h2feeSmz4GL7mBI8nykCOvPrHhNGyco2Py8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDsVrIdJSSnGbHUOEF6jg7W+Sud+4L3+KalJhK6Q+2pFwigeR
	Haz/wVxUxltn0UBzyK9dPvwg5xO7hAVqVLUZGFSXBOSwu0EPO00y1mQ2KzaNRGM49vg=
X-Gm-Gg: ASbGnctpo2+2itg00BQo1PBiCVXvnFXnXWCxbEIx+ZikEVNRfYU2RvP41AsEEXiW5bf
	0wSXmv0qJOWo2/NP0dktQzslIqjwoxhv8RWWG26TU4N8SynQUtvE4fj+tHkzrYVHDd0oNOqdrJx
	o4YzH6kJeyQ3FHm4Li+5XDBJQqkSPofhlhnnQHBXoxwgZt9kUtISBBlbND/p8lE2tnSM9i5LTJW
	fU2Q8Jpri5ieGSjd4SZJX75z6ZLD1lMXpcxDJ3oQpaxZHqR3LMqaNN2NYC5P63863BIYgDGsVck
	MA3kHeNuwtAp4phuLkp2pHQY5btHFFeFG8PcBhkqeUuZRDsOF3dopx08JKpNfVNrJ1nwj4XIfbl
	P6wLuhMsQwvq6MplcQ6TAk35pzn8s7PI+rk45p8GTvO6MV8FHbGm21ql/4NJ8gqKJvVUX9qLa9v
	AMw82VkYvRUHEH5o+WHy5gDmLVhbONt1bMWxtHvg==
X-Google-Smtp-Source: AGHT+IFqmyVTiO4jd12IGuBdWafKm3iQNK4XwEK+zoyywXk7QlRtbKpscOnh454U3MlVFgoq+zNhWg==
X-Received: by 2002:a05:6102:ccb:b0:5df:c228:288d with SMTP id ada2fe7eead31-5dfc54f95b6mr364321137.8.1763059176205;
        Thu, 13 Nov 2025 10:39:36 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93761196556sm796471241.9.2025.11.13.10.39.35
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 10:39:35 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-93526e2842dso326068241.0
        for <linux-spi@vger.kernel.org>; Thu, 13 Nov 2025 10:39:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXk24KA1zP5JmJIubBfDVFx8yEG05rhNPiBtDvpFDm31wXOvORj7ERVyjaC8iyswYjwtxu5FeCkgE=@vger.kernel.org
X-Received: by 2002:a05:6102:4b88:b0:5db:eeb6:812c with SMTP id
 ada2fe7eead31-5dfc5b96e0amr374019137.43.1763059175404; Thu, 13 Nov 2025
 10:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251105104151.1489281-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251105104151.1489281-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 19:39:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXEjnPWzwLF49ryooEUPNeLtXEuHDipcCMq=wsXN=zD_Q@mail.gmail.com>
X-Gm-Features: AWmQ_blsF688r-SQvCXnNFqKgHzgSK8u69yJh9wFop3IkqSYjXU8VHfHFzFl3OY
Message-ID: <CAMuHMdXEjnPWzwLF49ryooEUPNeLtXEuHDipcCMq=wsXN=zD_Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] clk: renesas: r9a09g077: add SPI module clocks
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 5 Nov 2025 at 11:43, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SPI
> peripherals, each with their own clock divider, which divides PLL4 by
> either 24, 25, 30 or 32, similar to the SCI peripheral.
>
> The dividers feed into the usual module clocks.
>
> Add them all.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a09g077-cpg.c
> +++ b/drivers/clk/renesas/r9a09g077-cpg.c
> @@ -54,6 +54,11 @@
>  #define DIVSCI3ASYNC   CONF_PACK(SCKCR3, 12, 2)
>  #define DIVSCI4ASYNC   CONF_PACK(SCKCR3, 14, 2)
>
> +#define DIVSPI0ASYNC   CONF_PACK(SCKCR3, 0, 2)
> +#define DIVSPI1ASYNC   CONF_PACK(SCKCR3, 2, 2)
> +#define DIVSPI2ASYNC   CONF_PACK(SCKCR3, 4, 2)
> +#define DIVSPI3ASYNC   CONF_PACK(SCKCR2, 16, 2)

I'll move these up while applying, so all SCKCR2 and SCKCR3 definitions
are grouped and sorted.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

