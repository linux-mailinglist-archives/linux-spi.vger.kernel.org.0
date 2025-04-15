Return-Path: <linux-spi+bounces-7595-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24128A89698
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01E13B8FDF
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0685288CA7;
	Tue, 15 Apr 2025 08:27:36 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC8275108;
	Tue, 15 Apr 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705656; cv=none; b=N7aQen95imfh0v8wheOJQDMWU/jfWDWeY6dCVp7tyQPyQTO2xet0Fw7nDe6aUvNrlDy5AGqZw8qLSF5vrHdCWsHRo6vMK/8FxQ/L/QflrxdqFJ0ZxQ6FYKscOCzMjB7BbpjS0LP3yktIU7Sa6QoWb+I4SM7YoSqAuwFd6nTKdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705656; c=relaxed/simple;
	bh=O047sYGEO2FirIMFno5oKvIviUxzQ/1Tzd4nTsphlx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFg5SWw/qJmcvCG8y3mhuzyaJDmcUN0JOdBtWKUXldah1G8N0yRfHf/54T3l0dDWgSSEJb6xVFH5u9FzX5LT2HdFFg9hihLLXDfKqj0GcEmA34JJDhTVVHFAXrAGKZkd/hpJ/XwLfGXNleIJOWV1vuzX8UwY+KisagR6HArPNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5259327a937so2162934e0c.0;
        Tue, 15 Apr 2025 01:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744705653; x=1745310453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGO+Xd6zIarjSEl7i+vxsyo+MvDN3vL+Ovlv+BhPKuI=;
        b=oqGezmJSPJ1zttrFEMKizRLe1YWf/aXyjWwnxaK808ToyKIfe/3tSdHuqltiOGnmVA
         rsoJmNETBqIKh9oHM/S5gCzPNoCFNl8he571uFsEMSw9tm09raYfhxBArJ3lozsgVb9Z
         LAqDmlaYCHO+9mh9HFYOMApL0ywfcPmehJMd3EJaQ0aocUJ9jvzOrV1XPDdQzckWAECe
         WzV/DAjbDYerm3JxTSVzPs4d33Je6+VN9Yf6BmWldpB7m0Y6dzBL6gtKify4/lJKZn1l
         HmgprNzP0/VBh6WrRhkQQCrdeeDYfpnpc9x/VbsAOa+DPFhMXXPcRCCcKFyohW76SDl9
         jwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy8BZYK80aVbijx+t02NyoH+doZ6x84jLsjLjNiGkQYVGm9hVF7WCo1hycBIWWKmEWFZCF+i1iHQ4+@vger.kernel.org, AJvYcCWZYzUgJbakYOkwHO+Danbt68NPmwpPjJ/dZHQTVOJjSYZ0iajM+LBjKfuEtgUgVQKhNbUi/yUjhv+h@vger.kernel.org, AJvYcCX+seipiCOzrMURx8Y4Lz1/rGMWr8glpLQ7I1rKCM52yK1sYccKv1I9e031B662hmU4MLQtXdR2c2wfWOGJVKdpQtI=@vger.kernel.org, AJvYcCXwyxzgvd6uD9B0xz+m5pXZ5WzwzgeUSxqwxisd/GEQOHVSi0CPZB/jcm9lBopDW8WQ1bmenS62XsOKUvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BlPb4fqwv/GZ1DhL7cZfsXk57AWt+j1sfIJ7AMGf3HKIkxBM
	CBNQdMqyGXq7k/dI8yXLzgKL+PiYCXPUGAruExdiUv9J7oHEVGmIcvz4ijR/
