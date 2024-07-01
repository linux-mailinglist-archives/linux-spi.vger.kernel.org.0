Return-Path: <linux-spi+bounces-3707-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9082791E061
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 15:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DCF1C21428
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 13:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B433115DBA0;
	Mon,  1 Jul 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UWKDH2AZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DF15ADA5
	for <linux-spi@vger.kernel.org>; Mon,  1 Jul 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839855; cv=none; b=QnehmXTCBJfR6BMfFRAVEihforNGTlh5GK7Tjt4WffiqQJfjwvblx33zyeap2XlG2mBXCzOdTWjJKluwRwd6gJmb8J707YYWMFffN5TbIDf+/IkzjM43ePmR6VYL0heUfe272BzT7wt6RVowg0B0YKZ+c9xRNMSsWFSb6xOuI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839855; c=relaxed/simple;
	bh=B3NQ8HCyj1ZTe5E7TLaeqHT43qtQdDbfhF0WcJB5/l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RH1aeusjuyCXokGT8TvYbYdDHtqShW9ymm9vjlfpI+fvJEyjzfZ/2rh+O+mJHDV+bEHX9AkCKDMljuZwPvUrml8GCI67Fqiq4bxNMt2EcfOeZ8HYPvwhhNwq6TNrcOo+hqbpjQ1tRixvmm0ahUKOeHjcQZMulAssPbFklQenmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UWKDH2AZ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f3ca6869e8so104795239f.3
        for <linux-spi@vger.kernel.org>; Mon, 01 Jul 2024 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719839852; x=1720444652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tv7hLmqJSP26fMN3IiNsBgVJSAix2nuXmhfSvybhYBQ=;
        b=UWKDH2AZl3qh51IaJ844eBRRwwGSLeuh5xk19tkKla8v4ZrIpy+m4k4BIjSl2eidlO
         9dpgHw1aDoQTUYXzk2xHzA1WjfNAqwDxOhcVJvogiMigtxJPkvRvw3MOZKwPFJbwWEhT
         zIaq7NxLSNGncfzWmKb8S8pMnM6RrVAeGQxB8AfeuKf6+1Zfd4P8i8ltFBAmKy87qBOY
         6LyYZJ9Nn4F9y+6OY61UcTXywKuFonw9UDJnhm50AJX7YciMtwUHU/o3g0ORLYyO0zw5
         zCBRHbDi09OHjwyPvJCF4bQ8/vwj+anBMK6m8MEgw6AEArmlsU9G9jPYgGViBUqDUW14
         Y8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719839852; x=1720444652;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv7hLmqJSP26fMN3IiNsBgVJSAix2nuXmhfSvybhYBQ=;
        b=dpUyu2RijnCVIF8uxcmuqVHopXr4YVfDTiiZWqvhkQF4SD2+7DylHPlGQeUmDzRCND
         KaTMfrMgLvY+fZ5qFjVic8ZwI/ysEo43QOVb1d6B98ve5t6L/VmHvrLIc6cRqzmwI1Y4
         Ca69rtxMDa5alseX8Orn6Us5cVTe4AgvUdc4a6U1n1H1pwqi4FYTW5DMjLDyHHF8YS1w
         1xmWWCfaTn+2nya3d/AfkAvvUGaCuv3sbDbj8G7qkmorDZvBoqCvJGD6vZvnH0nTp6mA
         pDEaq7/gQGu24Rj272j4WEfhnwhlYxMEJI0DHNc3Mw7BCUULc8UFe8pUMoJ+FsUfA5Yx
         DwOA==
X-Forwarded-Encrypted: i=1; AJvYcCVkI8Kx9c2LybZLZ+EeMmYPu2rA8KcmwRiXt/dpf/qq/5bC/4a3wZeYmVSPxAgRLUitJhVJb5IXhra1ox/lS9mxnKWtPxARqgun
X-Gm-Message-State: AOJu0YzC5hAmfIDy3Y//j4cGkzZNaw1zimVDk+LhqmqG437m6Fslhiwl
	4rb/rC4NgfBxbshZmfP+gQhnJHIoi+Jo6aR9K3Dnfw+9SoVSjBIYHwUG1kd+w54=
X-Google-Smtp-Source: AGHT+IEZw7OPZRtqEEfxj8LpOcD4ss2+Aeo4eVMjfKvEB8LYKyAWd6+8RBlnjTcAOf4l/FP8eMO8Kg==
X-Received: by 2002:a05:6602:584:b0:7eb:776f:d970 with SMTP id ca18e2360f4ac-7f62ee74896mr592724639f.14.1719839852334;
        Mon, 01 Jul 2024 06:17:32 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e08bc2sm2165340173.83.2024.07.01.06.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 06:17:32 -0700 (PDT)
Message-ID: <f8604c68-8866-447b-a874-562bdad1df79@sifive.com>
Date: Mon, 1 Jul 2024 08:17:29 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: dw-mmio: update dw_spi_mmio_of_match struct
 with thead
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-4-kanakshilledar@gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240701121355.262259-4-kanakshilledar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kanak,

On 2024-07-01 7:13 AM, Kanak Shilledar wrote:
> updated the struct of_device_id dw_spi_mmio_of_match to include
> the updated compatible value for TH1520 SoC ("thead,th1520-spi")
> to initialize with dw_spi_pssi_init().
> 
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> ---
> Changes in v2:
> - Separated from a single patch file.
> ---
>  drivers/spi/spi-dw-mmio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 819907e332c4..39e3d46ebf5d 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -419,6 +419,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
>  	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
> +	{ .compatible = "thead,th1520-spi", .data = dw_spi_pssi_init},

Your binding requires snps,dw-apb-ssi as a fallback compatible string, which is
already supported by this driver and uses the same match data. So you don't need
this patch; its only effect is to make the kernel larger.

Regards,
Samuel

>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);


