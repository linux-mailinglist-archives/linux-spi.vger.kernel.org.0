Return-Path: <linux-spi+bounces-11293-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F6C6DC13
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0DAAA2D742
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 09:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47A26F2A8;
	Wed, 19 Nov 2025 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFWsnPy2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81533F37E
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545001; cv=none; b=XiaMJsPf6M/wrrWXW+cSQEdRQCS3IKogaZV5D77KpYtqdzO7glziPjhW3BGdna4BWzZ23EtAKHYuh+7NBoIh/0wTsp2J6yakAa9gkebRCnWFI5RTa8BE46jcPqs3lpyXg/aJMq57TkhhLkYYImMMFHCkhX09iQmI76d1EkiUoX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545001; c=relaxed/simple;
	bh=EwpFOpKSeT2IIgWwf4A6fjtTnKG/2B0BxDZMFD7RoT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgOzaLRwTzNWFGn1WLruwAFx6GqVDQfUW+YBaNf/fuv+clGviZi9vWmNd4EJfu7F2vuZMd2wYXarD4qhTJaxhVyVjMAaDFZtCf5H8My+Kt/6ZrgYyBxtJ+bQZic7MxA8qF+6hQqkqw7G6QkO4nkvGwNDSjKLVD4XjcqYEAYc67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFWsnPy2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b735487129fso1041002766b.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 01:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763544998; x=1764149798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwpFOpKSeT2IIgWwf4A6fjtTnKG/2B0BxDZMFD7RoT4=;
        b=aFWsnPy2ZrXRmkYiMny7o3al7vW/cE/5ZQwttEt9FFWyyio0g48k3FqqwuH4+Q1z9Y
         2bJVG7Dmvq2pwR69huUgQFqiDEWaYZM9l1cZDhRBsfLX43YuEeZygY8NYiM89x34ZWTB
         1etScBXBCiU8haWOt1xOQieHtto8t7t4ThgTSRL8qEu/A501pFiapLVsV31qfvFI7r+N
         JuQ999O/JKgO4mVakWADR8Chw8ISOQ/bfgqRtgVaVfrhMinXzHXTvLtfBI6GXZ+Xwuau
         26G8VgaUnz77H59Jc0I9utUML4G9Mo6MfoTEPzZAsnub/BGp9X/9MWurxGD45w7nngOS
         hIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544998; x=1764149798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EwpFOpKSeT2IIgWwf4A6fjtTnKG/2B0BxDZMFD7RoT4=;
        b=ZQhjMqxQQ94qiO73lbECg91yQlBpMqxFZRblhc63G4MCZXKzZ3jmcY12TuZGMc8RFn
         TPpKMukzD+aC/bdX8WvvRYiWbJp4WUcY82JGtqX1muazZARrh/tIjejSKnqNkOWHQ4aX
         bAXTXbHjstc+XcCoqjoxZFF4+4Nbp83nM3aks66Nnwf4wM3NCjFcJD5r3+RNFoHTD7d6
         zBfboPAScSHzbpNLHRIjawwdyrtfnO/qAwIq/l0G8GZeztbW1JPNs0f437+hQMat1PDO
         h/g+BSbXfyRIZ9QAdoIt/cs0+XGFOtup5Z92x+xJrXVftQGBfFET8DsSMNdtJ6DvSHF3
         C4oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZxO5f8tyqzHKbJ3o77RiS0x+IEouUbtWVsgb4b80mMUlHNkEGQDHnJx52Tb3fUft1UABbnwJRmCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYWjOoDqaY5Pi3GUm0M5QLn18CQGCgyjnaZrCEf5tWNKMw7Zm
	CnEh0vWuQAPyzyGL5neaBMMW8s304hGCXQDMSZTL7GV2zyBH7at20L/IQj5mf2FUf7ojv4HRSrK
	wbTt1BWW2Q64Z7+uKhFIO49HSGLB+cEdfW5ky
X-Gm-Gg: ASbGncubkemhO/ar+tIhUgiULRK+dpQmWwMzf/mzEPI+44xVpIAmx6058bm3IkVB45B
	R6wPD2+/ufNaDNVN6DbKgjLfyituXAmyU7AcMZiB5dvksaXXBmoPjTrxqDWyYwe+9bq/Q38thXH
	Zdq3gLJLSR2nclDO7RDl+n58UPnqaXgvfATBEo82FMmdqS+Dyt/ZgUjTfKYK5P6QEnTv/xR1SXI
	K5VJGsEu0EyinPni0kBShCaiBTHYAfmF4p+D32UZ4yCcefMDoIGJIemPAh+Agvij9jJO9qXHt4R
	AQ5tL4JWG3zUpL210FS7BC927fW1Zufu8wrFyP2dVUK5gy60/hnx/00osK44F12u9TWdBaidMqs
	UaSg/cA==
X-Google-Smtp-Source: AGHT+IE27i7hoAlf326zvHcnsypDk3gUEOvHcV9e/0Mq2i5aLrYdZkNHIjUUaxQc7fTqMaxdOgU/HSM4R3NSm8D7qss=
X-Received: by 2002:a17:906:6a0a:b0:b73:8798:3bf8 with SMTP id
 a640c23a62f3a-b7387984551mr1449356766b.34.1763544997344; Wed, 19 Nov 2025
 01:36:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org> <aR2OU4se7lxcMtGW@opensource.cirrus.com>
In-Reply-To: <aR2OU4se7lxcMtGW@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Nov 2025 11:35:58 +0200
X-Gm-Features: AWmQ_bmQluZVGPpR-sh0C6St3sdk3Ta02-8QVAAA-vYLV5ztaPhQBmRG8cULlDw
Message-ID: <CAHp75VdB5j8BHTdLVai1TpjEyb6K6f-WB+Tnkmn1TtaQrDspJg@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Maciej Strozek <mstrozek@opensource.cirrus.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 11:31=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Wed, Nov 19, 2025 at 10:10:24AM +0100, Bartosz Golaszewski wrote:

...

> Although maybe that real node would take preference over the
> swnode?

The current design of fwnode assumes primary (usually from real FW)
and secondary (usually the SW node) and the code looks first for the
property in the primary node. Hence, if that will give you the match,
the secondary will be ignored.


--=20
With Best Regards,
Andy Shevchenko

