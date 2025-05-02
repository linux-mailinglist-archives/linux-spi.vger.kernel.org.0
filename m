Return-Path: <linux-spi+bounces-7854-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53B6AA78F8
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 19:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAFF174EFB
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602CF263F3D;
	Fri,  2 May 2025 17:59:10 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D20256C61;
	Fri,  2 May 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746208750; cv=none; b=cC1c2gPO/98+67m/DkDYtrbNwcMqmnDa+2xyAUWSaKzJu2Gr8lZapgcc1zULQhb+kx/6Aiq6rIrVO0IH0Oyp+401IrXVTETg7g+4Di7aRLz7gzM/bGwqVOeH1astU+N8oX9YCclKDvWUgdyHyEY8/5WuZAeRbf4E+8EbVxB023Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746208750; c=relaxed/simple;
	bh=MNs/AuayvBr1yC2U1RFW8MoN4KC1V3GKWSl7FAhXADs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbP4RnYvQREST+tO1UR9t2UOb2DrgkTJl3vJ8QHlDfT6YSNAu177dC7Hlz+b1sAMsHbeXth29dBE97rQ5dr2HBxibM/OJgUsFtH4iSLYIBGLhTYgN7bx+SDzXPNYbPf9PbKt6Lqhh+b4n/2QlIPnysb1J7XuvMa/pdNCX5Wf9c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-525b44b7720so648788e0c.0;
        Fri, 02 May 2025 10:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746208745; x=1746813545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+utF3dlTOxTPPaTvo29QMKNLxKu2c5QOiBUT+LYD4Fc=;
        b=giZL60yHcLhVEFxGu3HyLARB1I0OI9rT97u7Ot4KUS8zPkEcPAeXd+DMEDebRwDyEQ
         l+swm8+YyqlOV4IXHmSt7E/lhOQPPWiFO4VQKNqobZtwEw7fIQiIFmM9gY13GX0MIokE
         LSG/Rkxqsy1t7k/hDun0RcnYsnRopEUV55LDyiWicxCaGD8EKjxACKK7zyjc1k1Y2Uj0
         /JK15qdbzCzTl9FgJTtPaamHCDTeaj8IdyAYUHrUAPmOrZCqK//S0ibCKGVO2dzR2OOn
         c5U4LnvLqImfVt+l1V8c211YHeACk62LPltVXDA748IJaqdBzLZtaT37ZV1ySmssASeg
         DrSA==
X-Forwarded-Encrypted: i=1; AJvYcCUR5WTqb435RswqpeK7TJHF8TDXTWxL6LBMU2np5ViX2qYnoEeeNHA7vkIRxj8g2fksS1jq3HJjGx3zQ/ngSUFiBmE=@vger.kernel.org, AJvYcCVA+quwPbMEVSuXz9EtOx3BshD7W3m9TTCBrYUhOOX7ueyMBBK4+/pBff2fhT2WrOQP3LxF71X6UrQ/@vger.kernel.org, AJvYcCWd872d2kHoYKlhUoCmWWYB4uSfVTzXC/eRLSG7cWG7WFxZBMOmlBB7cER55BS3C/EV9icTJsIBXbN6@vger.kernel.org, AJvYcCXwZYAXvjKCQslju6hOSCIRxvUG2U/+ZTNVJ8pvIVALYUMAJd6FTWyma5alws40M5mwHvbdlb4dnT8gHV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoPWZX81cw2hZXKQOBDmezfzbPY+w3JlVFZYhvIba4Mf7fPUTU
	eEB90I2YRtZLF1fLSVg6BUJmWoMZd804HiqjDrS6NemvAO4Szf+zP23iuhke
