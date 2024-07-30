Return-Path: <linux-spi+bounces-4078-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81107940EB9
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 12:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BADD281796
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D82195B28;
	Tue, 30 Jul 2024 10:12:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7BB194AD7;
	Tue, 30 Jul 2024 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334357; cv=none; b=RoLUnVJkDxcf5fPpmgw8B5y/KasFgy2Pmypdp0n8HarsRm8qYuge6hBaq6ZMxP+N11oktUabdtM6yioxqn1Pmmnxmph9/2/6TFXLey1hFtEG3c8qI+c7fjzE2KXK7VR+TOcye1vCJ979xZFjAmt4vmjUfWvHraSEcpAc0Z3oC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334357; c=relaxed/simple;
	bh=iZXnJnntrAc9WavZB2/AHlbamGg2kaYx6GLjBAsUAp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdVjmx19ommBKIty/9nDPpxBzWrWmFSWgp6vreNuxvFJh9Wmc32QLvmCFeSYK7hyy5dT/Mm7L7Nt5zmpRAoBMXW3oDaxy7BtGR0qvFGiQE1hICq7kD+xAd2/dzLucMVWFlJ7ZcxeHTAe6QXD7JErZzlhok3CJfIdj7UmbC10Ucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0b286b922eso2775141276.1;
        Tue, 30 Jul 2024 03:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722334353; x=1722939153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMFk/2VRq2rm8iMk5HQVpTAxXpKF9aMv9v1fRZs/yuY=;
        b=iv9jZeWVmtvYd5W9LrJJCI/2omIG/Ua0xMOpWPv89x5VxEpOhT1+AQl1BZziQgF3ka
         VpqSDHM/K3DZZgeiT5+ACpeuhI6DEhDJGNGzy5warta0gS3jhuHLNeuPCNkCnbCJ6HNo
         xTwZU6lPvLWd+y56HuuYicofaT7YCbk+1qKOErPKAM9zS3lBM3O8L1/77pJCsTbpWhcP
         l8vlecsmAVfW0ACrKHpCe2+E0KWAuRhQC0EZFcZnovh8uxFOb278OB/WYhn3qoUiSobC
         dajPz49UE1N/YkF3+p3UTzUpHHjOMtatkwlhlxLeNBm0CXzRnBuRVnjtmEo3pJzXVwxB
         No3A==
X-Forwarded-Encrypted: i=1; AJvYcCURh9Wy9+tkB2cAbfczFcRNq9ZBit7bryjvLUEbm8TKKgByC7Twq4+W6YKBOgIQQx53mQEZKv8cMqnfQX1j5AdmTcaOw8xedVaLc1occQVpnX00lbgfPQ7MbvSZ9q6ajfPkyjtgKg==
X-Gm-Message-State: AOJu0YwyQytbCJEp7AUfEYW12xoCbcTtO0be1ypSWY95e/T1dHiJk2US
	v8HZ3dYzLLlmDXaTDghioqst4YM4+LFt6A+/YVA4iKZvqIXYC3qyEqSXG9kU
X-Google-Smtp-Source: AGHT+IEATwAX61DtN0XSsERqE5u5Is9BRj+d+Tp8b/PDKy/+kfhR7Ero/ex3/f59gHLOsuI25+OnDQ==
X-Received: by 2002:a05:6902:1506:b0:e08:6732:1145 with SMTP id 3f1490d57ef6-e0b5447a106mr13965212276.21.1722334353206;
        Tue, 30 Jul 2024 03:12:33 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a93f6dfsm2335234276.58.2024.07.30.03.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 03:12:32 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65f9708c50dso32935167b3.2;
        Tue, 30 Jul 2024 03:12:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwmGSGTOOt2GIiUgq4SM+42d8JP9bAkpu2IVcwvfEzClvg7Ccy74OL7Z6ysIbwb8czRkmKR8Xq6va4dF1GhrPoxWq6waM2wb4BLirmKTDxWRVRDsgJ4ue6FY4AuQKdKg4sUKOQkw==
X-Received: by 2002:a0d:cd05:0:b0:665:7184:fcd0 with SMTP id
 00721157ae682-67a07b751acmr117597127b3.23.1722334352127; Tue, 30 Jul 2024
 03:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724154739.582367-1-wsadowski@marvell.com>
 <20240724154739.582367-5-wsadowski@marvell.com> <CAMuHMdWnd8BOLVXpAy8CoFqKzYhp+vj6un=w7Umpo6OQ=Nxqng@mail.gmail.com>
 <CO6PR18MB4098B578E6DED1FF39C3ECF1B0B02@CO6PR18MB4098.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4098B578E6DED1FF39C3ECF1B0B02@CO6PR18MB4098.namprd18.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jul 2024 12:12:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbTm++Vcf8f-wAnHgXF4wgJydE3dAn2hO0oAiTtMkouQ@mail.gmail.com>
Message-ID: <CAMuHMdUbTm++Vcf8f-wAnHgXF4wgJydE3dAn2hO0oAiTtMkouQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v11 4/9] spi: cadence: Add Marvell SDMA operations
To: Witold Sadowski <wsadowski@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "pthombar@cadence.com" <pthombar@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Witold,

On Tue, Jul 30, 2024 at 12:06=E2=80=AFPM Witold Sadowski <wsadowski@marvell=
.com> wrote:
> > drivers/spi/spi-cadence-xspi.c:612:33: error: implicit declaration of
> > function 'readq'; did you mean 'readb'?
> > [-Werror=3Dimplicit-function-declaration]
> > drivers/spi/spi-cadence-xspi.c:638:25: error: implicit declaration of
> > function 'writeq'; did you mean 'writel'?
> > [-Werror=3Dimplicit-function-declaration]
> >
> >
> > readq() and writeq() are not available on 32-bit platforms, so this
> > driver has to
> > depend on 64BIT (for compile-testing).
> >
> > > +                       *buffer++ =3D b;
> > > +               } while (--full_ops);
> > > +       }
>
> How can I limit that driver for 64bit test only?

drivers/spi/Kconfig, config SPI_CADENCE_XSPI:

  -depends on OF && HAS_IOMEM
  +depends on OF && HAS_IOMEM && 64BIT

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

