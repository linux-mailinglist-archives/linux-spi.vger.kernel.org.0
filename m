Return-Path: <linux-spi+bounces-2321-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A228A1E73
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 20:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C821C24193
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B523F4F1F2;
	Thu, 11 Apr 2024 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlueOTAv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDE4F207;
	Thu, 11 Apr 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858917; cv=none; b=nmm50Tl2JWD/3SK8wVcIfFwziomFb1mfhlLSXCL6aHJekbFLCSI+V6/k24U9TFx5ZvnvRdfjxwEvFYOxxDN8Unpr24qqVIHMqt8OB2cQ1moFwVIevsCClcTiTFPtOzPB019RK/wNKNc+4DhRIAbL2jY5lZYeiMNSYO0D+bq3l1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858917; c=relaxed/simple;
	bh=9KoLhmJ62HZS/u1+U2FiEcVIp81BpXJI6juZOrEXQ4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7kqtEE3ho7Aw4s2IRzGdGaNcSZ29u954cZHxgJpbm7sOGtmjqhOg5KfMfklY3UZh1x6HtrtmQs+wNH9KuP526yTCu/hr+tUcGHBiM8M0167YeMDt8jZmNOKIoS+WyPjEaU9PugXL1Y395285T+H8NU6pxwA4B4g5Vok8kqyeGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlueOTAv; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51d3193e54so9354766b.2;
        Thu, 11 Apr 2024 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858914; x=1713463714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KoLhmJ62HZS/u1+U2FiEcVIp81BpXJI6juZOrEXQ4Q=;
        b=AlueOTAvfb4o1JW0A+vLXodE6Niqn8RjktU1N1qcMzVn/hTi/rIq0nHBh2egibYvNh
         fMAIvU0BRr0Tqm1jd0LFNW4ryj5ufaYCTyqbRrPOnsGiCl4rnXZhjFVIyNs/51WasA/I
         3NDlJTsanpliwjzOng/YKa4210+qI/eqVyO5DTtyY0wcbFX8U4Me8xYA+qeIEsozg2U6
         hxQihLpmN9pTxjVsCnwocJtBSaB1m22widVDa+kIhVINuX2BQvux1yul/v4XESBnsK6g
         4GG08uJkDPY+38HkxSdzoRWYnBvESDWDFHEUkTttIDBIjRWajwFZyAeEk01Xo0aViwNA
         wfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858914; x=1713463714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KoLhmJ62HZS/u1+U2FiEcVIp81BpXJI6juZOrEXQ4Q=;
        b=dS3EOeU+9koR7s7DCof1ApPSA4HyiYMv08Ixd2BCr9J/21bQ4WKKnCRlj8AVE2S9uP
         tpBHhg3Dwm7lXac2Pe87ZTJOEPULFd83lbVtChgNs8u8JzwORkAoI/WamMGiz/WO44D2
         hTI8vuJQGbTuWQw4YNH4oO20aFIgbR+I/fD+BAMMUx5pfP6v7Uf7WuNLwjnQ+xz2cFpQ
         fYYYTqcQPbwwvB3gyoZZ7x4Hi9U1Z9y+HIR+lvvF4QXmkS1pgAW6owbixHUcGVHAMK3G
         ZUirx/aiA7DlmoZVIJnv6WmM6OaNLkNrmtNe7LkyEeB8KwvudaTPATyp4Yd33aDxMDZq
         Gx+A==
X-Forwarded-Encrypted: i=1; AJvYcCU+iS6O71PaikBLI/8cisQGC1BMnxADJfxOWTAA5K74ivjG/JXo3wuOUpMidPT560Db8m+O5BFbifQ2YWte1tOqXIMuxQP/0JOIhQe5dAQTFv/j0y+z3Nm9x5aZt6T9fc9iTi7PUA==
X-Gm-Message-State: AOJu0YwVtH5d1BZk+Jf+5CVU48V5TMwi/O4iSwJtKFji/FDbqpaEkgpj
	DDr0BUSR9TdUt/POuiJWe2p+hEX9oDy3Nh+XA9p52kiGTFg4gcP+f+nPbmf8CNZjCZaAEtYq5ps
	Xj1bNCBvbJM9u1fnCOpZQPl+g4H7lP+n1
X-Google-Smtp-Source: AGHT+IGOi7sU6kub3c5gEseOSUqSZwpxQDU6SH5YGpxSgthio8s/COAH4tc4JSyx380Y36ZS7zgXBahadb/B3hRv0+Q=
X-Received: by 2002:a17:907:1b1d:b0:a52:2b39:879b with SMTP id
 mp29-20020a1709071b1d00b00a522b39879bmr283598ejc.46.1712858914283; Thu, 11
 Apr 2024 11:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-4-ckeepax@opensource.cirrus.com> <CAHp75VefB7fN8Bf3ZJ6sYnqdiHxoJ87zjDWERoEXNfY+NzosPA@mail.gmail.com>
 <ZhgYNfSXjqNksKmY@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZhgYNfSXjqNksKmY@ediswmail9.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 21:07:57 +0300
Message-ID: <CAHp75VedO9pqUEU0+c-c47HLLymiKbQzbx3u_FTqtp1FF+L67A@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] spi: Update swnode based SPI devices to use the
 fwnode name
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:04=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Apr 11, 2024 at 04:33:05PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:

...

> > Thinking more about this, maybe even the ACPI case also can be combined=
?
> > See for the details
> >
> > 87526603c892 ("irqdomain: Get rid of special treatment for ACPI in
> > __irq_domain_add()")
> > 9ed78b05f998 ("irqdomain: Allow software nodes for IRQ domain creation"=
)
>
> Maybe, I am not super confident that acpi_dev_name will always
> return the same thing as fwnode_get_name and I don't really want
> to risk renaming everything on the ACPI side.

Scratch this. They are completely different.

--=20
With Best Regards,
Andy Shevchenko

