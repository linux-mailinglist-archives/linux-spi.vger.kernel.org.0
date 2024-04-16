Return-Path: <linux-spi+bounces-2381-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8633B8A761D
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 23:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F781C21CB0
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 21:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6571C10;
	Tue, 16 Apr 2024 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S/F9yMxj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B038FA6
	for <linux-spi@vger.kernel.org>; Tue, 16 Apr 2024 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713301763; cv=none; b=fXhoMnPdZBqxjkcaD4QYprYg3YDJoksbzABA0279Avl7OdgzurIpjbdtk355/yYTQQQS5+QCzC8eC+4Lwz3guqffeIeGm1fPC+INeNlOJeBtbWjCdiVDumevMwdUf31/XQC9w/xpwR9FegYIEqxdgRNT0skj6/xEGvQaLi1frbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713301763; c=relaxed/simple;
	bh=/ua42effZ2yzeEmKRijxtmc5wwr0KWYF0Dxm9K4ebUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWoI4pTCIdhAcItBXvZwfQosqjSo4TDM5V2QfvDR6zruBjwWmSMmyJSgGGwD9X1JNf8EJZZe/0kKc/a3ZHy7ME78JIGIGnGnXwt/KB97JNlERameKMxyRYpCGajJY7zP4RjgRNn88T5ITPg+adAxamKaX/nHitsSjNSx/t2M1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S/F9yMxj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso169642e87.1
        for <linux-spi@vger.kernel.org>; Tue, 16 Apr 2024 14:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713301760; x=1713906560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15ytWXfgbMdpikNK3/DanSyZoRuKXzympN8kdSiXVPg=;
        b=S/F9yMxjygYA7tAIjKPjFGqavuVeGIZaaYuZeL5cYLgH+gm/3AI8tseepTyL1SMUWE
         KdBEb83f1wQU/ANuHWuFBNYizVoImcQk6RKxGXBt48rzXDrGuOT39qS+4WzXvQ6cWqXh
         povyISHlOar5Qd2JdhCArBebVbovLW0jUZwbxVr1/Es2P+RzSvKD5CMWYc+fKVukCTyN
         ek1FO+qLWrxUDYwJUo0BIlFDAtU7OeewTrvM2WI46rEFAhMWYh8rJgGe6/x9XlRgKc+v
         mJr2UfiB/QmsvvHO475cugYOBBm46B6c3FlPil5dQ7yMQW/do1/xA4AWyDi7Qtk3y31a
         nEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713301760; x=1713906560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15ytWXfgbMdpikNK3/DanSyZoRuKXzympN8kdSiXVPg=;
        b=JKMO1pF+N1sDsqRFTLbFtYAcnU6nBaI4CE+U70mKsM70ChxUDQCrNjHnVaboeGRhUg
         wYPCb3ybzQd8xrWYpaJIa3Llwg+aC+Z38MqfZQjrYdbNasZKDjXSqXX2pP/NacaFEWRO
         zNBvBUxef8c6h1k1iyvCYy0Gc92dB1t3+Qlkzh/Yg4fZ0q+BRYr4gTV7Lynhp3fPxWVj
         SoDRSGp0jpKhC1QPTbut0Kda/Q5EYJysVELwtqAVnZy14UmbzaHaABehc4ck+k8Rrp0y
         v8X0fANL0i4vx0gZ+tTWTGNjAqrgiOIOp2dFukW0qBzg6OWwHiWnuiuBoX8FFnMRGFyk
         TBeg==
X-Forwarded-Encrypted: i=1; AJvYcCWs40cTcz6CL0jyaflSZMGuNTPciRoxm6C4DoB3ogcnITs1shbatAksfirrcOhisGsUE6KUP9kyidFgzLVgVaWJnNZy8TL9F6tJ
X-Gm-Message-State: AOJu0YzHW0ip/+Z9XRclm/7H88tqOelvJTwqh1MwseWxeIjULxun1wnc
	7cDc8ty9AOyRLNEt1XpYaxLseLaznaqIE4KSN+fweWVwycwaODmioEd+pRUXpz7diwMBZoi36FH
	vzw4RJuXJlfglnLsGF+mDZ2fGvQA7Yi1U6/FiwA==
X-Google-Smtp-Source: AGHT+IGtkUoeTe744dqf6RVA32cNFZ+I0C3DqVi7nAzwtbBdqEdPCHWd45/6OmS0d8XlEIJRUCxAgSYkxxfQKmbBI/w=
X-Received: by 2002:ac2:4844:0:b0:519:45d8:9d93 with SMTP id
 4-20020ac24844000000b0051945d89d93mr30988lfy.15.1713301760506; Tue, 16 Apr
 2024 14:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com> <20240415140925.3518990-2-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240415140925.3518990-2-ckeepax@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Apr 2024 23:09:09 +0200
Message-ID: <CAMRc=MfKExrzoSe41O_E9TuVTiMq2j8phYiS8dXDg+kmU_EpLg@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] gpio: swnode: Add ability to specify native chip
 selects for SPI
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, andy.shevchenko@gmail.com, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:09=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> SPI devices can specify a cs-gpios property to enumerate their
> chip selects. Under device tree, a zero entry in this property can
> be used to specify that a particular chip select is using the SPI
> controllers native chip select, for example:
>
>         cs-gpios =3D <&gpio1 0 0>, <0>;
>
> Here, the second chip select is native. However, when using swnodes
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
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