X-Gm-Gg: ASbGnctJ1txoncqtw4kPYuGIMw+mBuxCZiePpbeuvLpKVJPARCGywPrzE4bsHtCq+y6
	0SSuuhMQVNbiGEjyQXprLc+QIolvlmDSaHm3x72xCEM8ARTERlSiXTCEdPSmkzrzJ5rG9Vt0I8f
	iix8t6ONTxUKFUXqTgaAprjAt4FyCgYK0UtoX7lqvTln5NzPe7tBS+hyNyDSMkmxuDqQ4L6HcIa
	7J9C0Tbg5ySsAY1RoFgHFlfVKe6681qvnfwNQfiWl036Iq/PuP8RQLaPH4VFLtc6dObpbNMZNkx
	ax/z6jiY29Wverw9cltXqS7YSvog70TFoXKHo8zb0jM8oV57JuVdmSEiKCduLwFk6E7C8/R5ArC
	Lv5Q=
X-Google-Smtp-Source: AGHT+IGI+2o4aOh25eWfRZJbdubs1qXRO7GFBB/L8qTwHtlnsUL5mrO8zNGcR7dxPPg223Kyu1gTsg==
X-Received: by 2002:a05:6102:290d:b0:4c1:8f9b:19f1 with SMTP id ada2fe7eead31-4c9e4f12ed9mr10973893137.11.1744705652692;
        Tue, 15 Apr 2025 01:27:32 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c976969fsm2528514137.12.2025.04.15.01.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 01:27:32 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4c32d6ddd50so81709137.0;
        Tue, 15 Apr 2025 01:27:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZ6oC4lsj4E+O4/ozhbF5EH0khqoGxBn2gu6QVKJRT+qs6zKH/xvQr2rlYREkxvlgVy1l5h3wGk0dZdyRhcyT0MF4=@vger.kernel.org, AJvYcCWdXjvjsZQTDyOatguskUO9tvbR2QyBgOwZk5b8Y/B6bmI8sj5y7ByAGBk3frxarkHK5bLsH4WhdQH9@vger.kernel.org, AJvYcCWvuBZolil8VUNgVNYgTTpnkFw2c3CvqrFc08vp9od7GcBDSdsBCJyJU2yoKSrOY9TXDoqywx0L/oYLl/Q=@vger.kernel.org, AJvYcCXhFYAU1U4vCOeLAn5REA56NS66wJgA5CPWP61jKMkXrRBtNSeF8y9dbQabfAiCbTsBDw6+VH+ZIMzl@vger.kernel.org
X-Received: by 2002:a05:6102:c4a:b0:4b6:d108:cac1 with SMTP id
 ada2fe7eead31-4c9e4eec888mr11050940137.9.1744705651860; Tue, 15 Apr 2025
 01:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com> <87o6wy1a3a.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87o6wy1a3a.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Apr 2025 10:27:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXX-An5=Q9Eunyy5pLwaJ8A3k333-OUQ9B=+xyKP1m0mg@mail.gmail.com>
X-Gm-Features: ATxdqUEIJsRkcyk194C5WDQ-k8_ecv3OZ-eRHLxN4ZrL9IbC3X6gIAUyq2lPs10
Message-ID: <CAMuHMdXX-An5=Q9Eunyy5pLwaJ8A3k333-OUQ9B=+xyKP1m0mg@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] arm64: dts: renesas: r8a779g0: tidyup MSIOF node name
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Tue, 15 Apr 2025 at 03:34, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> MSIOF will be used as both SPI or I2S. The node name is not "spi".
> Rename it to "serial-engine".
>
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> @@ -1250,7 +1250,7 @@ tpu: pwm@e6e80000 {
>                         status = "disabled";
>                 };
>
> -               msiof0: spi@e6e90000 {
> +               msiof0: serial-engine@e6e90000 {

Unfortunately this means that this instance can no longer be used in
SPI mode without changing the node name back.  E.g. with [1]:

    serial-engine@e6ea0000: Unevaluated properties are not allowed
('#address-cells', '#size-cells', 'cn5@0' were unexpected)

>                         compatible = "renesas,msiof-r8a779g0",
>                                      "renesas,rcar-gen4-msiof";
>                         reg = <0 0xe6e90000 0 0x0064>;

[1] "arm64: dts: renesas: white-hawk: cn5: Add overlay for MSIOF1"
    https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/renesas-overlays&id=0b4f1af2c454b49b9f266900dcb578dc311b1475

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

