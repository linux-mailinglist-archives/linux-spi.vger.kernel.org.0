Return-Path: <linux-spi+bounces-11849-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6A4CB2C0A
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 12:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C488830137B4
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB8321428;
	Wed, 10 Dec 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edNWy3IV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC64A205E25
	for <linux-spi@vger.kernel.org>; Wed, 10 Dec 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364423; cv=none; b=D6MPEDdl3AVO92e4jVpq/vlfX8jqEpeZ2lvHVj/tH5nebfjTfTwanKTnEl20T6dpW7S18RWDGK496YvRPlWhYJ2jYA+FRg/VAaQYKBFiNFDomGZTPv6JE1AioZCl0O9Wykt3ks3stgqHAUWHrz2o3FHYyPpI/0RZotESakCGwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364423; c=relaxed/simple;
	bh=NyL9C4Q7nKA3xVfg/2QpoLWEPS5+KcYWdViAB5mP6vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aihaClZXG+MwQuJ4KyvKioRg7fzenGhnVyfAjO4nxIWr1Nx+lu8441VywdPKueloOyeZuuAiet6Q25D4SnSoGkVfMUg7zSJ0hisSYwwL97Xtg+s4RIby2COHaq4jWmtPBR1nuhH+McBvf/h4d5cApRmfhZBMSZjk9m1oP5Z14Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edNWy3IV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7636c96b9aso968162166b.2
        for <linux-spi@vger.kernel.org>; Wed, 10 Dec 2025 03:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765364420; x=1765969220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDGP1HvpfMkO5vmj5IH/U7W1oBMmvxtv1IG7s407g+g=;
        b=edNWy3IVPXPM3zU0wC+OKVwWWtCTa1/IJXbpNDirrBoxMb1Kt2PYezGogg60Nb4H48
         PNN2mdxCWesb+nHbV1TzU6cgTEGqJo/qrm6Ekcq07K07hFTxVr+6eaKUu8Bylg3+fAmz
         1oN9yTrdBF0RO9JYEIP/THEMF1S+8Uuv/46QIdJWrm8h1qeoJ00tNOvniBGU8SIHzwox
         42Bm4ElYEWIxIM0nCghOqgv6WadJKqRKbBUo2ZifquI0MkUyW61LTblN3tevhRHosZXM
         iUsVzx+1tSulRHxFTe2T/7naVYZl9E9HbRt64W7UCQTqsD15n/y8ufuj2rydaJie9HaO
         e2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765364420; x=1765969220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iDGP1HvpfMkO5vmj5IH/U7W1oBMmvxtv1IG7s407g+g=;
        b=rWmK+J2556PSMHUCbpJTb/oSSXk34jBxdXNrtrPZK3Yuoaiu4YEyyx8vA7RLxDuNzW
         sK2ikuSfDSSoAOjmD3YSfbi0E59c2RjdEKCy7Pd6nk/vatE2Y3pUmMbwkce25bJQj+FS
         YDJuNyL0J2lQc6j21qKOjWTjkSIYTNRkNa0shUhaOnmmN58/CabGCGpN3OehZA4iReGK
         +W9POJ3xl08QV7/s0+SAyfej8WdOPLWI6W+M5RplTMoH0P9b6WvuFXKEYJ49rtpP5ifk
         lcDKg0tjEiQ9+sfE7hoKzdvwohNjoMin44rcTVx/gBk+0CLI3I7ZLH9v/eAL1zB+YuHb
         lxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHJDpRmoNFft42JYoCSVc7fw6Ysk5gkwUZTvWtRNN6TJtpa/t8Brs34xbJqUM6fZAS+xF29QEgeBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdc6Pzo19/N0mBnQt9KUM/6U58NIMs7LtGMkf6E/Uf4+D/Eqj
	k4AFPwPVZv0HC7zMIbt/hrcFjsQcsmeZZtwjMZPucTf+7WKQ5J5gdKassh8sUThsL1ZxxJnWLIn
	XG3kSiWpm7r/J68pUet7rtN+QXJ6oDyQ19OWBst4=
X-Gm-Gg: AY/fxX4YnRGmZleS/zmG9ZjmrE9qBTjof8YE2N9ddnh1hpdWzKRuaO7ZlrQenbOKhTx
	cWAsmitv7Azz5Ed2Mz8S2Q1pZRQxm7QxVPqzXEXpPZyKRRigUe5lwRrDy+PRYk1auL3fQ/Sr003
	hyGh+gZwZfXgBb7hj72qCaetqTnZAeKSXlsjZ7uvy2a1WiQLwbcDZogQjumnUke0sv3hHCl5WxO
	xaTMYAyNqC0xa/H27jW2ATz/Pffs/yqQq8o0t6b1aIVoRCa155vjWatX5XgmWk/7qmjYPxIpDvp
	KDJNwIGwfUtyp42RHUz854Avc5RaBBAm0iCF6OpQGOZVp/TUsUtF2pgLn99OVvVahqMaiodfxHR
	aOYgYnYI=
X-Google-Smtp-Source: AGHT+IFw5sv5HXkXEMI2iheFRxQ9CQIewk40C9/tFhkHDACVndFWuGjn2muHwTeRVZoGxiPmcZt+1g/gDVd6sRshhE4=
X-Received: by 2002:a17:907:3da7:b0:b73:8d2e:2d38 with SMTP id
 a640c23a62f3a-b7ce8427b94mr209542666b.50.1765364419760; Wed, 10 Dec 2025
 03:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-4-34e05791de83@baylibre.com>
 <aS79ex5Konr_EeMA@smile.fi.intel.com> <2aca99a6-9541-4cd4-933e-815ceaabe365@baylibre.com>
In-Reply-To: <2aca99a6-9541-4cd4-933e-815ceaabe365@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 10 Dec 2025 12:59:43 +0200
X-Gm-Features: AQt7F2oyHJ70Ni3PdQ_hcep-LsJmXx61VP_xsyFV78eFuHodczdlUa0PKwRFL7A
Message-ID: <CAHp75VeC1VePFHr9y+5spkyGh3viwu1vwdd+jRcDzyZJq_W1Fg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 2:02=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 12/2/25 8:53 AM, Andy Shevchenko wrote:
> > On Mon, Dec 01, 2025 at 08:20:42PM -0600, David Lechner wrote:

...

> >> +static u8 spi_engine_all_lane_flags(struct spi_device *spi)
> >> +{
> >> +    u8 flags =3D 0;
> >
> >> +    int i;
> >
> > Why signed?
>
> Because it is conventional.

I would expect the variable to be the same or close enough to the one
that defines the limit.

> >> +    for (i =3D 0; i < spi->num_data_lanes; i++)
> >> +            flags |=3D BIT(spi->data_lanes[i]);
> >> +
> >> +    return flags;
> >> +}

...

> >>      version =3D readl(spi_engine->base + ADI_AXI_REG_VERSION);
> >> -    if (ADI_AXI_PCORE_VER_MAJOR(version) !=3D 1) {
> >> +    if (ADI_AXI_PCORE_VER_MAJOR(version) > 2) {
> >
> > But this includes v0 as well!
>
> I think it is OK. There was never a version 0 released, nor
> is one expected.

Perhaps a note in the commit message?

> >>      }

--=20
With Best Regards,
Andy Shevchenko

