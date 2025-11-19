Return-Path: <linux-spi+bounces-11319-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 140B3C6F364
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 15:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D265501A55
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B76363C64;
	Wed, 19 Nov 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYyC7iJp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C335F8A6
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561518; cv=none; b=g5CRpZFMIj4bN/R+IrbLGlgSDb9cLEm2L/hKs0BxJCbG2sSxwmRJClGj6zthJCm+KzVVVabnZ+3vcWam7rh1BJgo57mwrI593SPJ/TouEXtrcLtJX0+HtS0IM5o5VpTZzBlpiv23J6ps9wy0QwMhJTsbHbFxGdYYHjriFweQr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561518; c=relaxed/simple;
	bh=NJrhdUcFLHXStkeDIb9AkDD9PRD1EDRXbbGXl7OqDr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ku7MSUQNLmDunuYl3m551wEbcWwcZsT9xqjx33Sg35xU2J/nIU/tnFBbln/1GI9mj2VBeV9lDMXzw4eD1iFLfWAMr/EP43gwmxGh0m6Pgv200ak1F18Ei6/QQYCn67Td0TUWIjwu6o6YdUNBt+IXfsakxh7nDlPyHzbAZHX+0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYyC7iJp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b73669bdcd2so950631866b.2
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 06:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763561515; x=1764166315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJrhdUcFLHXStkeDIb9AkDD9PRD1EDRXbbGXl7OqDr8=;
        b=DYyC7iJpqqRV06zUs+DgqnXM4pYzJTJUdJnnE+eeE1uhu5/umxlS9DOJ5jyvnXwQLs
         tSKE98q1x5uvYvUMLd/E4u77a9AbOCMj9YW6klmLdokap03/MDqs24xqFuDK/ZQIbTPL
         PhgWIyuWQE+t7Xn9/MCnA6ksQUAtzFrwFNAm8QyLNkJ25PB/w7vvjylxnt1WTPZTZmzj
         VIOujkIfkNoRRrEIheJ4n+C9zaeGgk/I2fSh7STcACcdnMVWBGFjlO+itEHFMUWomMlw
         dr6WH1ihBvaItrW8itmxTpaRmA8xz9BLS9mbLKQoGLiLkxDMuG41runK/cjbv+nes1dw
         oHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561515; x=1764166315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJrhdUcFLHXStkeDIb9AkDD9PRD1EDRXbbGXl7OqDr8=;
        b=vHiqFK05CoLR8yiyTGP2ceQw55M3IOAnO83Zof6/oo/0S1uDBC6EkM+l3YCiOIgzFm
         NMW7zXrHMorzYonUpB6GqAW1moCrDaPRgj/oYGaCzxVYcngFxgum8G9YuN76GXsjIqP2
         duRTrYD4W6CsWKzwIiPHQCmg7srOIpcjyrtjPaE4x5zyZwgAbJxnbGvLa5uFYRm/f4C3
         vA0psHvkvcMR0MPuI++hlUpDRkRlJJxuf1xh8oVkaBaAjTiRVgVmiQv1x0KulHJh6cjt
         MkubE+GcE+Sptf3UBYiWNT57NVufMfQol5+qaSi9TCSqG5pf6rzPYMjAE0xz/CYWc69t
         2UMw==
X-Forwarded-Encrypted: i=1; AJvYcCXYW4036szjmvNurCBuKOEZ5hL28NQD6KZ1cWhP34FV7/PSuftKRl0rwP/lwD+lUfiBgR+eU6Iup2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCeEe+neYpDcTivkIahvuq/lW9Q3ZpnyDxpOiwH/jh0+ZUSiCg
	6w3niYMlzfgzifGNB/eBeR5yFBL5BRgQulCxNKhW4aTyJDvNrvX8Zvu2c4jEuRnQMtWPTqmpmxz
	t+/PxMYYj3zQWKMizwYsVAf4Kx0uZjic=
