Return-Path: <linux-spi+bounces-2348-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1408A570D
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97A5B22FB8
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E300879DD5;
	Mon, 15 Apr 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+M/7T2u"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1A47F7FA;
	Mon, 15 Apr 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197198; cv=none; b=o5UL1GIxhvHlJD0A5m1xVEsKmOERroDua5OJ8QljVs8KBIXewacT2O4wMue3O36ih1u49DRyywWE63ykHgBHNNBKWod9hR/WqhP1q7bouHv2xvOd67uiaqBopJY7UKN4k+rrtr1T+o+VAnwLJbJ1/c6f1+YMonjBfEdHn68CTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197198; c=relaxed/simple;
	bh=sc5ie7WrysohWSg8pH4h7QVDXpnsIjaHal8hHPcmDUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHBT5nH6KtcE5+KFMSJKmLtIMtGb/wspP1oGNwUtEjE8qHDTvGbhstYqAb2poy0uOLahCFapB3KvfE0pCbSoQiOaBx5t30k2omHAn96ZgQojC6PORHASVm0m4IgkPQ2lW++2A/mdckeau0GuwExhZO0qwrk7P6MDkL+6TJhwIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+M/7T2u; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5701de9e971so1649241a12.1;
        Mon, 15 Apr 2024 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713197193; x=1713801993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+T6fMhFzhb1MzH2+aplkTiKcIpY7o47sOVy5Aw3El8=;
        b=D+M/7T2uULWNEyRoCbAW62fDY5Ipgn/3l8yiLw5zXWB9uoiIF98UhIp12FJM0WNctL
         ZFrVVIRiRfcq5SE+YnkKbY6JCv2TY1TfkNdhbx8wLo0wvzhIJ86UcFOqmSXJr6iy6eO1
         9YUW0Q85S6ezaMwNxldZWthvWFdFbbjNtJGi1cMRvbdqnSCvQwbewqQ6yorWGXlvuFo4
         lIjujpKoQjNJcfjV8tMfCr8FKN6gtuTS2uLlFqImnG7VNW+w6BCSckr0CIcVKr46osTL
         Y9CQBSKDg5f52tSTL4mWBlcX5ht4m6JDJSbwRJXGBrzTtg5vVTQFDkfQvVcRHArB+bal
         gVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197193; x=1713801993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+T6fMhFzhb1MzH2+aplkTiKcIpY7o47sOVy5Aw3El8=;
        b=JWFpAmrObUQuDwxRlbNQjeMQr+kqPLu0msD0cU/30SwUAsbRiCC2fR6jma7rtJc81Q
         N6PUF7F6k6/xcqMcqnTyUk+aiWJg+LsuSbHZyrlYkhzVA7yKGsSiKqPSGKBHcE2OBhic
         HxYJpIhgQSf2I6GOx9emm2aeFYx9C4ykmM5QFF2Ts5oOH1bcQDMP8zOY22qAnZfFprHE
         FP1qzs9tVi6arCNP5j1Hup7nrpojTelu/pfGX89lx0N17crhZtTJzUVOvYsb6imjUR40
         lQdO648abVid3LcutI49PhpQXcf27HWWpSI68E/Qa4ZCJ6Gx2y56o/gQxnylyQnL+QN/
         RJXg==
X-Forwarded-Encrypted: i=1; AJvYcCUEzmMGWL2PJUw7U7sMex3kDHUaHAguagO3bpJF/gQt4VY2L282OUSjP82HFZYpYXFzLJCHP7VO2bk26CmYtyasN9SM0tN0C8rYeVINBPARM2bIcYMbjtUS8H3O86/Hz7IS4jp/QA==
X-Gm-Message-State: AOJu0YyDN78abT49jWBTm0KaHd+2YwmLTHOT83J0kdeo5iTAvbStgH9g
	L7iPlUkS3397xe0ywIDittVZaL7cXMX9D+sOo1prZ9jEU8I2knRUwGy7AWYpX0Bacrz3fg9vH9Q
	fjy47vWQh+1ev81tHxHqCleklUpU=
X-Google-Smtp-Source: AGHT+IHoKx++V/6cMwGmsRq8AIbwv64J7dOc3PqncdPs3MfJtIdQC89qy9ygHBUaMjOIXVU38k8+ceWBSTNSquw6FAQ=
X-Received: by 2002:a17:906:68ce:b0:a55:3662:1d89 with SMTP id
 y14-20020a17090668ce00b00a5536621d89mr354096ejr.58.1713197192921; Mon, 15 Apr
 2024 09:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com> <20240415140925.3518990-2-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240415140925.3518990-2-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Apr 2024 19:05:57 +0300
Message-ID: <CAHp75Vc3xXLu1VHt_job1QEEBo8CZK=gJXsN5jgymZK-P-bg8g@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] gpio: swnode: Add ability to specify native chip
 selects for SPI
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:09=E2=80=AFPM Charles Keepax
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

FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>
(I assume that this is _not_ going to be applied standalone as we
don't want this without users, i.o.w. all or none as per this series)

--=20
With Best Regards,
Andy Shevchenko

