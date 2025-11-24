Return-Path: <linux-spi+bounces-11488-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A88C81F8C
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 18:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95FD54E5029
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 17:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7FA2C21C7;
	Mon, 24 Nov 2025 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fEYlIdOQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9352C11F5
	for <linux-spi@vger.kernel.org>; Mon, 24 Nov 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006503; cv=none; b=OHurAwS2AeFc9tEADhK6vDJCXDIQlUBwhRCoGPCvM9NvikRf71MB0WtP6l8nOC4VpPXO7IsLowmUjwJsGpba5rQNbaFVzAr8mwgcmBcSqlF714FuGymV9Ydc3+z62vhlRJ5UL71/XmR73eNvuixm8ktGg5EN34DpvgQHmG/RniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006503; c=relaxed/simple;
	bh=4r6uq+XJ6hrSbkNoNXPhbiKHyGHCKt75UkrHPmh0NFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRil83meUSZrO8CGy1AfX0sC+csn11BCyHmwCOnoBUGQjtkeVmB+drrL1yTx8lpCYesSmdeggQZi0laUf8zHrpbj5nI4hFU2GMVq8AhiwUAxG5k0Wz2oA1qZTQP/4wHiXft5H44rP+sW/fQQXatCUkGmu/g8yeb7wc1iQoNshBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fEYlIdOQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37902f130e1so36292301fa.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Nov 2025 09:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764006500; x=1764611300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r6uq+XJ6hrSbkNoNXPhbiKHyGHCKt75UkrHPmh0NFQ=;
        b=fEYlIdOQ3Nx0FvthAY/5aEUw5UUb3MtRrsBm/5nbXJ6RShy2OIOJrnBvaYqux8QtsN
         6E+DodmUX2Io+IMCmxdf25iypV0EtHUMbOG+3howrJVjk9XVF3HnNl2cUDZyzMGektvw
         xj4VjUPWw3dfOIX36p+OcSsbbbdnHI9slG0YOIcDYiscmrsSPdxk1hPJrDNE4ogmL5XY
         pMLDmFqIMQfiRMK3mIEzExfbo7UhLuvjEeNTwOCU4gjpw6x6FPW9hYyOwSQ/chzZiG2T
         g2PxPWTCJJJLxTUDzQk/GCU/WZhi9XvvvJYnQJvt/fQj2k6vVVQH7lwQWx8mNuTS7i/g
         ilqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006500; x=1764611300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4r6uq+XJ6hrSbkNoNXPhbiKHyGHCKt75UkrHPmh0NFQ=;
        b=U4Ijaoc1Tt9QMj4KlC/lDbs7MzkSB/Mg9xM6ZRXH4LCXgbqu3t7sIyCp7/up7FT+6Z
         NKHmm98rjwyNPQcpceuIdJg7N16K+nrwrrlOzoeqDwQt5mdlqnaaSNdF2upDRNXu7tcY
         +g00YBCT7SQdwKj2Ff/V197S7+p4bOsKgt1J/vsNrQ4gOb777QKahO/7afEqFwqQiToI
         f8/DzC76KqTB0I9l/H67lwK5eaQhEAYNkwb5ouJrI2PhkduzWDYEyDaO/RXP9fL18c1I
         +3aWDYp1rUUA7f0EHP52Qke+Ij4VKqyUFOMupiv4JuOdLG724Z18vtM0EmqGLQCmTZvt
         /uZg==
X-Forwarded-Encrypted: i=1; AJvYcCV8tFOz7M/A7LfQUo+1eqQlkb7otKzYQ8iI4SCa6ok/AilS37kclmt9D6ILF21T3Mm7mENs5P8ByDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGF/2w1Ivd+ZPx1FR0hvUYOTjal8wN7SZZ4gr9uErRk5GtyomF
	y3aQntQMR4UljI6rDJW8rnSEDse8aTo5JmnpeRnwdMBkS5Z+1OZoSWNy+UhMv+Io3Y4IvntLJ8R
	bTfLfxrNg0zTxpB5d4FVix7YKoNmg72qAMgE9Zm9rMg==
