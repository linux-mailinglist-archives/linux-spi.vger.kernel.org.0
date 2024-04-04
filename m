Return-Path: <linux-spi+bounces-2183-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BE28982F2
	for <lists+linux-spi@lfdr.de>; Thu,  4 Apr 2024 10:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEDF28C1CF
	for <lists+linux-spi@lfdr.de>; Thu,  4 Apr 2024 08:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850676D1BD;
	Thu,  4 Apr 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkUafOGs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36476BB5C
	for <linux-spi@vger.kernel.org>; Thu,  4 Apr 2024 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218610; cv=none; b=dIadAgwhkdB4pt7S10pJw5SyCUEbjvnLq5aeHu7T0qZqV/G0qApvkCW5IXFjoTIvTDQ1w+r6sp97exDAe0ZrQLM2JZH5y2TPf+F+M8VqaQ2nxSaTAR6z6d4N2j/Ohsenmd6igfdGr2C5a8YjalaqRPDTnSqPqZSnDwNrIxPQskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218610; c=relaxed/simple;
	bh=K2I4klhvcw4XgPm2iKkEVnDhpOsmF54u3TIBYldMFL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCJJxksKvwAI8XTpDKXIWVZCy4yoR07tgR1ev6rGvbErTyP5Vjb9GAJr0FPxLvDOsziYBvCnZt+zwNJPBJNyQPgufGQflorlEehU0QBr7E8p2uUqvIfWZHylDGXPAGChtc8QQqVKfZNh6d+LO6ovJRna2M7RQijUY8rEwhttVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TkUafOGs; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so789553276.1
        for <linux-spi@vger.kernel.org>; Thu, 04 Apr 2024 01:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712218607; x=1712823407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ye0eR6Apg8zCPUAz7DZfHM5W4XWEX+2e4HW+Aj34LPs=;
        b=TkUafOGsZo+wQyfJy9ZdvfdHYf3Nv3n3ZEa8xf4awQDc/Y/cnEoj26ecC0kapoipb5
         4uZzKrSh7vqfb4dGouk7P8TU2rujXkpH1ISIa0E1Q3CH9MCXwqS1/pku4NrFrLx+W1nW
         kWmMSC77NE901PbUde60YbdmfdJvRZXjFwdYZsXrht1afIO2M88v89bOp9q6QbJ7Mz3L
         lDj3xe4zQz71tn+R9RRHfSm0mYxJGPXhcp2Vk3il6FmSSXGA6f9tXUV+6y9WKZNl3gBk
         bHO3KAdQpRGfSuE8AtGMgt9RhjOzyjPDxNkwFAafX3paLrdHiyqvYhNZYdYP9YeQzK69
         TJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712218607; x=1712823407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ye0eR6Apg8zCPUAz7DZfHM5W4XWEX+2e4HW+Aj34LPs=;
        b=Z8fP9zAVC5+RczPiyVOStvtMFc7oXZWnBl+/E9tfMy0H1Db0HDMe61eefCftDop/XC
         OkkkR53jf528N0MjSQW5GXkrL97D2AbkqFAPuWb51Ad7/vZHYxBdcgQJMFPD8hp2I//x
         xKKTC6CyIXgTzQTXv2oNFqD8vK3XPUSqBbJ0IgYfsFkLRmF/5LD2amhNgWhGJJdfKne3
         AJT3+N0gClshxHKwyMsMuuEaDFGnRlUSNgwl1P7mT2XUMLdqoIfZhwKohM3KXHsscvIA
         qe3dj1u18D+2LEljojUup+aYaXb2OvmUst8mn94l/NrmM2csOqeoD/NGzf1Io1dSfI9L
         uR0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7QsxIuhJoaW2fhBc53NQ2IxOYzR5JkTMeEy+doagzRVPJQ10o7fRA2T0Hj7rI7Astns96oqiqmUd7vctgM5Rd9WxeFUBTpF/l
X-Gm-Message-State: AOJu0YzmoIH6JRHTBnKa1Aj98bmx6yWjENGmMB7+0oOfKgcPwKRJzC8k
	0VZRwhx9UprplLMFMvrQdOFHmHgWtr9MvrTgwZWSecCusCjFFr8wYb5YIcxDiC0NGsFJ/ppsJUg
	RZ4uYBT6CsE06QXlrwjVOpjWnkMY8bTY3Dc7YNAz5Vhnjq5tW
X-Google-Smtp-Source: AGHT+IEypxra2WuF2ceOV5Wbz7n/b6b/0RPPDoaoKIiMcDxbJLnm0mNJXKQ5l3SUFXjGXI9KiEUsQA963BRFGum+Hfw=
X-Received: by 2002:a25:880e:0:b0:dcd:a28e:e5e0 with SMTP id
 c14-20020a25880e000000b00dcda28ee5e0mr1686340ybl.25.1712218606807; Thu, 04
 Apr 2024 01:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326141108.1079993-1-ckeepax@opensource.cirrus.com> <20240326141108.1079993-2-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240326141108.1079993-2-ckeepax@opensource.cirrus.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 10:16:35 +0200
Message-ID: <CACRpkdZP_9y-Z=eZcbQe=ZF2ejutP6gD2ofTxXNvGTh7CUfwFg@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: swnode: Add ability to specify native chip
 selects for SPI
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 3:11=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> SPI devices can specify a cs-gpios property to enumerate their
> chip selects. Under device tree, a zero entry in this property can
> be used to specify that a particular chip select is using the SPI
> controllers native chip select, for example:
>
>         cs-gpios =3D <&gpio1 0 0>, <0>;
>
> Here the second chip select is native. However, when using swnodes
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
> Register the swnode as the gpiolib is initialised and
> check in swnode_get_gpio_device if the returned node matches
> swnode_gpio_undefined and return -ENOENT, which matches the behaviour
> of the device tree system when it encounters a 0 phandle.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Hm that's an interesting corner case.

> +const struct software_node swnode_gpio_undefined =3D {
> +       .name =3D "gpio-internal-undefined",
> +};
> +EXPORT_SYMBOL_GPL(swnode_gpio_undefined);

This needs a comment in the code telling exactly why this is here.
It is also taking up space and code here on systems that have no use
for it, so I wonder if it is possible to make this optional.

> +       if (!strcmp(gdev_node->name, "gpio-internal-undefined"))
> +               return ERR_PTR(-ENOENT);

This needs a comment stating why this check is here, it's not
obvious.

Yours,
Linus Walleij

