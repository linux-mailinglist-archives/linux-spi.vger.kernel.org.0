Return-Path: <linux-spi+bounces-434-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83E82C2F1
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jan 2024 16:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520401C21BD7
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jan 2024 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0236EB69;
	Fri, 12 Jan 2024 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k8nu2ViQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094D6EB5F
	for <linux-spi@vger.kernel.org>; Fri, 12 Jan 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ccae380df2so72221331fa.1
        for <linux-spi@vger.kernel.org>; Fri, 12 Jan 2024 07:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705074143; x=1705678943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaVw5UCNPa/eBnU3IdbP9nG5gQESTbpoML4+9XQsGiA=;
        b=k8nu2ViQ6nqFK2cdO51lezAvvzZ+Zd/L6DFLtOMoUlmCC0ra9VpapmyQ6qh6Bml0g2
         yZcP+eipX54D9kGoFKPlzEy7ISe4KkItdBlPruLa5CTfdtm+EhG8HJRhoTQmm0mVKN19
         nGe+2gnCtOsM/SJDctKuRADj6SweyiJREgq/Jrwum6rdRdRmcGGxXJ40MRt7VtfLadxM
         WYi3WlQevwSSGmvG0FDssxm5kCD7i0BucBd79BHI3+gh45qiiuuvKCqoiuQGNstqw9gA
         EJTiRFrqwu8B4Y5og8XVSa2iaIh/no/2+mTh/tYXJrzYjb/vkKWElSQmjkaIR3IG0kXe
         cfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705074143; x=1705678943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaVw5UCNPa/eBnU3IdbP9nG5gQESTbpoML4+9XQsGiA=;
        b=l0axKI05KFGxsBYSaazu+gOhpJ9s7F8fWFBjZBLndJ0QUB7P23KLBtMET3suMcoBqn
         uPpF0QvXZ5VeHdQGDo+/fqnEhaWCwd/ZzHvRjr6aW35Kmto5kEFXCZ+c0ucdON40aFg1
         LYc/HfODeJ/UYcfcI1y3FZbUipOTqL/6YorOM7ScjZHjbnNPx/ApYiiSknmGTtTq44pu
         ao10J2OZwze2nJnAprp35Kax75qr60wUT5tQ3sE5ErYbhpOIx9qx4KMPR5qZCJp87qem
         XIi7UUKcNR/j/X9JmIAHtfAS2vZVEGA0VP+5vqJ59jQV66yXmga/kzFxMgJxGgJ2QlCU
         EpiA==
X-Gm-Message-State: AOJu0YxNZRkPqAYZljF5zlNfHNi/yGUJFRRO2RxkOE20x8IVaPOmM8M0
	Gdqs4qWVIEvsBaMTtH6uAatHIsCKV7qbc42/khpbgdEqsRtMFg==
X-Google-Smtp-Source: AGHT+IGSdD++VbAlk6yLdx4OmCl7oUCBBWxOavT4Y+To7Z+DI6Nf4HIB4JFkD20KhlhibNd0x8p5Dty5gytrBI/xgy8=
X-Received: by 2002:a2e:9bd2:0:b0:2cc:db7e:aac2 with SMTP id
 w18-20020a2e9bd2000000b002ccdb7eaac2mr753538ljj.58.1705074142783; Fri, 12 Jan
 2024 07:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-6-e42c6a986580@baylibre.com> <20240112123711.0000422a@Huawei.com>
In-Reply-To: <20240112123711.0000422a@Huawei.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Jan 2024 09:42:12 -0600
Message-ID: <CAMknhBHs32nHH8o-m3ByFfiKGAY=U7is18LMM2tGhH-v4v+8EQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] iio: buffer: add hardware triggered buffer support
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 6:37=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 10 Jan 2024 13:49:47 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>
> > This adds a new mode INDIO_HW_BUFFER_TRIGGERED to the IIO subsystem.
> >
> > This mode is essentially the hardware version of INDIO_BUFFER_TRIGGERED
> > where the trigger has the semantics of INDIO_HARDWARE_TRIGGERED and the
> > buffer has the semantics of INDIO_BUFFER_HARDWARE.
> >
> > So basically INDIO_HW_BUFFER_TRIGGERED is the same as
> > INDIO_BUFFER_HARDWARE except that it also enables the trigger when the
> > buffer is enabled.
>
> If the trigger isn't routeable to multiple devices we normally don't
> make it visible at all.
>
> I'm not yet understanding what a trigger actually means in this case.
> Why do you need it to be userspace configurable?
>
> J
>

It looks like this question was answered in another thread (we need to
configure the sampling frequency from userspace). But there you
mentioned that adding a trigger for that seemed overkill. So you would
you suggest to add the sampling_frequency sysfs attribute to the
iio:deviceX instead and just forget about the trigger part? It seems a
bit odd to me to have an attribute that may or may not be there
depending other hardware external to the ADC chip. But if that is a
normal acceptable thing to do, then it does seem like the simpler
thing to do.

