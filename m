Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B519C495233
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 17:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376924AbiATQRz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jan 2022 11:17:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233057AbiATQRz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jan 2022 11:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642695474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RC733lFPIHzk3RkK9z52O+U2Hg6U4mWbFhj23dwMdo0=;
        b=VLRgdtAKCRZ0kb/1VcKDicwUy2ziLzIAqeV/8dhtoM839xx1Lezm4864Sg5purmAL+O5Tv
        T8L7uaQ2AhktYsIC3LcMkUDiu7t2L1nP+qyxNIB+Jv3wvkf9Tf2pFkJmUjHbUO1qZQLeAk
        IxHwuZ7sNsVDvkfVjb1Qu7kLZBAUJn8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-A-H8jkdsPSqIdNrcvrbggA-1; Thu, 20 Jan 2022 11:17:53 -0500
X-MC-Unique: A-H8jkdsPSqIdNrcvrbggA-1
Received: by mail-ed1-f71.google.com with SMTP id cf15-20020a0564020b8f00b0040284b671c6so6331007edb.22
        for <linux-spi@vger.kernel.org>; Thu, 20 Jan 2022 08:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RC733lFPIHzk3RkK9z52O+U2Hg6U4mWbFhj23dwMdo0=;
        b=jwfJaL8dLXlv49mIY1vHH//flQen8GNghlJIqfRR6Jn0uw6yUc2Bzb6jsJ9uhg5tZr
         Nf3xz6b4T3vqVTOvqyvkscYpVtU3VjjvS6UunsGbGTkkbHSoEDH3hlJjt8igJLAcl5Ep
         5HTUfwMGO6J4zBHc7Af0l6vpgpGF4lyP0OSgEjfWl2hEW4LSjRcCvXt1Xu4XpsjM38vY
         Mml4cCQuSb1Hx79c+lbGaE8FlgS5WDASrKhHIOPovxnJVSarOtn1jFo16Z2XNj8hgjzr
         PZ1Q4RrLcFmI0hI4sB6TL3pB1T2A4sekpeMznRgMCP0vNuyzy28CRg4Gt+EttA2bi6xf
         s3lw==
X-Gm-Message-State: AOAM530W49ru/stKpRC4+aTR+nmVgP/GnDn+FfQO0xIEVkONWwKKXjUm
        AQNwTRgt+QrWi9uqmevQGSsWrJd6JQYvDwbbcyt9bDSUzPYjRZogxUcMRBRsRivp/JKktiUWhq6
        V/0wEZjh4IWQOnnWIWRtn
X-Received: by 2002:a17:907:1c0a:: with SMTP id nc10mr20566732ejc.308.1642695471876;
        Thu, 20 Jan 2022 08:17:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLhLVVCXZg+uHvh9G2LyVGBe1+f7RJ+iHgGbV2n/0A0kB0ocN0jP+qvMTJsudz1CMuv8VAUw==
X-Received: by 2002:a17:907:1c0a:: with SMTP id nc10mr20566707ejc.308.1642695471591;
        Thu, 20 Jan 2022 08:17:51 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id lf15sm1184070ejb.83.2022.01.20.08.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 08:17:51 -0800 (PST)
Message-ID: <9c5ed5ee-7ca1-c1f4-5d9d-a63b4327a4af@redhat.com>
Date:   Thu, 20 Jan 2022 17:17:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 6/9] platform/x86: bus-multi-instantiate: Reorganize
 I2C functions
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
 <20220120134326.5295-7-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220120134326.5295-7-sbinding@opensource.cirrus.com>
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

Sorry some more remarks after all...

