Return-Path: <linux-spi+bounces-9073-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E13CAFCFFE
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jul 2025 18:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48B817940E
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jul 2025 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634842E4242;
	Tue,  8 Jul 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WLj3qSiR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC452E3B04;
	Tue,  8 Jul 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990531; cv=none; b=FakeQmi+Pev+wyoAk14GUF9LatyKOV7An1SbFbHghbqQdJc3BBVk60jKKoGWnc/xQeYsEzSSR3d5X7sU32PVpKEgiQJK9h3wDRwI5VwqBd4X/LOqXsAxxykcvkpWFLOucXfbXvYSSEQvXJ52SOjKM1QGv0VhFZo5UsVRp7WKyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990531; c=relaxed/simple;
	bh=WZrn6LujtO6NsLVvITf9+xGxJYx5Oo7dKbMFr3Gtgxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R++VwaLdnBMMsAvbJieEzQfDMX8uwyBwk15ww67mGnP9J64SCX81SayMxyoxtjOty/Hw7njYmQRCy+viWYhX9ytmNe9pN/CljVyNttXHKwxcfQSgy7sxX7oMzIrvmPATL8oiGCgMaubl4XkQ4ymjwmoxjINae42/GS44yokJtqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WLj3qSiR; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87f161d449dso3406714241.3;
        Tue, 08 Jul 2025 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1751990528; x=1752595328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCM6ovO5L3ci76w7Yr/1xFTj1/PqUrpAr14Rz9Xck/c=;
        b=WLj3qSiR5SZkgznkZASvXc2DQ6waXgMVD3ICBl4TUclXKzYId6FEJo9TV5+SKsbUg9
         CgqBgwaTwZVe/fVZsUzVf8KXLoFBc12Sj6oeKl/Kw4iNPZOZZ6ayu5wZ1gobuHcbIuZ+
         2zxm1sZcZFutKawFR4uieSTVPxzWzfvlll7Mh64M3U+VhT5ZJbJ8WP4pYuwKFmnU62/B
         atIcnMujXXuO/FaDC0/c25Cf3eR6P412y7o1VsHE1CW7v72E4bbbtDU6VVXP/iVXfU2Y
         8EWljzu69e9ce1QG7zQXUPE9ikD9JZ5OdQK+UxVef0SXHFlTTHIyao0psRBqDBn+1dJ/
         E7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990528; x=1752595328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCM6ovO5L3ci76w7Yr/1xFTj1/PqUrpAr14Rz9Xck/c=;
        b=TklCA24VTOmcYznSW7fIxot2sjK41sZV6Wn5W3H2akqarIspiizSkjKeYGLsXlxHQz
         TeAePYg/r2kVL39SZ9pPLU1J/SMB174Rl5n/kx8GbVGdRRoRAp6fYLskJFzOhfcnB8zQ
         TVdD6Yo4nXLMcOqDXb1Cwsz/s8OPBfsX29WAHLzER0cufQhdsIExNOylZyEiT6wEW5s4
         k/RQEIxxoS+7aKxL+ByhC1bTid5lK00OTo83fC64KiXFVPLW9qq8gLz6Of7DIqWhzDE5
         g0v5SiChL43RcBiaBEVVK/xbEzD813IXusxk2Of7UtY21OwPp0u1xRvx+clexYjsS8Q5
         djHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVSTidcuzmPMmOACvickc6jKo9hmFqqYl8P97IPLkFVuEdvpuuJBbAE9PHS+ETVgX2YM0ThXGqE7vj@vger.kernel.org, AJvYcCWXA5svKY/0WFxNLN5LA2mzDe2aN2W+fcV2VytKQkj/CJ7cHXtHR9C4RpRZZoEBTNcBSDX/pXSrqe+X@vger.kernel.org, AJvYcCXR8Ki5UJsVXiLAGcUXy1SDeacai99Zar59Re1DzRCQaps1KS9o9yND+VaRCv3cKOqn018/vYdlSl2FwY46@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrUQRntuQQlD1fGKjYUrvPeACN/3Quf9KqUsxPD2+oiV3hycH
	L6IlWQXLZQRO5m3hL5gjSof0XRyYi2kTZEXd+4q5uLhbGuWzIICw2zpJrAcsV+j2TKc67UYvEoT
	sOumKFTIqVyC8kyfJyh8npW6PujI46tlYG6sC
