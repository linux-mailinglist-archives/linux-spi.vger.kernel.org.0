Return-Path: <linux-spi+bounces-11321-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C69C6F457
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 15:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C90402EE25
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B966366DC8;
	Wed, 19 Nov 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9l/0C1S"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF4D366DC3
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562271; cv=none; b=bR0tGWPOtMC/BAldg77iY34qC2btvkhXyUWjojz3YE4f9GslRsU6pkg4CMuKux6ZB6JqtzHRu8n/9nUQHWwPOZg5OIOOE0nJh5mpoYDDuxsA8L15TwELKlbWNzxLJU4Y9OydCcGpVQ/mJ+RCWZffw2cgi5CeXPpk0qyoBd7Rb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562271; c=relaxed/simple;
	bh=vWSEerfPaRk+iI6tKXua2UkSPPsZ3pOrGj+xwe0dWZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N05/EMN0e+KGklBWUWQ17o7Q9V8bFL3s1WbJ1L6HTgj8vHKv6ePoFE0XYoZEI6r718OkSIrb/3kDd/OxRdusZ1GKG+iHwNo4EdPiDL5qsmYqdoAJ5yoREXcUBZbrnYBYR+jh1B6roJndTx3cc4xbIpGBaaF/X2BDZbuNqrh+/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9l/0C1S; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so10122200a12.2
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763562268; x=1764167068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWSEerfPaRk+iI6tKXua2UkSPPsZ3pOrGj+xwe0dWZA=;
        b=A9l/0C1SyVYMnYjBzLtCwzH6o2yT5Kc+1ikTz8rOYxbwlQne4Jk+n+2uprRlTQTlqN
         PseyNDMkpkxrl9Co4Kkj/e8f/odL+WY7IT+2z0jhRm1YYUfydqR9HwDpKRfktFvf0SBQ
         4H7SnHLE8zCyHaOtPgFPPQt4X1P5T6qFLr92vMIIJPCVUOnUOu8hDR4vnyWIgt5MHFjq
         om0FPp+WaCuOfOZPBTuN3J+sUN2Io4jK7BFa3S5pVV+sG9mF4zNRrqTv+wwL3AON/BC9
         xMK/F2QaeFmvAhfNvjqeJDf8W4ME12BlRagwx/4EgOd6d9imwgyZIJpZmWOLaMvpf1Cl
         oufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562268; x=1764167068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vWSEerfPaRk+iI6tKXua2UkSPPsZ3pOrGj+xwe0dWZA=;
        b=wtYqAWDcdHVwm/bwbmyrSj0RPA6+O3Q5QxvpabAs0v+EBUCcfplu2KiX7XhNstotJu
         aPc7D9HJ7lcDVKKrt8TXbFZPxtolU1iqIf0+yWQF2uPfcwjlXDv4Yaz5cQJDJ7EI6GaT
         PzpGTzT6wj/rwW6ZwI+OAGwBpw1ZejtXvBNLhu8Azop4sG9sFIv4UDa51IeqBxl8yqw4
         HrQhGzef3MGiDB64mtF/DtUJVMbFWlP9fFsf5buq5YbHggzQy0ynrtHU50MoeMbL/KGk
         spt+gOQlcS+ViWzHjuaczgBikuW26KRmP+hlA2oonlYbpwFBlizCyBHfgrwfSRiNnQZT
         9haw==
X-Forwarded-Encrypted: i=1; AJvYcCUXBK2a2jnHvUglwyt2pmazve3O5PIovPKv0JJUmQet5w4ssTUt1xPZKKa81U2HUQWFDid/knd62Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztWH+R6z4yTtF0+GLN14iv8sZZ2MjNoPtvkNtpRFyzDXdSdcoG
	obRo6kYXxrauptvYG3oqjokVtk9UjPL13Gw3KiLtLfjHRRHphm2gQaWlX9Ih9VDTAkBY/D+cYov
	2N+crYeVUalf4CVkghHzWz1P1vY7Izwk=
X-Gm-Gg: ASbGncu5Hd6gU2B0Go5nbFRsWwmNFnQmN5Rqkwy1VeUV3jsThz1L4jVlTEGnqw+wEx6
	PcOBzFGL/2wqP5BfbbejhmjiVPKNsbI3qtRREzppcgGilSCBTJIfyLe/O+nQE5Q7I/kq8Tb6yVM
	3Fyd5zoaxopkthqSDY4scHbHd2LniPlM7Eh1t+y0xI4mJAQKNZfe7o0Edw1JO728mHMRQ0Xzj5Z
	0dmw7sDxpOicvDBAmGb3qS44otFPCLl2DIp8kWZx6afVFHuqbBLfKONl5bICCPDdPEG1SC7oR+1
	ujaMTT2TdnZvlJ2789AsqGemLylHR9QcFnFLop8hMCvFhwxOnnzzhEb9GAizmx5ZVWwMV3Q=
