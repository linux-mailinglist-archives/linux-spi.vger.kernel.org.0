Return-Path: <linux-spi+bounces-11590-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5BCC89B19
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 528134E50BF
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131E73195E8;
	Wed, 26 Nov 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4MyEpi+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF731AF2A
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159071; cv=none; b=pVc3zM9kw+YJ3QTxBC2rWres9+0PuWlHsjUnqVxe55ivdKBbT2zPVrYSTTvOKFtA7FAR4021CgteovLN7D0okxMw7MWyBKgc+m1z/G/bSvZmZ734DPKRTSK/PHUlxSpeEilhks4rAdkvtdglm2DtU/yB7Ng+S1To8v0tZLlx7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159071; c=relaxed/simple;
	bh=A/iiy+Fp1kAykWnlOzSoYnOlxAMMKyuoGr+9DwSiOQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okVFei6C0WH+MaHhpLLAGyNBbzNUk7/s1NVjHbOx9XSIEGpvcebRVJRRkSpJBzqf8JnGwPpATG2ptw+uuRcFvgsaFQz5uZ5RAShxXzCLbrDXAWykivHDGTETIyJzl2ff9llZ0KzUESxAaatbu1Fczej8v3DcbJwFtf4pi8jet6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4MyEpi+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso43675775e9.3
        for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 04:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764159066; x=1764763866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9jAY13IDhoBX88jeAJQmVezaHbYmh2Vhoc27H1l3dI=;
        b=h4MyEpi+vv0FHF59vvCj38TW7jfl/WBP2JXP2mc5I2THiluJX3BEoUXCo/pEVuDsJp
         geteYMBq0gNMmCfIt8k8we8SoZOZFTh83KpH802VDMPJg+jkmTMpaqDs557iEPgt5LWr
         kRuzDYkqa8b9iMGobNBsCUqj+ENyBBq7W6OLsr1EqpVYGZLDHTEMJlbYBk82d/q2Y667
         Mat7m8lK1S8xjY9PV63AEzdYg/f+nxHfIDWeCskeg0iZ3tgWhNMjB3uCbi6YZdD2KYir
         4YRdedf0KjqanKF1T2XlmblJ6Wu1VEkuKKc7+R2nECLwUIizkG1Uzt+tWGCRzzcQg3k8
         dkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764159066; x=1764763866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z9jAY13IDhoBX88jeAJQmVezaHbYmh2Vhoc27H1l3dI=;
        b=wYNxRBvbmpH+4UueQ5Ioe/Fm9SInw3BppBBYvSl0ewyolhmyRl5WmSaE9sR7wdnCvd
         B1dTOChbmI8Q4SA9g94wemC4758ticFev7KTMpIkC/Q5ElM3F4GBbkN/Mg19bFSc8uoZ
         Rn0Ju3Bo5FNh1+6PZZCGtnruqWRx/Fxjdr59Mo/c0T0ui09NjtAeDWjYkkI6EIvrDaZk
         bNCrgmCycD3sFeWgkfxNW0VhcPG6DhT43o6cIaRjl+RGFotzQzku6CL4m6XdF+i/ZNT2
         uq6m2KMF3/q3MPsLkJVYXNZnLJ4f4hQ3UwqFuFQ+6sy4bjTLReQqKcXUX/jHRSbNxkTm
         c7vw==
X-Forwarded-Encrypted: i=1; AJvYcCX0rwnXyihKNTc2YvSMfqOR7s++CsBzoALpXOi/P2jCSXuSvMpqw+lq/JMLw3dkud788KvRE7Z8A0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7lczbIx1qbZnscthj6zDzDRmRrN0L9SrvYGNgIDh4tnd8S4G
	sLGotgE+xivaeoUOLiM2sXacIDQtuoKgjpYlFRxxZ7fxauRrx3wrv+hCvzTTLlS6EVi7XeumLq6
	EOwX7xQagsRVzb+VocZekjUs33zM603M=
X-Gm-Gg: ASbGncvzJ+jSflS8KfN3NEWwDojvUvqvKsHl1l+7YCZgjhKDvEEsyeakU5eilAeLnLJ
	3I1JvMPAJo4Lb4+FgjJsPnxJgquMVlQolNgngSqejFzMXdA83/VIeSRNc0OeMpOFLCsNqyzhgn1
	bDbMVp4nJ7H/t2FB58AJE8fPpQ4gdsbDl3/IV0nWZgUMfrfMmCQptMHivWKK6GgVUc11F1whVSk
	yGjkyLhaqgV3/zv1zX42jKSZB3AKO9HFNX0Gy3HkgxG54YGvM9XHOKRjzyRg2WI+anWGlDVx8Mf
	PfZDWmnL
X-Google-Smtp-Source: AGHT+IHC636RCi1541Ptvl75RzMnsiTIVETO1sWQDjqj+JrAZ9vxfXHnCrioMKRVqEbU6FVYIm3EdyVyxe4JOxXwHlw=
X-Received: by 2002:a05:600c:154c:b0:477:7b16:5f88 with SMTP id
 5b1f17b1804b1-477c0165a5cmr180904235e9.6.1764159066280; Wed, 26 Nov 2025
 04:11:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXD3f3jN2F7c+yHmEb1C5Byc-e=sEXt_s=UpBQLv_F=Pg@mail.gmail.com>
In-Reply-To: <CAMuHMdXD3f3jN2F7c+yHmEb1C5Byc-e=sEXt_s=UpBQLv_F=Pg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 26 Nov 2025 12:10:38 +0000
X-Gm-Features: AWmQ_blZWyGSSPNsufLhVifRnEBMhm6m_dSKdeAvhR9B3oeWnomG5gtFBihklV8
Message-ID: <CA+V-a8vDzG3_CKUPRLmFv9Z3qjqcgAp8vhpBHkGs=EA3o3Zxkg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/V2N SoC support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Wed, Nov 26, 2025 at 11:38=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 25 Nov 2025 at 22:45, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document the RSPI controller on the Renesas RZ/V2N SoC. The block is
> > compatible with the RSPI implementation found on the RZ/V2H(P) family.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> > @@ -12,6 +12,9 @@ maintainers:
> >  properties:
> >    compatible:
> >      oneOf:
> > +      - items:
> > +          - const: renesas,r9a09g056-rspi # RZ/V2N
> > +          - const: renesas,r9a09g057-rspi
>
> I am a bit intrigued too read that the initial value of the SPI
> Transfer FIFO Status Register indicates 4 empty stages on RZ/V2H,
> and 16 on RZ/V2N, while both variants have a 16-stage FIFO...
>
Both SoC variants report a value of 0x10 for the RSPIm_SPTFSR register.

Rev.1.20 for RZ/V2N mentions, 16-stage
Rev.1.30 for RZ/V2H mentions, 16-stage

> >        - enum:
>
> Please don't bury the enum between two items.  Put it at either the
> top or the bottom of the oneOf list.
>
Ok, I will fix that and send v2. The reason to do this was to keep it
sorted based on the SoC part number.


Cheers,
Prabhakar

> >            - renesas,r9a09g057-rspi # RZ/V2H(P)
> >            - renesas,r9a09g077-rspi # RZ/T2H
>
> For the content added:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

