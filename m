Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04184A5E3E
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 15:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiBAO2O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Feb 2022 09:28:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239174AbiBAO2O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Feb 2022 09:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643725694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CEpHnZRby+OdFBUfnJRcFlppJCsiaydDkxmoVJ3hW50=;
        b=Zvt7mCPlPkm6k1/it8P9sqrdXweEMwqfCNAgJfYN61Vi7taQpQlEr8JJ4VVBePJ3lRs6aA
        dJ71VOIPSPCZfHRPlxjlf0htnOdL8AlOiKRoCfTHVQ2ECL32s7UCWpCsMmqQ2IOcRxoZN1
        vbBtuIdtZN92HWCuDNaWtZ2+wuMvoKs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-UElwvnb0Mtmbv3kXPvBgUQ-1; Tue, 01 Feb 2022 09:28:13 -0500
X-MC-Unique: UElwvnb0Mtmbv3kXPvBgUQ-1
Received: by mail-ej1-f71.google.com with SMTP id gb4-20020a170907960400b0069d1ebc4538so6639289ejc.2
        for <linux-spi@vger.kernel.org>; Tue, 01 Feb 2022 06:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CEpHnZRby+OdFBUfnJRcFlppJCsiaydDkxmoVJ3hW50=;
        b=zHZsxKyYoebUzG6AHMItjE6thuQJTBLzFVUJdROtNviJ565NaLQAW5Tzdzco/a30m8
         s3CGDaDF/OiGuFO8POBg+vqAUV98A09RWnj4T1C/9JdmTmiJ3r9DzURZqhWG8YfyfUy5
         51F1DbpNc0UezdqoMHO2iKEpjjkS30LRydx9GytUHFCNA48FTCnauFIUMgzafhFBI086
         ay3pPuI0+L71BWCgZ6BL8pM/1Sq36Ew8MBfD8pR1F78XvpFw5D63QHSAQeZkHiYAZ+qo
         TNmE/UXwRoTiERYMg7lqNdN9wyEC72BYT1QnHXwoPxpzfX56jWw2IIh/MvcxK3bsuBJR
         ieyQ==
X-Gm-Message-State: AOAM530YfgybfoOJQPeV0ocYqkF0hhxHEyO/4DRHA33VpMMtIlALspP4
        dojlVP0eTvaiikXqnfGJ3TbONyrfOxCr4QgjeZ2D9vHYg6DIRuxeAYT8PB6WqSG5NTmPQVBGqWY
        wWpVbMTfmFyaMWMo+47Bk
X-Received: by 2002:a17:907:82a3:: with SMTP id mr35mr21612617ejc.455.1643725691855;
        Tue, 01 Feb 2022 06:28:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzH+OkYWLuf8TmYaxwXXYlvRBK1KtWvLtG0CxdP0S23KTwypjMtJcPU45wHJExMWa0+U0vTFQ==
X-Received: by 2002:a17:907:82a3:: with SMTP id mr35mr21612599ejc.455.1643725691655;
        Tue, 01 Feb 2022 06:28:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id i12sm14761309ejj.198.2022.02.01.06.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:28:11 -0800 (PST)
Message-ID: <36df02cc-d164-eb6a-4ce7-54d2ee916650@redhat.com>
Date:   Tue, 1 Feb 2022 15:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 2/9] spi: Create helper API to lookup ACPI info for spi
 device
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
 <20220121172431.6876-3-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220121172431.6876-3-sbinding@opensource.cirrus.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 1/21/22 18:24, Stefan Binding wrote:
