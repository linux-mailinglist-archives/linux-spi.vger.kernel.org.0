Return-Path: <linux-spi+bounces-11320-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F82C6F2FA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 15:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 35D852EDCA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 14:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5980A257848;
	Wed, 19 Nov 2025 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ItsdaGU5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1723D7CA
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561730; cv=none; b=gMDJ1KNVVpBRvn0T7dTfVLAV8igWcHNl953fq59srmdP/dRNmm88i6pEgr/SSuAPd5XMtC85et2EWSYMc0N+bJd/rNRovC60XsopdspSA3a0hnKVlTag+6r/O8rcGZhpMCaasOIg+sAl5IfzQGa+0QLSUPb1xAXevotdsCENUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561730; c=relaxed/simple;
	bh=mmErmvM7ga/VQbYlG7qRcjcWHTgxDOhJOX12iSowb9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmB0I0/0orGLFufSUEfN7oqP8JbKLNqYA/1Y8LvxnMiaoPwQBfN3AfRCfwMtrkGVZb/Pccxld6hwOQsY5s0nGZ15VI1KX7bAL7u9LB/p885kyEYnP063G0OP/ryr0PvCGy4mw5k2eCOqWe0sMS6shxWyyhgN+CUU+4RxVzxh/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ItsdaGU5; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59584301f0cso7003940e87.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 06:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763561727; x=1764166527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmErmvM7ga/VQbYlG7qRcjcWHTgxDOhJOX12iSowb9o=;
        b=ItsdaGU5R2digSvEp7Wzke1JXYRLl5h2dphsL1aLISVf+/l7J3cTzKlNLS+HeCLJ27
         ojOMInddNKOtuS1MZnY6YvgBegakPUSbfZ3X1CM71EJq3PJGtXs8/yNNPB8mKWFaqXfm
         Yg198qgcXyzC75LNVQjcbR+sEzIjZyjynWf6OIcpIGNE4qJ5weXBlGCqd3c05JyRj4UU
         XYybK/zC7JUmkOTav4oWqPFbG6s36NOF8uRhvIjWrk4l1cHmnmpjDS8O2s7eIX2ETAuM
         Di+TmWIr7TUc19ce4/qR5Mz99PCuF851kov//h+k5MjNRSRkZrnwW9DNc529rnotOukI
         t7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561727; x=1764166527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mmErmvM7ga/VQbYlG7qRcjcWHTgxDOhJOX12iSowb9o=;
        b=ckfvidcHJJ3rLZ5ZKS0WF7Xbu/hmyMnOJVd+Dm3FBfejBIBk3ME2iv+fLJw2lZNzbU
         2N7ybd6npQBos61ej2UvyUpVflpSPa7HTc9rt7J2rYPwarmdQlKCusCGp+hDR5Gi2NJp
         33Wzg5tPOizu3UXVWwXl/GEzRysTeKE9xesUoCz7y+2T+oksXE7DV17Uii1Nko26g56u
         SBuTTAuG+qPJImkwdK52lXQV9uAxDJ2YiZ67WhfLA3QU9wRLcE0GFQs9xg4pLFLaIneW
         6PLqk+qwxkFpq4AoQVcVKo7PvetYoRNqtOC8tA7JdcdICL8qbvkMk0ib0HP5Chvi8rmT
         C8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCW1LZxBK8KIE767NIUwd4e7q6W/5+wVd2Qqz6Ux/voxcTv3iArPUG6Cv2Tz3gm4L+NOClLniRWqfsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbD14USdFYDuQLUZw5IyjSy3BHuweQehtMzz3RAwLqBRoiE+P
	L9dWHyHoFZH5aq4KUHzsDhjkV3ZEXKkpRkUot5S32slYvWo6WwyOq7y6GOT0q8wagEp2jMMU2kJ
	Rss5Ye3XMpMuMy3yU2EkT+Mcw5P2Q2Cf5+OEw6CmtKw==