On 1/20/22 14:43, Stefan Binding wrote:
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> 
> Reorganize I2C functions to accommodate SPI support
> Split the probe and factor out parts of the code
> that will be used in the SPI support
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  drivers/platform/x86/bus-multi-instantiate.c | 150 ++++++++++++-------
>  1 file changed, 96 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/platform/x86/bus-multi-instantiate.c b/drivers/platform/x86/bus-multi-instantiate.c
> index 982dfecfd27c..50f1540762e9 100644
> --- a/drivers/platform/x86/bus-multi-instantiate.c
> +++ b/drivers/platform/x86/bus-multi-instantiate.c
> @@ -29,85 +29,129 @@ struct bmi_instance {
>  
>  struct bmi {
>  	int i2c_num;
> -	struct i2c_client *i2c_devs[];
> +	struct i2c_client **i2c_devs;
>  };
>  
> -static int bmi_probe(struct platform_device *pdev)
> +static int bmi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
> +		       const struct bmi_instance *inst)
> +{
> +	int ret;
> +
> +	switch (inst->flags & IRQ_RESOURCE_TYPE) {
> +	case IRQ_RESOURCE_GPIO:
> +		ret = acpi_dev_gpio_irq_get(adev, inst->irq_idx);
> +		break;
> +	case IRQ_RESOURCE_APIC:
> +		ret = platform_get_irq(pdev, inst->irq_idx);
> +		break;
> +	default:
> +		ret = 0;
> +		break;
> +	}
> +
> +	if (ret < 0)
> +		dev_err_probe(&pdev->dev, ret, "Error requesting irq at index %d: %d\n",
> +			      inst->irq_idx, ret);
> +
> +	return ret;
> +}
> +
> +static void bmi_devs_unregister(struct bmi *bmi)
> +{
> +	while (bmi->i2c_num > 0)
> +		i2c_unregister_device(bmi->i2c_devs[--bmi->i2c_num]);
> +}
> +
> +/**
> + * bmi_i2c_probe - Instantiate multiple I2C devices from inst array
> + * @pdev:	Platform device
> + * @adev:	ACPI device
> + * @bmi:	Internal struct for Bus multi instantiate driver
> + * @inst:	Array of instances to probe
> + *
> + * Returns the number of I2C devices instantiate, Zero if none is found or a negative error code.
> + */
> +static int bmi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev, struct bmi *bmi,
> +			 const struct bmi_instance *inst_array)
>  {
>  	struct i2c_board_info board_info = {};
> -	const struct bmi_instance *inst;
>  	struct device *dev = &pdev->dev;
> -	struct acpi_device *adev;
> -	struct bmi *bmi;
>  	char name[32];
> -	int i, ret;
> +	int i, ret = 0, count;
>  
> -	inst = device_get_match_data(dev);
> -	if (!inst) {
> -		dev_err(dev, "Error ACPI match data is missing\n");
> -		return -ENODEV;
> -	}
> -
> -	adev = ACPI_COMPANION(dev);
> -
> -	/* Count number of clients to instantiate */
>  	ret = i2c_acpi_client_count(adev);
> -	if (ret < 0)
> +	if (ret <= 0)
>  		return ret;

Please change this to:

		return ret == 0 ? -ENODEV : ret;

This helps making return value handler in the caller cleaner,
also see my upcoming review of patch 7/9.

> +	count = ret;
>  
> -	bmi = devm_kmalloc(dev, struct_size(bmi, i2c_devs, ret), GFP_KERNEL);
> -	if (!bmi)
> +	bmi->i2c_devs = devm_kcalloc(dev, count, sizeof(*bmi->i2c_devs), GFP_KERNEL);
> +	if (!bmi->i2c_devs)
>  		return -ENOMEM;
>  
> -	bmi->i2c_num = ret;
> -
> -	for (i = 0; i < bmi->i2c_num && inst[i].type; i++) {
> +	for (i = 0; i < count && inst_array[i].type; i++) {
>  		memset(&board_info, 0, sizeof(board_info));
> -		strlcpy(board_info.type, inst[i].type, I2C_NAME_SIZE);
> -		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst[i].type, i);
> +		strscpy(board_info.type, inst_array[i].type, I2C_NAME_SIZE);
> +		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst_array[i].type, i);
>  		board_info.dev_name = name;
> -		switch (inst[i].flags & IRQ_RESOURCE_TYPE) {
> -		case IRQ_RESOURCE_GPIO:
> -			ret = acpi_dev_gpio_irq_get(adev, inst[i].irq_idx);
> -			if (ret < 0) {
> -				dev_err(dev, "Error requesting irq at index %d: %d\n",
> -						inst[i].irq_idx, ret);
> -				goto error;
> -			}
> -			board_info.irq = ret;
> -			break;
> -		case IRQ_RESOURCE_APIC:
> -			ret = platform_get_irq(pdev, inst[i].irq_idx);
> -			if (ret < 0) {
> -				dev_dbg(dev, "Error requesting irq at index %d: %d\n",
> -					inst[i].irq_idx, ret);
> -				goto error;
> -			}
> -			board_info.irq = ret;
> -			break;
> -		default:
> -			board_info.irq = 0;
> -			break;
> -		}
> +
> +		ret = bmi_get_irq(pdev, adev, &inst_array[i]);
> +		if (ret < 0)
> +			goto error;
> +		board_info.irq = ret;
> +
>  		bmi->i2c_devs[i] = i2c_acpi_new_device(dev, i, &board_info);
>  		if (IS_ERR(bmi->i2c_devs[i])) {
>  			ret = dev_err_probe(dev, PTR_ERR(bmi->i2c_devs[i]),
>  					    "Error creating i2c-client, idx %d\n", i);
>  			goto error;
>  		}
> +		bmi->i2c_num++;
>  	}
> -	if (i < bmi->i2c_num) {
> +	if (bmi->i2c_num < count) {
>  		dev_err(dev, "Error finding driver, idx %d\n", i);
>  		ret = -ENODEV;
>  		goto error;
>  	}
>  
> -	platform_set_drvdata(pdev, bmi);
> -	return 0;
> +	dev_info(dev, "Instantiate %d I2C devices.\n", bmi->i2c_num);
>  
> +	return bmi->i2c_num;

And change this to return 0.

>  error:
> -	while (--i >= 0)
> -		i2c_unregister_device(bmi->i2c_devs[i]);
> +	dev_err_probe(dev, ret, "I2C error %d\n", ret);
> +	bmi_devs_unregister(bmi);
> +
> +	return ret;
> +}
> +
> +static int bmi_probe(struct platform_device *pdev)
> +{
> +	const struct bmi_instance *inst_array;
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev;
> +	struct bmi *bmi;
> +	int ret;
> +
> +	inst_array = device_get_match_data(dev);
> +	if (!inst_array) {
> +		dev_err(dev, "Error ACPI match data is missing\n");
> +		return -ENODEV;
> +	}
> +
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
> +		return -ENODEV;
> +
> +	bmi = devm_kzalloc(dev, sizeof(*bmi), GFP_KERNEL);
> +	if (!bmi)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, bmi);
> +
> +	ret = bmi_i2c_probe(pdev, adev, bmi, inst_array);
> +	if (ret > 0)
> +		return 0;
> +	if (ret == 0)
> +		ret = -ENODEV;
>  
>  	return ret;

Then you can simplify the above to just:

	return bmi_i2c_probe(pdev, adev, bmi, inst_array);

:)

Regards,

Hans



>  }
> @@ -115,10 +159,8 @@ static int bmi_probe(struct platform_device *pdev)
>  static int bmi_remove(struct platform_device *pdev)
>  {
>  	struct bmi *bmi = platform_get_drvdata(pdev);
> -	int i;
>  
> -	for (i = 0; i < bmi->i2c_num; i++)
> -		i2c_unregister_device(bmi->i2c_devs[i]);
> +	bmi_devs_unregister(bmi);
>  
>  	return 0;
>  }
> 

