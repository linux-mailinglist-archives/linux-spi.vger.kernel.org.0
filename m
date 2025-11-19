Return-Path: <linux-spi+bounces-11317-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6505C6EFB0
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 14:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83B7134BECF
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 13:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41E0352FB5;
	Wed, 19 Nov 2025 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CT6gLY/N"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C672F334361
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559314; cv=none; b=FDavuNqQlKItF8005GVRo0AkT1FSzvuy8YUUd7BJW+pvsimjsSMl4nT858h2oosAG2VZhi8JeFMkYNkVVH9tRHm1JQhCiUa0fSFWYMQ/XuYQHsGtePme/VgDUsPF6UG/rN6j8z41F3kYSUJSINqcG13tA4P2+wHQ9Kn/dpgfV+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559314; c=relaxed/simple;
	bh=mSEMF3yHwChy23f/YVNOf6J+YL1C2epK6zSKmHYZY5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBnN4AwaAaLB8jTGvmNQtTkVdTDFegX5xeimLv2hprkdIa6RZdCseFvHqVE93zc5lScV/xgc/ghCTD9gVqqt6sI+4YgOKKoBPNdjGwpcWJ4uNpfuPpt49GPGJzcf6fv0Oq9FybwZg93HwrGJh2lqlY8TKoEZmRPX6DNcXme9geM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CT6gLY/N; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5942bac322dso6359491e87.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763559311; x=1764164111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSEMF3yHwChy23f/YVNOf6J+YL1C2epK6zSKmHYZY5k=;
        b=CT6gLY/NHBpYm2ejq9UEfH01rNQdDSHNtjYCJn0rTj1jwMYQnhjd96waydPw1CQpam
         bENIolcbI3QZP0q/j78bwq+GlytGOE8O2V8b8MlEgiUczwsh4JG1U0OxehaAlcr6HbLV
         8METjSXikTz9mcGfy9CS5IpRg0ekB4HrTWPaLbpfoV0AiM3uLBZMoncGjaUwJ4VEwGPq
         ifgjP6XkYFhV3dNx0KH2zhEeMDbm6ZfPpSWEg8Pq49/XTzKYXFPB011hTN75yY4QT+62
         BB1V7H3CEFD88hXQmOls+agbUi8avv5BmS38drIwlcCXLbD64VFYgTlSiHSo4q6mKm2N
         rnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559311; x=1764164111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSEMF3yHwChy23f/YVNOf6J+YL1C2epK6zSKmHYZY5k=;
        b=WfFMTIxlPEm7enRXnNCc3pqjAHF9DktFaui/U1w1zeUZEVb/eA7phbFTfACrdBOXw+
         aXvHPSOBMJCLPr+o3XJugyEqZsBO9mZ43haH62ONHpxqZfg2V+o1aGJchNwDfzY7r9uA
         bD+r+qXvheC11HmFXYNq3o+J5FfsLFq4yxrtR6uo9mdKZLIbJL1y7A6RBU0hi9uwmImw
         9A2e7w2KXZc8/YWAU8E3i8WUxzcDWFU9wmbHoIyJpCnVg3omZnPmFq094l2tty2TRa1U
         x1RFWDQeB1nFV5iNB8b4WGwUSu0XZfwtaamP8Jfyl+GsyjmbZv6wQh4hX85gKn8Dt6Gw
         J7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVnfPwdi55Wk3vE4uQ4jl3tVGrvKalhCnAoOrpTM+KCzo4SsjnI45Q04fpGAQ4iVllD0blDpcZTtnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTQRzpUksje+hcmYknKI2YC5W2kDULHnOyVSZ7whup1PKoYB+v
	gqYmh0AeK0YsNpoEvZ/Wy4cVlE4IhJEZvyc+E8+1t6xoDLPrE8WW1USynFZTUfORzeLKm9Ji9Df
	adFYEAid7Mpkg/xMNf5bZCFn/JdL9mTtmvy1VrX3Tjw==
X-Gm-Gg: ASbGncuxfEpFKS1U2aJIHR/PVnvhzgH+76KdNMjtJzYFmDEaephIPBANJN5vTn+EDLB
	XUojc4u8ih+dBT6pZnpqTlBLYMa0QiEk5KjGB2GbFD1kIBWRC/iXnPOW60D1f8RYn4OUiOLDuJ3
	3rYlP1rdxUR83ZAYm3s4QuDRU550IrsxiXAFpDblpuPPAKtVAZrmzsg9XueuJzYSxXQZzZNMC89
	Wh9GTkQpvE23Q8EkxeECjp9cL6ZXcZEuWl6Q7yh+kAfiRdBfVVjkhuM+llJUFUEEXOQwpY/L8kJ
	NBEgsGbCZgh4kE7qXsz/0oCqHJA=
