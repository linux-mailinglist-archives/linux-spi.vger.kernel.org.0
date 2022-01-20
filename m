Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A61495266
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 17:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377036AbiATQbM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jan 2022 11:31:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376951AbiATQbK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jan 2022 11:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642696270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HG4KxWhwtWwNTvvRLfsMu7xjc8q7j8EF/CkudyE8uX0=;
        b=EmRMGuOvimX2dUzdo+0A/inwC5jOTjzTErhzJwTvVENh7YWBDO+b2dsmOOTAG6bgKHNg0s
        DY6+a5X3Lc6hMaPKpJUlkhm8/IeyilN76TKkgQ//UJyDoSYlfC8vFDvFZUugaeRWNJNH0j
        sSmpgxKiNw7KQScakoTrlWCsgNY0yDY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-RvsGNborNR-CgfAJNT5sAg-1; Thu, 20 Jan 2022 11:31:08 -0500
X-MC-Unique: RvsGNborNR-CgfAJNT5sAg-1
Received: by mail-ed1-f70.google.com with SMTP id o10-20020a056402438a00b00403212b6b1aso6345813edc.13
        for <linux-spi@vger.kernel.org>; Thu, 20 Jan 2022 08:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HG4KxWhwtWwNTvvRLfsMu7xjc8q7j8EF/CkudyE8uX0=;
        b=aftBbR6Wamd/C2AEH5eeC4qczSBRpD5OrGR3vvB9LlbRRef0Yq1uIc/5Rq/Eik1jbl
         0d1UplcNs+LDC5xpJWvU/lMZhwXrOD/qgJIt8jFGMrqKD8NjW3HnWdcKk8SJpSRvz45T
         0OdHMy4Oz39HNfEuFVROd2Lf2mLx012ODzDjAmAyphHBX8znY80v3//estWB9psVEfJ1
         0kswu75NBMkF9oCfJJedwF61aLMO3B5vMZOH1JNHn5W9YgjV0W7Y1X1F7jr4uPfcqrw4
         ZAVGHVyKMkRlcnBLo168tgV8ZoLPjfm3dw4amJgAUVvDYaletgcXA9QqEq5xKCN66Rn3
         +4XA==
X-Gm-Message-State: AOAM532KQfDQ/Ox42QfLOFDeLPQE7jtgtTqAxjQmftYu1iOcDSNCzslm
        kxAGMsDhLpjpXJRwu5FHH+DAJaXihB37q6TYa7fB3gqv1FazsATYy1PMrdGnHAh5MtVDXjvesR9
        RLNVh48kUEEYR9CRnlNOS
X-Received: by 2002:a50:9d48:: with SMTP id j8mr37489600edk.192.1642696267502;
        Thu, 20 Jan 2022 08:31:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDfvucpGU9m/OqAkslPe7xRB1r1l5bfzYpyd7TKbIdzsNby116Ajn4L3Y5Opjls/YVVi/ksg==
X-Received: by 2002:a50:9d48:: with SMTP id j8mr37489573edk.192.1642696267353;
        Thu, 20 Jan 2022 08:31:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id y17sm1206649ejw.172.2022.01.20.08.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 08:31:06 -0800 (PST)
Message-ID: <87c61164-47bf-c560-4e4d-78105a84531e@redhat.com>
Date:   Thu, 20 Jan 2022 17:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 9/9] ACPI / scan: Create platform device for CS35L41
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
 <20220120134326.5295-10-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220120134326.5295-10-sbinding@opensource.cirrus.com>
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
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> 
> The ACPI device with CSC3551 or CLSA0100 are sound cards
> with multiple instances of CS35L41 connectec by I2C or SPI
> to the main CPU.
> 
> We add an ID to the ignore_serial_bus_ids list to enumerate
> all I2C or SPI devices correctly.
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/acpi/scan.c                          |  3 +++
>  drivers/platform/x86/bus-multi-instantiate.c | 14 ++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 4fd1346d6e1f..2f2210c969c8 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1744,8 +1744,11 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>  	 */
>  		{"BSG1160", },
>  		{"BSG2150", },
> +		{"CSC3551", },
>  		{"INT33FE", },
>  		{"INT3515", },
> +	/* Non-conforming _HID for Cirrus Logic already released */
> +		{"CLSA0100", },
>  	/*
>  	 * HIDs of device with an UartSerialBusV2 resource for which userspace
>  	 * expects a regular tty cdev to be created (instead of the in kernel
> diff --git a/drivers/platform/x86/bus-multi-instantiate.c b/drivers/platform/x86/bus-multi-instantiate.c
> index 05bc941a38fd..7a394b671f5a 100644
> --- a/drivers/platform/x86/bus-multi-instantiate.c
> +++ b/drivers/platform/x86/bus-multi-instantiate.c
> @@ -328,6 +328,17 @@ static const struct bmi_node int3515_data = {
>  	.bus_type = BMI_I2C,
>  };
>  
> +static const struct bmi_node cs35l41_hda = {
> +	.instances = {
> +		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +		{ "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
> +		{}
> +	},
> +	.bus_type = BMI_AUTO_DETECT,
> +};
> +
>  /*
>   * Note new device-ids must also be added to bus_multi_instantiate_ids in
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> @@ -336,6 +347,9 @@ static const struct acpi_device_id bmi_acpi_ids[] = {
>  	{ "BSG1160", (unsigned long)&bsg1160_data },
>  	{ "BSG2150", (unsigned long)&bsg2150_data },
>  	{ "INT3515", (unsigned long)&int3515_data },
> +	{ "CSC3551", (unsigned long)&cs35l41_hda },
> +	/* Non-conforming _HID for Cirrus Logic already released */
> +	{ "CLSA0100", (unsigned long)&cs35l41_hda },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, bmi_acpi_ids);
> 

