Return-Path: <linux-spi+bounces-11314-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 655B3C6EBB1
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 14:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AF2D52DFA8
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 13:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F935F8BA;
	Wed, 19 Nov 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CFDbFNxX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6F3596EC
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557691; cv=none; b=VvN1Smqk8tlhKCdS7VkDgDW0ItbDfKBQ2raOkYE7L9drh4VY6SckxZMvmeqai5dwgifa/5uzVL/RX6gvPN0WRQXW5Jc2DQ00lLfq102TEEsTYdP+/+5YDTiTlWWyF2krkXuIRMgnru5/t5PBCE0vhLQREFyWriuU+Z7iR5Uwuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557691; c=relaxed/simple;
	bh=hQoZWYb0gKr8PXtINO5UZlKj5WNLOzVIF4OtWhYfcbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISNmYMY4Kg7g1m3ARmQFl4f7Ka/hOe9dd1iAxQf9sDap4ELUCSgSRvZiScMxtUW9f975jI/pzZgCF/Vy1JkLtYUECY1o/cCwUvaULd7tIEr0HpzCBohWYXym2tgtmxF7cLeqhf6yJKHls8SyEDb60VnwXaaTXnI14TLG1BV2YaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CFDbFNxX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so796181e87.1
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 05:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763557687; x=1764162487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HAVEbRJrzkEcyxCJ/0LbCeIf3zbDMGRzjvrnP0EUUk=;
        b=CFDbFNxXVpeWFqwcmg0AXEGK3tDcOo/uaGgRlo5bl3unXkzIazB0LRTr3zmg1TQYbC
         oq5n4x3Ba7uzJEOE4vZwbs6F16CuLWYZ3fNGUdL1Mppo96cUsWLqvXxG+v3/zpl14rAw
         8CDv0ARZmNbMs/npU8DaaVayYNgslHL7Lpn4gCV5YJUz937So56OHASyT+cMvDWIdapg
         R9jKbNsJbsZ8oqADOsa4OWC+sCgAgAyD/oR9FBcp8VG3FygL6k0l5T/CepCuL9giycmb
         FnqNqXbk82K3OsRswqT/xy4k43mn1X6CLBDczXYuM5iFZsjEds6bdUS+P9pKeKGZQHkg
         KzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763557687; x=1764162487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HAVEbRJrzkEcyxCJ/0LbCeIf3zbDMGRzjvrnP0EUUk=;
        b=R6dkEBxEPk1a+skGRAsDSHbc1b7mz7HxYu6NXMMsuGNyUeBUZ4nqHsejzUFZrNPFyl
         tIgms68Y361rZZFpwPbJa/4no5evKQanLgNs4EF4beXqtUaKv6gdSJdVTaQBqnsl5+OL
         Q2xmctnKNMFLARtS+bpPIqGgnVj0+iK58UFuVYL634uV0YWHuFDxQh2Dk7Zh0pO+vma7
         Tkysf019U8AXp7flDNk5IEfzdN4C/r50teCJLtobMAryFmC9U1irlceOzg04tnVbH5fM
         4YM/6T2UW1qLrDgG8eqb7yQdJP1YGjzOzovOhQ7H7s/1Z1BC0+B7CnbRuCP5CFOM1RIu
         1xQw==
X-Forwarded-Encrypted: i=1; AJvYcCWx+0VJxcU6XB0QtbB7bgKQtk8VZ9ecrTZi7T5ZDPdbJ1I7ipkgVDuhirKtrg2dS9dQlqYHICbXYvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHM7zgNn+Gq3xXjqQ5JdtGudUDidnbdnjZzkgho05IxtWce3us
	dS+F3Bg03Ug0DJUSqW8ICjjOuwpP9sRvQYF9py9y9nurWt98/OhuaWXENYVO5GRCSWM9ATgnJ+L
	uGdrCJerTVrdFCCAhwwYB1Z/gtqPgO70pguqupoRP3g==
X-Gm-Gg: ASbGncurSjl/JG2ALPoJxHMquNzr6+lpeN37xTb8IHmEWHN2k6pDV8x+cZbgiFAUnej
	4GRD0P+UrMB0W9l77yBC/04s/yNZ0SC+41kmwNUhEUBnZ34fPURIrnYRI6+KtKkJkYQY26mTbOP
	IQd6UkHxwzscWkuKJcj/epSpiBu8zgmipctegXkOKTqncjAEA85jW/DOARhJGb7GWlYRQE0fdvk
	JwGyBPL1ctHXDHJWAd9NRdF3r+2l4sKKXkrQJHjKGJ8Lcc/ncLDHAzh5XvAOmxwYT2p5inXGOKk
	21LTNHjKK1dCuEtU+2DQ7z/bvAY=
