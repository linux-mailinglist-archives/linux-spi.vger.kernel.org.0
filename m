Return-Path: <linux-spi+bounces-12413-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB07D24AA6
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 14:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 125E930245EF
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1915536E47A;
	Thu, 15 Jan 2026 13:07:27 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85336D51F
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482447; cv=none; b=YzR16DIB9I82t3qpNBjYFwzYtIZe0sxvY4c1/akJcUyinJm7gIX8r/KyVcX/gGfZH0YUPRdzP8k/2siLoLT24u37ZeUds5HstObkOQUfYQ3kegzqbX0XYAO/jkATwOAslJd5OUWwqDckH+IN32wg5TWtVvEEy6b2fl9kM0b5M0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482447; c=relaxed/simple;
	bh=Fb6cfrlDYSTdVoKacM7aiIt44RbJJ9yXtiwK/Pb98Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bgq2LI68PkO2bFU300wx4VoLR3tIGsf4EjlQvHm3hcgl17vW1zK49nRhBSBDCG9KBhbNg7WBsxADInyVLtfrmS8j7B37I4Yu82qh1PwSqKegQxEkA/dIG7J3f0kGU3lKFvPEbIqNitHm/5HyN8KomIhSh22UWG6BpOD+n1WnasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45c7f550f46so516441b6e.3
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 05:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768482444; x=1769087244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5LfkH5b0Cd4aXVhitL2lfRzadsZBam/RVDEkq/qT48=;
        b=wY6NiLfBsSCljAQrSiTgkQj1Qnw+uGU4J+m91FGg6vk270DN3iFDspI7DW/HQmXj18
         5k44eIM8dzFCvmxLOcc/gQZUTK0QawIlKtsz2QYOUMBkj2Ixs4zXq2Tgkg0MQf2UOdxM
         FilDHge7ecPWXaafO/J1FwEbL/uUzYyhkbtr6NMNpf+JZGKsD+OyNjEbioeHgBMVnLkl
         3T2iq+jkMmmgBkBlPAjYG1pPb4IgHH3lVVXzoGr71oatAHfPQBM8h2mkdGKv1azUEiEq
         KhXyYySL1nRY49UiPae9ki/7pvYEHB4Mxj/ExI3iPLX/hZHFn/BinYyFsxPWE0CW6Kyq
         AbYw==
X-Forwarded-Encrypted: i=1; AJvYcCWBNT5J99wMSu8IV/KUp1MSNsDLwDsfaJMtV+HZbe3Z5jLidCRWXwAIrtrSAb2l8kd1sgwpem9vl1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybo9VMzsWs/ehJW0/iTBdCKukFwGRAc0XcBKVR0sCFd28Adwka
	mczYecpuoH0FgU5vTcZsETqCm0V++f3DgA9JKpxDYr+Toq/asv9i5rS3y+PnyB5Uv1s=
X-Gm-Gg: AY/fxX4jvSG/LibC3xbvE5iSpU0w41TImbwgKRraoHBNpGediWZkRpxAZ77bucaqaI7
	6SFez0iON/2FOMb7CyWPTtTaf2tesUSJ76ycXY7r0tlV+KzCMJKFxs/gRKjcW1p1VK6QaQcbIxA
	9vlXizBpXr/6aiVwVAHJYqeBPHaT365NBTxIRSZmk6n5A4CwEQD5m/1A94iBC3XEJCQWPtKr87o
	+GqGpqdjOQ/lOGjQJzghGkGqaCAbSzF8PxQTjAspo2036M6ly7AWRZRAEfz7Bbcy+D5jGHHUCbi
	6jmtlfhoZmMg79Et6/eTyv1TqtL8PojJ+YZoQ3gh65Snl45FwibA79oFt3nGmfKRZnucFRUDQ8q
	gBsfQr3KCmK3IxNGHi+IsdUOT9ymnib9B3quLBvDf2JUqrWjrCl2Go6T20GmvjDM1RoyMNwsX+a
	3Wq9/3BwWfIJIp7GcjsgctjJQGNNvqnr5LWReLyB4U4uezCUb34u7wuMOjrZI=
X-Received: by 2002:a05:6830:4890:b0:7cf:dd08:356b with SMTP id 46e09a7af769-7cfdd083660mr25187a34.38.1768482444345;
        Thu, 15 Jan 2026 05:07:24 -0800 (PST)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com. [209.85.160.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfc3692f3asm5219748a34.10.2026.01.15.05.07.23
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 05:07:23 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3ec3cdcda4eso688483fac.1
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 05:07:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0AF6Y2zbSJaB/+bo0AKuxji2NsZMCBVzctXS2E1zivbpLk5LaCcLJbvQrtiIH9fCe3yrG7BcwjfQ=@vger.kernel.org
X-Received: by 2002:a05:6122:1311:b0:55b:305b:51b5 with SMTP id
 71dfb90a1353d-563a0a2026fmr2362086e0c.18.1768482061472; Thu, 15 Jan 2026
 05:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com> <20260115-schneider-6-19-rc1-qspi-v2-13-7e6a06e1e17b@bootlin.com>
In-Reply-To: <20260115-schneider-6-19-rc1-qspi-v2-13-7e6a06e1e17b@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Jan 2026 14:00:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUHwqBrNMQTO-g7yUA_owWXxT6bPi34Oxjt-J7N0Q2CXQ@mail.gmail.com>
X-Gm-Features: AZwV_Qj-rtbfaLket3bPJJXXpuT_68XztGQx-eBD01J-7kSXq9lOwz27T9URfFE
Message-ID: <CAMuHMdUHwqBrNMQTO-g7yUA_owWXxT6bPi34Oxjt-J7N0Q2CXQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] ARM: dts: r9a06g032: Describe the QSPI controller
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Vaishnav Achath <vaishnav.a@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Santhosh Kumar K <s-k6@ti.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Miquel,

On Thu, 15 Jan 2026 at 10:25, Miquel Raynal (Schneider Electric)
<miquel.raynal@bootlin.com> wrote:
> Add a node describing the QSPI controller.
> There are 2 clocks feeding this controller:
> - one for the reference clock
> - one that feeds both the ahb and the apb interfaces
> As the binding expect either the ref clock, or all three (ref, ahb and
> apb) clocks, it makes sense to provide the same clock twice.
>
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/renesas/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
> @@ -66,6 +66,20 @@ soc {
>                 #size-cells = <1>;
>                 ranges;
>
> +               qspi0: spi@40005000 {
> +                       compatible = "renesas,r9a06g032-qspi", "renesas,rzn1-qspi", "cdns,qspi-nor";
> +                       reg = <0x40005000 0x1000>, <0x10000000 0x10000000>;
> +                       interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&sysctrl R9A06G032_CLK_QSPI0>, <&sysctrl R9A06G032_HCLK_QSPI0>,
> +                                <&sysctrl R9A06G032_HCLK_QSPI0>;
> +                       clock-names = "ref", "ahb", "apb";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       cdns,fifo-width = <4>;

<4> is the default, right?

> +                       cdns,trigger-address = <0>;

Where in the RZ/N1 docs can I find if these two properties are correct?

> +                       status = "disabled";
> +               };
> +
>                 rtc0: rtc@40006000 {
>                         compatible = "renesas,r9a06g032-rtc", "renesas,rzn1-rtc";
>                         reg = <0x40006000 0x1000>;

The rest LGTM, ignoring my comments on the bindings:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

