Return-Path: <linux-spi+bounces-2485-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78AD8B0A2E
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 14:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96641C247B4
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F220015CD66;
	Wed, 24 Apr 2024 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnVGi9Kl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5376915B99B
	for <linux-spi@vger.kernel.org>; Wed, 24 Apr 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963324; cv=none; b=ldW8msrK/l6d7xGD3DicclEVe14aq8Q5bFkXRUr5LNGAItTY78aX9PY6s+2NtP6K4kPtql6Gy0nXQNCCsC7QA+KpzaW2lK3w7QyRjrTS+kcZLejoxTdOawvgRGVn/YZzTlTCVewB3QXsjAEfBOcIWzabr+aEDMUHGTzNh/bH9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963324; c=relaxed/simple;
	bh=OwzDq9Gg/8PW5ExxetsU0RQpYZv9BOy73ZGOBO4Bank=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVwFD77UaPxsJYmnAKrSqOlASsi8Znjm4PA9JzwfKrby2Y1oryC15FYiND0oz1kQY81otHf5cbH/+IE6kEJi7RAlo8W3uHT937EUcH/sMdCdp4fdqC0+2vcH7+jcbHnIApIhzp0M7cCZ318lUeaEVTMrI++hj4wrZgaUVL14sDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnVGi9Kl; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso10612839e87.2
        for <linux-spi@vger.kernel.org>; Wed, 24 Apr 2024 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713963321; x=1714568121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpWyQp0aO8XsvrhlnWy2W0Kvf5e4AqoBJIP8MtqSCu4=;
        b=jnVGi9KlBG0VpGWPH/+ugORzn/Cbg7vqMppWQCuT8XItDv/VciGiFeMLE30Y5JU0D1
         tUXarxqnFTc4/N8bJO31O4YWwHMM1nqvvmvfwotAFEKsJUMLKDCFlAO7YI8bOjIPi5qa
         HJMbPLht1IhgXcW5oZ3tIyo9Hn2LauxMlBQSr3GM1vs1Bp0MhOVRfYuqXPmCPog/Coej
         MtztKJll53snYSeUmZrIoXL3RDgZpRl5WQcg1JNNPrDj5QCWVv7b3+qshd8K/wf2WhEl
         bjRcvmi3VNbM5sdPUqx0kMIBGvR/9QKx4yo/6mZ4daZM512cXZOOZNrBaoHma4OPyp99
         3jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963321; x=1714568121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpWyQp0aO8XsvrhlnWy2W0Kvf5e4AqoBJIP8MtqSCu4=;
        b=AgGOFFj0Bl7NGGd+PZCbbgDK/ukhI8gZM+OOGE8s2H8TvMgqp1tHgK7oEeLdjBD1hX
         +chRywf4NJMHTKKDmucv2jD6XgcHgQF08EkcTWWX31EiZi3qCKBTgXX8mefDScMd5xuM
         995oBbCCTqEEb3zbCRAAyw/ni97Rtk8nawXN/KK5G/WmEcyCszentBuhPlXSj01hqJH1
         X64nkG6+0izIrq4S4PFe6lSKJ4r7NaDDdMgdSKx2EI383BxPBeIPgOVcVr1KMQFXU7dL
         f6TtImHCPFkG3r8QNNazfykSMRuHE/9F+HYoqUtdRPvcyfw91k9B05LKba/lH8AX4Vyv
         q/zA==
X-Forwarded-Encrypted: i=1; AJvYcCV2OIYtq0k1Mf1S62zrJtHXCu0GoNtMsj993IWUzhy6g7fm7JGB+lh8gP5yY1ZkEa6zGk0g3zCjZJkN5cIayRcx7vLcpNKAde5l
X-Gm-Message-State: AOJu0Yy3HEHHu1xw5cuEIF4i1jNswlSKEH4cnWrPB01lkI2P1fKyQBx3
	WLvdS/pSQsPnHahTgDC13NJ3RijRZRpmWSH5VmLhWAy8Pn7EsIhAxF6hkFHh1W2XH27hLKjLazX
	3qGbVOyaPe7GAjWurO4QvrwatUYs=
X-Google-Smtp-Source: AGHT+IGqPFwOLjGi6WosPxvlMfdI+CwdQ/7dxaXxgoGHEsYY53WzLwBgBOUZeWViARWetCT5FaQB3n633zmGB+pUAjE=
X-Received: by 2002:a19:e045:0:b0:516:9f03:6a92 with SMTP id
 g5-20020a19e045000000b005169f036a92mr2013237lfj.43.1713963321404; Wed, 24 Apr
 2024 05:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZieRYJat7Y0ISbks@surfacebook.localdomain> <20240424111647.81286-1-heikki.keranen@bittium.com>
In-Reply-To: <20240424111647.81286-1-heikki.keranen@bittium.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 15:54:45 +0300
Message-ID: <CAHp75VekzXPXD1D0isUspdBGKUpKW1ZgtMo3Bu4zGtrk3Sd31Q@mail.gmail.com>
Subject: Re: [PATCH v2] spi: mux: Fix master controller settings after mux select
To: Heikki Keranen <heikki.keranen@bittium.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	petri.tauriainen@bittium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:18=E2=80=AFPM Heikki Keranen
<heikki.keranen@bittium.com> wrote:
>
> In some cases SPI child devices behind spi-mux require different
> settings like: max_speed_hz, mode and bits_per_word.
>
> Typically the slave device driver puts the settings in place and calls
> spi_setup() once during probe and assumes they stay in place for all
> following spi transfers.
>
> However spi-mux forwarded spi_setup() -call to SPI master driver only
> when slave driver calls spi_setup(). If second slave device was
> accessed meanwhile and that driver called spi_setup(), the
> settings did not change back to the first spi device.
> In case of wrong max_speed_hz this caused spi trasfers to fail.

SPI transfers

> This commit adds spi_setup() call after mux is changed. This way
> the right device specific parameters are set to the master driver.
>
> The fix has been tested by using custom hardware and debugging
> spi master driver speed settings.

...

> ---
> Changes in v2:
> - fixed Co-authored-by -> Co-developed-by
> - added Signed-off-by for co-developer
>   both suggested by Andy Shevchenko, thanks!

As I said this was already applied and AFAIK Mark won't rebase, that's
why I gave you advice for the future contributions.

But thanks for following!

--=20
With Best Regards,
Andy Shevchenko

