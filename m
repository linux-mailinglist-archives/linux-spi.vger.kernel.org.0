Return-Path: <linux-spi+bounces-12081-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49390CD86DA
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 09:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76ACC300216C
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CFD31281C;
	Tue, 23 Dec 2025 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI7RCyeO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E1311C37
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766477375; cv=none; b=TXN/tbNVHug2i+C0bGThOONsXrxSBnJ78/YPm6OYJ5sI+WpmlsD23kd3rYwETHoEvq83LXHklejJ8CnlB1O6tFxzN/DLzUJ3GxsUMYSp0/cmcvd+y96zQyfpRwycBLS0DDd0BhmJ0vQsUGrhjqdXXKSe9jxFYlCHPCCvzE8PYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766477375; c=relaxed/simple;
	bh=Osiv6u6i1ftGMerytX5TzJR/+DiFkA3YCbZH6hF2Bts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvmdOBjdqoJIn0jbmt9caC839t0tp7tCV03bALR0RhzArifHUX4Q5Ad7ohXWbeil6pNwL5pls/RStruPklpT8ITUpT7o1TUONlvW/3u8hl9GPi1ilQ86IGO95DfIBzY7Z2BwVOsAMF/fSqAZWRQDAW3eyw5Lq0nz1z0myaiKR+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI7RCyeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5534FC2BCB2
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 08:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766477375;
	bh=Osiv6u6i1ftGMerytX5TzJR/+DiFkA3YCbZH6hF2Bts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dI7RCyeOS+g8g+w8tr/nHH3TWBC9ystOfBuKgxmJlMyJtD2+UIWKW0keY7uz55pKT
	 UqjVR7yluANmOLO6Ab6yR/S8d401gXtwWDVB1wFW1Om55TK11ItaHRiX+OXzYDiK50
	 TwOinteQZ3DQrgSCwIbq0GbWx5skC5Li9rGcj3RmHpUPRyZSvog2eapSUWtbEXkknC
	 QGKUA+idpZFa3tw8YwtUahfiwCKeQeJOBQ2trvcw3F7MeQvrThx3HIy8kMh8VM6qvm
	 qH17LAvHNvBClGnJ91/EXw5HXsVv45QF3Jgnw6g4oEMS7EZ+NQf2VSBm6QdYW49EbF
	 FHkvFU1FBEE3w==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5957c929a5eso6904064e87.1
        for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 00:09:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmvdewzhy2s/FARI596RHVWIXH9D+3nJsKPSiFPNv1PZjEhG5hMyrXvL3KTPFT7JD8lJoBd3KOjFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH7jkP1J7tB5X+JtgOdKspkMER4RQqMnII3zbL0b2PgqK0ZwKu
	54ZgvZuV6KSNA2TankeR64jbhYOzQWYM4kpQFHoypcYIYZLBcTb+NcRXeFj32/hMDYkPKyyyso2
	lCyrPaMN0UoeuDx87sYh3iBgGcNEP5yWri/K64D6qZg==
X-Google-Smtp-Source: AGHT+IH6CjtWz2eC6A7WTV5XCfvHyGHCVkBRxVtlBMZvSHN8FIkzlyMB48qGO3lG1plyLQSxcwjl5cDBpyBS2E08hfc=
X-Received: by 2002:a05:651c:2125:b0:37b:a4e2:4407 with SMTP id
 38308e7fff4ca-3812167ad49mr34213361fa.43.1766477373897; Tue, 23 Dec 2025
 00:09:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <02fd01dc73df$3b641bf0$b22c53d0$@trustnetic.com>
In-Reply-To: <02fd01dc73df$3b641bf0$b22c53d0$@trustnetic.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 23 Dec 2025 09:09:21 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mf2A++CHYcMdBi0bQ0DOAGLaSatQEOmu=aAEG_YjCqEWg@mail.gmail.com>
X-Gm-Features: AQt7F2rwHlTAC5wkXk0HJvSOHTgU-VBb0EX3H7YajrOrM-j05M9Rgbg9FpST7rI
Message-ID: <CAMRc=Mf2A++CHYcMdBi0bQ0DOAGLaSatQEOmu=aAEG_YjCqEWg@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] software node: allow referencing firmware nodes
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, andriy.shevchenko@linux.intel.com, 
	andy@kernel.org, broonie@kernel.org, ckeepax@opensource.cirrus.com, 
	dakr@kernel.org, david.rhodes@cirrus.com, djrscally@gmail.com, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, krzk@kernel.org, 
	linus.walleij@linaro.org, linux-acpi@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, 
	mstrozek@opensource.cirrus.com, p.zabel@pengutronix.de, 
	patches@opensource.cirrus.com, rafael@kernel.org, rf@opensource.cirrus.com, 
	sakari.ailus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 8:39=E2=80=AFAM Jiawen Wu <jiawenwu@trustnetic.com>=
 wrote:
>
> >
> >  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)                  \
> >  (const struct software_node_ref_args) {                              \
> > -     .node =3D _ref_,                                          \
> > +     .swnode =3D _Generic(_ref_,                               \
> > +                        const struct software_node *: _ref_, \
> > +                        default: NULL),                      \
> > +     .fwnode =3D _Generic(_ref_,                               \
> > +                        struct fwnode_handle *: _ref_,       \
> > +                        default: NULL),                      \
> >       .nargs =3D COUNT_ARGS(__VA_ARGS__),                       \
> >       .args =3D { __VA_ARGS__ },                                \
> >  }
>
> This change seems incompatible with my driver txgbe, since the software n=
odes
> are registered in " struct software_node * " but not " const struct softw=
are_node * ".
>
> So when I pulled the net-next-6.19-rc1 that merged this patch, to probe m=
y driver.
> The error logs shows:
>
> [    5.243396] txgbe 0000:10:00.0 (unnamed net_device) (uninitialized): u=
nable to attach SFP bus: -EINVAL
> [    5.243399] txgbe 0000:10:00.0: failed to init phylink
> [    5.576008] txgbe 0000:10:00.0: probe with driver txgbe failed with er=
ror -22
> [    6.109548] txgbe 0000:10:00.1 (unnamed net_device) (uninitialized): u=
nable to attach SFP bus: -EINVAL
> [    6.109551] txgbe 0000:10:00.1: failed to init phylink
> [    6.442044] txgbe 0000:10:00.1: probe with driver txgbe failed with er=
ror -22
>

This shouldn't have changed anything for existing software nodes - the
pointer in struct software_node_ref_args has always been const. This
would have failed at build-time if this was an issue. Have you
bisected it to this very commit? What line is the -EINVAL assigned and
for what reason?

Bart

