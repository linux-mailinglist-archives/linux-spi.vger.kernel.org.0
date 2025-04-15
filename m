Return-Path: <linux-spi+bounces-7594-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72647A89625
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 10:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200473A85FD
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C742B27B506;
	Tue, 15 Apr 2025 08:11:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A29A205AA3;
	Tue, 15 Apr 2025 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704689; cv=none; b=HhuTwgfk8aP646O75jmV5aAXb+EQ7TY/NQSJlykIaHydxETTx8bn+x18l3DGXWRAN1yZK6fcnvraj0P1EP/TQlG8EDDXiSPNi7WTEnV7aBw/aJdNU1mkRLLDlLy1VHaFzIqTm9zKj2BBtYhU9ZL+5pmtYwKPhMpPrYCSgnmyl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704689; c=relaxed/simple;
	bh=go4ZrD0N8TZrY/EL8HCtzNjBa1MLp/1yc68UAa0kVT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmPCrwMe09hCehLTw2KOPchoABLaBiqhyoadX1Dqj5ShbsgAgKoxOCCbCXiG2b9h+FTZR4EqS10RwjF050CWJ52IZRragt/8hY8sllmsvlbJcmLj6CuRXOEuyKED409HNrVmMmgPUGh1XY5chY+dKnly2vC9EXiOB1bH8sjGE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-523fa0df55dso5562068e0c.1;
        Tue, 15 Apr 2025 01:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744704685; x=1745309485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDP2FfxwMn/fO7MVGYXKNRgvr+3XYMhfA8mxApu8T60=;
        b=IDJO+QFgxLlQ9uwFarYWencCo3BpTX6RALfSpzkWg8YXKUKiyhaAqhY99dQm3aXuWs
         jYCSOsLsuCw9LcoJJP778OS22Lf7HmQMPC6wTNy5mo/Kv1bNU3EtyVcQGExsNKIwjAqt
         K8Bqmm3j+QHsFsGcCDfHrL+SinFFgJ7PyR/NML1dNwFv8VlS1N205YF36hlkg7Q2Plkb
         QwBbC5rltqpTVbqDRI+aA/zp9En7dpdOCn99gr8WtZFB75Ac6ZH/ULmSF3cbKRZWZ+l5
         lVpwI9Tdk0Ln19g039GJhmmD3UHv9fVKYi7j1C6M//1xYz5apxsUifuZ3PPo9hx9OYuh
         2M9g==
X-Forwarded-Encrypted: i=1; AJvYcCVPJCDW6Jc0xTljIn9Xsmb/HGGU/vZ8qVlOG9zzEcQVwuimiAT3zA7LwEJE+l80HXR77HfuN/ScrowfBPw=@vger.kernel.org, AJvYcCVUNwNp/g8a205u/jSOYam17z4btrd0AXBXMIRwORyLd3m3M1svhf3YZXlMXB2rIXer+NGZWBNAkxXJ@vger.kernel.org, AJvYcCWwAdnJKP57J/N5JjBgM+05SWIdrAiZWMaKP2iERd75iTbMuz5Iq2OUN7o3KFAhJyp8BIAJcNB6yseIVaqrlKKmcAY=@vger.kernel.org, AJvYcCXDPDO4xr/Ez/XNMbs5pyuhujkVEkE5w/XCKANnirC9cQzcrZrfqwjU14h/4B1jxZ2wnLunhtCjBOka@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq00x6KXAWQ1rNgaEtF5ELm0Vfqlykmy09QRsStqYGeHCCr2jP
	hUGABwfc5qmP6Li3VYzC1/heYCPCoSGLRhTkV9yrFxQCulVN+A9AFHcw/FJ1
X-Gm-Gg: ASbGncsDXdu6k3S4CfyqfF8sFsLaGXGbGXeyQibituXfolTaqDOK3WRneFQKuRv5Awt
	s4C0H7R4Ftql44Ue41vCJgihMBGlXAOcN0kYXgl6U+xHTD0PhnOsCxQ43jEbEnJ9ZQDXcKguoIl
	CAXXP2Rpu5aopKRujdD/o9CigSrjHG2Bwf8ZulZ5e0AS6OyL20eeU3hk3nq6yqkHjQNAzIPY5FH
	HWPxVdQxuRPo9Zf+1uU8qFfsmU8NMPStVq/ZCT8SeVFBNIq5VfK4tqbdS4Nju7ykP4FEso38k8m
	6DCQsbmD856Z1MYZ0kfpLAFin/1UcePou1EZhCh9rszc39ZCQiHiD7h0q9Z3Wt+tK8Vm08m4wO8
	O/5Q=
X-Google-Smtp-Source: AGHT+IGfXDBlpjXLAePbSzrWxFUGLcG03aCwz/OaC4Sp4GKCE+/4jLOwsgGVqDqLobkGMJuG/+0ScA==
X-Received: by 2002:a05:6122:547:b0:523:6eef:af62 with SMTP id 71dfb90a1353d-528f0c5b625mr1665797e0c.4.1744704685402;
        Tue, 15 Apr 2025 01:11:25 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8755713746esm2550892241.12.2025.04.15.01.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 01:11:25 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4c4eeb36d12so156088137.0;
        Tue, 15 Apr 2025 01:11:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDijKqEBcVZmktp+3veikFzkuGw4nXUVezOYX6OUdKn0rCebXtOfey3wA6ag6KmGu8DHm+zexLTgiT0Ts=@vger.kernel.org, AJvYcCUOZtXQZKsvMnxCvVlsjSCU3KX+EY1ZL/21ntARcrwcT7rmuYdZMx7jtKNCISdSMYoqYv4FNmNkE7PmWbJPo3cYhm8=@vger.kernel.org, AJvYcCUdWJTuaKccG5Bm2X8uBA+1sdG+9ERG48PsTkMNzZEvJ8BrQmgWHCSg/LOchCZ00coyrMiZD2KPuTMZ@vger.kernel.org, AJvYcCVK3mX75pQL2PQAJ+iHeC8Wa764mOqtfSFVrHiYCNikKGjhAa0yptTGjeWgW6AuW70saqboww1zhGaE@vger.kernel.org
X-Received: by 2002:a05:6102:32d4:b0:4c3:b75:16e6 with SMTP id
 ada2fe7eead31-4cb42eadcb2mr1769418137.10.1744704684626; Tue, 15 Apr 2025
 01:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com> <87plhe1a3f.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87plhe1a3f.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Apr 2025 10:11:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXjUY7KEF634Rn7ghF1MwLrzMH33POkSWhLVweW3ukjng@mail.gmail.com>
X-Gm-Features: ATxdqUExp-Wlyei0V7G9GnYdt2na2Zx7qvOecrD5K1BzwNxlqkUDVS7dh49SyAM
Message-ID: <CAMuHMdXjUY7KEF634Rn7ghF1MwLrzMH33POkSWhLVweW3ukjng@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] ASoC: renesas: add MSIOF sound support
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
> Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
> both SPI and I2S. Adds MSIOF-I2S driver.
>
> MSIOF-SPI/I2S are using same DT compatible properties.
> MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
> MSIOF-SPI doesn't use  Of-Graph.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for the update!

The hardware driving part LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