X-Gm-Gg: ASbGncsbjwBNiMZ/YIx3WjfcdvRRBKHdTeYqEf+2XQU07kw45ddk6Z0Yt7NXMTuQNu1
	/LxU2/Bb4w2IjsnprGQTG/qJ6SDPG7OoPx62juO/yXKj0thXFMQ1LOT4lxlXKwbXKumjUrJEAS0
	dogaPR6J1C8SxAYEhhVQkGxR1vDhrxDx9WP4r8e2rvrPDNZnhP0KLPkTH1ZFDtdvz3bko7vPSiP
	zspE1mBEypo51E+vTUnQtg0FsxIjFhP3IEBJ1cAneIRy8VLatkmAY6nC5TgOYZ8CCmpvXdJaMHJ
	Z+RYVCe8dncNCX3s+gn6Ef3/4ASOE8SAOwHDdz+pLUE06JBq4XkJ6QxOiMdEG+CYm5UK3+9o6SN
	nJqM=
X-Google-Smtp-Source: AGHT+IG6LKO2K35DHJ7AiT3Z2kSL4oPzMH8/EbvC8k/joE/9xpXcgA6azLkzhshd6YVoHQet8nX+ug==
X-Received: by 2002:a05:6122:659c:b0:529:2644:9118 with SMTP id 71dfb90a1353d-52aed7bf7camr2910730e0c.9.1746208745506;
        Fri, 02 May 2025 10:59:05 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52ae419fbd3sm591770e0c.30.2025.05.02.10.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 10:59:04 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-877fd121274so471060241.1;
        Fri, 02 May 2025 10:59:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5b+L63Wd1Fi3JnbwsiXDY8we9SCBlklA9EGM80rF+X1TXjDNBQP8SNY5T3aFLWRWh7f0x7396CQKk@vger.kernel.org, AJvYcCUS48kjyeBNYdkRGiwykEEArgKPcNFotYW4iAC8XCyjPYnrg562VqaJWie2RKrv5zSNjJc2xDvVG2I7@vger.kernel.org, AJvYcCWFIp28XKT9Qn5SQ6ioODf24yb0natuEO0oqMdNjJFCMpx7ugPYOUkqpt/bE/F1IKueTYaOa7SVcgjRSdg=@vger.kernel.org, AJvYcCXpahORTzV5qsyKlu3xcW2KpSiQhnftqehMByHXBUM8uoVjuGruLeYCjHyt9rwlwAj5zoW93C/E0rWjtTSO7ZorZJw=@vger.kernel.org
X-Received: by 2002:a05:6102:149a:b0:4c3:43e:5227 with SMTP id
 ada2fe7eead31-4dafb51b280mr3550151137.9.1746208744099; Fri, 02 May 2025
 10:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com> <87plha2wzr.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87plha2wzr.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 2 May 2025 19:58:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVAS-jBVzKR5MnK=ByT7kcdXi1EU9czAvXc7NvC37qy1w@mail.gmail.com>
X-Gm-Features: ATxdqUGplgwl97XrZjgiSV8k9sw-zEBQpP9eLbgU5d5tWrTao28xjeMcuuYb4zY
Message-ID: <CAMuHMdVAS-jBVzKR5MnK=ByT7kcdXi1EU9czAvXc7NvC37qy1w@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Fri, 18 Apr 2025 at 01:23, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Sparrow Hawk has Headset (CONN3) AUX_IN (CONN4) for Sound input/output
> which is using MSIOF. Support it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts

> @@ -603,6 +655,52 @@ sd_uhs_pins: sd-uhs {
>                 function = "mmc";
>                 power-source = <1800>;
>         };
> +
> +       /* Page 30 / Audio_Codec */
> +       msiof1_pins: sound {
> +               groups = "msiof1_clk", "msiof1_sync", "msiof1_txd", "msiof1_rxd";
> +               function = "msiof1";
> +       };
> +
> +       /* Page 30 / Audio_Codec */
> +       sound_clk_pins: sound-clk {
> +               groups = "audio_clkin", "audio_clkout";
> +               function = "audio_clk";
> +       };
> +};
> +
> +&audio_clkin {
> +       clock-frequency = <24576000>;
> +};

Please keep the nodes sorted (by node name).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.16, with the sorting fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

