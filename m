Return-Path: <linux-spi+bounces-3195-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DE98D7D57
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 10:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9521F22DCD
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 08:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BF359B71;
	Mon,  3 Jun 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OojbpjCX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA63446CF;
	Mon,  3 Jun 2024 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403334; cv=none; b=bz/awlw5nxviFSSPyBw0xH3Vp0NcR8qWRoBkDPoJ5gTtP8S6Qdr20lPJdsg61lRF7q0hyEoXXr0pEzcFhxIl0nh7OJ3VHHA0MsvU2jQqzBw0VZoBod2afxDtMhIppSuosAJuDkh6yw/2XHSLeuyQicM6I7BZbzfk1Tavo/W+lrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403334; c=relaxed/simple;
	bh=ffVlScCpAYPRmdmKFbEOAujMESyVwditKSQy2fdkHos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPGzymmsGnUin+eDl44O2eU3ilLwv6whFK2iHRLS501qdMR1/Z/9HVUtRR3Myc6hka6DP2qxCdUi5xFiMBaxlPMPwuGFrBAlqp0drt6Jjy0QxE2W//Hd+VcH6wOFZwbYHij93SmG7n6/bkA+wPVzokeXlA1cD6rbUl1A9pbHI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OojbpjCX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52965199234so4579214e87.2;
        Mon, 03 Jun 2024 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717403331; x=1718008131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAQKsZD6ySxnro4HriCuC0HGqYP8pUAOiGJhD7pGAsY=;
        b=OojbpjCX14hj526jWDGJkwUcjraIjdI7D5TX10RHx6XI7LdAcBKCxmfUsSRMXb/2gC
         0X5CDMr2ti/CGHhlaUStA0n1tI277VUdpOovu75I49lm1i61LYqOZ4Bc4+Bz4e+iw+34
         FF1l2Hu3vB4/3PcK0O5NffjIGTr5upahBqkHtnAP7mExX2Adg+T055GMwI6dapL7sFrc
         N7HxfGwMLeVh9LxoYZzO0p3nQgBXUvDkmYkmO47LCRnY1jelRDVEb12+ueE8PZvO6WSP
         LKywx80tXUv4Wp3KjRFMvJ/kos8kbzRQvFNZkn89GAgKTPAqXZ5YkjR6VJtZJO5XGqeQ
         YpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717403331; x=1718008131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAQKsZD6ySxnro4HriCuC0HGqYP8pUAOiGJhD7pGAsY=;
        b=lqfMoj3EQ+DtHhntZfyMTBT5tk3IKIttG8wiF0V0xelTdwomzvVu+e6jZ6eO8yAq9J
         6GqjLL6Aj4AmX7TS0Q8BwT7LNjONSY2TCE+VVbtM213gPMr124sSRq2aMFSySufoxfQ7
         6AR/t6Hr7L0QHNjNLMsMeZU7Dk+DW5+NOmEAaG1+7va9zvFQfow+JVNdlMJ29eAwGaJS
         SybjcCV4qV84RlsB4WHug0SIS8ETAHk7hgP7aa2vLoq7POE1YwVpnD+oAR7lG0QbSosF
         oYm9MhdoD2Z76lf0v6MWPy0OkwAkCjcViqIoGDv8S+IcddX6LwP3WDwIZ3wdufOC4Ql3
         bSQw==
X-Forwarded-Encrypted: i=1; AJvYcCUBCNjlgRBwWZKy/3tX6dLBBFu5Blbgvf+vsdnmYqdqTPQ/1k9B9catAEu1K4dGlLRCySAknomLFQSKETJjGCiGqsx6o0w92yyB+dy9DFc8i/Ipc0eas0zgJ8tjrONQ+1n7OSzUhWZ2K1FDP7qeqM/rBTqTNW7qnLba5Zc2Vg4P9Qv3BcjbFQ==
X-Gm-Message-State: AOJu0YzdNbeV8QHm102peZepJsms56yabrp0t2vEspJmWBoyik/T0o8P
	i1/u9A4z/DtlPvm2/slj3LWVa1OsqCnJV/MFmz54PwLa5wnlx0sa
X-Google-Smtp-Source: AGHT+IGLymVGTulZH/jz3LCEQ/QQZxXVr2EOUbsidXeOKtvuqSLnZ4TyppGavOqAdilZiEzJ0iuirw==
X-Received: by 2002:ac2:5f95:0:b0:52b:86cf:91b2 with SMTP id 2adb3069b0e04-52b896bfcf6mr5498131e87.46.1717403330769;
        Mon, 03 Jun 2024 01:28:50 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b94c13625sm548697e87.71.2024.06.03.01.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 01:28:50 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:28:47 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Yang Yingliang <yangyingliang@huawei.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Thangaraj Samynathan <thangaraj.s@microchip.com>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	=?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4=?= Prado <nfraprado@collabora.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 2/8] spi: dw: Use new spi_xfer_is_dma_mapped() helper
Message-ID: <4p24kjtplk6bk7amhwsrvvtryeeblitnd46lhlapwqudykayzn@3ki4zl4oknua>
References: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
 <20240531194723.1761567-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531194723.1761567-3-andriy.shevchenko@linux.intel.com>

On Fri, May 31, 2024 at 10:42:34PM +0300, Andy Shevchenko wrote:
> Replace a few lines of code by calling a spi_xfer_is_dma_mapped() helper.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice cleanup. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/spi/spi-dw-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index ddfdb903047a..431788dd848c 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -19,6 +19,7 @@
>  #include <linux/string.h>
>  #include <linux/of.h>
>  
> +#include "internals.h"
>  #include "spi-dw.h"
>  
>  #ifdef CONFIG_DEBUG_FS
> @@ -438,8 +439,7 @@ static int dw_spi_transfer_one(struct spi_controller *host,
>  	transfer->effective_speed_hz = dws->current_freq;
>  
>  	/* Check if current transfer is a DMA transaction */
> -	if (host->can_dma && host->can_dma(host, spi, transfer))
> -		dws->dma_mapped = host->cur_msg_mapped;
> +	dws->dma_mapped = spi_xfer_is_dma_mapped(host, spi, transfer);
>  
>  	/* For poll mode just disable all interrupts */
>  	dw_spi_mask_intr(dws, 0xff);
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

