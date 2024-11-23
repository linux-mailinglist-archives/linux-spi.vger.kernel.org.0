Return-Path: <linux-spi+bounces-5805-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 640749D6A8C
	for <lists+linux-spi@lfdr.de>; Sat, 23 Nov 2024 18:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35FFB20E6B
	for <lists+linux-spi@lfdr.de>; Sat, 23 Nov 2024 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D31381AA;
	Sat, 23 Nov 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ef/wO4pI"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF1195
	for <linux-spi@vger.kernel.org>; Sat, 23 Nov 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732382678; cv=none; b=R3PnXvaQqvQkd/tHhy8/MgCdVDeWaMz9PBrih9s9TZYYLQmNgDltp8Ky1qAKAhg+zv1KgJi3wojHCLHyUrutMGe2m9DoGcQFKFK5Uo5Zgwk8VmG7Plj0/voC4OdcWtEGCpUAr1pjyRXNXbkthsZBhf/BYoVKjOxfvthEf+HY9Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732382678; c=relaxed/simple;
	bh=tqaTQlcCqfd2wwPDQLnIKAoyRhA02BScDg6ibwoGNH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5XOlr7dmfaD7fGezuZ7dWaP9SJitf2tfiY65nYkbSPvbiuY5F3khu03WT0QwcZWEiv7J2Kv19nJcpaMnRaOHn7hkwhDb030rO9AY8ZR/BeyX8DCD5gbej5N2lB+zK+DbWQInZzowOW2maQg6pLc4O2732EVgCudsTYSxmLsrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ef/wO4pI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732382674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdFpdxTJOMYafjd4i3ic71NZeez232I3QNvfFR4LGrM=;
	b=ef/wO4pIH5lY/6p6Ns+9R5VgjaFdrQfekAFhLEA4bJkXppGf0+YzgEtdcDfCv1HOiTkZSz
	K3m2knmHkMFg2ACeF3okZwx5DsinpLOngubAt3Dh5n2DnKjP8nBNcwPaSWyNsnFKa2zWVj
	Bym9vEGnbLmRVDlQ9atF7OwH6inwQAU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-RdnXudAgNg6SP0T4oaPT5Q-1; Sat, 23 Nov 2024 12:24:32 -0500
X-MC-Unique: RdnXudAgNg6SP0T4oaPT5Q-1
X-Mimecast-MFC-AGG-ID: RdnXudAgNg6SP0T4oaPT5Q
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5cfdc574679so1881442a12.0
        for <linux-spi@vger.kernel.org>; Sat, 23 Nov 2024 09:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732382671; x=1732987471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdFpdxTJOMYafjd4i3ic71NZeez232I3QNvfFR4LGrM=;
        b=Y+yDEVicjH9O5P37rSRkrBm/INfEbm1pUZHkU3+VBhCjv/N61XQ2d8P1uHHSUERLEm
         eaW3s4fWKnZxPREn5zt9XLmOjNgG6EFqtYWpVQPry00r8GouK2sJJy42sjngEdBWmhAk
         iT7r3lv9YhZ1XWBZb97EARqqNUDiad1D9KVUun6xMbfqdYiT+FUk5bPkevqW2ffNYEiw
         Wn+eblaPS4oUF2mUX49vXKUfrGx113ftHiZHVKTwbr0qk5eZ1zyZxlHenfAfewy5J02Y
         G7cujQN1jUAUkbWVOGRVXMVMc776m9WtinRp99+LVneVkbpFnsfnBCqAuoxuOFWyRS8S
         JK4g==
X-Gm-Message-State: AOJu0YzureaZxS1gJjQIxpRco7W7gXUrYbdU280sSkZ7gyTx9oblRaVR
	EZ11qCnGFNT16JstgN/pUsBKfPm1SkqNA75VWbLTINqDrU490pc3gDp/fAtSfvHWlUsRQVNMSrN
	uq1oKMizWKLKSrKjDdlQMiB0i4+kYsIMTO/Qf8YVCa2DdUjhYpJNph+RLmQ==
X-Gm-Gg: ASbGncsA1VXYKeAIUR/43bMCPXUhNdf9m01JQObQZIXOfTHubyxFnU+nNyZZDAFISTS
	soQhPjixZ3auPfF33T4w9XjPltn9CyusuZhwAM0b7p9sriJxIaC/BkuAKcHqqcE+3fD6lggKsP/
	yguLUftMO5LstqarBmdRP0WnzE0uJCBf3fagpapl7x66nplohjboVX/AxHU/Jk/Jlhn7/UuVaSv
	/VLDnnVOKsQy5/5c8VrtX2MH6ir+S6v9d37bKDMjBaP4MOK4ubKKBlK1cp4sOgAxApRbMIBjYNn
	K5r4mxfqfV2KbosDmfYJvdWCyR+XBtKk2xYIpBmvnSMd3EMgdKzQUS2ZMlZlCXUya/0xVDdLrtF
	vKetQk1tPbxIFBg45j8SUlCjI
X-Received: by 2002:a05:6402:1ec9:b0:5cf:d1b5:1bd5 with SMTP id 4fb4d7f45d1cf-5d0206254d2mr6296664a12.16.1732382671700;
        Sat, 23 Nov 2024 09:24:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+NaSYop87b2aUy2KrAkpl4dpZ7GjArlMy3YMPrKOaGSOi1HOE0KwGe4W4bXdtH9eEtg9D7g==
X-Received: by 2002:a05:6402:1ec9:b0:5cf:d1b5:1bd5 with SMTP id 4fb4d7f45d1cf-5d0206254d2mr6296658a12.16.1732382671355;
        Sat, 23 Nov 2024 09:24:31 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d8603dfsm2226369a12.26.2024.11.23.09.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 09:24:30 -0800 (PST)
Message-ID: <3709a469-7730-45d6-bbba-ecd87c2ca2c1@redhat.com>
Date: Sat, 23 Nov 2024 18:24:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: Fix acpi deferred irq probe
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20241122094224.226773-1-stanislaw.gruszka@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241122094224.226773-1-stanislaw.gruszka@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lXGpACtqMfdJHA7oMF8Xd8vo-ORnhnP9YkYtAOlWkI8_1732382672
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 22-Nov-24 10:42 AM, Stanislaw Gruszka wrote:
> When probing spi device take care of deferred probe of ACPI irq gpio
> similar like for OF/DT case.
> 
> From practical standpoint this fixes issue with vsc-tp driver on
> Dell XP 9340 laptop, which try to request interrupt with spi->irq
> equal to -EPROBE_DEFER and fail to probe with the following error:
> 
> vsc-tp spi-INTC10D0:00: probe with driver vsc-tp failed with error -22
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: 33ada67da352 ("ACPI / spi: attach GPIO IRQ from ACPI description to SPI device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/spi/spi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index c1dad30a4528..0f3e6e2c2474 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -424,6 +424,16 @@ static int spi_probe(struct device *dev)
>  			spi->irq = 0;
>  	}
>  
> +	if (has_acpi_companion(dev) && spi->irq < 0) {
> +		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
> +
> +		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
> +		if (spi->irq == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		if (spi->irq < 0)
> +			spi->irq = 0;
> +	}
> +
>  	ret = dev_pm_domain_attach(dev, true);
>  	if (ret)
>  		return ret;
> @@ -2869,9 +2879,6 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>  	acpi_set_modalias(adev, acpi_device_hid(adev), spi->modalias,
>  			  sizeof(spi->modalias));
>  
> -	if (spi->irq < 0)
> -		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
> -
>  	acpi_device_set_enumerated(adev);
>  
>  	adev->power.flags.ignore_parent = true;


