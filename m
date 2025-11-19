Return-Path: <linux-spi+bounces-11306-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1426BC6E2F9
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 12:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB5E23A132D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07D352F96;
	Wed, 19 Nov 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zp8rnUQG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920352F5335
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550434; cv=none; b=uLHhhV0Ogp+Zk/BvCpVlYrzR0sbNk/xKA2jTgK+VWRcdZfkElYOdxzJL2Sww1v9SC3pIz36hBotTs/FvHi9LZF2dDbYeOwPdR615DA37WpLx5TBwxTisMTkpMrtBugqJJgjZ5wmHEcOrU4pxqSRp2kZYzN8yuItME+NZ0ecSS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550434; c=relaxed/simple;
	bh=P/HSfm7kSgkKKxmOcuhjzFjQ52PiIf79mZIuv7+jXOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4u+aCJ+WYrMqPjZRz2FfQIrdOtAGPvHuTAJEeM5cwUt82tR0joTozJUyq3OUecskOb1yXhd1BBA12etmXgaRsL1kv83tG67V61Zn8AWp0e/HESmNjlPXqKnjL1OzGd96l4K1AYUOvqIes3cmvyNskVCawp4H8Ryx7zuCLzE/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zp8rnUQG; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5943d20f352so7190655e87.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 03:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763550430; x=1764155230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAglYGE6ifGTtBz2S8pM9xkA97ILF6UPjp+08j6rklY=;
        b=zp8rnUQG6to/meegXrlYQM6x10vff5e4R4bEzfjbJyWKOcpyBynUOkY8UjyNNuAZPI
         9sHgJ2pmiKavGZePDrUmVhi7o0bE4kgEq79fn6lTdudbEeisPb+OgVd24bA+3Wb8ddBP
         KYS8GFDpqTbxSODBHi/+RfbmdgOR2O5/QbKDMxCs+rTE3hmsOFKiMLLQ2I3E/3w24JuL
         OTu3aFdrkL2gxR5WYUhY2vcq4UzqsDk7J2LYivSop/uCOrgpKl4sBG4U8tXGIASRpTgV
         1LTCiXRdA8zki9vqTr24fMY+iAbhrGczaZrhEwEVULQW9PzZQbemLUN96S2IDnKvbIqw
         KsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763550430; x=1764155230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BAglYGE6ifGTtBz2S8pM9xkA97ILF6UPjp+08j6rklY=;
        b=LrufKzudUYKCdq3XvLxY2s8SgRIuFg2k9qoiyG2BtrkCdRpxe9BPEiJJHIkfAHD1by
         zes383CcEuDPeZMJFZC7Y3w9RaRqjCfv4LGjb8inygB1iiqIDuAJwBfFSIuc1zmsDtUn
         IzXOB4+yTL8C8RogyGYAj38K9TO7UQNGDPhkSDFPxlavmIHb9EhP2dzaEDJ1oY7eu5i2
         TU50d37+k/qG4U3b5elQ/TMNWuMmGc9nSjNoFPJ3Bftf5TP9YvGkv2ecYUxCU9vr7kQ6
         a1EkbxgTDdI1xS4JtEIXv+8qtxRfF2DdIy+lPkhMJlJTBLmaOTAdUXdKXvZVusi/FZqO
         LR4A==
X-Forwarded-Encrypted: i=1; AJvYcCUoKUkp1/uMfIbJ4pYUoNX3feobocPzrKCS5gOMGlViWjr3Xw2zUkdLredFK3x7iOyc74MCEDbnhxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnuPQr6iYStOYPK75++TdRjPS2GqY/xpV0LFsQCnXGe+2FYcAR
	Zfh10sgEtJJlSW6yi90JU74jN6bJwj/jhREXHjGMH1pJ8Km5aK25JW5iqea9s7UOx27aWiateCq
	JMs9Jk8pUNzLiEdB5FUhZwKdmGYUagokySBhX/8l0tw==
X-Gm-Gg: ASbGncsYE62gj+2sXio5nW0+Xb+5bGNdT1Wt4KZJGwgCkk3f9cX2lQ2Ez2CBwy+w5O+
	VQojPaVABDu6xIgKhGGWhylmsy15gn1EmB6pckN1pSf67OI+FAekIArTpXpDSOR/40o69UP5Mn5
	9UkbOcu9IM7Uzb203Dt2pUA8frycdJHi526+qsgzBtLFRHk46CqcbXZ7d26r948p7/YnUj0T2B1
	yBR5/LSUkHTtpKHUL5BU/Ed20CE/+C6QN2i/HxYU0PjAeht93pPtcKGvfSvR+N/yq/sk5QVdtOV
	i8fdTWTtf02/Vv3WbdD1KqWSiq0=
X-Google-Smtp-Source: AGHT+IHz1jfLeXX4cVuvQLHrboCDkU9Z/3wJ/aOh15NqEvgqPBK1kJhzlTN5go1fMOmrHzOvoCvAd8jNUnqKzCWd6rQ=
X-Received: by 2002:a05:6512:61cb:10b0:595:91dc:7289 with SMTP id
 2adb3069b0e04-59591dc7516mr3074895e87.9.1763550429550; Wed, 19 Nov 2025
 03:07:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
 <aR2OU4se7lxcMtGW@opensource.cirrus.com> <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com> <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
 <aR2gVzKhfN38MHAR@opensource.cirrus.com> <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
 <aR2i6lNNWEbQk0fx@smile.fi.intel.com>
In-Reply-To: <aR2i6lNNWEbQk0fx@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 12:06:57 +0100
X-Gm-Features: AWmQ_bkondsqV9UsntdoN89OxecZ_AJb26WupJUBcE1O5C5776e2GNUo79GFsOA
Message-ID: <CAMRc=MdYcdrQSDWKDHrx4-Y4-y92AQqr73MoRC3ws-X==SL0MA@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 11:58=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 19, 2025 at 11:50:09AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 19, 2025 at 11:47=E2=80=AFAM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > On Wed, Nov 19, 2025 at 11:38:35AM +0100, Bartosz Golaszewski wrote:
>
> ...
>
> > > Cool, thanks for all your help here. Might take me a couple hours
> > > but I will get to the bottom of the EBUSY thing, and report back.
> >
> > Sure. Could you just post the stack trace down to where the EBUSY is
> > returned in drivers/base/swnode.c? I'd like to analyze the logic
> > myself too if that's not too much work for you.
>
>
> FWIW, there is also an interesting debug technique. Put in your driver wh=
ere
> you get this error code something like this (after all #include directive=
s):
>
> #undef EBUSY
> #define EBUSY __LINE__
>
> And then you get some error code which is line number in some C file. You=
 can
> narrow down grepping of the EBUSY in the suspected files and get the one.
>
>         git grep -n -w EBUSY -- ...files of interest...
>
> Hope this saves some minutes for you.
>

Charles confirmed he gets it from device_add_software_node(). I want
to know how we're getting there and how we could end up already having
a software node.

Bartosz