X-Gm-Gg: ASbGncusnYgEesCNN4rVbI3SntLYS3L1j1cMiUWlXS5NkVQ6rf8CKd+34ADQvxJsTLB
	lg9AkklItDaqSP2GQWvpLCgAJ83EKbDC1hYM/PHIke8TVRlhgV2RQ3jXAbXxytxABGL8x45N2wT
	sTLvWu8iLOcuUSoHMSs5kBd49miAJjZNSkenMoOM7QdLNu7S40mWKV/wXjGAbru2yEC77vG4d8u
	OTL57zNyYQVmQRTXqqg45Xs0pS8MxHBzNHHgdotT5+T7bjGNBS+zPE33mn9iC0bksa9fEsS0v5b
	UJy0eCQjkVsTjEmc3F2fTsZwOPA+b2sGHEj7XA==
X-Google-Smtp-Source: AGHT+IF993DoHSMlB60mWDtCOrB1XMOt2yUP8xFOoEjON0prsCxIqX3jeiL/LWt48eiHKiIUUX/0Hv99+yLDo3p5YEc=
X-Received: by 2002:a05:6512:3b27:b0:592:fa8a:810d with SMTP id
 2adb3069b0e04-596a3ea7847mr4433290e87.16.1764006499554; Mon, 24 Nov 2025
 09:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
 <20251120-reset-gpios-swnodes-v7-4-a100493a0f4b@linaro.org> <aSSOo4q0sLDHqe1h@opensource.cirrus.com>
In-Reply-To: <aSSOo4q0sLDHqe1h@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 24 Nov 2025 18:48:05 +0100
X-Gm-Features: AWmQ_bnvq_Ux1-kkcgnqJRAH0qfvPMdf4XOXl8mrvC21GsBAI5YmjWFZH8pho_M
Message-ID: <CAMRc=MfiR4AMYXc5YA0GOt=+-kx0yO0qFdYd2mZqwguW5v+U5g@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] spi: cs42l43: Use actual ACPI firmware node for
 chip selects
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, 
	Maciej Strozek <mstrozek@opensource.cirrus.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 5:58=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Thu, Nov 20, 2025 at 02:23:59PM +0100, Bartosz Golaszewski wrote:
> > From: Charles Keepax <ckeepax@opensource.cirrus.com>
> >
> > On some systems the cs42l43 has amplifiers attached to its SPI
> > controller that are not properly defined in ACPI. Currently
> > software nodes are added to support this case, however, the chip
> > selects for these devices are specified using a hack. A software
> > node is added with the same name as the pinctrl driver, as the
> > look up was name based, this allowed the GPIO look up to return
> > the pinctrl driver even though the swnode was not owned by it.
> > This was necessary as the swnodes did not support directly
> > linking to real firmware nodes.
> >
> > Since commit e5d527be7e69 ("gpio: swnode: don't use the swnode's
> > name as the key for GPIO lookup") changed the lookup to be
> > fwnode based this hack will no longer find the pinctrl driver,
> > resulting in the driver not probing. There is no pinctrl driver
> > attached to the swnode itself. But other patches did add support
> > for linking a swnode to a real fwnode node [1]. As such the hack
> > is no longer needed, so switch over to just passing the real
> > fwnode for the pinctrl property to avoid any issues.
> >
> > Link: https://lore.kernel.org/linux-gpio/20251106-reset-gpios-swnodes-v=
6-0-69aa852de9e4@linaro.org/ [1]
> > Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> > Cc: stable+noautosel@kernel.org # Don't backport, previous approach wor=
ks, fix relies on swnode changes
>
> Just wanted to check what the thinking is on backports here. I
> see we have marked this as do not backport. Which I think is
> sensible the changes in the preceeding patches are a bit much for
> a backport. However, the patch has caused the regression has gone
> to a few stable branches (v6.17, v6.12):
>

I totally forgot about this having gone into stable.

> commit e5d527be7e69 ("gpio: swnode: don't use the swnode's name as the ke=
y for GPIO lookup")
>
> Are you guys ok if I send a revert for that patch to the stable
> branches it has gone to? It doesn't actually fix any bugs on
> those kernels, and we are starting to see issues coming in that I
> think are related to this:
>

Yes, definitely, please do. You can add:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Bart