X-Gm-Gg: ASbGnctlKfwxfukC0A7FqvQDESdsWn6OBpTfxY9hoDIOsxxou9EXfH4AlDBAC0Nv+o9
	TSNmBopF/wkHytwIcjE1t5DSde6Bt8EZyRiHJ2iZtZ5OSTnefCoj4iXEuM5mMcMw/th9ax+khdy
	Cq2HQditeGNINnea7E6RPlBgzNrOgkg9cjoaGhanuu1pU5x2MQEaUi+5D+dQ6yBa11VrtMfmdzR
	yE=
X-Google-Smtp-Source: AGHT+IENP/DbHEOmXazWnqdsKnY+LYuCikhD7sRqatVwo+/hDfRbpoohC07uCw491fbaRThr0kbx8qgWACdDFljdvmw=
X-Received: by 2002:a17:902:daca:b0:235:f298:cbbd with SMTP id
 d9443c01a7336-23c8747eddcmr316693035ad.21.1751990517129; Tue, 08 Jul 2025
 09:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com> <20250704-spisg-v4-2-6b731dfbe610@amlogic.com>
In-Reply-To: <20250704-spisg-v4-2-6b731dfbe610@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 8 Jul 2025 18:01:45 +0200
X-Gm-Features: Ac12FXzOu7a6I2ZVTETrFDoplFmbCGvI4ZO5J3eEez7q6yQ4MAf6A0pZTz-sze0
Message-ID: <CAFBinCB4Lw04StL-kPpzKHPyETKfi5FYFipHRBDDnPdtRVDrmA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
To: xianwei.zhao@amlogic.com
Cc: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 4, 2025 at 5:07=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
[...]
> +       div->table =3D tbl;
> +
> +       /* Register value should not be outside of the table */
> +       regmap_update_bits(spisg->map, SPISG_REG_CFG_BUS, CFG_CLK_DIV,
> +                          FIELD_PREP(CFG_CLK_DIV, SPISG_CLK_DIV_MIN - 1)=
);
Are you doing this to prevent errors for value zero?
If so, is CLK_DIVIDER_MAX_AT_ZERO applicable instead (it has been
discussed for the t7 clock controller recently: [0])?

> +       /* Register clk-divider */
> +       parent_names[0] =3D __clk_get_name(spisg->pclk);
Instead of using __clk_get_name my suggestion is to use struct
clk_parent_data with .fw_name set.
If you want to simplify the code further you can use helper macros
like CLK_HW_INIT_FW_NAME

> +       snprintf(name, sizeof(name), "%s_div", dev_name(dev));
> +       init.name =3D name;
> +       init.ops =3D &clk_divider_ops;
> +       init.flags =3D CLK_SET_RATE_PARENT;
> +       init.parent_names =3D parent_names;
> +       init.num_parents =3D 1;
> +       div->hw.init =3D &init;
> +
> +       spisg->sclk =3D devm_clk_register(dev, &div->hw);
My understanding is that devm_clk_register() is not recommended for new dri=
vers.
The replacement is to use devm_clk_hw_register() first, then
devm_clk_hw_get_clk(). drivers/pwm/pwm-meson.c implements this in case
you're looking for an example


[...]
> +static int aml_spisg_probe(struct platform_device *pdev)
> +{
> +       struct spi_controller *ctlr;
> +       struct spisg_device *spisg;
> +       struct device *dev =3D &pdev->dev;
> +       void __iomem *base;
> +       int ret, irq;
> +
> +       const struct regmap_config aml_regmap_config =3D {
> +               .reg_bits =3D 32,
> +               .val_bits =3D 32,
> +               .reg_stride =3D 4,
> +               .max_register =3D SPISG_MAX_REG,
> +       };
Most regmap_configs in Amlogic drivers are static const.
If you make it a static const then I suggest renaming the variable to
aml_spisg_regmap_config for consistency.

[...]
> +       device_reset_optional(dev);
I haven't checked the reset code but I think the return value still
needs to be checked (drivers/mmc/host/meson-gx-mmc.c does so).
Even though the reset is optional there's conditions where we must act
for example on -EPROBE_DEFER (which must be propagated).


Best regards,
Martin


[0] https://lore.kernel.org/linux-amlogic/bd68352f-7f8c-4cbc-9f4f-f83645cc1=
f70@amlogic.com/

