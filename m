Return-Path: <linux-spi+bounces-6277-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D55A08DD8
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 11:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CBF168310
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 10:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3FA20B1F6;
	Fri, 10 Jan 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="vALKgF6q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E92080CB;
	Fri, 10 Jan 2025 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504738; cv=none; b=gL0tj8xcarPGoYJI72lzJsBusZ/qXWtdpH5ytxILEA5hqIE2oxzuU/WpymJ+r3wEi2RdtSAp13bQDz2Wy+7c6euFMUIDQ/EvirLSp5UbYbOlIysMIGlLQ14crXffSf9a6S39gX8l2WBFOzCC6LAYZXu+de1C+DofTMwHait+974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504738; c=relaxed/simple;
	bh=cXYt5M7H3gNA7mynhhkDLAyzQW62DJmstrI94XqxrzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBCEz1hYyY14ynQZxXvMSxpT+ng+/yIX5rxQ/gny0Y7mTeXmAgrwKC1OucYiBxnocdlSbIjuiC/1UAZu4b+AHuSKc0Ec0Y/pH3KIQQTCAGEwzyXSpRFmaN8aAAOkKoU8rrI5uCNt5IXtteJ4m5+/DmUQ5ZKSInVOPKJhYPeaMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=vALKgF6q; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B8671486AEC;
	Fri, 10 Jan 2025 11:25:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1736504728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZEnoKWVnNWxWfpvM4CKXWKQ2zlo+dYmzvVDMOYSnHk=;
	b=vALKgF6qgEd0igT7VNytsLCV0DUpK0yJL2uouCVImkOs3L1XzAPOMzM/lznYTfq2ucfS2J
	cV4dDlLUcHyytiJFODvoHrcbwYFNyGbLwNa4wZJ+1FAZdVYNxeZQLqyNKnfLSZ5WhCUTMa
	gJbj4CHqcKSYnYwcBiHM8K1ogLSXmu0YSbnVl63/8wHS3/Ew9+cQPQ1yd1u4UR6ogF/kxz
	S4Z17ooV/vKUpAswGmwmMH4H1q6U4POOMi1PzVBT+HOlEAF0kPzNgY3tLwhxJnazrofuwr
	eVjKFC+n+nnZ2jGz5CNw9oZjf7z6Cb/3hidU8jAPc9Sxa1YMB3F4FvsL61KxFQ==
Date: Fri, 10 Jan 2025 11:25:24 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Mihai Sain <mihai.sain@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: atmel-quadspi: Print the controller version and
 used irq
Message-ID: <20250110-reshuffle-thrower-3212ad741403@thorsis.com>
Mail-Followup-To: Mihai Sain <mihai.sain@microchip.com>, broonie@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241008083226.51163-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008083226.51163-1-mihai.sain@microchip.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Mihai,

just saw I made a similar patch for myself lately, so regarding the
discussion of the need of such a patch, I would opt for it.  However,
see below …

Am Tue, Oct 08, 2024 at 11:32:26AM +0300 schrieb Mihai Sain:
> Add support to print the controller version and used irq
> similar to other at91 drivers (spi, twi, usart).
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  drivers/spi/atmel-quadspi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 95cdfc28361e..757f07132585 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -687,6 +687,8 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>  
> +	dev_info(&pdev->dev, "AT91 QSPI Controller version %#x (irq %d)\n",
> +		 atmel_qspi_read(aq, QSPI_VERSION), irq);
>  	return 0;

I think this should go above pm_runtime functions, because it does i/o
on a register.  This is how my diff looks like:

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 3d95b887235e6..7405b66e14b30 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1356,6 +1356,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
         struct atmel_qspi *aq;
         struct resource *res;
         int irq, err = 0;
+        u32 version;
 
         ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(*aq));
         if (!ctrl)
@@ -1470,6 +1471,12 @@ static int atmel_qspi_probe(struct platform_device *pdev)
                 pm_runtime_dont_use_autosuspend(&pdev->dev);
                 goto dma_release;
         }
+
+        version = atmel_qspi_read(aq, QSPI_VERSION) & 0x00000fff;
+        dev_info(&pdev->dev,
+                 "Atmel QSPI Controller version 0x%x at %pR (irq %d)\n",
+                 version, pdev->resource, irq);
+
         pm_runtime_mark_last_busy(&pdev->dev);
         pm_runtime_put_autosuspend(&pdev->dev);

Greets
Alex


