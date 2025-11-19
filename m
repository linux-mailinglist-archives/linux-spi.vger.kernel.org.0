Return-Path: <linux-spi+bounces-11322-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B0BC6F6A3
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 15:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9656B4FBBA2
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97B0278E53;
	Wed, 19 Nov 2025 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="V2pcwFqt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0935B120
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562661; cv=none; b=U8jFVeC6plY5Zu33YjcacCH7rS9SlQsk4BDOnXx3xp8VmxVY1QgGd36WX8gXLvde3yqfSLcDry6apI1asgiYAzpfc8eE62CcqZDHMfOzqacaH3p9NZPnJ4GUpgF9z7v0AeBtidpSAFMxtQ1SceCcFyD4sHIQoERaXqZwQLCuRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562661; c=relaxed/simple;
	bh=RqlmkZVtMnSS4VV7rGoVQjvBgMw5M7aZVmjjfVekxr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCpDJm+l0FNePZTQc9WTgEYUQ5lTNuxYrKEIK0p8ROH+3XXaHvVsFSRDzuRISlKvJuXfDMNxy6ZSQoEJCOz2R6i1rs12MD8SuNR8rLqnCAyNEvXNNZhE29FrOlUsR9/nv39lpMlRdrUgCCg5RcOjfL0nzLKJloiVL2cv4tsre0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=V2pcwFqt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-591c9934e0cso9244953e87.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 06:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763562658; x=1764167458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqlmkZVtMnSS4VV7rGoVQjvBgMw5M7aZVmjjfVekxr0=;
        b=V2pcwFqtIsfMLGlwMAhBh3C/Lhwg7xsRcPfQ6Y6yxBqLxEkftuocm3j8CylTmclDTe
         u9CwUwibPrCE9RI8F1rdZ/WE30oRIMmdu2awmIFJpSMN9/wNR8vJ0x6WB3RriMt4qZuN
         XGsZLRuuVK6Bm+4mYN5Ey8e3/gHPEXc8wK4QWlvRz4QWVAumNdl60I79xwoy3eZFaMSS
         P+qbiI4T5QQeSLAKrgMdA8E193xZzP+X1B8rz8MQVQV/OGxjtizk7++rsd+B5Wzi5siV
         +9Lux9Sl9Y58OhqOFipqs+mwGO6A1j3EUhY6qqzKhhXEOVe2RaE6xpjWSksRrRxuqml0
         l1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562658; x=1764167458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RqlmkZVtMnSS4VV7rGoVQjvBgMw5M7aZVmjjfVekxr0=;
        b=Ahz4L6LMKJyQjGiXZdKh7kchVbct0p2y4otX5InIH2zEaNDMFNxnI+D1GuIG+1EnZf
         J8J8qD3vmulic1bntZ7itQbn/sng25zGPFwcmYcFbhTzc7H2LWfA/q95fv63ff43d7Hh
         VLpMg4O1mKOtorluxu2nHdR1o2dXi7QU9fyEaj//OP/WWe2cl/4tROoi82x36ZvRq6dZ
         gFQFALo7Jm9r+00dY2qOe2CvfXmoJ4q/+0LkFMbZeyP32Q8tqx0gJczysAeJnfFcTdig
         lo9wORHGaW/FXS6D2XGhV3M2vSM9oFDBuS6xhZ1OxnS/16z8GliN1zPsnhh1nTRiFrJ2
         o0UA==
X-Forwarded-Encrypted: i=1; AJvYcCUedRv9hxzQymfjhCbk0vvMq5cR9k5MZX4SNQUCD/y2Kw5d9FI0kOckNaHJDXLERSHPq4i6fHYmY4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5K7iAxpuXLVDQQGQ2WcpazPrwIMYaOibavqhY9cYbuT9djJl6
	z8SlYolZNFlmE72OZegXiLJ5EyE706Ui2XZT62yaqc8Xp8yPrSu9Pac2fOYpPC16il1Bwx9wT08
	tHaQ8gihHK/uToHGWIyv3dK7bVm45FVn4CrvlLWgygg==