X-Gm-Gg: ASbGncukTeJDWa6TxRds9aWQ8zrQ+g3SWFt53/+iPC6N7hjKzZ9FtjSg5974X5NG/F3
	7EjA3Y1GhUp5Huy2wM9Fwaek6APjgT/nxigjSoqvkfLacyaV5NZJBrIispG5BwI37LI0jTWPl8/
	R44/HAZB8mBBbtEXNF4d8zc4ToNFaH03WXxDaGJLgarvfGFYefiWb2YNj1KLbtdb6p2/I6mN4Dn
	4veKVwAlbhZjMnDWX5ezX9pTp4qTDP6gt4yi6m+iVEi/aze/6zK9NKqRL0+mAVFyTdwzgp4cq2p
	U9Vtab5SIp0hjHYnqGT/BPoyjI8rl0MtHddjJIjc64fumL1AHVdcVY8ZXQ4cIkDl6DMSzTp27OS
	UqV4m/Q==
X-Google-Smtp-Source: AGHT+IFEXIkjxyjvo3Heg8Rdqnv3nAxyfyX8doWI94v7sDgAwB7zhzPma511LvpWLcEqAp+oBuiHOWStr+0eOQi1eXM=
X-Received: by 2002:a17:907:6d1b:b0:b73:398c:c595 with SMTP id
 a640c23a62f3a-b73678add5amr2235890666b.19.1763561514654; Wed, 19 Nov 2025
 06:11:54 -0800 (PST)
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
In-Reply-To: <CAMRc=MfuQSGPbt3x366j5c9Sg-mgu=TfmD6X25Dk5Rmu0JiiEw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Nov 2025 16:11:18 +0200
X-Gm-Features: AWmQ_bkdZvQRGM-9u6BPNa0MIyrFFzDnJukSJG2IxcoLgl_ofWnSxnzvQoAeVFc
Message-ID: <CAHp75VdLfkcrmaGBPu_YLDReyX5Gvu9pE6BXweArA5PmM3MQnQ@mail.gmail.com>
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

On Wed, Nov 19, 2025 at 3:35=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Wed, Nov 19, 2025 at 2:27=E2=80=AFPM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Wed, Nov 19, 2025 at 02:07:55PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Nov 19, 2025 at 1:53=E2=80=AFPM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:

...

> > > I still don't understand what the software node that's already
> > > assigned to the SPI device is though? device_add_software_node()
> > > should work just fine if the only other firmware node the device has
> > > is the ACPI device node.
> >
> > Its the software node we assigned to the first MFD cell, that one
> > succeeds but attaches itself to the ACPI node as a secondary.
> > When we get to the second cell we try to attach a new node but we
> > get the one from the first cell since they share an ACPI node.
>
> Ah, I see now. That's indeed a fundamental problem that can't be
> easily solved. Andy is right about the needed change but phew that'll
> be a big one...
>
> > I think as Andy pointed out though the first 4 patches in your
> > chain do loosely want we want. Previously, we used the name to
> > point to the actual pinctrl driver, your patches should let us
> > do that properly through the fwnode. So we can drop the pinctrl
> > swnode and just have the cs-gpios bit point at the actual fwnode
> > instead. I am trying to hack together a strawman but its failing
> > in a lightly odd way. Hopefully I can get that sorted fairly
> > soon and post, or I guess I could post a version earlier if you
> > wanted a look in the knowledge it still doesn't work?
>
> Yeah, I'd like that. I want to get it upstream and have interest in
> getting it fixed ASAP.

I also have a side interest that the reset-gpio becomes an agnostic driver.

> For the record: I believe the logic behind this patch is the correct
> approach. It uses the existing MFD infrastructure that's there for
> exactly this reason. However without being able to have an arbitrary
> number of firmware nodes attached to a device, that'll be impossible.
>
> Just an idea: we could try to do the conversion gradually - by first
> adding that list of fwnodes to struct device in parallel to the
> current approach of having the secondary pointer and then go from
> there step by step.

My idea was to mark the fwnode with __private and fix the (ab)users,
should not be so many. Can somebody mock up a coccinelle script to
find all dereferences of fwnode from struct device?

--=20
With Best Regards,
Andy Shevchenko