X-Gm-Gg: ASbGncvQY1pQaHtPwyehpVB8i5rPhtR5vcVj0kpdaMrn+DHUJ/Z7TOg5K3XoRA0xWLJ
	yghWWNVZCmLNTnvxm/FX+YeQj17PxbdEjhRFm7r5E6oBwT0JmPpJCKgIkb1U5mcItf1Zs/1X/qr
	AO/exfyR7qEQ/PMlGd6oWjxsOVu3NeUxnme8GYbCCh+CaVX8GXqIQKaCbp6BBWl8qOka3GK762c
	eNLstXb6uSdzFEPxdfVgTkaCj97NV7nfHM/s//lTt8ZQ/vz325eztiV0sd9RCT8DH5GDjHS73r8
	sji0fg6jmOrNSliLEgsu8aSfI8bFnBEJl4oXHQ==
X-Google-Smtp-Source: AGHT+IGlwKNIFJf0B06xiqsBim3zZHxtg0Dk3LS/5Vy/N4EzGzah7sxq5tgZXcx/UpWMQT1BpVSrDNq3SmXjRUdnIis=
X-Received: by 2002:a05:6512:a96:b0:595:81c1:c57 with SMTP id
 2adb3069b0e04-5958419e999mr7349781e87.11.1763561726282; Wed, 19 Nov 2025
 06:15:26 -0800 (PST)
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
In-Reply-To: <CAHp75VdLfkcrmaGBPu_YLDReyX5Gvu9pE6BXweArA5PmM3MQnQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 15:15:14 +0100
X-Gm-Features: AWmQ_bkalTfxM-mHFZnJ7F3uIb_qVMr0oulRAFuqzl4n4tn5KQZGXdlcpCtiHfM
Message-ID: <CAMRc=Mf9djJ77ob8L1OKa6HHBx_JxR_sajWH1mFGz=V+hMDbmw@mail.gmail.com>
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

On Wed, Nov 19, 2025 at 3:11=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Nov 19, 2025 at 3:35=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > On Wed, Nov 19, 2025 at 2:27=E2=80=AFPM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > On Wed, Nov 19, 2025 at 02:07:55PM +0100, Bartosz Golaszewski wrote:
> > > > On Wed, Nov 19, 2025 at 1:53=E2=80=AFPM Charles Keepax
> > > > <ckeepax@opensource.cirrus.com> wrote:
>
> ...
>
> > > > I still don't understand what the software node that's already
> > > > assigned to the SPI device is though? device_add_software_node()
> > > > should work just fine if the only other firmware node the device ha=
s
> > > > is the ACPI device node.
> > >
> > > Its the software node we assigned to the first MFD cell, that one
> > > succeeds but attaches itself to the ACPI node as a secondary.
> > > When we get to the second cell we try to attach a new node but we
> > > get the one from the first cell since they share an ACPI node.
> >
> > Ah, I see now. That's indeed a fundamental problem that can't be
> > easily solved. Andy is right about the needed change but phew that'll
> > be a big one...
> >
> > > I think as Andy pointed out though the first 4 patches in your
> > > chain do loosely want we want. Previously, we used the name to
> > > point to the actual pinctrl driver, your patches should let us
> > > do that properly through the fwnode. So we can drop the pinctrl
> > > swnode and just have the cs-gpios bit point at the actual fwnode
> > > instead. I am trying to hack together a strawman but its failing
> > > in a lightly odd way. Hopefully I can get that sorted fairly
> > > soon and post, or I guess I could post a version earlier if you
> > > wanted a look in the knowledge it still doesn't work?
> >
> > Yeah, I'd like that. I want to get it upstream and have interest in
> > getting it fixed ASAP.
>
> I also have a side interest that the reset-gpio becomes an agnostic drive=
r.
>
> > For the record: I believe the logic behind this patch is the correct
> > approach. It uses the existing MFD infrastructure that's there for
> > exactly this reason. However without being able to have an arbitrary
> > number of firmware nodes attached to a device, that'll be impossible.
> >
> > Just an idea: we could try to do the conversion gradually - by first
> > adding that list of fwnodes to struct device in parallel to the
> > current approach of having the secondary pointer and then go from
> > there step by step.
>
> My idea was to mark the fwnode with __private and fix the (ab)users,
> should not be so many. Can somebody mock up a coccinelle script to
> find all dereferences of fwnode from struct device?
>

I think you're underestimating the level of complexity. What about the
concept of dev_fwnode()? It literally makes no sense if we switch to a
list of fwnodes.

For it to make sense we'd have to have a kind of "dynamic" firmware
node attached to a device which we'd fill with an aggregation of all
properties from firmware nodes in the list.

Bart

