Return-Path: <linux-spi+bounces-4215-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F96C956503
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 09:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A85B20A8E
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0924158520;
	Mon, 19 Aug 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keGX4fjF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526B158545;
	Mon, 19 Aug 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053948; cv=none; b=Ii7qUZr12JjxhJVB0tL85m6gBSM9ntfpgvSSBPaPH4muz75LI6g58Bq0b54b046DUmLCOawJ5MqymZQA5s2UGHUIQ9l5qOFbn7kgkOwyR0QxrI3VbeRzC9AiLjt/04kGLEYRMXvxeiwdJ6Ilk93W0M6+KrN+y0QFzhDb8vo3vII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053948; c=relaxed/simple;
	bh=Mq5MkwxJ6DP3YaiDoLh0Dlz+3JdepyCbHOXbKe1ZypA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geV2UxI3OBgU/nrpeIE+/3V4DGSB89Qi3W3YXLE83tg1fCwzFJacTz0pPJMvFrJavKNFukuOCi+7GA/EioMq3bjGbXIrEIQxFISWN2xlqxk0b5dKYMrxm/QVUcMXBgqkzY7k/Me2Bo7fZHSS2kAGOgM420Rjd+yc6cYDbZiWV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keGX4fjF; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-68d30057ae9so37018697b3.1;
        Mon, 19 Aug 2024 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724053945; x=1724658745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kBW3MGhNwKlqdS/UoAuEV7dcSYvqQCnZIYpObkTt3ko=;
        b=keGX4fjF7xI5XC6GQwrEGMIp45EL72MqBsSFcDYbt0Oce70cysp82gCIvmF2GVXOFz
         IDjCyoFk+qpIOm+Mp+K3jOH4hgYLZD7j39oRi0hU/Xsix1q2Y9ZGfevFQNRWrcxwBIIe
         BqnxgZkdz4bIlmLo/gt1bJN+crRoUEE+olC4QIfUSAT9hjLG8mJ/PaQuDwpr4WMxh9IC
         kmFNSlQrHR6yg1/pibBGWxRG2t/Q0PCSS2TCAZPtFQ5fdZv3aYSyEoCIGvErkkPc/JJG
         dz3ar1qfjUdOxIGR6+7p7TFOht0etcWw3/Mq6jX6ic3LYGnluQXASRBULPe/sL18M+KH
         p8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053945; x=1724658745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBW3MGhNwKlqdS/UoAuEV7dcSYvqQCnZIYpObkTt3ko=;
        b=fjpyDUyZufcz6lUv6fd7a3YaDjW2yP+l6oocQEqH6EFLIrr4EQ0QZKTAscklXrXXCF
         WH75M5+oJw2SvmKa743WMp367hpa/h/U4yjoFzAb3qmJpt08XuOalY/r3A5sLf6zRNcV
         g7zPlJ1Lu2CAezuQME8CKx+mtkf6DI33vZbGc+RaDxBukAlunf2Abp/GwepDhfE7oFXs
         d7t+o6dX22p+UxKl5X41g5RYhLOMcTFwTa9PhY5tf2+0irzfFexaQBLhkITp3ZT3NVLf
         32Ebsy7bknDoy8Z5M2Ni8M8Ot/Q3e5ih2+HtmCGs+b+Yk1qtrSqchcyKcBjDMF+2/P2z
         lABA==
X-Forwarded-Encrypted: i=1; AJvYcCWA2eiznhpnbigKBRQe0HAHlFJeLXMETULdprFCP+kCfN2vrBlTcReM9rsg4MkiOoc3VKSFZQVMseCCxQjgbjBg5fNTKD5nooXAZcOkNUPOvDGPIl6Jp66RT5DrLSUHAMFnI0DE5dLQ
X-Gm-Message-State: AOJu0YzXkDjOY1gjHNarNcFPYVzOTH5lvDYv6GEH2Oqh8quAVbD9tOV4
	r9GoMy5r5FhS1LisIbQo4RIWmmvHlxoAKeRZ0GltbDDeZgxP6m4bDIOw9r+8O+O0cQkJ6KEtALS
	5hhpMQu1S//bVMCbGhlB/WMOwHlw=
X-Google-Smtp-Source: AGHT+IFPaaFCadv9UY/EIB+Ltvs5QIP79GVfOmRbslhqqxLA2O7FEcw6DuLsoLJxO5t9AcR+uJL1pdBQxFTzdCBV690=
X-Received: by 2002:a05:690c:4084:b0:63b:df6e:3f6d with SMTP id
 00721157ae682-6b1be5d14c4mr88992177b3.37.1724053945444; Mon, 19 Aug 2024
 00:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819040310.2801422-1-ruanjinjie@huawei.com>
In-Reply-To: <20240819040310.2801422-1-ruanjinjie@huawei.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 19 Aug 2024 09:52:14 +0200
Message-ID: <CAOiHx=mqS+r9PZJEQETVU-2GdgsZoFQ0fFAJ1zTVXPmZCBP0PA@mail.gmail.com>
Subject: Re: [PATCH -next] spi: bcm63xx: Fix missing pm_runtime_disable()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, noltari@gmail.com, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 19 Aug 2024 at 05:55, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> The pm_runtime_disable() is missing in the remove function, add it to
> align with the probe error path.
>
> Fixes: 2d13f2ff6073 ("spi: bcm63xx-spi: fix pm_runtime")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/spi/spi-bcm63xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> index 289f8a94980b..0531b6f3eef3 100644
> --- a/drivers/spi/spi-bcm63xx.c
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -614,6 +614,8 @@ static void bcm63xx_spi_remove(struct platform_device *pdev)
>         /* reset spi block */
>         bcm_spi_writeb(bs, 0, SPI_INT_MASK);
>
> +       pm_runtime_disable(&pdev->dev);
> +

How about using devm_pm_runtime_enable() instead in the probe path?
Then we don't need to call _disable() manually.

>         /* HW shutdown */
>         clk_disable_unprepare(bs->clk);
>  }
> --
> 2.34.1
>

Best Regards,
Jonas Gorski

