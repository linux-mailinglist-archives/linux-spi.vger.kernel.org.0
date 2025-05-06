Return-Path: <linux-spi+bounces-7922-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926BDAAC059
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 11:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A76178222
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E7C268684;
	Tue,  6 May 2025 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZDHisNN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC132472A6;
	Tue,  6 May 2025 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525054; cv=none; b=byomDUSgClWVJ/XllBYkPqJYCs8VizUdXOnlDjwiwBrRe9fPyzEPVd8pYrB17JTDnegRkBXvoTMRAD26m7xWHXTFlCskW1Haj3ASd/SU7WSq5FnEO98phKkQ7xJg9S0Dlllw8xbMfBsu+PjJ4+lfcXzMbXblhkPK68HtzgXo9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525054; c=relaxed/simple;
	bh=JqbzKMxg4NH4McAzvsP0auX4j6YwzFxR8+jb5/OztjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0m65u1K8MXT7QUPU089oAlDBXUdm1c1f21e2MDS/lImq4jm1Joh8cttJcp8pXjnmaDnATf8+Z6bdw1+uIPnxu2DrCqQhOt1Lhxs1oTAEWeb9E9yPwP5YfuuNoA9fbsPemwIX/VTe1e8zA62guwNMN2QRdmbtBJrq1xDwecbJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZDHisNN; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54d98aa5981so6447043e87.0;
        Tue, 06 May 2025 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746525051; x=1747129851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+fT522H6brz7o9tM8egtk3glujQpnthQ1tpum8wNy4=;
        b=PZDHisNNY+McTeSXSNmbLYm8jqrQyISoDXa5L2o7itcQGvoCiarf3vgw/NAXs3NwN7
         AP1PNeMEpe+0b57sLEvGdQd0N0ZQL0vAOd8LM9izbdPzomMYowA1R/Vjw5vgUOgOY4Kg
         sQX4QC0F/+mhVIJPpRbtIafFs4dZ4f7GTtBPNf1DsTetaPVZfEHgy8ZbtQ78hDTTZY6a
         LP4OhNNuicC00whneikfGNy5zvBtoY0o8ehKno6Q+AnhdGrZubYCCMO1xl5a80Ma8Vcg
         aUG8/l9nYKk0RON4KuMYrMpbXu6TLXu22SkfU9al/Ajzyk/6nW8kKE5+p+avuy7hjS0O
         G7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746525051; x=1747129851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+fT522H6brz7o9tM8egtk3glujQpnthQ1tpum8wNy4=;
        b=d8HCLFwRr3lzhAKjidF0ZZxV36cRxtn3tUJlCRqTSn/otiSesLhY/6L6fpBM9in0Kw
         eWPVYlMK0tx8+4UMCLVgR5KYOofvnll1ToG23hF1gJUBwJWxgA44awUOrUfUXnIBUHj3
         50Y8D+EyrgYWezymv08x8Xs10hu+/tQqEJUF3AhmXRyIC2DqzMe0E+KkHRRIPTYAqSBk
         Fnr73vJ5m8U6xDSnQ83qKR9uW6IcmQS69vAwIesMfu/4kY9sKJRSx3Vy3k+KGE5fe+Zl
         lTnQRBjouDjSXd+aFfPop6KT8VB+xm4FIN/J3lRtWCjdqtdKoeD3WsrWxLuCTB7oIl/L
         wcug==
X-Forwarded-Encrypted: i=1; AJvYcCUmVlh6t/bOB5vcq4KLu/e5iglgBHzP6+H/5P3HP0Ouuyxlp8NYwSaPRan5pZuXrQ7PLmmyuyeEwFhn@vger.kernel.org, AJvYcCVuYZiNYcFYVQKJcij11VDEpugFfRBNBgAjOmTPmjyobMSePQbA+SdedpPAeL8LByI2s91cNyoWahWmhAc=@vger.kernel.org, AJvYcCVwfEDDPBa295g56JRIwYtFi3zg4XghE/CVXvrNFMhPqcBkbRZeYmZ2UFln0DEaS0wNvsHU9dV5z9enh4Q=@vger.kernel.org, AJvYcCWrHMOzF7gFK71+Cota4C3/paggNgV/6QhUzf7mUdyavLs2lfTiiaAQtXj9sDhtZ41KjnPnnleV@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSsZILXb6VuLxH/ls076jmvGwssoPhT5b1DHrstZBbSfmdg3V
	ZX23vV+YrlhF/V1RdskZbuzEs8tfig9Ft7I5T+Ls3vJdyOpt2cFt2r4aXPDebtmGu30mqkkvQpe
	pKbPXorIRycyaGx14KWVr5oLjHxo=
