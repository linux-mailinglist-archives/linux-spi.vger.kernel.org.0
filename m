Return-Path: <linux-spi+bounces-2225-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9A89C963
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB76E287BD7
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434EA1422C9;
	Mon,  8 Apr 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhrK2cBK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7165C13E3E7;
	Mon,  8 Apr 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592728; cv=none; b=UqeAfxqESXzKz0UnpjU8qvar59Y4HFXcF/Z4anJ4Z/qKkXaGvQjvusGGtRdW3NzeouN+0+TJC0XnJfKXQ05S0/b4nk6ujJbXA227/e1b9q/cjYHmuVBxcGnWQmIUssPynkAKTQKQZEFwpSrmFj0NtnCayfuq9k+Yi9Cb41ytiaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592728; c=relaxed/simple;
	bh=DB00QQXzi4xoHbDc5i8wc+FwpheaVMBne8m5kd/5+5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKbWtxy74suaXxVi7WW/6Wb/Q52b9XyHtQp+GPOBLuJAL1GkPX11rXTNujRiBOumFxYsAFMR8wstTcS/1xgAcXL+/4S1WCqxXXtSMnJQ1cFxFWJ3UUUEGOaK5RtmR25F/gML++asnQ9+PDrUN2ZNGDQcXRLwh2zrnhVRG8UJ2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhrK2cBK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51a7d4466bso358999166b.2;
        Mon, 08 Apr 2024 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712592725; x=1713197525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIfb30IQ5nVXGYvpbE1srfV3/j/IlpRzx8/7nKXBLp0=;
        b=WhrK2cBK/P9inuf3xaUzHq10GiSSLfGp6BygtX/wjG0HfUPSnHH4y6psxGUgUK/wL6
         WjFd18uQztCdWoTLPk4GhHLmsqqPtehk1cxA+fAtWru9KNLrpjXfl7x/NB9m3vNZSqn4
         7AiGZjcX0X1nBfCkZNBQN4C/eTJApRSiDlhOV8YumnLP/AFRXcq6ZUypGUZ9lHL6JcBv
         4bg66hJKz4dx5IW7KEEM7RBI28TzLggZoZk0H9UhVHVbpw6MqWO1pLrsILm5M8RE0qoJ
         h9NYvBrMGyQIyhrdRyjhqYQF4PKVndoHEfzXeztlgsOCTObI6XOVyKuxk8UeKVp4F1ZE
         HDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712592725; x=1713197525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIfb30IQ5nVXGYvpbE1srfV3/j/IlpRzx8/7nKXBLp0=;
        b=DH9tuO73pQ+9ypmmo/GonobuQfz6STnWiszJTIpVRwcCyawQRipsBJ69mLMfE/LZ2r
         MKFhuZSMIQ324eQMcyNywG9fUssUiX51QAbfDnoGf4B5sb0SwjzwTfBa9RX1c1FEChT1
         YmA6WoGXoOU7nRslh6vVWGVUjrxMOr5VlhGEkiuhon+/UYi9suG+RI06GU0r+CMD6S2t
         op6HdmRaAr5lBZsxKJ8uYh1l8516d2i4EQ1eaYEo++SQDUf+w3TuJeTxzZTEb3/5oEVq
         1pmFU+azv2LmU3f37qJewBIOqjXPHKaFnJSnchwlm470E+LMRi2KU9FF7G6DOksM00IS
         WSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvQFIAX84rmMEQ9c9Nl0fU+hPR6joiptSFg1yoyEe1ldlmtVZYtBAVDJH0M1RhDz2ceVYgMWugC0JbBLj+yH4mbQwmM6/HBKiNK+GvykY+zzMy3Or/02yWYp28E8w6FNXNdupFdQ==
X-Gm-Message-State: AOJu0Yx8PhD1H2df1Ss0BH25N17MwGirsC837dKVcx7ourJlBzA4Zxdh
	NPz0tNsHAruYCQsUeVBRY7s7EsbcAbz47wo9YigbCYVhzjW+XzFRWLd2hL4zpuoTk7MCeOYbZgj
	TSXpndSFUVbg3Qs1JVxdtL3BzQPD0MJbR6e4=
X-Google-Smtp-Source: AGHT+IG15U1akHtkcdEoPTye4ES962SAQdHyvH+j9CmtZtLyOMDWt3d3cnv3n3Nb2/ZkiJq0+hXKygfzR+u1o8Rr4nM=
X-Received: by 2002:a17:906:495b:b0:a51:e2a0:98ed with SMTP id
 f27-20020a170906495b00b00a51e2a098edmr764985ejt.4.1712592724551; Mon, 08 Apr
 2024 09:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
 <20240329114730.360313-3-ckeepax@opensource.cirrus.com> <Zg28J59MRvk3B-_J@surfacebook.localdomain>
 <ZhP2fPYd28sXw7EZ@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZhP2fPYd28sXw7EZ@ediswmail9.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 8 Apr 2024 19:11:28 +0300
Message-ID: <CAHp75Vc1Wt0sERNfYsyE4j+RHzAVGigf_5Ng2Bit1HUY=t+Fdw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] spi: Add a mechanism to use the fwnode name for
 the SPI device
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 4:52=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Wed, Apr 03, 2024 at 11:29:27PM +0300, Andy Shevchenko wrote:
> > Fri, Mar 29, 2024 at 11:47:29AM +0000, Charles Keepax kirjoitti:

...

> > >     struct acpi_device *adev =3D ACPI_COMPANION(&spi->dev);
> > > +   struct fwnode_handle *fwnode =3D dev_fwnode(&spi->dev);
> > > +
> > > +   if (spi->use_fwnode_name && fwnode) {
> > > +           dev_set_name(&spi->dev, "spi-%s", fwnode_get_name(fwnode)=
);
> > > +           return;
> > > +   }
> > >
> > >     if (adev) {
> > >             dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
> >
> > This should be something like this
> >
> >       struct device *dev =3D &spi->dev;
> >       struct fwnode_handle *fwnode =3D dev_fwnode(dev);
> >
> >       if (is_acpi_device_node(fwnode)) {
> >               dev_set_name(dev, "spi-%s", acpi_dev_name(to_acpi_device_=
node(fwnode)));
> >               return;
> >       }
> >
> >       if (is_software_node(fwnode)) {
> >               dev_set_name(dev, "spi-%s", fwnode_get_name(fwnode));
> >               return;
> >       }
> >
> > i.o.w. we don't need to have two ways of checking fwnode type and you m=
ay get
> > rid of unneeded variable, and always use fwnode name for swnode.
> >
> > ...
> >
> > > +   proxy->use_fwnode_name =3D chip->use_fwnode_name;
> >
> > Unneeded variable. See above.
>
> Hmm... I guess I was viewing this feature more as something that
> users would opt into. So other firmware mechanisms could use it
> if required, and so most swnode based controllers would still get
> caught by the standard naming at the bottom of the function.

software nodes can be used as a trampoline for old board files (in
order to make the driver cleaner and prepared for DT conversion of the
board file in question) or for quirks. In either case when we use them
we really want to have their data to be propagated unconditionally
(just based on the type), the (per-subsystem) gate is a carefully
placed mine on the minefield.

> From my perspective it will do what I need either way, so happy
> to update it to always use this for software nodes if consensus
> goes that way.

Not a maintainer here, ask Mark.

--=20
With Best Regards,
Andy Shevchenko

