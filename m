Return-Path: <linux-spi+bounces-11158-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D36ACC4E1F5
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 14:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E4347040
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BE733AD8F;
	Tue, 11 Nov 2025 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="ih6ybhPX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A50133123A
	for <linux-spi@vger.kernel.org>; Tue, 11 Nov 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868005; cv=none; b=hwrGlJAZE8cubEx0SKHN5puHiAJIXOUGMRHCrQEXGsMOHkQqO+OPBJp+fyjuanMW1wMLu3lRYYK7mAuDNyLhE0VHs/MYvt58VEn/A2ofcEI+NjQbBeqNZI/VbPIe2Dp5uYXGoksicAUvOl4fGkekxq/pxqW65hzG7dUP6yKkbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868005; c=relaxed/simple;
	bh=m/IDcbUYaTlqaJOcWar+0Jl6b6b2/gJXupbjxTarers=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axGY+6hJ2k+qpMC4aPyosrxcv72FzrdesYJCNp8r62CPPu0GUuvA96P/7QmQYzjzhzkE8QAoU67xa2GXfoESBgH/Z28IYOiHQF9KIuxtAhiUU4swmFHWgUGaq5hJm1J5U8pQZCproQOo+g9gBqSfGB+oM5Rym11FlKTY6I8/NeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=ih6ybhPX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59445ee9738so3257504e87.3
        for <linux-spi@vger.kernel.org>; Tue, 11 Nov 2025 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762868001; x=1763472801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lY3yD/lWkhxBE38j+dUGeqe89ypJFm7YKL/U6lIARs=;
        b=ih6ybhPXbqtT8us51h/YwWyVZ9wcl99rW3342DSYuZA6MsfWJX/+RTijmuAGgNOgr7
         ZCLbtKuYI2jn8B38r3aHofSHCteMAzdlkJVisOuiy7yxJXiPI+HXxjcMbwG4RwMcclqm
         bn1Wn7GNBYw9cX0I/OfJDZsoayVCsHR0qwVKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868001; x=1763472801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2lY3yD/lWkhxBE38j+dUGeqe89ypJFm7YKL/U6lIARs=;
        b=gNsgJRqimV10gYDIM8Q1vf6xCcSsNZIYIkT/Y85HNSxeH8mus3OMgVKP9i5GeF/8MJ
         YPMmhVbz0oHiXFv2Lrm5yrJxtkBIcjO3IlH2sS/VBqhaZTs8u+aDsXg+oK9y9P7B427q
         UAjZ/6SSKgPCwcxbgdgNrHHEJXIhT4A/C3pHiZsQE5Df5u2b21qhiWVrOUjtrNjtP8UZ
         xP3c04h/QmggW8JyzUjPFRSR3gbnKp9eoNvN4eLcD4z9hrlhGXaHJvlCQxRqe8Jum9Pn
         QUapgRgDD+vGGmjhHuf7og1GuzQR2/HvG8KLFpupl0MRP8xW08i9T03fqZCjhEAKlTMB
         aLLg==
X-Forwarded-Encrypted: i=1; AJvYcCUVw2mMHkFX8AaA15z4Wf72/PFBOQQBdAY73bosxOjfOSwQpcX93W6+pJLHG/A66R4yUQZKHwUy2PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVSFF1kiEWf/UhnxOhZ6NiIy4Jj6NPzR5bmxTZ8Dbl/j2hPUvw
	S/rHj69CV7pWNnvpVW1mwj48j6ey01y1PC8ItT7uWoUnyCZT+MIXNbvfagfYLX4TDsT+LaHSzYS
	nywh+EgUA3SlxOMIPClNNg2J+fqZetEE1s+PoVDru5g==
X-Gm-Gg: ASbGncsRvyIoSGWq8yG1JzoOHtvdjvFDOi05YuM1hfXeEI+7gVdgWQpIPAnc9Mnb1mP
	V0vXBn138lSURu0BHHWNe1DmHPGkcK/j2W6tco68sRQLErOjuVTdv50uXKM8ZH9KJp1lIpcWv+9
	ZJj0riOm3Ji2u51/pVNo+pgEdO5Sgp4z1Y/4cVKek3yT8AdWmqzFTI+4+nevVWaR/YehRwK/yPe
	q+yDHNNUaPvlEi2LQCNuKJcTuz/heI3ThYlhPeIw0NB8gs0GCqFFki0xWXs1Q==
X-Google-Smtp-Source: AGHT+IEa2+alpsV7yZo2MQ2zemGQSgaZflRIFnqWJ5eOZ/bg4aVTD1e/Z7u7RDia8HjsH2yeWCn923dhPxhZxjFLNYs=
X-Received: by 2002:a05:6512:61a1:b0:594:51ac:138 with SMTP id
 2adb3069b0e04-5945f165199mr3017960e87.2.1762868001402; Tue, 11 Nov 2025
 05:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106153119.266840-1-r.mereu@arduino.cc> <20251106153119.266840-3-r.mereu@arduino.cc>
 <84f0ed2f-bf51-4dd5-93f1-f26e077a2549@kernel.org>
In-Reply-To: <84f0ed2f-bf51-4dd5-93f1-f26e077a2549@kernel.org>
From: Riccardo Mereu Linux Kernel <r.mereu.kernel@arduino.cc>
Date: Tue, 11 Nov 2025 14:33:09 +0100
X-Gm-Features: AWmQ_bl9u7adnSSXNZGOLBBGiNfZ8y3mPpTDmoF7L_YWRx9FeA-avTcHCLCKRGM
Message-ID: <CAKA1JhYTC5p_7Zj9b7g1YKZhjH0=tnnJkdW1rWv39L-SF-SDoA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drivers: spi: spidev: add compatible for arduino spi
 mcu interface
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org, 
	linux@roeck-us.net, Jonathan.Cameron@huawei.com, wenswang@yeah.net, 
	naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com, 
	chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com, 
	farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, Riccardo Mereu <r.mereu@arduino.cc>, 
	Martino Facchin <m.facchin@arduino.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 8:13=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> > ---
> >  drivers/spi/spidev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> > index 5300c942a2a4..f0dd516c2083 100644
> > --- a/drivers/spi/spidev.c
> > +++ b/drivers/spi/spidev.c
> > @@ -704,6 +704,7 @@ static const struct class spidev_class =3D {
> >   */
> >  static const struct spi_device_id spidev_spi_ids[] =3D {
> >       { .name =3D /* abb */ "spi-sensor" },
> > +     { .name =3D /* arduino */ "mcu" },
> >       { .name =3D /* cisco */ "spi-petra" },
> >       { .name =3D /* dh */ "dhcom-board" },
> >       { .name =3D /* elgin */ "jg10309-01" },
> > @@ -737,6 +738,7 @@ static int spidev_of_check(struct device *dev)
> >
> >  static const struct of_device_id spidev_dt_ids[] =3D {
> >       { .compatible =3D "abb,spi-sensor", .data =3D &spidev_of_check },
> > +     { .compatible =3D "arduino,mcu", .data =3D &spidev_of_check },
>
> That's way too generic, IMO. First, I am not aware of Arduino boards
> mounted on top of regular development boards, so basically you are not
> describing actual hardware setup but what could be potentially plugged
> into box with Linux... and then it is like saying "you can plug
> anything" because MCU covers everything, like calling it "Raspberry
> Pi-clone".

This is used to describe one of the interfaces between the
microcontroller and the microprocessor on the Arduino UnoQ board.
Since this could be used in other layouts in the future, we thought to
keep it generic enough to reuse it.
If this isn't possible, do you have any suggestions?

>
> Best regards,
> Krzysztof