X-Gm-Gg: ASbGncsRrSm9CqO1VTBZP26w7ndwKj6jJw5wP4DVlVVya5HmF3j7cao6mGp8hUP4WuE
	Z195OhxLKhK00h1zA9jBGIanlQ6gIcHbwV/9zBjw0ObyMpC5OrFjEHpRbL6W2eoBiln02VDj1sC
	+QOx/I6OAeqIIjISlVDcG+Tf0=
X-Google-Smtp-Source: AGHT+IGCdnN++39MsbNDkcs9Nw2mbdDyjnL3MoWEOy3Rg3kK7lGviQiCG0YyI/SKhQjPzHkIdvnJ+8gnH9wkeF8oJHg=
X-Received: by 2002:a05:6512:b83:b0:545:fad:a747 with SMTP id
 2adb3069b0e04-54f9efb4445mr3183952e87.5.1746525050343; Tue, 06 May 2025
 02:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com> <00b119fb-1cbb-432d-a884-5b33696461e6@nvidia.com>
In-Reply-To: <00b119fb-1cbb-432d-a884-5b33696461e6@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 6 May 2025 04:50:37 -0500
X-Gm-Features: ATxdqUED6Yin9FVSQH1pz5OxO5Z_06zduEaLQoz8cbCxWez0G9eyBoIDDzQwQe8
Message-ID: <CALHNRZ928KN6ZBDzdGWyabSQw4Hny6F5RdqZ4hBUZosPZtni1A@mail.gmail.com>
Subject: Re: [PATCH] spi: tegra114: Don't fail set_cs_timing when delays are zero
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Mason Zhang <Mason.Zhang@mediatek.com>, 
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 4:27=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> wr=
ote:
>
>
> On 24/04/2025 03:03, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > The original code would skip null delay pointers, but when the pointers
> > were converted to point within the spi_device struct, the check was not
> > updated to skip delays of zero. Hence all spi devices that didn't set
> > delays would fail to probe.
> >
> > Fixes: 04e6bb0d6bb1 ("spi: modify set_cs_timing parameter")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >   drivers/spi/spi-tegra114.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> > index 3822d7c8d8edb9730e937df50d1c75e095dd18ec..2a8bb798e95b954fe573f1c=
50445ed2e7fcbfd78 100644
> > --- a/drivers/spi/spi-tegra114.c
> > +++ b/drivers/spi/spi-tegra114.c
> > @@ -728,9 +728,9 @@ static int tegra_spi_set_hw_cs_timing(struct spi_de=
vice *spi)
> >       u32 inactive_cycles;
> >       u8 cs_state;
> >
> > -     if (setup->unit !=3D SPI_DELAY_UNIT_SCK ||
> > -         hold->unit !=3D SPI_DELAY_UNIT_SCK ||
> > -         inactive->unit !=3D SPI_DELAY_UNIT_SCK) {
> > +     if ((setup->unit && setup->unit !=3D SPI_DELAY_UNIT_SCK) ||
> > +         (hold->unit && hold->unit !=3D SPI_DELAY_UNIT_SCK) ||
> > +         (inactive->unit && inactive->unit !=3D SPI_DELAY_UNIT_SCK)) {
>
> The above does not look correct to me. For example, if 'setup->unit' is
> 0, this means that the unit is 'SPI_DELAY_UNIT_USECS' and does not
> indicate that the delay is 0.
>
> Shouldn't the above be ...
>
>   if ((setup && setup->unit !=3D SPI_DELAY_UNIT_SCK) ||
>       (hold && hold->unit !=3D SPI_DELAY_UNIT_SCK) ||
>       (inactive && inactive->unit !=3D SPI_DELAY_UNIT_SCK)) {

This is what the code looked like before 373c36b [0], which dropped
that check because the pointers can never be NULL. Should this check
if ->value is not 0 instead?

Sincerely,
Aaron Kling

[0] https://github.com/torvalds/linux/commit/373c36bf7914e3198ac2654dede499=
f340c52950

