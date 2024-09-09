Return-Path: <linux-spi+bounces-4740-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8953971546
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 12:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30461C20A2B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D541B3B2A;
	Mon,  9 Sep 2024 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2IQvUu1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA161AC8BF;
	Mon,  9 Sep 2024 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877572; cv=none; b=H1i+VMtHWJ4Uz8iaoFou5afujhPqbdtG8ZL+2KgFcoeuSC1MzHSkmlum4c/sQAA84L6eIEqjxljTYz9dIWfIN9+AvihX/OKJLs2m2ItXy7Vt8h3dbMKRirVyREgsc1nKxdv1zfeHhEJQEh97dnU9uKtGHG48y+x5vwwq0cnlu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877572; c=relaxed/simple;
	bh=vjRysiKxyGdGA4AY0ytCy+i5GAF/On6Gr0J08cUMKDk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pm1S2sByojc1GQp6C6zXPvVcoXx+zi63EAc9ECxhrVvOA/S8JaBAtROCNI7oMcU0QWXe8NrJ6bAcPb5BrEExLDNxVg8KUsy7086wCOuyGEEN35ojCf0dGgGRmM9MAQdggFc5XFaqvtms8TAOeMHnAYrXe7a92Jj53wlDjPVEuqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2IQvUu1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371941bbfb0so2480416f8f.0;
        Mon, 09 Sep 2024 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725877569; x=1726482369; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISibUxuI97oG6O4QKOeX0myJkEm0PAQbIlWNwEF4zn8=;
        b=m2IQvUu140F9HVv/JPWkAjMoZ9XmpSC5sMxBRa2hgNLrrv70BblE+EArux7UG2Mg5B
         JqJ0WErmVdnaom0KN7l7FWQd1Oh8WJmdSZbVNhCDshZGN0iccdXM/vpkrKmt6v0jn+eR
         dZNEsN4LmYVArDlLbjTJVkNz1T5QYl5ceYOQBp8nyeswxPdcckxNcFhh6wmu51mEgL6K
         LixwhxNZgMBxfHYQHku28FYAgD3enuafxJOOWwm16obnABGz93uLvXANtQJofQfqebyt
         sEQzLyuq5Zqpr+JJWeAPJCCLplvWrYUeylRNj3RTyjHZFOyXjqswqyuJdd6KEfwv6B/b
         vHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725877569; x=1726482369;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISibUxuI97oG6O4QKOeX0myJkEm0PAQbIlWNwEF4zn8=;
        b=fA3u+FHGpIZ9YR9shwsSSKFx77vHQXeiwnmf58jv9jPNkBFYxTmIk/hEN/k2IOLfWi
         HS3R6Te0cT+ST5LEVuxsK3211z050UkPg3cdqO4DSpDcw4qzqYlP4XHnN2DOZVvF32I/
         /Nri7pkomn6rEUPs/kmUh396KRhoRQICp0tZv90fX8WJEJIKMH/pvyHJ+cvcoe9sH378
         cYlgBwKfrnzg4CzLnRRicRMWZ10xVQAW8m+hiLLMYtbr2uJf70/dXS3G476xE3CWErdA
         HKpcGw2IcrUgkR7xENpChhIjYJH1wcyB3VYpeLABAPTQl+EiyBXag8pa94Y9eo2DQn9e
         3cCw==
X-Forwarded-Encrypted: i=1; AJvYcCURdAI3M602erfQtVSHFgtFS6qkLibQ6w93X37G+0uUykctcBAOzQLMf2SWXPahlBzfd63CybnScLhreSZI@vger.kernel.org, AJvYcCUmb/B0HpezQvCg/QqSbUF61lP2cQOD3UEj0AD1dG6iy6wYeFz97j7RD0BC6ENyWKXVzxQpZ9Hpdz3Q@vger.kernel.org, AJvYcCWgGtQtq2w9CihIUwndf3iHGE8Zki8VZwCawSHhKSOQFwZSElakVYXGufh0on+Lp7pNPfzkm4mlUL69@vger.kernel.org, AJvYcCX+baSUJEozkYTnQoDPGlFx687ddZ9ggqi5TUWQHUZ37vou1XD5BOYgVZ6YF8swPoEKSCsWH1Vvi4P5xWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4J8/HziY8qf2KkiH0VVMH0gd0jQR3DyqeThTWORZMSibkj5w
	9IqnDDs+bH+2NAf+bdbCb4mSArOmzOGlh3B8MaNixZ7raMagGTYi
X-Google-Smtp-Source: AGHT+IGBK9cph81z/hY52nwArccd2p7hMtUV1kAy86UaX3SM3/dXzcfTpymVaLI65YmnG+9CrrYawA==
X-Received: by 2002:a5d:5547:0:b0:374:c31e:971a with SMTP id ffacd0b85a97d-378922b81f4mr4172859f8f.0.1725877568946;
        Mon, 09 Sep 2024 03:26:08 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956767c4sm5651474f8f.63.2024.09.09.03.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:26:08 -0700 (PDT)
Message-ID: <fd23afc9700089acddec7537133dc96975580b07.camel@gmail.com>
Subject: Re: [PATCH v3 1/3] input: touchscreem: ad7877: add match table
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michael
 Hennerich <michael.hennerich@analog.com>, Mark Brown <broonie@kernel.org>, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Date: Mon, 09 Sep 2024 12:30:17 +0200
In-Reply-To: <20240909093101.14113-1-antoniu.miclaus@analog.com>
References: <20240909093101.14113-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-09 at 12:30 +0300, Antoniu Miclaus wrote:
> Add match table for the ad7877 driver and define the compatible string.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v3.
> =C2=A0drivers/input/touchscreen/ad7877.c | 7 +++++++
> =C2=A01 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/input/touchscreen/ad7877.c
> b/drivers/input/touchscreen/ad7877.c
> index a0598e9c7aff..7886454a19c6 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -805,10 +805,17 @@ static int ad7877_resume(struct device *dev)
> =C2=A0
> =C2=A0static DEFINE_SIMPLE_DEV_PM_OPS(ad7877_pm, ad7877_suspend, ad7877_r=
esume);
> =C2=A0
> +static const struct of_device_id ad7877_of_match[] =3D {
> +	{ .compatible =3D "adi,ad7877", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7877_of_match);
> +

Just curious, is there any reason for this patch to be split from patch 2? =
Also,
this patch should directly include mod_devicetable.h for 'struct of_device_=
id'
(instead of relying in other headers).

- Nuno S=C3=A1


