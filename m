Return-Path: <linux-spi+bounces-11394-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85996C73F66
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CB5B35748A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C4333730;
	Thu, 20 Nov 2025 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PHji6EP2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB830AAC6
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763641691; cv=none; b=Q4wLypZKGBFUjR2CPqTg6nxbdCkdsN6alaQDeT8ZgKWqSuMGhRETyequvdtWfWIyh4iXtCNAOg8wPPDpw8KWncZpCMmTUrUvnx8YbHqmSyO9jCt1JcM4lqPkI1l/UKr4Gw+nO0CzU49ceAhRvtJuaH88r69H/EodqY6S/eDVBpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763641691; c=relaxed/simple;
	bh=P9H2efPbk/0jv8cNM4Qf1i7HtYICf5C2snOcL0Djqe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLLHPaiLFHlAW315GLkuHo/LMYU1U7MKAJCD+OPGjfjIrpO3UuSNm9UtJz1j9N7GPWaJ2NyuwcSpuB6oAAZ3CsRtzTluoEm83oGd0DvDVNNSHg5Pn7qcAyFnDgEE1xy4MrIiJ6OlNb1epQ9KXWirqNKqB7mPW+e4YxMOwGJD/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PHji6EP2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37a33b06028so7470121fa.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 04:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763641688; x=1764246488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bL2FhXRLpT1HcsZuSiUDRIw4ZCNtNP1rJvajASfpfw=;
        b=PHji6EP2eSKiSJrDzL1V6ikL+YK5mDLAjrdl6LdKN0yflJj+sgHOo4G74/dQAcQhZS
         4htzhqv86DTBJu0jTCSAexGNOVQ4UYcZtNde4TAUGvHY9TUCXApd4TNKwgRTa7HhXD4s
         04c3ewxGaVUgEr3vU/8xe1qyUK0ApkpFcCamxWqfu/OXBvnH3ASn8c7DTk+bEFmRfDjD
         OdKuI4kKqbQFdJKfpWk2IyIv6JijiWuu+wXpkehsGjTDFNiFweEVqjzRBJc7nDDdYJWQ
         uEmXyU1BK82UZ38Q4czGOeiRww4YvssB4/3wKqlZ1WkhJV7isPuz7+0IWWv1WCLTX2Re
         hmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763641688; x=1764246488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bL2FhXRLpT1HcsZuSiUDRIw4ZCNtNP1rJvajASfpfw=;
        b=XE0z7L3elRA9itD53xjxygr9JSZdRnLObR1TpnGCR7KJzzFFLWuKxtOusWgSliEOm2
         VrAXZ2Vsep4nht6Fs318jOwUakM5PubcYTqSGmSoMGi9zpn2Qcb3r8V5fT8at0w8CUGJ
         JEQ2Kgf4oO6vCjayVSq/1lChjDJ4WwS4eZUYoHJ5x8vW11Gk6kifRyZEN1RlLUE3IJlY
         8Nx5zwlPC1czL8QeGOLHS+q9GYLi6J2m4L7Vo15ckRDkebaAaCxAm3uHVlQIbXaH+i87
         JlVV8DQ4AQzv/Lb0i0tAD5E0y/MDuWaSzJCzhmAKJ0i+3EF5RMQ2wYWAdiLXg1ahgGvj
         NbFg==
X-Forwarded-Encrypted: i=1; AJvYcCVpoEpyjuC1gYNh6XCKSQ9y9kTkBArx46T4KH5IkBNC2G2Or8JksIMW0ZZmv0btgb1gITPq6wjEGo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDNDYvCMfcP5b6jYIk9+iii1psp1FUj+0CqYT8lDnXLiJB+P7
	56Oe/vxaHx47/2HFHS06VsayIfYLTzPYvUaCEzwE4+AXyvBHE+9hiT6zQUJhkYbSx9ErcYHfnqz
	bcptIZun4cE8fedBT7dDYMU+ruz0CN3P0QfrnGMPB3w==
X-Gm-Gg: ASbGnctzLE2gepxPKxA49eX5dTQAG8+nAMCWBaKH13LEdRXK9eGMpSUMnKo4tJyuteP
	cqkmLOAK648as7W2V8Cln+RBftSr4mUiv0pRG+iTwmJlLcdA2LNCeKt+eOu91zzzirrxasPuIAY
	mhs5LwG5BApuyLtawdq+jxVLHg6AiCA9whk5Vep6n2MpSG4gPbRmlz51DPO4m+FKBTSI4+1cQcN
	r+zG0vT0VNTR2ptGRLIEEbhSWx9eN5PL16yCHx5duSk7E0H2wokx043hBqeZvnqCh6Lr0B2SQ6P
	vXW/dM02ss/JaY35j/8rJ8nedw==
X-Google-Smtp-Source: AGHT+IHFiFeZ/wg9cdVAeRgWCSZ2ZNOQSff6PDeSQvaK6oPJEJIrZO4Vdj8XkbntIz0Y4rPDws3qGLiEr0Yvxl+9NZY=
X-Received: by 2002:a05:6512:a8c:b0:592:f40a:25f3 with SMTP id
 2adb3069b0e04-5969e2f430amr1099865e87.27.1763641687051; Thu, 20 Nov 2025
 04:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120105907.1373797-1-ckeepax@opensource.cirrus.com> <3beb841e99f62767547054c4344f2c60eae4ed9b.camel@pengutronix.de>
In-Reply-To: <3beb841e99f62767547054c4344f2c60eae4ed9b.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 13:27:55 +0100
X-Gm-Features: AWmQ_bllvrDTigtL4OXlTYgl2RQDEQpq52mz6b94Dl7uiW46iGJLK_UCbVTevPg
Message-ID: <CAMRc=MdJp8T2gZ=ExWCOKSaVqZqo4Dc2qAX0hXkx98ShUx3mjw@mail.gmail.com>
Subject: Re: [PATCH v2] spi: cs42l43: Use actual ACPI firmware node for chip selects
To: Philipp Zabel <p.zabel@pengutronix.de>, broonie@kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, linus.walleij@linaro.org, 
	andy@kernel.org, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	bartosz.golaszewski@linaro.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 12:21=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
>
> On Do, 2025-11-20 at 10:59 +0000, Charles Keepax wrote:
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
> > Fixes: e5d527be7e69 ("gpio: swnode: don't use the swnode's name as the =
key for GPIO lookup")
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >
> > IMPORTANT NOTE: This depends both functionally and build wise on the
> > linked series from Bart, it probably makes sense for him to pull the
> > patch into his series.
>
> When included in the reset-gpios-swnodes series, will this need either
> a noautosel or prerequisite marker to avoid it being picked up into
> stable without the reset of the series?
>

Good point. Also: the  Fixes: e5d527be7e69 ("gpio: swnode: don't use
the swnode's name as the key for GPIO lookup") tag needs to be removed
as this will go before this patch.

In any case, looks good to me now:

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Mark: can you Ack it and Philipp will include it in the immutable
branch with the swnode series[1] I will resend?

Bart

[1] https://lore.kernel.org/all/20251106-reset-gpios-swnodes-v6-0-69aa852de=
9e4@linaro.org/

