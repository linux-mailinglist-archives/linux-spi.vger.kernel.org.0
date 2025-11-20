Return-Path: <linux-spi+bounces-11395-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 417ECC73FA6
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 905482A7DE
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C79331A40;
	Thu, 20 Nov 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AgT6lVtj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79F30E843
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763642010; cv=none; b=VThxPhoYKBy5atYmVvEtHF3Sqm40cLZI1ZkJixpd+GGBM6T1XjvMhFIOF+RpoAxvye+EP/OeIgrQ4e1O/6vmnO1cTcsR0SiR9PAU7D2uFyJTAoSpkSdCbbd6XWKEgv+8T1AJDD5HeNekDlW54uyVmg0RBpHa86DJNxQleeDOVl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763642010; c=relaxed/simple;
	bh=9g2zA8FzAMTNkIHXZSnYTPmf3AmIIIUujAJL+eqWIEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMUKZ1DQBIRR6Pm5hNjEcyfxmcnLQv4ernfkwT9wGJrlby/evWwPFIB64OiK+dw30M+ZpxG8KFz1RADxsmTdTs/aqsE1CEkfsZDu5yB9wxPt8ZOktTeuhm7Gm/7SgL7FNKEIGus2aHnQZiB0iW/4lpTzRXt7NooCVuK4p4iNTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AgT6lVtj; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37b996f6b28so6635051fa.3
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763642007; x=1764246807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9g2zA8FzAMTNkIHXZSnYTPmf3AmIIIUujAJL+eqWIEo=;
        b=AgT6lVtjZ//BVrYw6rMS1dDhGh07h00pC8tlxtWBiU2FzhptiaXPB5lAQqF5st6JrP
         oCFFE9Upsk5Ofw1I+rQxPtR0g2kEJzK15jkC7TDflllZ0FMzsAprHuvxQuWP4GcVMk7C
         p1R2OLKIxYJnld7EVTILlXXu58MAeeH2/QkfpLrCXF27N8QDL/0cKmU0Y3YxWY6yYqxT
         PoJQ/pT3gDPcpiPev46E0p5uUXghHO8GFskaUFoPZeUXPA7xuhDIRV/49lYVjnlEKrMe
         BAkSBDwElfU2nvtUt1wRVgQ1k76ms90rjrzfffq7V/TjIiWgJ5X0uSY7VHY41+/I9OO5
         EiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763642007; x=1764246807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9g2zA8FzAMTNkIHXZSnYTPmf3AmIIIUujAJL+eqWIEo=;
        b=J4SX1QXg50SjYHHGz96apvA9eVRx33dQkXPvHE+SOyFzP7ec6CNR4RuKucV2Ffv1H4
         ePekmBpcJhQd2aN1T2Cc2et3Vq4NoDGk2r9/oCkt8u/eAu+LBYpNgm7ntxIBFE1oFpWq
         gS2FGU+ngLFPtk60MHtGAro+xJor5mFn8+mteklKmSibua1lYA0E0fv7Xa1HzOBaLTAi
         dFPkkycSnd/GrwwFMyIK9E5V1QTNgm6/LZiyoX3J9P22w+Nn6IzXX/ts0/7Xk5xjQ1hu
         TXJ97IR5dAXEmNLCJxe/EaFRoOVFS3w+1lLLz8uPYwjkiv/oiCUdv6b6H3kmVykP+8Un
         WVoA==
X-Forwarded-Encrypted: i=1; AJvYcCWYYE47Vbn1AJM3AMrVUV490ioIMPklTZdq8j4FwfpndMbo3WC1KKMhAcaXQ8i7QOtDFNNTU/mH2Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTWjm3SMxvIFbNe3c6uwn+v1tDLARtM9w2+plYLJfiJUK03Oo0
	7Gz2Zy+03D6A2ZtOSVRIhMTeGjqu6lErkdPAD0l4HepFJ1JCjE1QmZb3nuSjn8cY4GV1sf8WN9J
	qGU2+7CEtg/dzi09Zny4sd8y6R9i1d3AVAYoMl+xwUQ==