X-Google-Smtp-Source: AGHT+IF6t32NaD5Tx3rJ26IXH92DE1MRlTrcX44KbvNvlhg+o3j8JG1AOWcpLrkwNwv0BaGg9UrhqKgO6l7XE891Nkw=
X-Received: by 2002:a05:6512:3d05:b0:594:2654:5e3a with SMTP id
 2adb3069b0e04-595841b297amr5946984e87.18.1763559310956; Wed, 19 Nov 2025
 05:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aR2Uo++k1NKkk2sj@opensource.cirrus.com> <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
 <aR2gVzKhfN38MHAR@opensource.cirrus.com> <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
 <aR2i6lNNWEbQk0fx@smile.fi.intel.com> <CAMRc=MdYcdrQSDWKDHrx4-Y4-y92AQqr73MoRC3ws-X==SL0MA@mail.gmail.com>
 <aR2o2R30TbVOcqZe@opensource.cirrus.com> <CAMRc=MciO0WYejOYZduqE73U4OVTxcaMfe6Sv1VXWJWL2FFNmw@mail.gmail.com>
 <aR29uKW7yLxws9jA@opensource.cirrus.com> <CAMRc=MdXNXQhE9zi=i0x0yGCi0fKQNU8_tn2_Uy24TAhxG7BRA@mail.gmail.com>
 <aR3FnUNO4DyCdiLD@opensource.cirrus.com>
In-Reply-To: <aR3FnUNO4DyCdiLD@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 14:34:58 +0100
X-Gm-Features: AWmQ_bkfaZeLh4OilUDUASBwlQ_ofuCsFZwdswfFVK-TLjxbjtf7DwJUHvGCcwk
Message-ID: <CAMRc=MfuQSGPbt3x366j5c9Sg-mgu=TfmD6X25Dk5Rmu0JiiEw@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Maciej Strozek <mstrozek@opensource.cirrus.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 2:27=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Wed, Nov 19, 2025 at 02:07:55PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 19, 2025 at 1:53=E2=80=AFPM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > On Wed, Nov 19, 2025 at 03:58:08AM -0800, Bartosz Golaszewski wrote:
> > > > On Wed, 19 Nov 2025 12:24:09 +0100, Charles Keepax
> > > > <ckeepax@opensource.cirrus.com> said:
> > > > > On Wed, Nov 19, 2025 at 12:06:57PM +0100, Bartosz Golaszewski wro=
te:
> > > > >> On Wed, Nov 19, 2025 at 11:58=E2=80=AFAM Andy Shevchenko
> > > Can we tackle this the other way around? Since there is only a
> > > single fwnode for the device, can we find a way to get away with
> > > a single software node for the device too?
> >
> > I still don't understand what the software node that's already
> > assigned to the SPI device is though? device_add_software_node()
> > should work just fine if the only other firmware node the device has
> > is the ACPI device node.
>
> Its the software node we assigned to the first MFD cell, that one
> succeeds but attaches itself to the ACPI node as a secondary.
> When we get to the second cell we try to attach a new node but we
> get the one from the first cell since they share an ACPI node.
>

Ah, I see now. That's indeed a fundamental problem that can't be
easily solved. Andy is right about the needed change but phew that'll
be a big one...

> I think as Andy pointed out though the first 4 patches in your
> chain do loosely want we want. Previously, we used the name to
> point to the actual pinctrl driver, your patches should let us
> do that properly through the fwnode. So we can drop the pinctrl
> swnode and just have the cs-gpios bit point at the actual fwnode
> instead. I am trying to hack together a strawman but its failing
> in a lightly odd way. Hopefully I can get that sorted fairly
> soon and post, or I guess I could post a version earlier if you
> wanted a look in the knowledge it still doesn't work?
>

Yeah, I'd like that. I want to get it upstream and have interest in
getting it fixed ASAP.

For the record: I believe the logic behind this patch is the correct
approach. It uses the existing MFD infrastructure that's there for
exactly this reason. However without being able to have an arbitrary
number of firmware nodes attached to a device, that'll be impossible.

Just an idea: we could try to do the conversion gradually - by first
adding that list of fwnodes to struct device in parallel to the
current approach of having the secondary pointer and then go from
there step by step.

Bart

