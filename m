Return-Path: <linux-spi+bounces-2322-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCCB8A1E7F
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 20:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3941C24F18
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173FA139591;
	Thu, 11 Apr 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3+0veoI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724DD38DF7;
	Thu, 11 Apr 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859030; cv=none; b=aThJpBYiuyyaIOfwlSOQjkkSmRCzwTaNC8V/AJniwO+oj21S8K1V0/rbMxvt3W0LPi59wynFAdYBKmmqHZD3aoVY0+cC1ahZQERbu39CYBUYiV898gm9B0aPPEl8H/3myw2HDfRSL/rVWZfKLlrMIOstY84jvgx0HMCfvhRS4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859030; c=relaxed/simple;
	bh=8szLF3Be6MiFMBH+72Jwj9Nf7maFx29q6dHFoQX8xVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwbjTNTqbA/YlsL0ZSuOzMZbtcpHylgHnTje5DoQ/PA85NJsUwA4jJ9zZSnf8kIyWM47xPCOYrBtopRxXz1MvVdGOjl7SLElNXzAzxxCqY6jOlX26ywSTMK5OQ7MXJNEbq2qI24UvUhmfqdTcT8omVxqmtXwNlmA/80t4hDLedM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3+0veoI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d6898bebso131158e87.3;
        Thu, 11 Apr 2024 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712859026; x=1713463826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8szLF3Be6MiFMBH+72Jwj9Nf7maFx29q6dHFoQX8xVI=;
        b=Q3+0veoI3xorzbDJjO9CCpNmi+7Mnnuti7v9e6b8JnTg+oAbopnoiA3phWvZd5LsBy
         SPzNYRLobicJ388GBFQMfazlSRTE5bvmWeMcnTocDssDt4PCvzu2Ee2m9JNKyU6wPGul
         iXsEYTRKiwJ0FqH0YRPT7H6jx8YK4gpFl21yyn5IfRr56ptDvsbDVwnBRaaNbjQaFVtG
         ACACaO2ieMHDM17UVFb/3KXISEEhaEINlJ03LRI4L2orz+ohwQPfVfTo6ZGnAloExvQs
         /8cLoJwkzRnSireNEdZ7xhKFwaks/XsgxLk/Gf4zTmPy3wrqbJsfsfhOAhz8Wjvl3Rvh
         zXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859026; x=1713463826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8szLF3Be6MiFMBH+72Jwj9Nf7maFx29q6dHFoQX8xVI=;
        b=hIkplTQvWd7cO6nsTxCOmLZfffxhQbonvHSP3TYeSrexJmJsexVxSbZs5/ET4shMDZ
         wYRM2gILfmllin+v1IEkQSVKnoslV6aEUEEJ6I7l/TI312ZSWwaDOFeIdTsRNLe+h1m9
         mh0MhhYVkQRwfKmU5zyREWVRBJT7g+sLFebeHKmMGr8PvNVTeeniGaA2ZH1hjE52IwqP
         yY9c/rqFJLr34gF5HPRebN7gz2XanJzakWMos6aD3bPgCpJ0091GF/YbArvdkvIrtxg9
         nlXSatE7P23ZbLiJ6KxG3xeVFBGTCb8L+y9kLQm4qh0hupgt4uabaowqVmqynJgJhkv4
         ttpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVBq32Jk4ElS6IVf3oX635yJEZa9A8A/D/pvAp4N/fJeiaNY3xDFe2DwDyUof3S5rha5NDeGGRDoKxjazrIrdJ+61VVSGCyisnRc7F9uqbWbWSXzYWNe6VQ2cNrVvtWWWc1MFJtg==
X-Gm-Message-State: AOJu0Yxhoy4B7LT5J2esjr5k8IxCnBGgZNd/Majeuqur1RJcfXObh91N
	x+kpQYf86ShGUylhSuAIZ2JL86FEZaZvcURXYw0xc+hiOysk3YfkHFek0YdJM01kSMX0dY/dFkF
	yijc4+rney3g0sWDzlNAP229HOHo=
X-Google-Smtp-Source: AGHT+IENHwEfhT+Iho+3R2jMiSIZ6/h1c6Pa5kmxrXUUl9DfZ67ktolPf6CARZf/+kINif90bGq+lZWk2HE6okHcHwE=
X-Received: by 2002:ac2:4846:0:b0:516:d1cf:d9d9 with SMTP id
 6-20020ac24846000000b00516d1cfd9d9mr274722lfy.62.1712859026284; Thu, 11 Apr
 2024 11:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-3-ckeepax@opensource.cirrus.com> <CAHp75VfAoKvvnQr74-rpJhEv=U=o00Doji-1zuV3-_+n+cbVVg@mail.gmail.com>
 <ZhgWMK7HU2jmsmTq@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZhgWMK7HU2jmsmTq@ediswmail9.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 21:09:50 +0300
Message-ID: <CAHp75Vf5YRo9hCeT=4E+UP15ORTLSd=RbZp5auGYcFQBgtJF7A@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 7:56=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Apr 11, 2024 at 04:30:13PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > >
> > > Use the more modern is_acpi_device_node() rather than checking
> > > ACPI_COMPANION().
> >
> > I don't think it's valuable on its own. There is no clear motivation
> > why to do that, I suggested it exactly in the conjunction of not
> > introducing two ways of fwnode type check. That said, you probably
> > want to elaborate the motivation in the commit message if you want to
> > keep it separate.
>
> I am really tempted to just drop this, its not necessary for my
> changes and changes something that is unrelated to them. At the
> least it belongs in a separate patch.

Okay, just elaborate in the commit message that this is done to make
new comer not to invent its own way for fwnode type check,

...

> > > +#include <linux/fwnode.h>
> >
> > This header is not supposed to be included by the end users. property.h=
 is.
>
> Fair enough will update, although I really feel these headers
> could use some annotation if they are not supposed to be directly
> included. Either include everything you use or just include a top
> level header makes sense but this weird mixture we seem to use is
> very confusing and I don't have a big enough brain to remember
> every header.

Rough hint is to look into the contents. But I agree, that is a complete me=
ss.

--=20
With Best Regards,
Andy Shevchenko

