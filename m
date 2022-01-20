Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0453495068
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 15:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbiATOkH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jan 2022 09:40:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357157AbiATOjo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jan 2022 09:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642689583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6QJQxwpqs/8UeUwXAKCD+lQ9KYdKmTM83V8hAlwFAc=;
        b=KPRFvlRlfXTBWFLm7+enlMoYRzNbjaiCcDVvOp70bqtYRlOwTiF6SzzgwBSfWfELL2EYBe
        pipU4DDLjFvRYttZypGKeVVHQXj9dfcpqbIq9rKMlUirX4MgVRgc2pnQgPJqhwz+mRwuB9
        lqBEREHRFT7UAZDo6G1bl+oKl8sf9jo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-ae29BNBDMEuGOumTzSAmhw-1; Thu, 20 Jan 2022 09:39:42 -0500
X-MC-Unique: ae29BNBDMEuGOumTzSAmhw-1
Received: by mail-ed1-f72.google.com with SMTP id bm21-20020a0564020b1500b00402c34373f9so6113314edb.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Jan 2022 06:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U6QJQxwpqs/8UeUwXAKCD+lQ9KYdKmTM83V8hAlwFAc=;
        b=e19MTP8Quqa4BiXBaxkOaN7EPGKjW8Det2IpFPRbp1ZZ+yK3v3Xr2s5AYvnxx6MioD
         ECAnwEsv3r4kz+D6Iq0WcmCKo/6zAaUxEk0sO8qXvXWRTHwzLSo1FfD0H0i/xWMBKP50
         262l4zbqabUj1d6QFluXhGIvq41/UUOpD3D23Be3BnLMgFgSzCJh0V5VwZRgU0eDcGjT
         0QHgKzrJ0XT4PwmVqXJn2hbvOXcyD5n9JZy4nKCHrmTucovBRUjl4CRn528moggIwiEK
         oca0mfvWWSLKdIoK9899TeHQ/HIUjtNAPKBaO7yC80/HfUf4Psrp4iYwSGyC5EUXMe62
         POKg==
X-Gm-Message-State: AOAM533bI26XtMpYc/yJy+Dvz8kZt9Peh84KidNzZQJJa76dOh5E+WJ/
        WI/muW6Y/1+bj83mgqSot2QwRjUDQB+EcGIUO1Ct3l5NnVvg8pGUnWWf6AGJOhqDDbty0eV4E1w
        TdG+1wMMkVgL6U5MXK5N2
X-Received: by 2002:a05:6402:2d4:: with SMTP id b20mr8449554edx.98.1642689581193;
        Thu, 20 Jan 2022 06:39:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7QsHN5sY6fK7Vbj+K5/OavxogCBIliNExc9shQzj9qCMxf2il3s8jvjaw8aZ+7DIdD8rq1w==
X-Received: by 2002:a05:6402:2d4:: with SMTP id b20mr8449533edx.98.1642689581020;
        Thu, 20 Jan 2022 06:39:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id cr8sm1386979edb.47.2022.01.20.06.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 06:39:40 -0800 (PST)
Message-ID: <1ff8954c-9894-b0cd-a261-afc30ff02e6b@redhat.com>
Date:   Thu, 20 Jan 2022 15:39:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 4/9] spi: Add API to count spi acpi resources
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
 <20220120134326.5295-5-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220120134326.5295-5-sbinding@opensource.cirrus.com>
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

On 1/20/22 14:43, Stefan Binding wrote:
> Some ACPI nodes may have more than one Spi Resource.
> To be able to handle these case, its necessary to have
> a way of counting these resources.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/spi/spi.c       | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi.h |  6 ++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 898cc9931490..8c0c2e26609a 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2325,6 +2325,46 @@ struct acpi_spi_lookup {
>  	int			irq_index;
>  };
>  
> +static int acpi_spi_count(struct acpi_resource *ares, void *data)
> +{
> +	struct acpi_resource_spi_serialbus *sb;
> +	int *count = data;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return 1;
> +
> +	sb = &ares->data.spi_serial_bus;
> +	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_SPI)
> +		return 1;
> +
> +	*count = *count + 1;
> +
> +	return 1;
> +}
> +
> +/**
> + * acpi_spi_count_resources - Count the number of SpiSerialBus resources
> + * @adev:	ACPI device
> + *
> + * Returns the number of SpiSerialBus resources in the ACPI-device's
> + * resource-list; or a negative error code.
> + */
> +int acpi_spi_count_resources(struct acpi_device *adev)
> +{
> +	LIST_HEAD(r);
> +	int count = 0;
> +	int ret;
> +
> +	ret = acpi_dev_get_resources(adev, &r, acpi_spi_count, &count);
> +	if (ret < 0)
> +		return ret;
> +
> +	acpi_dev_free_resource_list(&r);
> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(acpi_spi_count_resources);
> +
>  static void acpi_spi_parse_apple_properties(struct acpi_device *dev,
>  					    struct acpi_spi_lookup *lookup)
>  {
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 1a34fd0f6ca2..25a82729f8da 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -764,6 +764,7 @@ extern void spi_unregister_controller(struct spi_controller *ctlr);
>  extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>  						struct acpi_device *adev,
>  						int index, int irq_index);
> +int acpi_spi_count_resources(struct acpi_device *adev);
>  #else
>  static inline struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>  						       struct acpi_device *adev,
> @@ -771,6 +772,11 @@ static inline struct spi_device *acpi_spi_device_alloc(struct spi_controller *ct
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
> +
> +int acpi_spi_count_resources(struct acpi_device *adev)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>  
>  /*
> 

