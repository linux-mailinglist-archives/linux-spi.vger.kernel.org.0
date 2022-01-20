Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F40E49505B
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 15:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354256AbiATOhy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jan 2022 09:37:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353556AbiATOhx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jan 2022 09:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642689472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPyIPk6/0DSM39d75aqtLFcVP807/DRC2fXXT2y2VIg=;
        b=Q3LviAxg9SiYYVNeMxOcbUQxbYgdu+AOUYy5RSJLNxfGHb0eN6ptyTpGoh0DOYcXCAYs5P
        mryTBf6TPOtiVB2ON+ccNRXmVCuovVYTOWlgj8bmqV8CA5GBvxwkPhUYofxoBxMIGEaNGG
        FIMGMuk31jrKweAoIDbFDuOFKdHjfpU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-T8IJJ5UvOFq9gfV6KVKD3Q-1; Thu, 20 Jan 2022 09:37:49 -0500
X-MC-Unique: T8IJJ5UvOFq9gfV6KVKD3Q-1
Received: by mail-ed1-f72.google.com with SMTP id bs4-20020a056402304400b004032af6b7ebso6065811edb.16
        for <linux-spi@vger.kernel.org>; Thu, 20 Jan 2022 06:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dPyIPk6/0DSM39d75aqtLFcVP807/DRC2fXXT2y2VIg=;
        b=MN5nYSARzuis4yG3Zgm9Kpp36gTB7EU8G59K9pBHB+zyzl4h1iXRk0rOWwGEi58+GR
         y0Z4DeG7K830q0+ISX5nIb9+nU93T1q4/7eZ/TIzWrZfRasq9x9nRxyBP0/CGraRQPht
         i/PwxX8ewEt3fkFR+FsC10+A8D6h9dA33WZXNMG+lZ3yPUuKqyAoigJOiUk9XKoEjhz1
         JkQdznqyKLUbBLr5accHay2VCzCNP4ZdloNVpFLBipwVhjf05kl7uH0LuQxBHL5gCZEm
         xcX7vddvg7WzqVrLkeZUjk6Jy0T5BYLiLx9mkDI5cEsrFgOSJte6zpWIOq2pPFN4yMHX
         gE3g==
X-Gm-Message-State: AOAM532+X6fRSzdRY0CP2msr9FfeSLtdoaQmHSTGImaN5BvwWKtZB77/
        vb9Cra02nT+OMT2mo5NnkGPAt5CCMcftwi5DFgQILm+DRQB8peFQxaDiyJEtMAX3AFOXa2evBFA
        jR5SzC2Qs7RIRhM2AtZ3i
X-Received: by 2002:a05:6402:2791:: with SMTP id b17mr19574194ede.173.1642689468091;
        Thu, 20 Jan 2022 06:37:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjkrEhShTflpw7jGM6KhhUDT4r90ruG4S9WPGY374oNXbMYSf+ClZ5qzVw1EVHLqb/3Sd1Og==
X-Received: by 2002:a05:6402:2791:: with SMTP id b17mr19574174ede.173.1642689467862;
        Thu, 20 Jan 2022 06:37:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id o18sm1076152ejb.111.2022.01.20.06.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 06:37:47 -0800 (PST)
Message-ID: <f849c693-86d3-8454-eda9-96c69daaf862@redhat.com>
Date:   Thu, 20 Jan 2022 15:37:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 2/9] spi: Create helper API to lookup ACPI info for spi
 device
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
 <20220120134326.5295-3-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220120134326.5295-3-sbinding@opensource.cirrus.com>
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

Hi Stefan,

First of all thank you for doing the requested refactoring
to reuse the existing ACPI SPI enumeration code from
drivers/spi/spi.c .

On 1/20/22 14:43, Stefan Binding wrote:
> This can then be used to find a spi resource inside an
> ACPI node, and allocate a spi device.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  drivers/spi/spi.c       | 46 ++++++++++++++++++++++++++++++++---------
>  include/linux/spi/spi.h | 12 +++++++++++
>  2 files changed, 48 insertions(+), 10 deletions(-)
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
> index 0346a3ff27fd..200725692b93 100644
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
> @@ -759,6 +760,17 @@ extern int devm_spi_register_controller(struct device *dev,
>  					struct spi_controller *ctlr);
>  extern void spi_unregister_controller(struct spi_controller *ctlr);
>  
> +#if IS_ENABLED(CONFIG_ACPI)
> +extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
> +						struct acpi_device *adev);
> +#else
> +static inline struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
> +						       struct acpi_device *adev);
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +#endif
> +

I don't think having a stub here is necessary ? I would expect any callers
of this to make sure that both CONFIG_SPI and CONFIG_ACPI are set. Note that
not having CONFIG_SPI set is not caught by your stubbing here and there are
no stubs for any of the other spi functions.

Regards,

Hans



>  /*
>   * SPI resource management while processing a SPI message
>   */
> 