X-Gm-Gg: ASbGncs46YMr2iQLz2+jIfLh7E6n03TKcbXI9vhgplzuHHBaruygdXZNtrypI30I38I
	7mfp2UbAKD3Dxn508vcVzTxzzvNVJ4JRU8tGXyUgeFpXnD6jul7fLSFkz2n/Et6c+uM6H3h0zF9
	y2ztMahHsQub8D4ewTKITr3LVjDnxO+BKDLWMHsKtSGMrEkvbiFM6potQ90JlBxlnG1lgneod3C
	4r0CYb3gC/+9HKZokJmk1Tp102GAr0UKfDYnTicJ6vRLH7M1V8TKTpXqpEOTaVwb8bnIGRQdvu1
	7dqIsqEsdPHvO3WJWIhw73bZqA==
X-Google-Smtp-Source: AGHT+IFs28MMNUgFYI3iSwLRyTE8I2EDvLITWgQ618U/qcnkqtpjTvDZRHT2IGmIN2LmnvUGv1JDHAZs/hwBATssw7g=
X-Received: by 2002:a2e:9790:0:b0:37b:aa93:613d with SMTP id
 38308e7fff4ca-37cc6752540mr7357131fa.12.1763642006713; Thu, 20 Nov 2025
 04:33:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aR29uKW7yLxws9jA@opensource.cirrus.com> <CAMRc=MdXNXQhE9zi=i0x0yGCi0fKQNU8_tn2_Uy24TAhxG7BRA@mail.gmail.com>
 <aR3FnUNO4DyCdiLD@opensource.cirrus.com> <CAMRc=MfuQSGPbt3x366j5c9Sg-mgu=TfmD6X25Dk5Rmu0JiiEw@mail.gmail.com>
 <CAHp75VdLfkcrmaGBPu_YLDReyX5Gvu9pE6BXweArA5PmM3MQnQ@mail.gmail.com>
 <CAMRc=Mf9djJ77ob8L1OKa6HHBx_JxR_sajWH1mFGz=V+hMDbmw@mail.gmail.com>
 <CAHp75Vf_+WzMn+pmwK4zhLEZtG3Uat4FrdFMCMtPmmX82E3Wzg@mail.gmail.com>
 <CAMRc=MdbgeJOMoHDm_z04ko1pdKed06GP4=M+VsPaD3YOEvs6Q@mail.gmail.com>
 <aR4qxiR7pzrPdaUz@smile.fi.intel.com> <CAMRc=Me-DXN9kx+5bqDb9doMG9MX2EiRJiC=_QqDc0q3gOz8wA@mail.gmail.com>
 <aR7luqqew3LRwFgn@smile.fi.intel.com>
In-Reply-To: <aR7luqqew3LRwFgn@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 13:33:14 +0100
X-Gm-Features: AWmQ_blDoZPlIeJRmMuhollO_8xLtYrhOZeIHhTLu8BJ_wc62Lveu80O0CFrd44
Message-ID: <CAMRc=Mft8R9RjZhy39G60b2VRi7F2so-iUaARTj+MCgNx+qAqQ@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 10:56=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> > Look at all the find_device_by_fwnode() functions we have everywhere.
>
> What do you mean, please?
>
> $ git grep -n -w find_device_by_fwnode | wc -l
> 0
>

I made up a placeholder name for all different variants of functions
finding devices of different types by fwnode.

> Even if you refer to *_find_device_by_fwnode(), still it's not everywhere=
,
> just in a dozen of modules.
>
> > The crux of the problem Charles identified is the fact that the
> > secondary fwnode is a field of struct fwnode_handle and not of a
> > struct device. This really doesn't make sense as we see where multiple
> > devices use a single "real" fwnode but want to have different
> > secondary software nodes.
> >
> > Moving the secondary fwnode to struct device would already help a lot
> > but if we're doing that then we may as well switch to a list of
> > fwnodes.
>
> They all should be an independent entity that can be part of the struct d=
evice
> but it's not obligatory relation ship.
>
> Again, device may have a backing fwnode, while fwnode might not have a st=
ruct
> device consumer.
>

I never said it must have one. Just that it's common and we do use this fac=
t.

Bart

