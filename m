Return-Path: <linux-spi+bounces-11596-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D48C89C70
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D0F3B6D5C
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FBC327BE1;
	Wed, 26 Nov 2025 12:31:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB382FFDF3
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160285; cv=none; b=Wme0REVQO9ZUb28NmnWBDtcQH/gWPJpIXawn72zb6oAZS6KOmgGkgPuA0jqs73ih8QMubEbFPumBYaqS3IHQ2FdifXEX+ojoh/0liPSrgUyrBOLKmoIYmVDDgQKnYTyyVNEn/w+xJRlD3BHWbEDRcjlZoUBGB4Uo2sUxu6R6+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160285; c=relaxed/simple;
	bh=n72+LqBciqZ8qXv8XKxHQzFcQ/xEgnqQaVpiyP9J89U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SszAOJlfsmrFS0xmRjHikZtqi8C11Rhr0Q3a3Ox+TJBCksvOBvcNfDqkycprgF8aMPtPhOPM8xYRy9Z6EQbavnBmCppHzG3FuooB/CZ5bSi/F5XxAv0ObT76aYoqh/CRCDuta7Msxe9eK+MK+2qLKUrd80IddxjTU6jMPEYn/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55999cc2a87so1026819e0c.0
        for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 04:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764160283; x=1764765083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IebHBTGSBZDf2bN+LDoDCtbDaHZ5HR00nyG3SMmY0/Y=;
        b=wx3u/HdTUcYetNLItcy7sWZFYot5Ey0Fj2wfc+eqoze4y/ZNRKoiHg/iDG5VB1SyLz
         SgxCNunBtOMFLlyZ1bUZp+VtM6p33iYXUcC+Alw6425wGfmN6NzvR+YTDcvFjCi5FaXM
         JoJgwXlESfw6kTZEz/hnlt0KoV3fzfN2SkP40RgLAP7P5PcVYe8NLOGo3RB2oYc9iuW6
         kRz9l+a0yS5UWiW24DKI+BUhNGAHEDPBpgmVLoOmcXq1Qz/06WFZKwAlGHNPywVha5uO
         10Ku8OZBAoKFArDlw69Anjl2Un3P23r7a/+BDyzMGVfXr6NBFtLLySpKn6fBiZ6nYIAY
         je9w==
X-Forwarded-Encrypted: i=1; AJvYcCUCylKQ6Liw4uCGRMMGTkbr+LcHRQV+3IQGGOIDA24NzUO5ulp5NX81s3oiuBhV/d2o06miKKyuEEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZBpryKL3enXuU8S4Jm9VvlFuwn4QWq0gOkCkWNWUBPQgRPz5K
	9kW1okHtKl06IYqsgEwk/iderjbO+zyiQmeeXantwI9lByeG8wbRwapetYYq01YF
X-Gm-Gg: ASbGncumLcokgeVZFpLcvNzbWYxdQidE1Fyj/O81oi3WSUi72FSugq+3BCcuiwZOVbT
	m3KnzNr0ZD/L/XdmlifMqzK+6nuEWE/VLLMa09H/FqJIhABjMZdMMvdx63GviSrjBCha3zxDgxA
	4JC2HXxfjAb1wc3QiU9h+k/GBGiU9pLPSiKeCDrSTIla+YwW/bW/jB6RwdLbyB1vs86nqI4sF0p
	lAcgETTNzhgfVWDPGm7CZPZhIcL6kiMwwvCIE/HZPvglQ9vqcbMNgEZ6xu+V+ZdIk5VhQh8NIzV
	x4/Zchl/w9jQvcyQY8Vg9gkZmjnSHUl4Dy0+Tftg59WaVGnd+Q/oWKS5oICcibzRS1TBPes3NBI
	L+Ime85rPehnCpI4aNaAJmWiPEfOvCM/PPhjCDn6UMsklEKtDrHXhmdCfa2UannzPbUBdsb79bc
	p5AsWJV02Ermn2YyaKB0p1/U1vM+pa2HrogFRvSh9cJnz/B08u
X-Google-Smtp-Source: AGHT+IGtzSQK3xHiWev45O9bW0+43gCXbDDN7UFF4J2qFQuUV55d0t5arLCdVatjOA7ZZ3NWaLWAGw==
X-Received: by 2002:a05:6122:660a:b0:53c:6d68:1cce with SMTP id 71dfb90a1353d-55b8efff034mr6283576e0c.16.1764160282448;
        Wed, 26 Nov 2025 04:31:22 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f633999sm8376209e0c.6.2025.11.26.04.31.21
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 04:31:22 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5dbddd71c46so2564967137.2
        for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 04:31:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGJoHSd4e4KOxYgpgPsH4WmW6TXgkTuDTlCzXPDQZZ32iPNmmB4rUsg5AImbpUDrt2jLbTEMZz1Dc=@vger.kernel.org
X-Received: by 2002:a05:6102:b06:b0:5df:8f4:61e6 with SMTP id
 ada2fe7eead31-5e1de4306d4mr5874535137.32.1764160281205; Wed, 26 Nov 2025
 04:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXD3f3jN2F7c+yHmEb1C5Byc-e=sEXt_s=UpBQLv_F=Pg@mail.gmail.com> <CA+V-a8vDzG3_CKUPRLmFv9Z3qjqcgAp8vhpBHkGs=EA3o3Zxkg@mail.gmail.com>
In-Reply-To: <CA+V-a8vDzG3_CKUPRLmFv9Z3qjqcgAp8vhpBHkGs=EA3o3Zxkg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Nov 2025 13:31:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUM8hN0xM2Q-Y_oGb+u=+ONabO-M-Wg+_5A-SStHm4pdw@mail.gmail.com>
X-Gm-Features: AWmQ_bmlFD-VTRpd9QpSsyXpi_cI3W3wmlQ-DQEzT-MkMb8_VH0lcb9MT1A0uEc
Message-ID: <CAMuHMdUM8hN0xM2Q-Y_oGb+u=+ONabO-M-Wg+_5A-SStHm4pdw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/V2N SoC support
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Wed, 26 Nov 2025 at 13:11, Lad, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> On Wed, Nov 26, 2025 at 11:38=E2=80=AFAM Geert Uytterhoeven
> > On Tue, 25 Nov 2025 at 22:45, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Document the RSPI controller on the Renesas RZ/V2N SoC. The block is
> > > compatible with the RSPI implementation found on the RZ/V2H(P) family=
.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >
> > > --- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> > > @@ -12,6 +12,9 @@ maintainers:
> > >  properties:
> > >    compatible:
> > >      oneOf:
> > > +      - items:
> > > +          - const: renesas,r9a09g056-rspi # RZ/V2N
> > > +          - const: renesas,r9a09g057-rspi
> >
> > I am a bit intrigued too read that the initial value of the SPI
> > Transfer FIFO Status Register indicates 4 empty stages on RZ/V2H,
> > and 16 on RZ/V2N, while both variants have a 16-stage FIFO...
> >
> Both SoC variants report a value of 0x10 for the RSPIm_SPTFSR register.
>
> Rev.1.20 for RZ/V2N mentions, 16-stage
> Rev.1.30 for RZ/V2H mentions, 16-stage

My RZ/V2H Rev.1.20 says 4h (Section 7.5.2.2.19 SPI Transfer FIFO
Status Register (RSPIm_SPTFSR) and Table 7.5.2.1 List of Registers)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

