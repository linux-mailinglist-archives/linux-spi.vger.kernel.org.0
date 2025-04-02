Return-Path: <linux-spi+bounces-7388-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D5A78D3B
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 13:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387EC1893CAC
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D607238D27;
	Wed,  2 Apr 2025 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JonVyCoC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A7238163
	for <linux-spi@vger.kernel.org>; Wed,  2 Apr 2025 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743593804; cv=none; b=MESuzcf1U0T+8JuG5o89lEXFHOtIqGKG3LX+5Q8BbZEaucS6IyZv4z105ftZQ7KJkPYPeDnJixdsTFWj95EaFBq8jjGbGauxr2pAc/8OQ6tsfjMfX7QH9/OaIaqQFAAqgqykmdHVLBqBkmmhmix2yJtqSiVbldUik/F5MkKkrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743593804; c=relaxed/simple;
	bh=K/IxOeoGpLWd0tF2MZP/yWzEs17gKVZtkgJ6ev+aWm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW9OwiBlYicfpQyin5LVLZpyA+RopWtkRnRynqk4fD+me01v+gEnMhcOEXqKpHNUg7kUp65QUbuVzQk2P2IbWGTHNrNVtUZ0d8vCppdJfs+FnQFF0UZo5tEWH9Vfj5/tRQ+R1fOZ5xwV6Q2uPoQpGktSjsvys/kyL4ux/52tAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JonVyCoC; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54b10594812so5274188e87.1
        for <linux-spi@vger.kernel.org>; Wed, 02 Apr 2025 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743593799; x=1744198599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AKdoyoCSvRsoZGSSFw8MoqljRP5EvFB4ozAvbpb1Ao=;
        b=JonVyCoCFPknaBmca8mds5pzV52jmq9pZraFiiG37Kvyhh8kh62yPeTNV3ssO0rLyY
         tg/wyZRs/DS6SgaztXxx+spduB0gl0i7F0VQ0ja2bj5NRw9HArG8pw2LDMBGeFvtcYhI
         QfwN/WG68XOqKH7scQ0sOU6SGRc9/iguusQjINdIhfGvgV6E12yebXHMNt6R5ihulGO3
         AH2aHTLCBbCYjeS1enhuTkrG5wZsNvMIMvorgn7hqdigPOHJTqb1An2HbVQ7BpnOXq4a
         w2UxjgksjVb2LkPuDFmvHjiYr8W6guJj5zOUMALbUm+s7TGUFbN6IDTlmqSa/AdqVoE9
         2AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743593799; x=1744198599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AKdoyoCSvRsoZGSSFw8MoqljRP5EvFB4ozAvbpb1Ao=;
        b=YeP2LhjJG15kjAjTLGHPBjxoh6YXt1NvRXVOGG/UrZPf2DziF6ve3AlBTkGa2/ep1Z
         16S1lTDtU9xuJY6Z6H0YLNtA4prpyO6eOD9ncbvM4/aBgjKq91B0ahdtnFHm9cJ6AO9t
         3TkoAtYmb9JtlN/i7vEKJcYDGllvnXLYcvVUf46yj7Et6/jiZnqEiHYOv+dvYk4pcmtb
         Lbe8Z/1nJLTXGKnc3FmtDVLsLemIq/r6H7XmXO4Nqjq9CRZXk7daNs6VHuuyogC5KO6T
         cIJfs4zZhRRVSxk3ZzAXoFqdKqztotFDGunKD99mHoEJiL2UEg4Xf2SfH8SKpxMhBGME
         taHA==
X-Forwarded-Encrypted: i=1; AJvYcCUGatmivoHQXBZB/z47nk6Swr9SvdfzDDYr8an7+oyy4RT4x/3/fWWf8x5UisCKvm1A7kyiF4MexZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybS67WZaKdnV8Sy4UN+izWMqKqbr97DKopUnMj5FgPoFo622rT
	bN0jFhB9r14JmPZyhyleWAZFFgFvIfpDlRabY3bVf7TXwi0VA2Ix7Dq2VmMAI4gz7pvF4betV1o
	ydMbqTFKQSfYq56pYyxQ0+yrYytrPrRQl+IlblA==
X-Gm-Gg: ASbGnctfa9sZanumsjzjMUs3P7it6V422q6vquk745yJkGv0N4IllTk0i0b3KVsmXeb
	9Sr/bp8nUAvHYvIHKF3pZ3WpaU4JCWYFktfougPQbN0DdXfpsjOlJq+uqwfTyW1W5I1b6zNdulw
	to13X/JrB1U3cFG98rS8xnDvZb8l1h7szwKMpVg4Q2PGcZu+ubA9BMXeG+8Q==
X-Google-Smtp-Source: AGHT+IGsnbfXwvFZVuoC9UDDv3Npd3hZvi9h1Pp8wvqwNQjg5U9HC70EwnrQvmAWsGN56Cs2yZSGmu1+vFuYnT3C5tg=
X-Received: by 2002:a05:6512:334f:b0:54b:117c:118a with SMTP id
 2adb3069b0e04-54b117c1200mr3694523e87.55.1743593799153; Wed, 02 Apr 2025
 04:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401224238.2854256-1-florian.fainelli@broadcom.com>
In-Reply-To: <20250401224238.2854256-1-florian.fainelli@broadcom.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 2 Apr 2025 13:36:28 +0200
X-Gm-Features: AQ5f1JrJhtH8_ur3V9au8mD0Q0X31nTvcx7xt8ybgxveuCtP18Bl-AMF_VqywNs
Message-ID: <CAMRc=Mefks5RMDkO-w-WT1279rKKyz8Up9UbuNdcF+WpsOxioA@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835: Do not call gpiod_put() on invalid descriptor
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 12:43=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> If we are unable to lookup the chip-select GPIO, the error path will
> call bcm2835_spi_cleanup() which unconditionally calls gpiod_put() on
> the cs->gpio variable which we just determined was invalid.
>
> Fixes: 21f252cd29f0 ("spi: bcm2835: reduce the abuse of the GPIO API")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/spi/spi-bcm2835.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index e1b9b1235787..a5d621b94d5e 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -1162,7 +1162,8 @@ static void bcm2835_spi_cleanup(struct spi_device *=
spi)
>                                  sizeof(u32),
>                                  DMA_TO_DEVICE);
>
> -       gpiod_put(bs->cs_gpio);
> +       if (!IS_ERR(bs->cs_gpio))
> +               gpiod_put(bs->cs_gpio);
>         spi_set_csgpiod(spi, 0, NULL);
>
>         kfree(target);
> --
> 2.34.1
>
>

We could also just set it to NULL on error in bcm2835_spi_setup() but
I'm fine either way.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

