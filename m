Return-Path: <linux-spi+bounces-4636-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A3196C60E
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 20:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA161C24D9E
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D2C1E1332;
	Wed,  4 Sep 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CqiuvQQs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890F6E619
	for <linux-spi@vger.kernel.org>; Wed,  4 Sep 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473545; cv=none; b=USg4J7UDtD0t9au6YdxYGKjU3n8vRLqN8LDoEOVBKApQl4dTq02k+NXX/p9ifEgoTZbGnHwXdidppy2VKjFYHelMcHjDWr6E4zUnIhgGS8Iu7m8pcGHDYKLqHxgpMEVFvNqMI4NbRK5loOO7haCxhmz7LQsjYE0Vo9P8mZJSDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473545; c=relaxed/simple;
	bh=Q7Agty0zXBtBtOtFGvBFvozyDANzGd+EnAjH7EKjSOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHnHGlHbFeXxOiy99COr6hU5o5bw9k0D8wAyNl28mIk9myfb7C2rysQYCfxVRO6iqEstaNWxkiLj/NSUyh3Lu/L7yKHU2V1DplHkF2iuTZmJxiMRcqFjdXcboyHOFT0Psu5K1ziG8qyiYUTaSvU8rGuqyeTnaundY8DbUkLIPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CqiuvQQs; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3df0c4a65baso4231631b6e.2
        for <linux-spi@vger.kernel.org>; Wed, 04 Sep 2024 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725473542; x=1726078342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wdKYvJTYXyrjklFqOv07HIaDpIbI1w2LSQ7FPhX/UI=;
        b=CqiuvQQsjWoPK84zLzZ4I/1yVlaK3TDcoLt/+z6BzD2z9PQ+4kUQM13G+gJgMmCJ8S
         UhdTMQ3ZE2UmiNHoDms2SQKCJJwjKemN8kugIvxkqQ45odMqgy1a39IeQshDO+agt5vA
         jBkR4ohh/nuYq17fJCoAFw7WAjRJBq5OIlZIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725473542; x=1726078342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wdKYvJTYXyrjklFqOv07HIaDpIbI1w2LSQ7FPhX/UI=;
        b=BNq+8oR0cqYBppxQd20YfswB9cmhSxhqiV0Mw7tuYuYxCd1mgYg03ARVUryAwicAGM
         cRTjowIm9L0l3KShwfpvhq7vgqv/7V5XAEgyucM2WKHhlYKoAHKJlxsKrG+ZHPspbuR1
         upXkKp0TMeEGL9tPj9W8IkYC+wCjMydvtR1GsABKzDVT/yMny4QP4AIeboZCS1ZH5UO6
         8zaZjYstpmghOPUOR9YZ82n9FSnaoZpTOZKU/Ap5Iwpb/EjxGd2wA5EDX7vSZkwSxjNI
         dX7/zZZpOsZL9qkU/QoTgS+qPyb18aACdCebI0BJSfjJue+bGuCgrc7MR6PHidGLPmUN
         3Dkg==
X-Forwarded-Encrypted: i=1; AJvYcCXDxkUYt6bPk6QlkGqxss7rik591UcOI4p/CC4VhneCW+rpOtQkZvf2/UpUnvyfFabWYCnLWXwg0bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyldlX7VBf0On0gjVLGxro4LfKEK0Eqne1VHwlPrv24fpZpGpWY
	qkI9FLBZkyF3L6bbquphkDmW9F1K+4y14KchI13IV13j4szi4rGx174kE4Ezjpx6f+uK9vsRDuM
	=
X-Google-Smtp-Source: AGHT+IGjODrttIXgNabhWfbF1We+zKzN6vYR6tYq0Jt//MiXc2ayKbSTCXbxwAaca4g48tPnU9sr5A==
X-Received: by 2002:a05:6808:1809:b0:3d9:273b:169d with SMTP id 5614622812f47-3df05e88001mr24297765b6e.44.1725473542128;
        Wed, 04 Sep 2024 11:12:22 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b4c6e0sm395841cf.45.2024.09.04.11.12.21
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:12:21 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bd6f2c9d52so34353436d6.3
        for <linux-spi@vger.kernel.org>; Wed, 04 Sep 2024 11:12:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsZySwGDaBMJSKaqtO7ObADdTMj3BWCy11FeHNAgZmV8Z+I2dKBtSKbUgE9OmBkE6sWyxsN4+Rhk8=@vger.kernel.org
X-Received: by 2002:a05:6214:33c8:b0:6c3:63ea:377d with SMTP id
 6a1803df08f44-6c363ea387dmr141190726d6.43.1725473540667; Wed, 04 Sep 2024
 11:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904021943.2076343-1-ruanjinjie@huawei.com> <20240904021943.2076343-2-ruanjinjie@huawei.com>
In-Reply-To: <20240904021943.2076343-2-ruanjinjie@huawei.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 11:12:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VyDk-e2KNiuiBcACFAdrQmihOH6X6BSpGB+T1MsgsiKw@mail.gmail.com>
Message-ID: <CAD=FV=VyDk-e2KNiuiBcACFAdrQmihOH6X6BSpGB+T1MsgsiKw@mail.gmail.com>
Subject: Re: [PATCH -next 1/3] spi: geni-qcom: Use devm_request_irq() helper
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, linux-arm-msm@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 3, 2024 at 7:12=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com> =
wrote:
>
> Since spi_geni_probe() use managed function in most places, also use
> devm_request_irq() to request the interrupt, so we can avoid
> having to manually clean this up.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 37ef8c40b276..77eb874e4f54 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -1144,17 +1144,15 @@ static int spi_geni_probe(struct platform_device =
*pdev)
>         if (mas->cur_xfer_mode =3D=3D GENI_GPI_DMA)
>                 spi->flags =3D SPI_CONTROLLER_MUST_TX;
>
> -       ret =3D request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi=
);
> +       ret =3D devm_request_irq(dev, mas->irq, geni_spi_isr, 0, dev_name=
(dev), spi);
>         if (ret)
>                 goto spi_geni_release_dma;
>
>         ret =3D spi_register_controller(spi);
>         if (ret)
> -               goto spi_geni_probe_free_irq;
> +               goto spi_geni_release_dma;
>
>         return 0;
> -spi_geni_probe_free_irq:
> -       free_irq(mas->irq, spi);
>  spi_geni_release_dma:
>         spi_geni_release_dma_chan(mas);
>  spi_geni_probe_runtime_disable:

While the idea of using "devm" here is fine, this isn't quite the
correct usage. You need to be really careful that using "devm" doesn't
change the order that things happen in a way that breaks the driver.

Specifically, before your patch the order we init things:

1. We enable runtime PM
2. We allocate DMA chans (spi_geni_init=3D>spi_geni_grab_gpi_chan)
3. We request the IRQ

When we un-init in failed probe, we do the opposite order:

1. Free the IRQ
2. Free DMA chans
3. Disable runtime PM.

Your patch switches IRQ the devm. devm handles un-initting things in
the opposite order but all devm stuff happens _after_ the error
handling in probe. That means that after your patch, the un-init is:

1. Free DMA chans
2. Disable runtime PM
< start running devm stuff>
3. Free the IRQ

...so after your patch the IRQ stays enabled longer. I could imagine
that an IRQ could go off and try to use a DMA channel or do something
that needs runtime PM and then things will go boom.

In the very least, parch #2 needs to come before this one and that
would help, but it won't fix everything. Specifically in order to keep
the order proper you'll need to use devm_add_action_or_reset() to
"devm-ize" the freeing of the DMA channels.

-Doug

