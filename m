Return-Path: <linux-spi+bounces-11318-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A789DC6F306
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 15:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0A6F346F1A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718153446CB;
	Wed, 19 Nov 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gR+++1Pg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8665C3538A1
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561389; cv=none; b=daOfvcYgUoLE6cPqmqiLlzNQSGowe6RYixpPbVVN5rnt3neY8bfBI/2cClw7IFpNQIpBFWn3thiDIIgQnVtmdtZd8vzn40vBNCnsOry3ZDVrM/k4PvzeHrydnsygvsrIsqr/ohWjGGVwS66GIYGMYLCO4OeY3P4wybA8zaz9VYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561389; c=relaxed/simple;
	bh=oaQJkpLoRmPH88edjtjw6e0CUhdPfZru2YI8CASwDRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcBoZeGUqWiAIdDNfsG3w50rSnW8j0x2Bikv0Ma5vfo5536SLv0L7zXfi0KOA/P/o3ktRyN1FI2DdJxT2V0hr4k+p6D17A7sARg72erON3FS537/aMA0aU1v7C/62Epy7k12iReHX9vexr7ySxzTlgfViOXUwLXU/Cj/4ZJ8mLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gR+++1Pg; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37b495ce059so58914821fa.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 06:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763561386; x=1764166186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaQJkpLoRmPH88edjtjw6e0CUhdPfZru2YI8CASwDRQ=;
        b=gR+++1PgCrzo9uVK4C0WKS3OWBL8Ou8VC+MqqJn46UkDimyIKyQJKMeZdcpHqaZUsJ
         JDFVdzffuB0ZbjoU8j/FkVnAeWQlaUDnT4B0ZRZ1G3e4sdhiFnB+JKwNxq/n1VfT60vY
         UQHt24xJvl2C/HJ4abikvrQpvZtZNAu/8AGNbT6PsdsM7tLxCXQtUPGt1W4sSKrF4h94
         5s1rdtT+hY/A1Ig6ezUbp6TofPv9aTTnK4oA8nPSGRUeMUFrprhTcuS39zviN1rSAvHS
         sWYsTZtwterFeNZPIHEbaotP+P13gxEg1w1//qVxIhF4yL72bRgOTgrD7UmNHg9ESvyh
         2Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561386; x=1764166186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oaQJkpLoRmPH88edjtjw6e0CUhdPfZru2YI8CASwDRQ=;
        b=X9JfgPhVwVvXuiXUEPMW8pDnf38vRreGiQxMcoo9GQ9oeMfo3lvR4v4CliPs1zsfBc
         OJCj49xC5UPQRF52gUoXZNKUuZ4IR+VagSBzmQFVzHAt705ZIP03rffHZ7VWv74Ouxc1
         LOC3suC7m4leXk+qYCGrh26j76aQqppzCKLscwFHflGBY/XBNLh6XmRg42mdG92z537C
         /M4tmTWzFGNsTG+TU//CwA2JF7UbloPlQ4Axt5xOPbn8mAusqC0zOvu/v0dnWVAu0Haa
         k/SGwYgwDYIn4R+jNby+EptnQsqDBUCH7xEkjKT4l1EIoOeNWPjh1fnSmlN3Nelwk8hR
         Yl9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWY706UTJFaDEtv+v7wzajAiEwW6EAEi+4+nEHjgVhW2lKgp42lwYWcByyeYsFBk1mfFPHiKAIY2lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8uMRjwRk2NOTbpWwOKmCJ7WQJKbF9fG4/3OIt+jNr3K/KS5D
	nsWzKrUZRrkMfQF+9e8e1JlUUnO6wKLdXKD09lg51aNP0QxAxEq4Xbwm0l3xPoZoP9uyWGm6jW8
	cOPTnBuogqQ90OqYDFnmPNzk5s/dw75xcvQoL79mEhg==
X-Gm-Gg: ASbGncs/GAdtwAfWmYLIHxyU7jTQRv52YeeRyd8i4bzyVPd+3SVp4hqOqydo6SHdshI
	37O3C0SF9MeJFtuik35rowtWVKJRv5IsJZ4lU68Qt4d9LjCkiYBHN1rtTTWp2FQl4mbjDV9WD47
	soJGpPc1WrkW24zknx1/R/wYkffoX6djsnhxEkA/EGReFJlv4MLIEWNZIllf0WtnRN1UIyA+oW2
	0/UohVQMv581gEXjVpi3tDplITfM2+kzd+zki46pMSPxfSKpECJhuE/SsD3z+bnELbe8VsgtfTl
	tcBoXzuRXkMQI4LDxiv+yZf2WV0=
X-Google-Smtp-Source: AGHT+IEeA2MlI3JrK1vn3lEmeQsXIQ9eQp9us0I+JYX+0qUqjPDNcKyIq9tYmQgbg39crSEorsfXs+YtJFZeiSxhvQo=
X-Received: by 2002:a05:6512:33c8:b0:594:3567:e835 with SMTP id
 2adb3069b0e04-595842523d5mr6058585e87.35.1763561385570; Wed, 19 Nov 2025
 06:09:45 -0800 (PST)
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
Date: Wed, 19 Nov 2025 15:09:33 +0100
X-Gm-Features: AWmQ_bkuL9SC7iST13IM0z8S8Q9KRGjjeXzDaed4bWZ13HYvJ_YIUtsuMOzhJkU
Message-ID: <CAMRc=MebbjT7QAn8M0q0MsbRhTA-CUNKmo4nUPgXBXrmU-4D6g@mail.gmail.com>
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

If your solution won't work after all, we can try using machine lookup
instead. We have all the blocks except for support for the "undefined"
GPIO in machine lookup. That would need to be added.

Bart