X-Google-Smtp-Source: AGHT+IFOTESTGX3coCTwSkh0/t71LWjq0sAzk7nvKaSf0jj6S3GyWUj+21JdjGqOY1KYtwXVoO7Xen6Kuz6TKdtzwyw=
X-Received: by 2002:a05:6512:224e:b0:594:3b8f:b309 with SMTP id
 2adb3069b0e04-59651c829f1mr760883e87.11.1763557687097; Wed, 19 Nov 2025
 05:08:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aR2OU4se7lxcMtGW@opensource.cirrus.com> <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com> <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
 <aR2gVzKhfN38MHAR@opensource.cirrus.com> <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
 <aR2i6lNNWEbQk0fx@smile.fi.intel.com> <CAMRc=MdYcdrQSDWKDHrx4-Y4-y92AQqr73MoRC3ws-X==SL0MA@mail.gmail.com>
 <aR2o2R30TbVOcqZe@opensource.cirrus.com> <CAMRc=MciO0WYejOYZduqE73U4OVTxcaMfe6Sv1VXWJWL2FFNmw@mail.gmail.com>
 <aR29uKW7yLxws9jA@opensource.cirrus.com>
In-Reply-To: <aR29uKW7yLxws9jA@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 14:07:55 +0100
X-Gm-Features: AWmQ_blnoUsG5H-9efcz-0u6UdrvFr9ylGH2hCaCTztZ-mSYErCZyF808ZXio0s
Message-ID: <CAMRc=MdXNXQhE9zi=i0x0yGCi0fKQNU8_tn2_Uy24TAhxG7BRA@mail.gmail.com>
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

On Wed, Nov 19, 2025 at 1:53=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Wed, Nov 19, 2025 at 03:58:08AM -0800, Bartosz Golaszewski wrote:
> > On Wed, 19 Nov 2025 12:24:09 +0100, Charles Keepax
> > <ckeepax@opensource.cirrus.com> said:
> > > On Wed, Nov 19, 2025 at 12:06:57PM +0100, Bartosz Golaszewski wrote:
> > >> On Wed, Nov 19, 2025 at 11:58=E2=80=AFAM Andy Shevchenko
> > > Ok I think I see what is happening now, the swnode is created on
> > > the first cell (the pinctrl). Then it moves onto the second cell,
> > > but mfd_acpi_add_device() copies the firmware node into both
> > > devices, the device_set_node() call at the bottom. So it inherits
> > > the swnode node through that primary fwnode.
> > >
> >
> > You probably mean this line:
> >
> >      device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
>
> Indeed yeah that one.
>
> > What is the actual device whose node we copy here? Would doing the foll=
owing
> > help?
>
> Its the actual ACPI node for the device, the cs42l43, sorry if
> that isn't what you are looking for not sure I totally follow the
> question here.
>

So it's !is_software_node() and  is_acpi_device_node() instead? Then
disregard my suggestion.

> > -     device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> > +     acpi_fwnode =3D acpi_fwnode_handle(adev ?: parent);
> > +
> > +     if (!is_software_node(acpi_fwnode) || !cell->swnode)
> > +             device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: pa=
rent));
> >  }
> >  #else
> >  static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
> >
> > > I am guessing this code has perhaps been more heavily tested on
> > > device tree where it is more common to have nodes for each cell,
> > > whereas ACPI is far more likely to have a single firmware node for
> > > the whole device.
> > >
> >
> > If my logic above is right, we should not set the node here unless it's
> > an actual node coming from firmware OR the cell doesn't define its own
> > software node.
>
> Will that not leave the MFD children without access to the actual ACPI
> node though? (Not tested just eye-balling).
>

Yeah, nevermind it.

> Can we tackle this the other way around? Since there is only a
> single fwnode for the device, can we find a way to get away with
> a single software node for the device too?
>

I still don't understand what the software node that's already
assigned to the SPI device is though? device_add_software_node()
should work just fine if the only other firmware node the device has
is the ACPI device node.

Bart

