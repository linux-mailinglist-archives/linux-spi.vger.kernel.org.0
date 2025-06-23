Return-Path: <linux-spi+bounces-8721-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B489DAE52FD
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 23:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FBC4A2273
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE515220686;
	Mon, 23 Jun 2025 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C87dIOdB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A811E5206
	for <linux-spi@vger.kernel.org>; Mon, 23 Jun 2025 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715324; cv=none; b=MHr57jZWOY74C4+VEC/x+7D7TnlYtMZdgRdNgEM0yB8GC0YMm8P0oFYdMX80GwkJlcZrEDH+5oiJPyG6wsACotvB63A2B5YwF8DpiNZQhKjrhDPCByce6c0Ch/mkYyqQ54OySzGCGjswetYQXajB0hQEhLLNNNPbBvl7Kh4BrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715324; c=relaxed/simple;
	bh=4bYjjF2yI77Na1nfsIj+g4X8U6tLp5T8SWhZcd9HNQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJK0ru+k6Wb0r75OUxFRUUarzOcsouG1MpkfLUSRi8S6bnGMH+JzmWzIjxAHyiY6dKZFz6Ee75wT0uiN/OGH76+ermiwqFVPzVnU6utg09koX7fNsAtuoHSoZ9UC4ycnre+tZnu9DFlDQ+yuuLgePLtAoDJQvj1MBXB0mcD/wCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C87dIOdB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b595891d2so41404081fa.2
        for <linux-spi@vger.kernel.org>; Mon, 23 Jun 2025 14:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750715321; x=1751320121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnU+QVcxCYxEYL6PbzPZLje0addWyJna8P/l/C/lVg0=;
        b=C87dIOdBKEHiRR4ASB6zeIVNydIg4vXXMHRB2eSnxdu6Xmg1YM/ZB/XV/UH+dnKX8y
         Fa+b0QGkAGRh+BY03nBCQroT2iyjAqOBatlfLU4iPmVgRCxFa/9urbBVLAATmI7pYCVy
         ArFGjm94IyXezHc0arYfoG1Gjzg4bKRyE06HKJs6zOg+4HDa0QY8Q8QpKaiUOk9EvkWE
         6JcQVmglXz8LjQTt34uShPjORshpZIgvpnOomAPhtvLG5aapyx+Mf7SBNwAWNNSCSiJv
         t337DfPivHq8AUIHLn9UaItSg7/ad9v8Xjm+8zR+vF2CnOkKYia72VUSzCfjHk/trSOH
         h2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750715321; x=1751320121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnU+QVcxCYxEYL6PbzPZLje0addWyJna8P/l/C/lVg0=;
        b=pe4BckA/21nZqsecL0qdd/Z/Q3Lhum52E8loP8L3RfNVlAmWt2A9ghbNjPS7ivbrsl
         j2IuLaFdO/DTazyrUVzL/wHL2FmKdqSl8/yUpMdV021Z1Kg17JuJswb0Y8QZiAmHV4AH
         TAramMRHKAmjaNUqqMCBJ36xOLOpeSIzqknpKncrc5pixlZzsU5ZJtki3C1zbK+oEusV
         +MxdHJ29NmycukRK6kzTjWM6hcaXyFM6Xcvk3eOGiX9mvWoQBhU1lXyBcunH90VFA752
         TOOyZc9u7lu9sStXAC6K4ocdxdQAwIPkNDGSPurrgtssfPILWMEaVOsBDkoCYdHDuh7Z
         2DbA==
X-Forwarded-Encrypted: i=1; AJvYcCVekLs8wgUAn5SvgxmRitrE4qWocXgouzdNGd1T2bOPiXiaA+La2t7jiXIYnw7KGlCngTKng1/TE5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxK4Q+ew2kepAqsDZ7xzUn89mDgOGeisBj26ojvdb4GG+vijZa
	09MKXi0/bvISiXe2dQ7y8jdp6bKlXQSQZr11ndPO3cZVCE99W4ab4aOVlOs/Vavp0e5UkLwH/ne
	YyoJWP34Aa7fuuMrzgk0yPVNoyLm/3owXWNVhTyMokw==
X-Gm-Gg: ASbGncsLpbo4hYiPXUHxtbldNo64TY+Qb7zRN1OLKWefcJv0F3c5YRbhD42UOp7v63A
	clxGTG+2bLROhedi8kDR7bL28nvOItz2EI0PHDC38kmIcG0pG484Xah0q2zrgMBIVdPAf4A6nv0
	rJfx017XNnkG23Pzc/Sp0/mytkvLCyX9UZSv5Egn9PhKtg
X-Google-Smtp-Source: AGHT+IFEqza0DpEdoJWsbOSXs+4vZVjClIQT5f7IxRB12yNjDJQmhlzB577QjPcTEosoLth3err0U0r4QBcPWJHQ7Rk=
X-Received: by 2002:a05:651c:1a0c:b0:32a:8c12:babf with SMTP id
 38308e7fff4ca-32b9918b02fmr47960381fa.2.1750715320985; Mon, 23 Jun 2025
 14:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-2-0766f6297430@baylibre.com>
 <aFj5eEvn2uw_HSl0@smile.fi.intel.com>
In-Reply-To: <aFj5eEvn2uw_HSl0@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Jun 2025 15:48:30 -0600
X-Gm-Features: AX0GCFtsL-oycWVZVWTYTg3bjp_VLHo3OYdhTaf-OnhrFfyHZtM-ORpccSVZDA0
Message-ID: <CAMknhBHuJY=8rxgJsMhvRNxZskmPhEZc1jJMQnHzQHFFoucWRA@mail.gmail.com>
Subject: Re: [PATCH 2/9] iio: adc: ad_sigma_delta: use u8 instead of uint8_t
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 12:51=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Jun 20, 2025 at 05:20:08PM -0500, David Lechner wrote:
> > Replace uint8_t with u8 in the ad_sigma_delta driver.
> >
> > Technically, uint8_t comes from the C standard library, while u8 is a
> > Linux kernel type. Since we don't use the C standard library in the
> > kernel, we should use the kernel types instead.
>
> ...
>
> >       unsigned int reset_length =3D sigma_delta->info->num_resetclks;
> > -     uint8_t *buf;
> > +     u8 *buf;
> >       unsigned int size;
> >       int ret;
>
> Wondering if in the cases like this we may make it to be reversed xmas tr=
ee.

Fine with me as long as Jonathan doesn't mind the noise since it looks
like I will be doing a v2 anyway.

>
>         unsigned int reset_length =3D sigma_delta->info->num_resetclks;
>         unsigned int size;
>         u8 *buf;
>         int ret;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

