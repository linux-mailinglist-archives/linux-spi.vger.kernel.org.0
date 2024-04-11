Return-Path: <linux-spi+bounces-2316-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C83C8A1D29
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 20:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768B71C23DAE
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437F01CD763;
	Thu, 11 Apr 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHj21U+8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1391CD767;
	Thu, 11 Apr 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854287; cv=none; b=WlfM65xbP1hGDeij1k25VylUwLsaPNQG6V+UhcbGT41Qb6hMRL6amYsvKVM8+ySJwWmzBKZ3rUFIJ3njjnZov4NRS1iFtFWi+TvZH+dtcwTMzS7AqPZ5oFEQaaFx4iS1cvmpC+s9SGQp3UP1AI3TfmlNEzw7yyrzTohlauGCpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854287; c=relaxed/simple;
	bh=2sjusYdRY13jqqn7q4dUiA1U8WEotLQxuNDEWnSd7b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfW1FNu+n+1hrS16LUBR+o0mSt/G3DjcZ8Ff3qQbQtyV4mGIOko7GBphog/YoIeCljdfZFM5Zxhf1hOaPZg/XyyIb+re976rr1XjLVi3luCjvaZXvqt/9xK/dsLvaH5xK8qoSQXYga+XRpDwYqZgL6fLhJJpmNy2z3gIkmLpApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHj21U+8; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d700beb60bso129674951fa.1;
        Thu, 11 Apr 2024 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712854284; x=1713459084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQSyDdBlnmYdTQ0HjAL4WennHKHAI1ZTY47Qb1fxIlE=;
        b=VHj21U+8lQNe/4PHLSJ72xGDWe7HSzsUJ+pEEoYX9V7+pv1bh7Jj2zvb+XSbjaC9lC
         VUDivwAD68YBC0wFumfe2xzSsUrHHpeK54/cjRv15SzhyTT9eE1wWTMShIX1iaQ30jPK
         edigeS+MfQ/JnuLCY2LVd+LYp7rDWtYh8LOUKEhHdjq07YVlBorfzhEtCdY/1i5e+Q/o
         ZZfAZF5zCKeKOuuHPky7XWOQYdGgFlTJvdU++dRWvBdvowDBpKBL414wqH7BrH6tS6lt
         hdL6z28Z5AQEYA1kXUQLQ/BZczZRwX4S5H6j2kYTXoe5FW7lFcx+ggz9QrGww4uY34Jm
         hp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712854284; x=1713459084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQSyDdBlnmYdTQ0HjAL4WennHKHAI1ZTY47Qb1fxIlE=;
        b=GyJ0c60OZxyl+yiYj1qJdmHcaeqcwb+PA+6O5TY41KopPXQi5+7+5Zpd9j1BYtCUN/
         W+J3YtMH+JMNfuFYsTRmPx1oNbQVNOI9OcTOuQlsNjLk32GkvmOvjRe0tJVH4ce8xoAg
         Lqp/QxOvnUPblF3WtBTFu4Vo3wPd2WVM+gcaAtxtUcBAUuMeiRAvyoPXIEf8Zp0qoBGQ
         hNdjGNttSglHjAdsfJFuLNt3PzxF4Pu5T9cPb1FldqoIiDGNYkWz4lTEd588X2sV3D2I
         ZEYv+vAIEyF6gC/YLVDSCVGi67kLoDNIew160F9z1S9idkzCXyuMp5W3eX9443UOcYMt
         93mg==
X-Forwarded-Encrypted: i=1; AJvYcCVLKQBAAQQAxYPHmTWAUD5ZzrsqVmjmoZI+iKOe8E/3+sWok0h0c0SkPIqiGIdOfTOuDk6Pe2Ad41iJX+A0lxRNBk6scBrObscWKnY7FaWXxX/H/HqTiMC5UdOgroavzH7Kdl7+eQ==
X-Gm-Message-State: AOJu0YzR+g9ptJdNbKyjujgc7u1naN0CIq4Xljuq+hrYSmDYTCpuajwQ
	bstNn9YdudR7fUEVppF8G9WghUv/o0BeaLfP0eHfIbKCMYrmh93fpV8Oaj50fOuwmuWh7wmHvF6
	xI0Te6rHpSWGimVrBePCNKIvYVSw=
X-Google-Smtp-Source: AGHT+IF5710VrqXYli3lbCaE8SNNq9QQxEZ6NGodoly/vicd6Kg7iL+c5oFtZO+JtREDYtjGj5yu0bsRFKWb2dGXUp8=
X-Received: by 2002:a2e:a451:0:b0:2d8:d972:67e3 with SMTP id
 v17-20020a2ea451000000b002d8d97267e3mr188248ljn.5.1712854283473; Thu, 11 Apr
 2024 09:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-2-ckeepax@opensource.cirrus.com> <CAHp75VdV0JEX6NkRz=c1TLc7fxdo9EJeBW++byJ6u7ofrTVsdQ@mail.gmail.com>
 <ZhgTeE1JKAJ4Jhbv@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZhgTeE1JKAJ4Jhbv@ediswmail9.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 19:50:46 +0300
Message-ID: <CAHp75Vdb7Op-ddo5RxZuMYLFBjGbGxtQaZA0yE8pfXQBcLH5GA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] gpio: swnode: Add ability to specify native chip
 selects for SPI
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 7:44=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Apr 11, 2024 at 04:25:25PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:

...

> > > +config GPIO_SWNODE_UNDEFINED
> > > +       bool
> >
> > But why did you remove the help? Please, put it back.
>
> Sorry didn't realise you still wanted it will pop it back.

No, I don't want it to be user-selectable.

This is defined by a non-empty summary near to the type of the option
(bool, tristate). The help text is orthogonal to this.

...

> > > +       if (!strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
> > > +               return ERR_PTR(-ENOENT);
> >
> > This is a dead code when the respective config option is not selected.
> > Or actually a potential flaw if somebody else names their swnode like
> > this.
>
> Can add a check for the config.

Maybe something like

    if (IS_ENABLED(...) &&
        !strcmp(...))

...

> > > +       ret =3D software_node_register(&swnode_gpio_undefined);
> > > +       if (ret < 0)
> > > +               pr_err("gpiolib: failed to register swnode: %d\n", re=
t);
> >
> > Instead of this prefix, define pr_fmt()
>
> Little iffy on this, there are other prints in gpiolib that do it
> this way as well, I guess I could add a patch to convert
> everything but its starting to get a little out of the thrust of
> what I am doing here.

That's why I'm talking only about this (gpiolib-swnode) module where
you can have it as

  "gpiolib: swnode: " fmt

or alike

--=20
With Best Regards,
Andy Shevchenko

