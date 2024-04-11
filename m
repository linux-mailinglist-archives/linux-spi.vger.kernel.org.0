Return-Path: <linux-spi+bounces-2309-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE27F8A1597
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 15:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9711C21F21
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 13:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE5114F13D;
	Thu, 11 Apr 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJInenRC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A514F13C;
	Thu, 11 Apr 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842422; cv=none; b=f3OVZsXGZOY/DVMrDX5DJsmOBjbEi0kvF7VeExAIozZfe7rqAqLKl9sQaPaHmYk5UrDid9gJBB3FfVPUKpxM54hiThhZQlFdU91n5TZ3nj53hI5Ql1Li5iIzpqXwGwMtNqiZ+WDy3YVot9jCrKgI99rFiK4fpKww+UEe6GXM9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842422; c=relaxed/simple;
	bh=GCnDbU+fphI4kMLD9SH/9X2lG9saMzgULom0hdFPNFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nlc/OwYXM0i7KrEqyse6PgJNPyRbPg0dWEKESXqz+03sdBKzwsSswdHrTGGevjKVlzAMIKlw/p476HlJxemiCQu9MdL22k4XG5lF+r/XhRV5EyYxRarSFE5yanHecdIV9isPJD87HY+yFgGgkS6jBOUt6E594L8S7r9RF5S//Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJInenRC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a520410b7c0so275178566b.0;
        Thu, 11 Apr 2024 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712842419; x=1713447219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKcSDuLsn6a4W8tZV5jVbqCdko6prRaDO3N8hpEcSUU=;
        b=BJInenRCJBCxY97UAvD/Wc5pfyqRfE0/En+1alODUSpQROGyaMqwF+DuSsRe/IyoI4
         BwpRvWVxXjUlz1kxdvKIZvggm9RUW+0sHZq2dpQcciviLomUbHo9Cvs+rrZtxLJFWgIE
         Q0d6xQ5RhL7Ng7JMxgtZQyYry+wEProjlOEUqsNLGfHXLgNOGQewOynivWEhVlKMZQz3
         ujWUnB5u4BpZj2jgx0CIV5sUIOUTU/W9tPrBqyxjnXtT8Sjto+sAbwWGbAoon30Dbl2O
         HVg4ZDJKjQeZueXu2kRVOOdkiNsJB1IGaO1zDB8NMEuCsLw3e8jKhBpgQlb9W87QIvZw
         eRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842419; x=1713447219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKcSDuLsn6a4W8tZV5jVbqCdko6prRaDO3N8hpEcSUU=;
        b=NGhO42qoNG+LHRRedB6JRA36OXSbDdw4H8XZs5MZgibGw10uJmRiXe90br+1XYjePK
         C3V06qRzZwYKm2mZqRmhJ/eOa4rDMLUXVG3rNRLmqHHILSbugQMtRpDYHoAqjAfWgolC
         yFipMO/bi5r2OGW9H9rIgysu+wdXMuf5M1bUTw9cJ3eoXH/Yv4SJ3JxHgFuBPndj8b55
         l4mSvHtZ3MXCY2/9Vlzyc5uRBHLFZWtf/lERUFY5A3+yooy9My6WAEJUGIt3nFikM9LT
         TsFfoDpvrxW5mr0nzhB2VOIgDRjQJnZwsyTzWQb3Us9PSE7TWURGH03U8z+pxxIK2DYI
         W+8w==
X-Forwarded-Encrypted: i=1; AJvYcCXwVjvRUVJBXkfp01PCfOpCKVE9/SrnF48vKWBy1xk378WBIMCU+fwLWNI1ktyUzCIGcmvV1SBrZ4PueCRtJIb9aybssRcgPz8ALer24WLLPyGHGEuzZYnIrca1GpzqE9VmY2vyNw==
X-Gm-Message-State: AOJu0Yx+bLebEFyHQ4h0q70U4R6A5Uak16TCYVrShprAWLfdBkxAPoqX
	BslHvg+30nMYVHtx5ESbcbIlo5zAhZbKB3kl/Qz/gS+zKoypqA3hLygmjIG0lJlv/evCh/PB3cw
	6qMzxgX6pgh4ERd4JfVW6WHzfgoiE+/lS
X-Google-Smtp-Source: AGHT+IE4GIGbgs8/1Ous947RQeWR/01AFQ1wpELL3Kfr8jDuWzWyoHVBe691Hgkih/wqzZzf3cCuC0Goe/L4kgBFEdE=
X-Received: by 2002:ac2:5194:0:b0:513:d246:6e65 with SMTP id
 u20-20020ac25194000000b00513d2466e65mr3114710lfi.50.1712841962275; Thu, 11
 Apr 2024 06:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com> <20240411090628.2436389-2-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240411090628.2436389-2-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 16:25:25 +0300
Message-ID: <CAHp75VdV0JEX6NkRz=c1TLc7fxdo9EJeBW++byJ6u7ofrTVsdQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] gpio: swnode: Add ability to specify native chip
 selects for SPI
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> SPI devices can specify a cs-gpios property to enumerate their
> chip selects. Under device tree, a zero entry in this property can
> be used to specify that a particular chip select is using the SPI
> controllers native chip select, for example:
>
>         cs-gpios =3D <&gpio1 0 0>, <0>;
>
> Here the second chip select is native. However, when using swnodes

Here, the

> there is currently no way to specify a native chip select. The
> proposal here is to register a swnode_gpio_undefined software node,
> that can be specified to allow the indication of a native chip
> select. For example:
>
> static const struct software_node_ref_args device_cs_refs[] =3D {
>         {
>                 .node  =3D &device_gpiochip_swnode,
>                 .nargs =3D 2,
>                 .args  =3D { 0, GPIO_ACTIVE_LOW },
>         },
>         {
>                 .node  =3D &swnode_gpio_undefined,
>                 .nargs =3D 0,
>         },
> };
>
> Register the swnode as the gpiolib is initialised and check in
> swnode_get_gpio_device() if the returned node matches
> swnode_gpio_undefined and return -ENOENT, which matches the
> behaviour of the device tree system when it encounters a 0 phandle.

...

> +config GPIO_SWNODE_UNDEFINED
> +       bool

But why did you remove the help? Please, put it back.

...

> +       /*
> +        * Check for special node that identifies undefined GPIOs, this i=
s

for a special

> +        * primarily used as a key for internal chip selects in SPI bindi=
ngs.
> +        */
> +       if (!strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
> +               return ERR_PTR(-ENOENT);

This is a dead code when the respective config option is not selected.
Or actually a potential flaw if somebody else names their swnode like
this.

...

> +       ret =3D software_node_register(&swnode_gpio_undefined);
> +       if (ret < 0)
> +               pr_err("gpiolib: failed to register swnode: %d\n", ret);

Instead of this prefix, define pr_fmt()

> +       return ret;

...

> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h

Why? I already said that the best place is gpio/property.h as it's
exactly for swnode related code.

--=20
With Best Regards,
Andy Shevchenko

