Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A8F4A5E7B
	for <lists+linux-spi@lfdr.de>; Tue,  1 Feb 2022 15:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiBAOmO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Feb 2022 09:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237882AbiBAOmN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Feb 2022 09:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643726533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjzDEqkfJ2N8210XIx7ybjZjd9nnlt1goBZyP/z8PRo=;
        b=I7HC1v4r7/CB8IBrstm48DN1ZVm3avIwQmjUAXEb2NKLoLkzWKNp+tJRKZ+QFcrTfCzyHA
        k2wstOAXHRLjZrAVFmDdZXll56cQl243wdRGtXFcETOoa9T5jXDDIzTH1wTL/x29v1OrTm
        H/etPk/3O/qL59nA4MjsZboWqik7afM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-uMNCnY2WNHa3UTStbn3VZw-1; Tue, 01 Feb 2022 09:42:11 -0500
X-MC-Unique: uMNCnY2WNHa3UTStbn3VZw-1
Received: by mail-ed1-f72.google.com with SMTP id ed6-20020a056402294600b004090fd8a936so8802336edb.23
        for <linux-spi@vger.kernel.org>; Tue, 01 Feb 2022 06:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NjzDEqkfJ2N8210XIx7ybjZjd9nnlt1goBZyP/z8PRo=;
        b=KZgULUivnRAq0iwv65xDk5wR83YGS5bST3TUkXe9LQOr5P2LI1e5ZOK4+Vv+tBI7Hg
         J/BvQXD4OIJi+b22tvscwohL3L1FTJzWWvQ1xQ/vG4aPQIU03whPuwLubDIWI+yzuDq4
         CSv1/Jh4VYjstYSIUVdnDQwUtE6UUzTRjd5nZhIXdTh9OYfHjcyEnzEfm0uvO1YSmwtu
         G9GyFHTZmqSTUl3B4dEyGmcuBRv205D91jDB6oduz9ua6bNZAcJZ9imjT0Ki+D0iiTkV
         uA3scieBj8IGEOSNJ3lCqeoxChP1ZgBJVemjwbzP7dGG4450M8d4dFsEnBK0FOOA/Pbv
         uJdg==
X-Gm-Message-State: AOAM531mBDHQPlViHGwjJkLMHW2L3TsURGU9MsXK4FK+U6Sr0cuoQPYz
        0/CbTqz1dgnZkUlhvB4CAZ3hhmMqcObTp/rZVIHapLe2Rz+uUPOCme/BihUki/AdT6u7hHXWh71
        HPiKqYZIUwSJsu+Gg48BD
X-Received: by 2002:a17:906:974c:: with SMTP id o12mr12816426ejy.340.1643726530730;
        Tue, 01 Feb 2022 06:42:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNDyANDY0zMYuTljWq11CTgp0bQzqb3WikdoyniZiPHEGU+6ua6ezX3gvJIdSHcNSeP5gfIQ==
X-Received: by 2002:a17:906:974c:: with SMTP id o12mr12816408ejy.340.1643726530531;
        Tue, 01 Feb 2022 06:42:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id h16sm3616306ejj.56.2022.02.01.06.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:42:09 -0800 (PST)
Message-ID: <8cc4190e-f6ec-dc23-c487-4f0c4c7126e8@redhat.com>
Date:   Tue, 1 Feb 2022 15:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 4/9] spi: Add API to count spi acpi resources
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
 <20220121172431.6876-5-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220121172431.6876-5-sbinding@opensource.cirrus.com>
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
>  include/linux/spi/spi.h |  1 +
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 06c0a308b38b..ec9f2ed579e3 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2324,6 +2324,46 @@ struct acpi_spi_lookup {
>  	int			index;
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
> index e5bbb9cbd3d7..394b4241d989 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -764,6 +764,7 @@ extern void spi_unregister_controller(struct spi_controller *ctlr);
>  extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>  						struct acpi_device *adev,
>  						int index);
> +int acpi_spi_count_resources(struct acpi_device *adev);
>  #endif
>  
>  /*
> 

