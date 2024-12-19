Return-Path: <linux-spi+bounces-6119-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ABD9F76A8
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 09:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5880D161076
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79CA1B4233;
	Thu, 19 Dec 2024 08:04:04 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EC43BB54
	for <linux-spi@vger.kernel.org>; Thu, 19 Dec 2024 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734595444; cv=none; b=cP1bi/GwaTMdbbdJHFUPniYQdadyxLjkxzpOe+s7XyKIE/TyNeMrKGUy0iQMkSE7jikqKbaS2M+5ZIlHN18BxnxHyUhLErfaQUSUjzKp1WRXrOr0BTXFFI1JVT1wdOlNwQLY9ktnxfwSidLGmtprHnieTCnsrhAxVr68Uu7Km3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734595444; c=relaxed/simple;
	bh=8OzpZQasZhYdkXNpZrJ/pLd7dwlGmc0GKzXGquO0GMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LknZ0dB+O5p8GNNfP2xK9ci8gskMxLpcuiz6i2FxBUAiDlpWpXL11LT2ogMDUFQHZ+Zgw5F8c6iBNhCerSUGrKMWYbbzYZxwgHCg8/AJwz6Cb8On7n/bb7utQEiDlqIudrhx2r1cZC3kHCjjoAPOeazPWQVVTtHZHw5zmk7Q+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5187f6f7bcaso171064e0c.3
        for <linux-spi@vger.kernel.org>; Thu, 19 Dec 2024 00:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734595441; x=1735200241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkBMHtPIDLOISKRZDfY+2tE3dIQXAFPIRw1KtEpx7U4=;
        b=AKV19o/b4x1KVDkq0T8OYrUlXqrKGtbV8A3WiblMD+F2VJDKUVPPP99kjQaHt4dap/
         x70GJw7nwYVmr6ussq+KPq6Q+crk2vOma9m4tz1PTppLqcSgKclabSbsDl+l4QHNXFn4
         sZYwr4h1ymfGKZODMQZ+oqM+3bKHE7aO+eEACg2p/OS5nsBjU8DjPZhRTLCoK9+8S1yr
         JRDN3uBOfIebb18w6UpxNHjtTvlUOWQoKUlL3xj+vGCYoBILRFWjb16wB1ZIAnAJCEad
         DAaG12cl5eq0jIfJguk2FwH8kITjH58cuvrIzebN8qfYteiKpZ8lgqzsikUT3lL6laDc
         P3gw==
X-Forwarded-Encrypted: i=1; AJvYcCXowdYXFW8YKF0Ad8qMuqXPfu2VsZnIkAtieC3uF8tR97Wz1POZ5B6qLmAbmQj08pfkA+KEn0vgEi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznnQcJdT5/vmFBW4Z+xfkMWJ1EJ1h+DoO+8y27n6AjC0L6YEgP
	3Df5dFR+qE2CIbytaRS+hyIspQ0G3SjqprcJ0Ie8L3HmYCXc1IppZpXFkpOF
X-Gm-Gg: ASbGncsrz/X4rtFrq4xvDi7ItvylMzUlittPx+6mOfpjtPld4INtdXOBPho0EW2wvKy
	AgoNV0ghQ6hAE8fp5rPLF+zvsqHNefNBmINRdya+iVQW9bq2vxVI9bhTf19TdgjZKuJ9YzOfqQp
	fvPGwyolaciOgTuEhiH8cF7Gam2QepYUW9096TGuXaBwBuunvmzh28eQOXokjQfRVE71PZfRVt0
	eJ4nHQsMfmTOcOKZbfAoOFnil5/v9SqMjlwL1DI5/HsFtZw8ImlOd1OjNSXazIn36YBsiD2YdNY
	ZgzxNcuDnkRK6bTJ7cQ=
X-Google-Smtp-Source: AGHT+IGVkV5brda3Lfh2YDYCB9XfMMwgL3k9jJnbAgRuZheP/J+owcke6OkZt7zpz2jsVuuQ1zTQxw==
X-Received: by 2002:a05:6122:201b:b0:517:4fca:86e2 with SMTP id 71dfb90a1353d-51a36ddf0c0mr4689859e0c.10.1734595440905;
        Thu, 19 Dec 2024 00:04:00 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51b68b7d627sm74279e0c.3.2024.12.19.00.04.00
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 00:04:00 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85c559ed230so103488241.0
        for <linux-spi@vger.kernel.org>; Thu, 19 Dec 2024 00:04:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfp84VGJ1CMXFMTkVAPolONKLWyacoFoBZS9ZMxn5tjoEvHLF/KsTIjd77Y2Ko6yFlNEWG0Kw6if0=@vger.kernel.org
X-Received: by 2002:a05:6122:2225:b0:518:9dca:f0fb with SMTP id
 71dfb90a1353d-51a36ddf95cmr6119983e0c.11.1734595440388; Thu, 19 Dec 2024
 00:04:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217114226.1223724-2-u.kleine-koenig@baylibre.com>
 <CAMuHMdVzyq6L+9iNhtSdGpAJOKyu2vkzvveHXt0in9xUhD6mLQ@mail.gmail.com>
 <tk6wlbylk7aqfd3sys2jitpnbdz4xomdg2yr7hsppxyptgbek5@3vtvajq7krun>
 <CAMuHMdU0FjXBgFLUxxvQeODPsU8xf+LAdQCg4xpAn_omJeA9WQ@mail.gmail.com>
 <CAMuHMdUEXFFXt1EkGafv+-arG4x4hFQMGO6E14O7zguyGT0kmQ@mail.gmail.com> <o74qqp36r3mgdk7muqtc3zqp7dkqqixfutirf2eeniatckoxw3@pjgfaokp5rvv>
In-Reply-To: <o74qqp36r3mgdk7muqtc3zqp7dkqqixfutirf2eeniatckoxw3@pjgfaokp5rvv>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Dec 2024 09:03:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXMLzACD5mcCtAG=oE70SLGMquFrVpBROaLvnJjz2YdUA@mail.gmail.com>
Message-ID: <CAMuHMdXMLzACD5mcCtAG=oE70SLGMquFrVpBROaLvnJjz2YdUA@mail.gmail.com>
Subject: Re: [PATCH] spi: spidev: Align ordering of spidev_spi_ids[] and spidev_dt_ids[]
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Thu, Dec 19, 2024 at 9:02=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Wed, Dec 18, 2024 at 08:10:57PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 18, 2024 at 8:02=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > Further improvements could be:
> > >   - Generate spidev_spi_ids[] from spidev_dt_ids[] at runtime
> > >     during module_init() (consumes cycles :-(,
> > >   - Teach the subsystem matching code to strip the vendor prefix,
> > >     to get rid of spidev_spi_ids[].
> >
> > Oops, and modutils, as the tables are used by userspace :-(
>
> Then how about a build-time check comparing spi and of module info?

That's a good and non-disruptive idea, also for i2c!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

