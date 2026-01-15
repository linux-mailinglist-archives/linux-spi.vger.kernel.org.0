Return-Path: <linux-spi+bounces-12412-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF73DD249CF
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 13:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DCF1304281C
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43FC397ACA;
	Thu, 15 Jan 2026 12:51:20 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B7399A73
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768481480; cv=none; b=Yol1pXmlaL4eYTj6GeqJVgF2RWFydsO+ClQeLLOC/NrU/oPj4Dz164rECHbdbQlDDWPAj06C/AXfyzzgcnEtK2ofbyoAU6OpWJD+TBkHKLxNdkuR0MnEZDEcpDmwzl7u82ZpKMpj9IL/RtsBN+A+2UG7sVTZ1NL3GBCNv5r2bOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768481480; c=relaxed/simple;
	bh=G0llLSNnn6NcC6KSkN6kYKOlUKIgvNvU2oPhikHdlbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srblFr/3thJfLGQgU3vkkxoxV0o4CuC8A3t5BWOy9wetRo/8qnKtLo+WpoZA7bJVCC57mbnuT2jWHqX+Iry/q6JCIQ8c0zlGAzhHTUbzi4ZWpsM5rdlad1yOZ8JPsyshftKjL2YP0y372Vc6/2FyyuwAoa8n/Eo2+AUWN50qXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d6f647e2so9061725ad.1
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 04:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768481479; x=1769086279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTjFGVrWlLy/q+nJJcYxgEGTZ7R4mxUKMHt8K/er7Bk=;
        b=h8RQd9tu/LuzS2bPO2fKEov+s5oz6fo/3n75ujYJZWTP69rg4ktU1KJtfAo/D/47BF
         6ud3tIoSJaxj0fUh1RMvCKer4mytMWe0Jva9WvGkWt8n0KqYM/3D+xtMlyVnnVl3aFXO
         JoUuoxVGFo83+tsgZSDiv8jxmNo/9+7LJi5EGmqNiEKXVRZZaQfmEIXiBBIvLjCG5m/U
         a8hqUcbnUyGFFqLKnGYN0xNhVLV09zUMIZ7FngJ3Ek5kpHmo7SR2q1rJ6ZSn8KbvPqxm
         rsnL1gEoQ1SkwdsDwgstDufgmVyUy6OOigCF73K+le0wl3tX9wk87ISut/gf1ejc7jea
         BD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVllTDkF4aOJVHZmVYPlom+SHY4coKzFTcBQRGbdCC4N7lFuxtb4eGB29cKjBNZ9aHrkRhheGddWGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuXwqV9t8aAuHGiYiy/Mix087OjW5oGFC1CtOYR0NPq+3oa7Vt
	lvgj7HgG4B5HIsv7ztW+H4aKQww6nwYezFksY1LjgmxeeW45BN9RsXYkcAPZRMBqxdA=
X-Gm-Gg: AY/fxX5Ho7r4m/W/NMOXrx+crCvSaQ5h/Ek/FxlO5hDFcz2jcvunUgdVdINjMomzFgR
	evqBgEQPVhRPDuOiPd6p1CWlc4Et6n4W6YJseTQOLNA+WgM9Xfgq2JVGI+IgUt6IZlkq66vjwms
	7CMBtqAXNYJViJRfrolN/QvgvsYzHaE2QGnSsZdluHwktTKXZTtHwn6X2ML+qokXHQbZ4LTu4I5
	Pl2fiO4qyyshh9WkIIQEgPIj4llUq+kXwQy5EY6Yg0cNrVeDv+Du6AtTZgJiJzaw7gYT1LdZZhn
	Z8Y6e1KIiCxjQy5s+PwK0ngfAlmTfjUkNzHhp+qX41AWxb+Kr5nCPoHRJoKPPbCR992HIM6j/Nb
	ipH9zO50B8g8rzw+OqJIwj+xCVrtbGxgNjZrFRX8VWxYYlNo8ogzMbhCo7GP0y7xM25ch39IMg7
	XX45Z14n/kMrIr9MGgL+ao0puiQwAC8oksjdGbKPlFlBSOHsoESOk0ps4cBiNMMRA=
X-Received: by 2002:a17:902:fc44:b0:2a0:bb3b:4191 with SMTP id d9443c01a7336-2a599da50e6mr64223895ad.12.1768481478604;
        Thu, 15 Jan 2026 04:51:18 -0800 (PST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com. [209.85.210.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c4893dsm250399575ad.28.2026.01.15.04.51.18
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 04:51:18 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81f3fba4a11so834998b3a.1
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 04:51:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIXXezw9IWLjP0Q+j8qFk0n/QMwjAQJh4AhbxU1o9j0C9rRMAnRbVq9Dap3KTGFK7i/iAm0nWxUpM=@vger.kernel.org
X-Received: by 2002:a05:6102:3f47:b0:5ef:b3b7:6e3f with SMTP id
 ada2fe7eead31-5f17f416e55mr2503254137.3.1768481150952; Thu, 15 Jan 2026
 04:45:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com> <20260115-schneider-6-19-rc1-qspi-v2-1-7e6a06e1e17b@bootlin.com>
In-Reply-To: <20260115-schneider-6-19-rc1-qspi-v2-1-7e6a06e1e17b@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Jan 2026 13:45:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW5hwNu-07-7xvyWdcGKUZy+pCX0=W=JNgd4h7m72wQFg@mail.gmail.com>
X-Gm-Features: AZwV_QhONECo5-MoxTpQjjP-7GyvFR79J783OyYxOrmcopvq9NEZH1YUXPhgpUI
Message-ID: <CAMuHMdW5hwNu-07-7xvyWdcGKUZy+pCX0=W=JNgd4h7m72wQFg@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] spi: dt-bindings: cdns,qspi-nor: Add Renesas
 RZ/N1D400 to the list
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
> Add support for the Renesas RZ/N1D400 QSPI controller.
>
> This SoC is identified in the bindings with its other name: r9a06g032.
> It is part of the RZ/N1 family, which contains a "D" and a "S"
> variant. IPs in this SoC are typically described using 3
> compatibles (the SoC specific compatible, the family compatible, and the
> original Cadence IP compatible), follow this convention.
>
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -80,6 +80,10 @@ properties:
>            # controllers are meant to be used with flashes of all kinds,
>            # ie. also NAND flashes, not only NOR flashes.
>            - const: cdns,qspi-nor
> +      - items:
> +          - const: renesas,r9a06g032-qspi
> +          - const: renesas,rzn1-qspi
> +          - const: cdns,qspi-nor

Doesn't the need for (at least) the CQSPI_NO_INDIRECT_MODE flag mean
that this device is not compatible with cdns,qspi-nor, and thus the
cdns,qspi-nor fallback must not be used?

>        - const: cdns,qspi-nor
>          deprecated: true
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

