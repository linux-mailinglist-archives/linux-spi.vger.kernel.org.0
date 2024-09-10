Return-Path: <linux-spi+bounces-4764-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD0972CB2
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 11:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07393288644
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 09:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C918800A;
	Tue, 10 Sep 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmPUlEC6"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF016A957
	for <linux-spi@vger.kernel.org>; Tue, 10 Sep 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958846; cv=none; b=A7Lug16D7CpW80peMz279kRdFIl4j2mE/jmgyNn6KAUe1SG04FZ8SlJayULXzrqIBnuh6qcuttmabXWrPULlktziDyD42YjNXAG1KRrGPQSa1jW3O78GeBSJ8AMC3IpmQjlZleAUyaZkDAOGAoH/i/G6ON9kcnDGVS8XHdwQztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958846; c=relaxed/simple;
	bh=jvP2CShRbo1D59rvxjlwPvRbkOjjEaoXxnhnFtM6xB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fau8Y+Kq6HcR84v/hGilK3KCYv9ochLF4/nKUDHl8EpVJmnmA7MzFvNCa/pkNklldc/z83qOJW4AUweHgz4gXEtYjZMbcUMeanFlO1N5fUnozHicQddfpqLlsvsPseGeEwYGBZGQ38flS5xQmfr+B6SeTHTEDdCEx2tsiJNFoTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmPUlEC6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725958843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhiuzN32efomWjuY/NVTDByQS3uu6AVNQbc/n11HQBk=;
	b=EmPUlEC634P6Bl2uADqF6g9Oa2Q96E7C3HWDvskuHiUdUzbKWLSOzNf/2EVZ5eRub1RZzL
	B9c/uMRX/PH2PLFlD6r7a/WAOy+11nGtDLJvDmBwMsbc1C+nB9mOqs10gzKps6HAMWo60R
	Hr2jRqQBH0r2X/RhVoL7zqmAJhPujXw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-hoaptky5NQC68RHKemkEqg-1; Tue, 10 Sep 2024 05:00:42 -0400
X-MC-Unique: hoaptky5NQC68RHKemkEqg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a80667ad8so372421866b.2
        for <linux-spi@vger.kernel.org>; Tue, 10 Sep 2024 02:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725958841; x=1726563641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhiuzN32efomWjuY/NVTDByQS3uu6AVNQbc/n11HQBk=;
        b=czr23EWwImReeWpA8gWzTSK900L13PXpHU7ltl9ipIdAMeRFKMtnQ4DO9IU5nZ+jT7
         k7IRhkIFsa49NuYPsBVZrc9aQDVWfL1biWSaQAS1OLkYDdW5JLpcaCVxZrjyhMvc4+3S
         wUJcwE8mtgLkXt+KjHoDTwJSY2ag08bEo3Dxy0r9aKCqwcD5KwBY6EDhmQOj/M+drvjP
         7bgN8psQj7fNhlVVWtABKqBD6Mk1Y3n3IA5UKsilis24tTt3omdAdWVQDauRewQ8rHJ6
         BHbShkLOokSal9egGLWjIyYG4G0yYQsTlXAjl0v1SoeMbbt2PBPb2qnwp03NHkYbK52o
         9Ayw==
X-Gm-Message-State: AOJu0YxJvobf5KLf0w7/MRoy7NAaXunFmkZsjgTp6mtHCzCAQa+GpKoo
	zCLgE5T4BgfOSBJbm2bW2Cvsl18L2or4zLPzvlUcJw8Xl18sypRnIGTDdiyBQ+/tp2jAIHzKi2H
	ywUJMUNZRM8uBz3FEZYwUx+nMqsQgB0wXZdBsIlpfU52EWQURsdyghDc2BQ==
X-Received: by 2002:a17:907:3f8d:b0:a86:43c0:4270 with SMTP id a640c23a62f3a-a8ffaa97a61mr7485066b.13.1725958841406;
        Tue, 10 Sep 2024 02:00:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8ecB3ho5gSaKqeWr0v4uJU2RAyDyWIvn4rzdMnoVxmq5t7dfn1QKTjY+0Zs76xfGNI6PSig==
X-Received: by 2002:a17:907:3f8d:b0:a86:43c0:4270 with SMTP id a640c23a62f3a-a8ffaa97a61mr7481266b.13.1725958840917;
        Tue, 10 Sep 2024 02:00:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ce86cfsm452720066b.150.2024.09.10.02.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:00:40 -0700 (PDT)
Message-ID: <1cdbf313-d585-471e-b625-16d3fd9ca90a@redhat.com>
Date: Tue, 10 Sep 2024 11:00:39 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 6/7] platform/olpc: olpc-xo175-ec: switch to use
 spi_target_abort().
To: Yang Yingliang <yangyingliang@huaweicloud.com>, broonie@kernel.org,
 matthias.bgg@gmail.com, yangyingliang@huawei.com, liwei391@huawei.com
Cc: linux-spi@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240910022618.1397-1-yangyingliang@huaweicloud.com>
 <20240910022618.1397-7-yangyingliang@huaweicloud.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240910022618.1397-7-yangyingliang@huaweicloud.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/10/24 4:26 AM, Yang Yingliang wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> Switch to use modern name function spi_target_abort().
> 
> No functional changed.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks, patch looks good to me.

Please merge this through the SPI tree together with the rest
of the series:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/platform/olpc/olpc-xo175-ec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olpc/olpc-xo175-ec.c
> index 62ccbcb15c74..fa7b3bda688a 100644
> --- a/drivers/platform/olpc/olpc-xo175-ec.c
> +++ b/drivers/platform/olpc/olpc-xo175-ec.c
> @@ -536,7 +536,7 @@ static int olpc_xo175_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *resp,
>  		dev_err(dev, "EC cmd error: timeout in STATE %d\n",
>  				priv->cmd_state);
>  		gpiod_set_value_cansleep(priv->gpio_cmd, 0);
> -		spi_slave_abort(priv->spi);
> +		spi_target_abort(priv->spi);
>  		olpc_xo175_ec_read_packet(priv);
>  		return -ETIMEDOUT;
>  	}
> @@ -653,7 +653,7 @@ static void olpc_xo175_ec_remove(struct spi_device *spi)
>  	if (pm_power_off == olpc_xo175_ec_power_off)
>  		pm_power_off = NULL;
>  
> -	spi_slave_abort(spi);
> +	spi_target_abort(spi);
>  
>  	platform_device_unregister(olpc_ec);
>  	olpc_ec = NULL;


