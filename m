Return-Path: <linux-spi+bounces-2310-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B97AF8A159B
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 15:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 509B7B24754
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 13:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5614F125;
	Thu, 11 Apr 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5wJsp5Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B914F9D7;
	Thu, 11 Apr 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842424; cv=none; b=qaZdEtbjkYy8SW+myc7BbnSBhBcpjoSi8mPrf+/BgdCr0KpQvR7Vzno0uaPKpf1s2q1EnFZO1ayDtgrrC/aLd5fNLIfFLjNoUmJPQfw6+8Z8wW/r01a5CravF+uxoX2s1Uzzc6/b5T8FzYZ0h4cv7r5E3xlORZxF+dQzzcP5kzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842424; c=relaxed/simple;
	bh=I94ipfx2TNTJw+LkKEJqQzm3Mt7zbdi8apTqD/1MGsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWV27yH4WgHzZwb1KCI2BN0yGsSQ4BJUScSx9NKF65olUKbst326JSJeXwg8W8orPjZy7c9wO7FEIj38OeVBsmnwnav/fvB8cu3gx4O37kL52ciZJ7nPMKJMZ7o3bOlKAFwiR+b5tjjFzsO2saIu+ACPx5tglidHZNF3Yo3ddbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5wJsp5Z; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a52176b2cb6so165136766b.2;
        Thu, 11 Apr 2024 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712842421; x=1713447221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzVbincBYyE5qZwRAEXwYM35pwlF7NqzXwqmp8oeEWg=;
        b=m5wJsp5ZnUeWK3V/HF7Z6K1KQXAM5+jIkrEwmzW9AIFGXZdWheTYi5FgmwhF2cYcCE
         9I4aH6PbHDBBp0SqKnIqnejlr1JMufvsgiPz2vUbN2IbdXMuu29/J/8sW1SihxbCqlgh
         WTrX1K9VnHvYcZZVuiZ3cTqibsfjo/p5hzlscaLGgwtpRpPp74whystLGWTthGfo+4oM
         V8dB7yhzUMinr7Y2AS8EHUwONsAJOrmWeS83jimPyRLSB8M+hO3Jj3IyrqOF1Quhdddt
         W6JAbLgKJ8SZZKs0IXCpmKFuJ4iAEFYdZr+tCdl4rwy9Tatm0sPA01FqkGAob1GuHvBp
         H7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842421; x=1713447221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzVbincBYyE5qZwRAEXwYM35pwlF7NqzXwqmp8oeEWg=;
        b=aLG9QgEr1ZWOQXPKhtKd9C6qkmoaWad/u25G/UpkEzSeIWwL4RjCO5U8THzqkYqCay
         bEpXAc6mDluBNhXfRDCtut5iJrkpLx/mEAOS/KCoQPw43dhB8sUbCD9uH7c7+miK8RsT
         eIR/etwUw5e/BuBgY/pUis9vVxIeBWH1mkSg5hQ1a7ySg8VwCmgML0T4qsosYf3twfSn
         Y2WaZzS5/QBMHsNL1pojtttSdu/WqLoWMnzjANLvfmH6w8nkUeeYcdpR0cInshHmu0Gu
         0pog79h8UJTv8siQmv5KZfVBM2QFWuai6tFEuqRVbdguY+WmRvmzYeK0Gn1EsPouOuDA
         MtvA==
X-Forwarded-Encrypted: i=1; AJvYcCXpSl/NPWbaCT+pj3UM90RXG2y0fzd3RWXZxxofExXDctlnuZsLl/sUpdYTlM1fMj7NlCn0x1g6XcPlSnnpObo8I6ba5+A+8j12R9eo0e0ZUl0kHPTYuWpZtetNkrtLr6tP6SqENQ==
X-Gm-Message-State: AOJu0YyFdYYRCqt/+ZW9Qf/fEwM+iFOcWoGE8aZJExitRkU6i0V29GRK
	zLONiGtzVNCSEGY1vnMVzsyHDaN64cTHZVVWnklGSxkRd+xQbGn0VlpRxtFfw+wb1oIoS2Qy2PL
	h9qYk4noc/26fN2l59UdZsonXIWyM/GMpoKw=
X-Google-Smtp-Source: AGHT+IHSKAK5yx2iH2r/nkTa19jeAW86cSRJWadPuv3y2KUS9hKYqhtE8N5xSiZSyFRuwXU2KBUbYpv9p7xFs98B9dY=
X-Received: by 2002:a17:906:7308:b0:a51:885a:c0a with SMTP id
 di8-20020a170906730800b00a51885a0c0amr4035954ejc.61.1712842421506; Thu, 11
 Apr 2024 06:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com> <20240411090628.2436389-4-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240411090628.2436389-4-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 16:33:05 +0300
Message-ID: <CAHp75VefB7fN8Bf3ZJ6sYnqdiHxoJ87zjDWERoEXNfY+NzosPA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] spi: Update swnode based SPI devices to use the
 fwnode name
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> Update the name for software node based SPI devices to use the fwnode
> name as the device name. This is helpful since swnode devices are
> usually added within the kernel, and the kernel often then requires a
> predictable name such that it can refer back to the device.

...

> +       if (is_software_node(fwnode)) {
> +               dev_set_name(dev, "spi-%s", fwnode_get_name(fwnode));

Wouldn't %pfwP / %pfw work?

Thinking more about this, maybe even the ACPI case also can be combined?
See for the details

87526603c892 ("irqdomain: Get rid of special treatment for ACPI in
__irq_domain_add()")
9ed78b05f998 ("irqdomain: Allow software nodes for IRQ domain creation")

> +               return;
> +       }


--=20
With Best Regards,
Andy Shevchenko