X-Google-Smtp-Source: AGHT+IHn+k30CDgmnN3cX0JD20uIQgOwGKj/bJYkmvQ2Q992SFI9vKwkM/qNyYUaTShfNiFnIBCVTi1Yxe5OKWv9Bt0=
X-Received: by 2002:a17:906:dc8c:b0:b73:b1ff:4db1 with SMTP id
 a640c23a62f3a-b73b1ff5009mr967076166b.29.1763562267529; Wed, 19 Nov 2025
 06:24:27 -0800 (PST)
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
 <CAHp75VdLfkcrmaGBPu_YLDReyX5Gvu9pE6BXweArA5PmM3MQnQ@mail.gmail.com> <CAMRc=Mf9djJ77ob8L1OKa6HHBx_JxR_sajWH1mFGz=V+hMDbmw@mail.gmail.com>
In-Reply-To: <CAMRc=Mf9djJ77ob8L1OKa6HHBx_JxR_sajWH1mFGz=V+hMDbmw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Nov 2025 16:23:50 +0200
X-Gm-Features: AWmQ_bnJ-q9HQiQwowyGZvvUaMzh50-2xom6S8QmPW3aZF3X3xIPv_WvQVzTw5s
Message-ID: <CAHp75Vf_+WzMn+pmwK4zhLEZtG3Uat4FrdFMCMtPmmX82E3Wzg@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Bartosz Golaszewski <brgl@bgdev.pl>
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

On Wed, Nov 19, 2025 at 4:15=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Wed, Nov 19, 2025 at 3:11=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Nov 19, 2025 at 3:35=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > > On Wed, Nov 19, 2025 at 2:27=E2=80=AFPM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > > On Wed, Nov 19, 2025 at 02:07:55PM +0100, Bartosz Golaszewski wrote=
:
> > > > > On Wed, Nov 19, 2025 at 1:53=E2=80=AFPM Charles Keepax
> > > > > <ckeepax@opensource.cirrus.com> wrote:

...

> > > > > I still don't understand what the software node that's already
> > > > > assigned to the SPI device is though? device_add_software_node()
> > > > > should work just fine if the only other firmware node the device =
has
> > > > > is the ACPI device node.
> > > >
> > > > Its the software node we assigned to the first MFD cell, that one
> > > > succeeds but attaches itself to the ACPI node as a secondary.
> > > > When we get to the second cell we try to attach a new node but we
> > > > get the one from the first cell since they share an ACPI node.
> > >
> > > Ah, I see now. That's indeed a fundamental problem that can't be
> > > easily solved. Andy is right about the needed change but phew that'll
> > > be a big one...
> > >
> > > > I think as Andy pointed out though the first 4 patches in your
> > > > chain do loosely want we want. Previously, we used the name to
> > > > point to the actual pinctrl driver, your patches should let us
> > > > do that properly through the fwnode. So we can drop the pinctrl
> > > > swnode and just have the cs-gpios bit point at the actual fwnode
> > > > instead. I am trying to hack together a strawman but its failing
> > > > in a lightly odd way. Hopefully I can get that sorted fairly
> > > > soon and post, or I guess I could post a version earlier if you
> > > > wanted a look in the knowledge it still doesn't work?
> > >
> > > Yeah, I'd like that. I want to get it upstream and have interest in
> > > getting it fixed ASAP.
> >
> > I also have a side interest that the reset-gpio becomes an agnostic dri=
ver.
> >
> > > For the record: I believe the logic behind this patch is the correct
> > > approach. It uses the existing MFD infrastructure that's there for
> > > exactly this reason. However without being able to have an arbitrary
> > > number of firmware nodes attached to a device, that'll be impossible.
> > >
> > > Just an idea: we could try to do the conversion gradually - by first
> > > adding that list of fwnodes to struct device in parallel to the
> > > current approach of having the secondary pointer and then go from
> > > there step by step.
> >
> > My idea was to mark the fwnode with __private and fix the (ab)users,
> > should not be so many. Can somebody mock up a coccinelle script to
> > find all dereferences of fwnode from struct device?
>
> I think you're underestimating the level of complexity. What about the
> concept of dev_fwnode()? It literally makes no sense if we switch to a
> list of fwnodes.

Why not? It will return the pointer to the primary node. You can look
for example how the list of the DMA descriptors is done in
drivers/dma/dw/core.c. Not the best solution, but gives you an idea of
how it may look.

> For it to make sense we'd have to have a kind of "dynamic" firmware
> node attached to a device which we'd fill with an aggregation of all
> properties from firmware nodes in the list.

"Dynamic" is just a node in the list. The only potential problem here
is prioritisation. Should we add to the head, tail or insert? But
converting current approach will be straightforward.

--=20
With Best Regards,
Andy Shevchenko

