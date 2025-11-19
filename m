Return-Path: <linux-spi+bounces-11298-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9134C6E0B8
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9D234E24EC
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22D34B1A0;
	Wed, 19 Nov 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fvIFzPn8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF53451DC
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548730; cv=none; b=Ft3C5iUTvCNF2D5IAKziYr+h9QlZQZqgsUSSHQI16Sv4mhaRTtTFNNr8qFXzIDgFajhF3y7t+FSWQximBQNBrxW8WvoEWqmm/WauHr8b1Nd9sHetprYX1KPxkke+kRzNVyRHOLj67pYWwQizhdJAMeprF2zJpPasbF7TgskvyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548730; c=relaxed/simple;
	bh=L7VgHgGI9r2tjhuEbwy2r1ej8K2QE/4okZ+9y9/KnFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awmS3aOIpDvcZ0njHDnRyXxE3o0ixgUZN7WaPAKZ+WKRB87KUQ/t89m5GS8d5m+T12KDx5/hxUJzcURnbCEK+pXw/HaFvPv2ZCurgHuYWQj1qq2oAsnbrQrWwrtvUAdY19EHpmL8J+GwAoW3AfowJ/sE118i+dNN8nCqMCKtr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fvIFzPn8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-595825c8eb3so6550985e87.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 02:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763548727; x=1764153527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7VgHgGI9r2tjhuEbwy2r1ej8K2QE/4okZ+9y9/KnFM=;
        b=fvIFzPn8W4Ba1/PHiV7ZwGj8KE1DCXlzeG0bGNPfGR5PfnzTO6aMWLX7BG2yaTjhA6
         /GHWLUdzRhxJUoFn+Uu91elx0w7v60oybNdpMumr8xGlUnra8HksFUWBjy0UaotvZTI7
         y2aJuiE5nLICSA5tVSkgMEcj1rIX98iIJj05RdDVl0nuVRRdN6qEPZ5d8a6alwW1PQOD
         OXVgbq9joRHxpqblnQk/BTNGGe5QZTuk6Bal04OV1CxXgG75fY+JVoehDNo5Vh/fUWdq
         HMiml41bZsef+XDrCwj9WhkPPcuHdYgJSuusPRh//SegD9FgVzzJR0J8f2rbc7wdjNuC
         XfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763548727; x=1764153527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L7VgHgGI9r2tjhuEbwy2r1ej8K2QE/4okZ+9y9/KnFM=;
        b=TWa0NY3DN0Jf3oqIFHQy2aSDaU5JJ+m1g3SHSLxOoRUyAxzycGmYKJ3CxtMEXZ6ubs
         4o7H4H95wChrOdsT4MaA5/EqYX/ulEY+8+N98atmHRNDQ8mV04JpYXe7c3YwhhKeT3/r
         amBnc3GIwnSFlZ10uZ3kl12HamtwFV+yCz53LoiHp/WIckdaOkiEIw2PjZp4P03/P7Dm
         51cY+nJy0Th4josm0DvFuYQPFgcWLPDhDtvmHPMvbSBGUr6dKuNm5V7J1ik69XQMhlnB
         1qUzYpAeExYfeAmUqPXK3Fi/db0lN0SMtxSTonFpM85HxtaskxJ9SQfOZyz1bMH22nAl
         wUeg==
X-Forwarded-Encrypted: i=1; AJvYcCV3NVFdxRN8vb8e6AIMn+pWvb5Wgaw63+v4j98GjW9S8sUd0PNiPVB9lCQMd9mEHaBoWGZOpLoFjTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/rqT5IQFveQisNjnHYgoDpfium/LxKanDuBHA39ShGDePFHR
	F1jja2NOE4ScwDhd3KhH28q/Ajd67PiYJWl0YFj9EyJDlNjG8kxsor+0+PNzuwAzJmNHqXJyaVM
	YHl/2s/azl55KB6Cqhtd3GrfWA8wSE+uaglpUxkaHug==
X-Gm-Gg: ASbGncuCuMj7i9xANjB4HUtZI+uoq4pBwVY6p4fYW/saHS8pqXLUZF5sD1R1ApXrzdU
	dBjJwejvK10/0A7tyJ1HbU9+TJ+w9fbKcFXWCEQjkiKXKUapZlrDzbF9mlkhCPY13SU3bn6JkcU
	rECjagsj8q4i4Ln+QmbQnD5MTKZMmQcteGcFmq0Bracb0eO6kk/Fp9Xb7xysKzQWDj6kR4s+pH9
	wkm12+FOBxwAWB0C0pU4cpPMIR0icuJedIORrukWaKqena2jf+/RhDxtMAuqrPZLLFnm+S4RE4w
	4IN82D0b+oNZWc4Bzp8Nx7REv77VFe00lpi72Q==
X-Google-Smtp-Source: AGHT+IE74jzemY2YhU+PbF7yBA85kAHsHX4mJ4KqZ+2S4FXjqC72Dq3JqM65bbpoVibuwYHQgBzH97q1Jp9PeLxzN0k=
X-Received: by 2002:a05:6512:4017:b0:595:8350:5812 with SMTP id
 2adb3069b0e04-595842523e0mr5924629e87.36.1763548727365; Wed, 19 Nov 2025
 02:38:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
 <aR2OU4se7lxcMtGW@opensource.cirrus.com> <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com>
In-Reply-To: <aR2Uo++k1NKkk2sj@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 11:38:35 +0100
X-Gm-Features: AWmQ_bl4kMdbPY0ybo97ugZVPgitgvbcQ_ZwJ9p6cLlBP2waz2ombgcLzQOoeDo
Message-ID: <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:58=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> > > > Hi Charles!
> > > >
> > > > Please give this a try. It's only build-tested so far. I hope I
> > > > understood correctly that it's the SPI driver that needs the "cs" G=
PIO
> > > > from the pinctrl.
> > >
> > > Unfortunately it fails with an -EBUSY on adding the MFD children.
> > > I will investigate a little more and report back.
> >
> > Does it fail in device_add_software_node() in MFD core? Is it possible
> > that the device already has a software node for some reason?
>
> Yeah it seems there is already a software node, although somewhat
> at a loss as to why, the only ones we add are inside the SPI
> driver. I will poke further and see if I can find out how it
> acquires that node.
>

Let me know if you figure it out, I'll submit a v2 that doesn't drop
the undefined swnode.

Bart

