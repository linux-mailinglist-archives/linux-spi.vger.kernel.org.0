Return-Path: <linux-spi+bounces-11659-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A4C93065
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 20:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73AE3AD6A8
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 19:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E4827F18B;
	Fri, 28 Nov 2025 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDZFa99T"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F11255F31
	for <linux-spi@vger.kernel.org>; Fri, 28 Nov 2025 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764358257; cv=none; b=RsVYEAWwabVcmfI9igOitRvNhqVIhd5XQ/BIAZqtGoIBWlYdzRn6r8ZreIZGZ13IiNVGtNslsLiVYGx/JnRjSB7XsQ7Q5pJ1kTy/sV8WqlZAkjl40m/anCJLeyCZdHfMS7pSpjLDGfTPsfxUdKqbthdOb/6q2UXBmhyXRTvtuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764358257; c=relaxed/simple;
	bh=7fDKOiPRL+jeUG4/faH/k6QmMbJQxTR6AB86PQKLOC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quaTrRBK2tyhpmDCO+gsKpOujHmfgCTbsfoZ21UsIwPYkGvN9duOBD1U9tDLhV2/XuG3tfznp78GzbZSCDxXRq1O45yGEWF5e3xVi5S2SAXtaenUvUDEAPiYt0k6bRskybp9CtFCoI9167b+DXi29PVyU7yfPT8aCBuIz2Mb4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDZFa99T; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63f97c4eccaso2000226d50.2
        for <linux-spi@vger.kernel.org>; Fri, 28 Nov 2025 11:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764358255; x=1764963055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xAd+ASuEhvruiqqqS1VkXuxRaI3omsRzXSJff68rbE=;
        b=DDZFa99Tm2JiLOrBFsHcpDYI9Bg6W2b+rcR1l42HOoRPvMnWm9xPmlDIPfDUZ6R4JB
         MSRgCW/EvDBxZlQ2PMt3PSfQeUGqLsdKYqyTMqfDCkhM27Zi7iMzThgoG03zlKnkh00B
         LtKy+tI5QHXTZCZKRVN7e5p9jUCKGokP0tI4CZpdXip30B+QaeAmwCcaHDxO0YW3AyCW
         fZcLus5tuZYmnxl+ShtUvgFa31oN5RLeLiSfGJ8/mS5Bq0GWYdM5EO6l5Ow/+vQhSJ0b
         LGKWjV/bp7B9jw3eRWxWCiSLOwnsEG+v9UhM985kMdKjo9uGSwQJ5ln/0yGsnbAOEZ77
         7/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764358255; x=1764963055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5xAd+ASuEhvruiqqqS1VkXuxRaI3omsRzXSJff68rbE=;
        b=G0J+xEznTrj6gQwg4QUEHJGNHel6K1+NgcuBkV9dGGCu5HBh7XW2+jY3GPFNMLa7Ta
         RnurGMmgy4vzRL71q3S8TPcSaoV4h+k82ZqG9hl21rV1LV2Z1DIziEWiq+CDROf5NiHK
         PweG7upH90VhDeSEhYfoATw4i1KN0PvtXgcS4Ut0P8w58jfFndD2TkOiU0/4EFL89B6C
         24I9LXvsSZ7eFEOYrZzwmVp2nFM2PUI1F/ELDrro6r+Tci6AOb9sBpKumHi2jbnJ7Lmj
         nr7X+zyz6G0jVaJxFk55/CrhlE7CGtH8AUTYJbx0pEdtjn7pf7cc1YWbYVRnFlQraCUW
         X2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtCGBAkRaTlq1S+fAR/2UlefoeMVK8GQ/ZPwTJaLSHtoRLzAYF1Yc992LAonNvSOczX9ZY930Eg3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAaIBu0hjap4ejTzAzlrj9YtRruGX8XygjbL3gRSyJpLHDZOI/
	cXez+7on87kF5uDFX91+7/vYJdMX0ddK4BwMQ2azSqY67jtFLmRTiULgKd4qe6nL1UJJCS/oDkf
	Zy4e7PEpn+bzhL6sYEhT91dhkfF8p+zc=
X-Gm-Gg: ASbGnctXvDdaTqdwpR4ySuXSeNYQHxm5YwWT7TYOoeTOkGf8MI9QUXkHjUsmngdykTu
	vuBubbiZIiZnf6l6Zjfh9hakvem4eWpuLmhyTa5FKcaLiVYb2mGtCOX1FE0kd9f9ZgCz0kPUS+K
	HqS5QAh9agKaq51tHyNhyVtJh0RhwYt7gqFMUPX5ee9tWNRfA708ZVVz3AJSCkL8crUvhSewY7I
	nB782LLkoUAften1usiAHxg+iLEO1DjUjdoJUQG5VPVAbjiGb6eut1UmjbBEZojcHFCjw==
X-Google-Smtp-Source: AGHT+IHnC8LPnhSfG+oQ9BnWocPWNMrndMWjmQBMW42OYy0Tfb+ry37q69w8RBuj3IVAcDntxKyjoACvfPod9mNmrPI=
X-Received: by 2002:a53:c058:0:20b0:63f:abbe:3964 with SMTP id
 956f58d0204a3-64302a61a6dmr17349578d50.13.1764358255324; Fri, 28 Nov 2025
 11:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128185518.3989250-1-andriy.shevchenko@linux.intel.com> <20251128185518.3989250-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251128185518.3989250-3-andriy.shevchenko@linux.intel.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 28 Nov 2025 20:30:43 +0100
X-Gm-Features: AWmQ_bk9kRjlW72OY4DdLuUSzwXKVWlZA97eNqqfb6mT1rM3GqUOny9E1GJR1EE
Message-ID: <CAOiHx==y-4Jjckr-KnwdmJhi=TR9_wzcHvNo8GAeUmJ43Y_bHw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] spi: microchip-core: use XOR instead of ANDNOT to
 simplify the logic
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 7:56=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use XOR instead of ANDNOT to simplify the logic. The current approach
> with (foo & BAR & ~baz) is harder to process than more usual pattern
> for the comparing misconfiguration using ((foo ^ baz) & BAR) which
> can be read as "find all different bits between foo and baz that are
> related to BAR (mask)". Besides that it makes binary code shorter.
>
> Function                                     old     new   delta
> mchp_corespi_setup                           103      99      -4
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/spi/spi-microchip-core-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-micro=
chip-core-spi.c
> index 98bf0e6cd00e..2f4b21ad56a7 100644
> --- a/drivers/spi/spi-microchip-core-spi.c
> +++ b/drivers/spi/spi-microchip-core-spi.c
> @@ -161,7 +161,7 @@ static int mchp_corespi_setup(struct spi_device *spi)
>                 return -EOPNOTSUPP;
>         }
>
> -       if (spi->mode & SPI_MODE_X_MASK & ~spi->controller->mode_bits) {
> +       if ((spi->mode ^ spi->controller->mode_bits) & SPI_MODE_X_MASK) {

This changes the behavior: if a bit isn't set in spi->mode that is set
in mode_bits, it would have been previously accepted, now it's
refused. E.g. controller has (SPI_CPOL | SPI_CPHA), device only
SPI_CPOL. 0x1 & 0x3 & ~0x3 =3D> 0, vs (0x1 ^ 0x3) & 0x3 =3D> 0x2

If this is the actually intended behavior here, it is a fix and should
carry a Fixes tag (the message below implies that).

>                 dev_err(&spi->dev, "incompatible CPOL/CPHA, must match co=
ntroller's Motorola mode\n");
>                 return -EINVAL;
>         }

Best regards,
Jonas

