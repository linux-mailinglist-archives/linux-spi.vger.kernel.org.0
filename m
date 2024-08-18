Return-Path: <linux-spi+bounces-4208-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E872955FA7
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 00:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1B71C20880
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398AC8F6E;
	Sun, 18 Aug 2024 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VejeZThR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5B8BFC;
	Sun, 18 Aug 2024 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724018564; cv=none; b=rm+pnKhHTecxfXbNEIMcljrNSVPAKPQ9Uco9wgmShhkeiUw5vcNtXT/khEzDAhUfRXQdKcRHku5PDa3Zmqs+cpR4joRNS38Sb6/xc7moC8Bm+snLw9LqlX7DrWyHP8CZi+zU5l6z1B9Y/jG+KZ86K//eM2Rrzkz1drakncvhWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724018564; c=relaxed/simple;
	bh=4OY+OfsgBEGBbUrCMGs5ii6nHp9EOSwlPSMYS9b5f3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljtvxz8aNkn1cachRtNWhZCLEE3oLWTk67zK02ggAsJim72TH5MD2MG5DkA4HEtmkDPDzaFL9P2yQuvTAgBBC1k6Y+EyGQ7OiMlJwYHq4LZz2Igi67wSbZy74otM7hItx7x19Uu1zCnpt4rnWF33tMI30TZZYcwKQXu13FtkxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VejeZThR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-685cc5415e8so36632447b3.3;
        Sun, 18 Aug 2024 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724018561; x=1724623361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ETxuffj1hjBq3fNSlGndae1t4Uh+6W5yBNTfchSYFjI=;
        b=VejeZThRJJ8ZR+hcxLIt+vkKiA0DINWRe8l8gvDGji/yIJd5ztHKD12Hj5mxcoLTeU
         Mx0BsIBcJX3ZaE380lF1w/OntM0SPfz/krfsW9BH4kRDO3ntKGs+VT5Og3qaaME8A1TZ
         sOfpYI+8ehE2K69/puRLjC4vpOGY+Oob9UerbP6ctg7Cqri7WkLgQqrD3QVBoklopxqS
         g485IKoPbH25/dqkJ0XvnydklA0d0b1fOsFU8bDfgkHftqb3PQey0/DW8zCktpTfxFwQ
         URshBiIsL90jAga4djP9669ZoocZKPhp/IWbRELxRln9Y8A5q8wAwaruvPbSgzs98le2
         WK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724018561; x=1724623361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETxuffj1hjBq3fNSlGndae1t4Uh+6W5yBNTfchSYFjI=;
        b=hwjqW9uKy14Kh0DGDBXjX3nl66rc/tCnQ9BmzlX8lvZ0lTYOKVbfO4tkmNx3r/6ubR
         wPV2hefeD6NGrOQN2KdcjrR2PzbD0ip4W2V5C5mG9cH4GojIhM0ALLq3NZIOIEaCKKMk
         zeBhzn0G25EVBt3XyHWMD1pFnXVm64F75n1w65eYpVDnz+zyzrr8QTGuKg7/saKRMhlt
         EhvpU1knSqlYwR8Vb4oXvbivIVrXCJU/Wp1g5VbxU1bf2nCgYo6kwvOUju5+bv7x0wf7
         BcgjQPEsPH/qH0PequYAAbHIzpJI87/yxQVI13b6+PBfFqvhsIcfI4T9InQ+SJfcBlrR
         kAJw==
X-Forwarded-Encrypted: i=1; AJvYcCWNweO30XpbuadEsNWTMh2e8aA0qjnmGEyykfy2eSMmDjnxFRzwOYFBz4TOzRK+1BN3eDXA6FM5yrG6OdSMVYnIzHNLxWgBl1vSHuPiiGpSZTQgkltkeJFaxHalNLbF8vRbY6X4RmJ0
X-Gm-Message-State: AOJu0YwKG0jX3xdeAoJhyoAJLRCP/lj4kcG0enj5BkksImYXuXhTz3uP
	kLFZyIfCFvG1jPqi+nS0ZVZ8uckaBDtURTbzCtF9Ifzj5uOH37xt2Z251uWf2KoCUnR5MKPu+Ax
	AlI8w+esW1HWSa2P3ROyskHNbNPU=
X-Google-Smtp-Source: AGHT+IFu5Ai0L4rYHzMaFuY8IIAP2nxViIakFziB7jS8dmaSv0NgxBIP+I4NjIKlU7CX/R4mBtSn1LXnxBkjiQQyxm0=
X-Received: by 2002:a05:690c:4183:b0:6af:125a:1c5d with SMTP id
 00721157ae682-6b1bc3f6774mr80202527b3.38.1724018560935; Sun, 18 Aug 2024
 15:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722141822.1052370-1-make24@iscas.ac.cn> <172372877149.37632.11411791571570145777.b4-ty@kernel.org>
In-Reply-To: <172372877149.37632.11411791571570145777.b4-ty@kernel.org>
From: "lee.lockhey" <lee.lockhey@gmail.com>
Date: Mon, 19 Aug 2024 06:02:31 +0800
Message-ID: <CAL7siYP5OO1hKiTw4nKSKhLjRA82uFn7ijz3NxYz8uk_7fRthQ@mail.gmail.com>
Subject: Re: [PATCH v3] spi: ppc4xx: handle irq_of_parse_and_map() errors
To: Mark Brown <broonie@kernel.org>
Cc: jwboyer@linux.vnet.ibm.com, dbrownell@users.sourceforge.net, 
	sfalco@harris.com, akpm@linux-foundation.org, sr@denx.de, 
	Ma Ke <make24@iscas.ac.cn>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, Mark

On Mon, 22 Jul 2024 at 22:19, Ma Ke <make24@iscas.ac.cn> wrote:
>
> Zero and negative number is not a valid IRQ for in-kernel code and the
> irq_of_parse_and_map() function returns zero on error.  So this check for
> valid IRQs should only accept values > 0.
>
> Fixes: 44dab88e7cc9 ("spi: add spi_ppc4xx driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - removed Cc stable line as suggestions.
> Changes in v2:
> - added Cc stable line;
> - added Fixes line.
> ---
>  drivers/spi/spi-ppc4xx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
> index 01fdecbf132d..599c29a31269 100644
> --- a/drivers/spi/spi-ppc4xx.c
> +++ b/drivers/spi/spi-ppc4xx.c
> @@ -416,6 +416,9 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
>         if (hw->irqnum <= 0)
>                 goto free_host;
>

The repeated addition of code here is indeed confusing. :-)

> +       if (hw->irqnum <= 0)
> +               goto free_host;
> +

I noticed that this patch has been merged into the spi repository for-next tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=f1011ba20b83da3ee70dcb4a6d9d282a718916fa
and there is also a related patch:
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=7781f1d120fec8624fc654eda900fc8748262082

The return type of the 'irq_of_parse_and_map' function is 'unsigned
int', here we use an 'int' type variable 'irq' to receive the interrupt number,
this might not be very accurate.

Would it be better to change the type of the 'irqnum' variable? and do
not need to check if 'irqnum' is negative, like this:

           if (!hw->irqnum) {
                    dev_err(dev, "no IRQ resource\n");
                    ret = -EINVAL;
                    goto free_host;
           }

>         ret = request_irq(hw->irqnum, spi_ppc4xx_int,
>                           0, "spi_ppc4xx_of", (void *)hw);
>         if (ret) {
> --
> 2.25.1
>
>

Regards,
Luoxi