> This can then be used to find a spi resource inside an
> ACPI node, and allocate a spi device.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  drivers/spi/spi.c       | 46 ++++++++++++++++++++++++++++++++---------
>  include/linux/spi/spi.h |  6 ++++++
>  2 files changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 1eb84101c4ad..13f4701f0694 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2410,8 +2410,18 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
>  	return 1;
>  }
>  
> -static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
> -					    struct acpi_device *adev)
> +/**
> + * acpi_spi_device_alloc - Allocate a spi device, and fill it in with ACPI information
> + * @ctlr: controller to which the spi device belongs
> + * @adev: ACPI Device for the spi device
> + *
> + * This should be used to allocate a new spi device from and ACPI Node.
> + * The caller is responsible for calling spi_add_device to register the spi device.
> + *
> + * Return: a pointer to the new device, or ERR_PTR on error.
> + */
> +struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
> +					 struct acpi_device *adev)
>  {
>  	acpi_handle parent_handle = NULL;
>  	struct list_head resource_list;
> @@ -2419,10 +2429,6 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>  	struct spi_device *spi;
>  	int ret;
>  
> -	if (acpi_bus_get_status(adev) || !adev->status.present ||
> -	    acpi_device_enumerated(adev))
> -		return AE_OK;
> -
>  	lookup.ctlr		= ctlr;
>  	lookup.irq		= -1;
>  
> @@ -2433,7 +2439,7 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>  
>  	if (ret < 0)
>  		/* found SPI in _CRS but it points to another controller */
> -		return AE_OK;
> +		return ERR_PTR(-ENODEV);
>  
>  	if (!lookup.max_speed_hz &&
>  	    ACPI_SUCCESS(acpi_get_parent(adev->handle, &parent_handle)) &&
> @@ -2443,16 +2449,15 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>  	}
>  
>  	if (!lookup.max_speed_hz)
> -		return AE_OK;
> +		return ERR_PTR(-ENODEV);
>  
>  	spi = spi_alloc_device(ctlr);
>  	if (!spi) {
>  		dev_err(&ctlr->dev, "failed to allocate SPI device for %s\n",
>  			dev_name(&adev->dev));
> -		return AE_NO_MEMORY;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
> -
>  	ACPI_COMPANION_SET(&spi->dev, adev);
>  	spi->max_speed_hz	= lookup.max_speed_hz;
>  	spi->mode		|= lookup.mode;
> @@ -2460,6 +2465,27 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>  	spi->bits_per_word	= lookup.bits_per_word;
>  	spi->chip_select	= lookup.chip_select;
>  
> +	return spi;
> +}
> +EXPORT_SYMBOL_GPL(acpi_spi_device_alloc);
> +
> +static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
> +					    struct acpi_device *adev)
> +{
> +	struct spi_device *spi;
> +
> +	if (acpi_bus_get_status(adev) || !adev->status.present ||
> +	    acpi_device_enumerated(adev))
> +		return AE_OK;
> +
> +	spi = acpi_spi_device_alloc(ctlr, adev);
> +	if (IS_ERR(spi)) {
> +		if (PTR_ERR(spi) == -ENOMEM)
> +			return AE_NO_MEMORY;
> +		else
> +			return AE_OK;
> +	}
> +
>  	acpi_set_modalias(adev, acpi_device_hid(adev), spi->modalias,
>  			  sizeof(spi->modalias));
>  
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 0346a3ff27fd..d159cef12f1a 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -16,6 +16,7 @@
>  #include <linux/gpio/consumer.h>
>  
>  #include <uapi/linux/spi/spi.h>
> +#include <linux/acpi.h>
>  
>  struct dma_chan;
>  struct software_node;
> @@ -759,6 +760,11 @@ extern int devm_spi_register_controller(struct device *dev,
>  					struct spi_controller *ctlr);
>  extern void spi_unregister_controller(struct spi_controller *ctlr);
>  
> +#if IS_ENABLED(CONFIG_ACPI)
> +extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
> +						struct acpi_device *adev);
> +#endif
> +

There is no need to add a #ifdef about something which is just a
function prototype. Having this declared when CONFIG_ACPI is not set is
harmless, please drop the #ifdef.

With that fixed, please add my R-b to the next version:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



>  /*
>   * SPI resource management while processing a SPI message
>   */
> 

