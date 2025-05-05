Return-Path: <linux-spi+bounces-7880-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED10AA8C7C
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 08:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663B73B55EC
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 06:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B22018DB2B;
	Mon,  5 May 2025 06:51:40 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3581C862D;
	Mon,  5 May 2025 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746427899; cv=none; b=XXuP2cEUKMgE8Qqf5W/koTpQPfRMzbtpFC6blfdTUJokmq3TpjRtaIxOK5XRsq0iit61qvT84HrjCNYzRQh8nS5/Mt1vMGgu16b45gb5PpF6hMauJ7D9xG3Hkcak7CUdCOcLbuxApgeb4ycWDRGvkUN9/H2YSy8d9NmsOVCEkAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746427899; c=relaxed/simple;
	bh=0m4XV4D2MiQ1WprDwZkzO0FhSxw1ZRdOkQukffOUixE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mheqLO62IuIcBCxvTVuQTWry9Bfwyp4yZi2lObeHLE9daypKysPbyVq/VOe/yx1gUPpET/MlKjdtoXeGLWiLDM8T7LoGBf51qI/vhswWosWeLOAFUVgrxn2a54RZau5M0VzGhfOSBZVILzcvfrV3yUS2x4Fvq8dLQZYKPE4Fti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-523ee30e0d4so1269000e0c.2;
        Sun, 04 May 2025 23:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746427895; x=1747032695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maxzXA80KMmh9eCh+oE6VH4eam0KcRrBuBk8VvhsU3A=;
        b=u42XjRlNSQnlZk/35eRMpTXb85i3kM+jvcSw4mU0pGjp92ZKf+zH4tEoj8KrqscJXv
         /ZwKuZinDtFXWAWjTxUryJcKbSqRzDZ0qK3IhcobtPGfJzrNHbFuKtVUMguP6Lj0rhzd
         IHU+09hpPNA31467WwQytSJBt1bq2H1SrLXIpAV/tyS/rge5ZFE/+bwwPt5IEI3gbj+O
         5OAxQFYMRLrXMFNuSUa8Ziaj1NMXrdDKIn5VSyS0bUbHrUxSyBoYigCzg8IB2iLzh3cm
         VeDC2RFm9MUzacJ13sy9dxy2ezAwoBMDcKegIYnvrn7+Tln1V7ER1Txxu31TRiJaCAr5
         o47A==
X-Forwarded-Encrypted: i=1; AJvYcCVAVyjtWZ73K8woB8s/A6IymvNwggjcyRxjnsRUJt1U0mMYYW5GjhxizWuh/HLmegqv7VWGl5noSkzXqzc=@vger.kernel.org, AJvYcCXlVm+FnuGq5Mkr4eO96iLl16P5YFP1ry7RaiuBNDkP3myRv3diPUTR/xtZ5MIiKQsJGdNMhD0wTWUHithfnNzkaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV64Jwt9yvJb5iGPU0FXOJZfyivotquYV9HgwzJeIr0S3lQAHz
	hNGpeIwZoZtSnHbPUk9zcbNcw+4VVZdRCk4H/cJ5SAZZS5lm+KIYxt95mxlR
X-Gm-Gg: ASbGncsuEQKX935N4aMn0wZ9TpqoJsFXn3fSKBjPV3d0yWAdpnDZolZ0FRw39uJNI0a
	N+94xx5uwvCdbzmykMlRe1Y4VAgklY9wgiEs624hrn5fbEp2A0b7wAZ9oSHCd1RIouo/lOHjS5A
	/QNjBKpoDCGkC2IKervyEJlc2mv9P2z4M3You5yMkiwufZ426JGU15yfyPpb0xBZN8vk0s0h/Zy
	ybAJ3ga6eY+I3QZh/yg4DyZuzJi8M5ZC3gBTzqIRCSfSgLTs588EQTK/0l0b/6VSleOi6vCYP0x
	aTKLN0MhdNLS96jrBpskfw48sXmp9PX/ocfyrkVAfiy5eXvXxeDD/avjuwULE1obmmkdDtZ0WDG
	lbEw=
X-Google-Smtp-Source: AGHT+IETNH460qhLJAS42ojxL0zZ1olNumJDait1LfOlzu/A7Z1U/vPYUJd21T4gRouDfSG09GJpdQ==
X-Received: by 2002:a05:6102:2c02:b0:4c4:e018:326f with SMTP id ada2fe7eead31-4db147cc599mr2864076137.10.1746427895130;
        Sun, 04 May 2025 23:51:35 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8780affddd7sm1249413241.8.2025.05.04.23.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 23:51:34 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4c313374107so1122716137.0;
        Sun, 04 May 2025 23:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWy1EQL/r7pRQXSiInahTv2qpBiAonxi9Tu0WLFJPhM53R7lccBpTtVWDhetyTLxuNCBF7P96bXihbZuW8=@vger.kernel.org, AJvYcCX49wD4DPkIaxmr3sGEJ577Dy+ZE8S7aaV6uJinXypMnJivPz2TiZaY6lQVndsf86fGpJw0keQRQSG2Eh6qCKxP2g==@vger.kernel.org
X-Received: by 2002:a05:6102:1512:b0:4c4:dead:59a3 with SMTP id
 ada2fe7eead31-4db1477d082mr2719964137.2.1746427894233; Sun, 04 May 2025
 23:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746180072.git.geert+renesas@glider.be> <d8dfe7cdd8980e08b9fae51ff9fcddac20eca22b.1746180072.git.geert+renesas@glider.be>
In-Reply-To: <d8dfe7cdd8980e08b9fae51ff9fcddac20eca22b.1746180072.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 May 2025 08:51:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXo=WCyHtH32+1Et-oX4scoMdvf-qhFBCiJU+MjgSfcfg@mail.gmail.com>
X-Gm-Features: ATxdqUHMOPV2y0-Pfe7-TMijcOvzvpZPKz8vRYPNlfp2io_IHKxnp5X2iG1hJUI
Message-ID: <CAMuHMdXo=WCyHtH32+1Et-oX4scoMdvf-qhFBCiJU+MjgSfcfg@mail.gmail.com>
Subject: Re: [PATCH 22/22] ASoC: renesas: msiof: Convert to <linux/spi/sh_msiof.h>
To: Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 12:14, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Convert the MSIOF I2S driver to reuse the MSIOF register and register
> bit definitions in the header file shared by the MSIOF SPI driver.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested and asm-inspected only due to lack of local sound
> hardware.
> ---
>  sound/soc/renesas/rcar/msiof.c | 94 ++++++++++------------------------
>  1 file changed, 28 insertions(+), 66 deletions(-)
>
> diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
> index 75c9e91bada10289..36d31ab8ac6a5f18 100644
> --- a/sound/soc/renesas/rcar/msiof.c
> +++ b/sound/soc/renesas/rcar/msiof.c
> @@ -30,56 +30,15 @@
>  #include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/spi/sh_msiof.h>
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/soc.h>

This needs #include <linux/bitfield.h> on some platforms.
Or better, adding

    #include <linux/bitfield.h>
    #include <linux/bits.h>

to include/linux/spi/sh_msiof.h in "[PATCH 21/22 ] spi: sh-msiof:
Move register definitions to <linux/spi/sh_msiof.h>", so the header
file becomes fully self-contained.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