X-Gm-Gg: ASbGncu4DPWbfnmnI6rV2BcIfznKZvIPIj6liw6uk/Un+zGPl8PYMEVb+bPtuJ1Sctw
	kwah7EAN7tpgGg83gX53DOCx5b89ueKkw2kf5HB7uYNhR6+xldb4Qvq1NEobWQjWlA5oZY6j9JM
	7eMQ6levILqunSVLK+pAa3QZSs1GOCsT4OT7RDdbMuwPDVkp36vzvw6Ge1uoPjESjzyhQ90xSOt
	/NEEJFRm0NlfjVDeJqFiU7lKsPISuYOcLvRxr3LfJVB3/CoF0iVF9QnoK+G9/bJtGtgW66kOE/u
	5aSVnRprG1sFvHsvykuRDD3NEC0=
X-Google-Smtp-Source: AGHT+IFeBKy0OQVDr+grX60hNSEzHPwf/BYlgPYJ4ITPtLhxniNFdhTROp22k2lpyOYdwX15vFMUXm86PqBcuDRFKL0=
X-Received: by 2002:a05:6512:1395:b0:595:81e5:755f with SMTP id
 2adb3069b0e04-595841f0cbbmr7676774e87.32.1763562657952; Wed, 19 Nov 2025
 06:30:57 -0800 (PST)
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
 <aR3FnUNO4DyCdiLD@opensource.cirrus.com> <CAMRc=MfuQSGPbt3x366j5c9Sg-mgu=TfmD6X25Dk5Rmu0JiiEw@mail.gmail.com>
 <CAHp75VdLfkcrmaGBPu_YLDReyX5Gvu9pE6BXweArA5PmM3MQnQ@mail.gmail.com>
 <CAMRc=Mf9djJ77ob8L1OKa6HHBx_JxR_sajWH1mFGz=V+hMDbmw@mail.gmail.com> <CAHp75Vf_+WzMn+pmwK4zhLEZtG3Uat4FrdFMCMtPmmX82E3Wzg@mail.gmail.com>
In-Reply-To: <CAHp75Vf_+WzMn+pmwK4zhLEZtG3Uat4FrdFMCMtPmmX82E3Wzg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 15:30:46 +0100
X-Gm-Features: AWmQ_blfe5QTw6X0qXGpvuRpiXdjVHSvkJNqPQjlIHeiBlpeHFSl15c6OrJD3eg
Message-ID: <CAMRc=MdbgeJOMoHDm_z04ko1pdKed06GP4=M+VsPaD3YOEvs6Q@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 3:24=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> > >
> > > My idea was to mark the fwnode with __private and fix the (ab)users,
> > > should not be so many. Can somebody mock up a coccinelle script to
> > > find all dereferences of fwnode from struct device?
> >
> > I think you're underestimating the level of complexity. What about the
> > concept of dev_fwnode()? It literally makes no sense if we switch to a
> > list of fwnodes.
>
> Why not? It will return the pointer to the primary node. You can look
> for example how the list of the DMA descriptors is done in
> drivers/dma/dw/core.c. Not the best solution, but gives you an idea of
> how it may look.

What even is a primary node though? You can have auxiliary devices
without an ACPI or OF node. Only with software nodes. Which one is the
primary? The first one we add?

>
> > For it to make sense we'd have to have a kind of "dynamic" firmware
> > node attached to a device which we'd fill with an aggregation of all
> > properties from firmware nodes in the list.
>
> "Dynamic" is just a node in the list. The only potential problem here
> is prioritisation. Should we add to the head, tail or insert? But
> converting current approach will be straightforward.
>

What I have in my mind is not another firmware node in the list in
struct device but rather a new firmware node implementation, that
would be assigned to the device via a dedicated pointer and would be
filled with a logical OR of properties from other firmware nodes added
to the list. Then dev_fwnode() would return this rather than any one
of the firmware nodes from the list. Think of it as the "master
fwnode" of a struct device.

Bart

