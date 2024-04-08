Return-Path: <linux-spi+bounces-2224-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD00489C958
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 18:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFEF2860CA
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6D21422AB;
	Mon,  8 Apr 2024 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0HNiFlb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227E913E8AB;
	Mon,  8 Apr 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592515; cv=none; b=svcdRzf9m2ocIKjAyDbIldsYjfUNHVStSw5wUEzPQonU623LEtis4+HF4iofA2ZHhK+4y90NRcsBGXmHaRJxjEOyZivg94+e6v+q8qcopbe7n0QD6sFl0pvUSpZjVJ7guqpeLG11DBdy6A5Rmq/9Ps5ZZTlHSAuSO7UhcChPbqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592515; c=relaxed/simple;
	bh=LuK52G68sV8wmG51vDdU+FBlJoogw177YUbxkO4TPXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGBomPWSwR26N2DcECY0RdrdoV6cwr2gZyYL5Nm9sLxcJWES6mxpnE3exiXaXi3MJt7muSyS2Ve+OLdzmMv63zEfihXquk5p94PHn3K4cW+xOa43ATmJGSRjkwkZV/sFVyvkXTy7QQzdBk0BIIPnF/fJZUyIpaEv8UsrCkKTl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0HNiFlb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51d90def9eso136121466b.0;
        Mon, 08 Apr 2024 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712592512; x=1713197312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LddNB/SlR7VWoe9W9ijRpH02JJqnehM5Rk6HpRI4lyA=;
        b=a0HNiFlbgHEulNm0XSBOejZTRFNeK+4SSkGuV8Hbdnt8Az80WaWj40lzmyPZi87Kda
         MADvtjq02/IhgitK3iQOTfFQYg67k7G2rgMpuHuHLMIcSYcGFh5oblbDVLrHxxS/W908
         P8EoEQ8vlOWxu/Pt9nPzSA8pDxGUl/ONwIbU/dFG9R+2WlZit84B8rWzWo7ReAkJs1ca
         H4PRcV+T5TgoZIeLuUFzMYLhsL6cgCvaquXskd1H7put8fH7LflvRKeu/2Cqseu5JBXC
         oaRt4FLWrUX8SMykmXw8lwQo2/hIiA+r1oWphHaXIKsxuiwF4FiWZnKkGXjg6fQKhp8N
         iX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712592512; x=1713197312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LddNB/SlR7VWoe9W9ijRpH02JJqnehM5Rk6HpRI4lyA=;
        b=BPxJrFFj5rtLmAZP//XBOLuYgxvJvL4fr9vgUUv7J1e6CKmjsJFIzPKtIpSWdUhd2U
         bfuONhK3U2UoaS8AUYAmMsdGlA5uutfCoJcOwIqCzFU92+mRhN/8hxX9//SiSawtqXoR
         0Wo5C+eRtQ3/A5GFy3h2ZywmiabcsRKB9H/eWtGdyS8WoLlCeyR2gC5Vf888ukPJSiCm
         ArNYR5uh5OZ84wHQ6m/wMFmRAmwWLt4IWgMPtJSwSfQi2BgDAiPqSjA0jbQ7A2qE39VP
         Epo69WhSUk0WKeG65X8SsVZzFE3RF0W+Brh4HGLNGx6hlzibnxF/SwKHfT8zK34ihTCL
         9NsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQCip+WIviNq8+t0IaGtDR4u5RfyLgv3FAClFAvDYCwGIPh/JFrdXzBYFq0pelyH8tFPfPeNsTEjd1d9npUBrUmzv6hcPZ0Ifi9dkue8eX9HgWzS8bp0Gd08uTme2rWziIzqfBqw==
X-Gm-Message-State: AOJu0Yxgm5iVf2SxskD9jrBNQkixFjpekIdgs9l0W1Rpq6JXsn6jyHqp
	GHH0wlAQVWIDMzgmZGwqBqOl/UWlH2DDpD9Y3hdXO4TxvHiE5m0m6zw+BK4rahNi7u5VdWYeoqj
	j10GhWAAB7aaZsWecfLkeHij0JMuDNaDFw/qjFg==
X-Google-Smtp-Source: AGHT+IFYL9i+2WeiRWUNRR6GdDCbfxImfItNL4tU/+xdtZ9H2UiiK4Qh3ykh+LKtVVurEC/J0Vf1S1RCYo+v5qhHZ/4=
X-Received: by 2002:a17:906:4704:b0:a4e:2bd3:a060 with SMTP id
 y4-20020a170906470400b00a4e2bd3a060mr6137237ejq.64.1712592512179; Mon, 08 Apr
 2024 09:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
 <20240329114730.360313-4-ckeepax@opensource.cirrus.com> <Zg3AaNM0eizfC6Bk@surfacebook.localdomain>
 <ZhQO0vTvr67bR2O9@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZhQO0vTvr67bR2O9@ediswmail9.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 8 Apr 2024 19:07:55 +0300
Message-ID: <CAHp75VdJQd4bcJ4qfMfJvNnNrE46SHmQQiVwyJa-99Y5k50nsg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 6:35=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Wed, Apr 03, 2024 at 11:47:36PM +0300, Andy Shevchenko wrote:
> > Fri, Mar 29, 2024 at 11:47:30AM +0000, Charles Keepax kirjoitti:

...

> > > +#include <dt-bindings/gpio/gpio.h>
> >
> > Hmm... Is it requirement by gpiolib-swnode? (I haven't looked at the us=
e cases,
> > I'm not the author of this idea, hence the Q).
>
> It's required for the GPIO_ACTIVE_LOW used in the swnode stuff.

Seems to me like you are mistaken.
https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib-swnode.=
c#L85

...

> > > +   if (!is_acpi_node(fwnode))
> > > +           return false;
> >
> > Dup, your loop will perform the same effectivelly.
>
> Are you sure? Won't adev end up being NULL and the adev->handle
> will dereference it?

Yes, you need to check the ACPI dev to be not NULL there. Also note,
that is_acpi_node() is not the same as is_acpi_device_node().

> > > +   fwnode_for_each_child_node(fwnode, child_fwnode) {
> >
> > > +           struct acpi_device *adev =3D to_acpi_device_node(child_fw=
node);

...

> > > +           ret =3D device_create_managed_software_node(&priv->ctlr->=
dev, cs42l43_cs_props, NULL);
> >
> > No, this must not be used (I'm talking about _managed variant), this is=
 a hack
> > for backward compatibility.
>
> Hm... odd, feels like the function could use a comment or something
> to say don't use me. But we can go back to managing it manually
> no problems.

Ah, I was thinking that it inherited that from device_add_property()
(see 2338e7bcef44 ("device property: Remove device_add_properties()
API") for the details), but no, it seems okay to use. but then we
really need to be careful about lifetime of it wrt. other parts in
this code.

--=20
With Best Regards,
Andy Shevchenko

