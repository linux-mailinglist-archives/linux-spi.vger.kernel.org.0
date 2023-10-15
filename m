Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3996E7C9870
	for <lists+linux-spi@lfdr.de>; Sun, 15 Oct 2023 11:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjJOJQp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Oct 2023 05:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJOJQo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Oct 2023 05:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073A8DC
        for <linux-spi@vger.kernel.org>; Sun, 15 Oct 2023 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697361352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6GHnZPE9tqaUE7IUXr8Kjm0FNAiXOJNmp9dZGcG/hI=;
        b=ZeefL86DBCa0enANs32DFrsgHi3BzoJemK/Nrhb70zOHP0fIDc8fMlT2XCOAOcO2L0GFKn
        Lw7bg7jLjNdwtlDj/oFqOlNlZ83BlSfL5Wim3wKSa+aDnmULthUG3BH7qb0ctAY+KVmQKu
        1ltTtiKSUfhX2nVxIfk/zb25pCTmUEs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-tXq3TJYiNN6MsSoic_qTTQ-1; Sun, 15 Oct 2023 05:15:50 -0400
X-MC-Unique: tXq3TJYiNN6MsSoic_qTTQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9bd91ce3033so217595966b.0
        for <linux-spi@vger.kernel.org>; Sun, 15 Oct 2023 02:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697361349; x=1697966149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6GHnZPE9tqaUE7IUXr8Kjm0FNAiXOJNmp9dZGcG/hI=;
        b=dAcAVoMWE5aO8IpMTaSXTDvhD5/HkmTfAhWg9A+7pu5y/Mjpv9Yj+aYNU46j5Lp3UM
         C56lffOUQ+C+pBejC21Cztep1zFeUfXhnJdOOwxb4mpAOxOXNHxtHKrDJHLkkTDXOMRi
         M3D12htE4MuBlv7P0vMN7b1tCeS/PnFzGEXwtgDi/XCPO8ajG074ZZFms1rdum3GyAsJ
         Z5OPIl6OKzmi5p6epgyXHd0seW79Xi6Vs7FD1FWzzQERIXoBkJDFIDoiJnXJ+zI4FA5n
         LDvHDhfPldjbU9/zVUdTTgyDg1Yg336+G5XRFvfsDU/kJUcG8SFm03LIoh4iYo44FtFI
         jQFw==
X-Gm-Message-State: AOJu0YxlLhY3KnWi1VA1ZALI/knATrX5BS/lQXFGB7EZlRn0+9ERLyZb
        ZWLP/mgjO6ueqeejw7vQCsXsFBqCQHOgNkE/4df/s2s7nYp2JyxQbEZ3tBdsJd/yGebE2iOU0b0
        hHu7Lb+qtjQe1/cdMmRSINeYgXzN2
X-Received: by 2002:a17:907:94cb:b0:9c3:8242:e665 with SMTP id dn11-20020a17090794cb00b009c38242e665mr621928ejc.8.1697361348987;
        Sun, 15 Oct 2023 02:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqiav65BAH59PFNrCGQmrRuqmpL/4GwmkL4TGEakPFwgpPBWODuKzPJ2GvjbRfyr0QlkIXpQ==
X-Received: by 2002:a17:907:94cb:b0:9c3:8242:e665 with SMTP id dn11-20020a17090794cb00b009c38242e665mr621916ejc.8.1697361348594;
        Sun, 15 Oct 2023 02:15:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ks18-20020a170906f85200b009a193a5acffsm2010141ejb.121.2023.10.15.02.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 02:15:47 -0700 (PDT)
Message-ID: <65cb8c8c-1a07-922b-db7a-dba54afc76b6@redhat.com>
Date:   Sun, 15 Oct 2023 11:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] platform/x86: x86-android-tablets: Add audio codec
 info for Lenovo Yoga Tab 3 Pro YT3-X90F
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20231014205314.59333-1-hdegoede@redhat.com>
 <20231014205314.59333-5-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231014205314.59333-5-hdegoede@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 10/14/23 22:53, Hans de Goede wrote:
> The SPI attached WM5102 codec on the Lenovo Yoga Tab 3 Pro YT3-X90F
> is not described in the ACPI tables.
> 
> Add info to instantiate the SPI device for the codec manually.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../platform/x86/x86-android-tablets/lenovo.c | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
> index 585f10a57810..d5d815940ce1 100644
> --- a/drivers/platform/x86/x86-android-tablets/lenovo.c
> +++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
> @@ -12,6 +12,8 @@
>  
>  #include <linux/efi.h>
>  #include <linux/gpio/machine.h>
> +#include <linux/mfd/arizona/pdata.h>
> +#include <linux/mfd/arizona/registers.h>
>  #include <linux/mfd/intel_soc_pmic.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/machine.h>
> @@ -677,6 +679,89 @@ static const struct x86_i2c_client_info lenovo_yt3_i2c_clients[] __initconst = {
>  	}
>  };
>  
> +/*
> + * The AOSP 3.5 mm Headset: Accessory Specification gives the following values:
> + * Function A Play/Pause:           0 ohm
> + * Function D Voice assistant:    135 ohm
> + * Function B Volume Up           240 ohm
> + * Function C Volume Down         470 ohm
> + * Minimum Mic DC resistance     1000 ohm
> + * Minimum Ear speaker impedance   16 ohm
> + * Note the first max value below must be less then the min. speaker impedance,
> + * to allow CTIA/OMTP detection to work. The other max values are the closest
> + * value from extcon-arizona.c:arizona_micd_levels halfway 2 button resistances.
> + */
> +static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
> +	{ .max =  11, .key = KEY_PLAYPAUSE },
> +	{ .max = 186, .key = KEY_VOICECOMMAND },
> +	{ .max = 348, .key = KEY_VOLUMEUP },
> +	{ .max = 752, .key = KEY_VOLUMEDOWN },
> +};
> +
> +/* YT3 WM5102 arizona_micd_config comes from Android kernel sources */
> +static struct arizona_micd_config lenovo_yt3_wm5102_micd_config[]={
> +	{ 0, 1, 0 },
> +	{ ARIZONA_ACCDET_SRC, 2, 1 },
> +};
> +
> +static struct arizona_pdata lenovo_yt3_wm5102_pdata = {
> +	.irq_flags = IRQF_TRIGGER_LOW,
> +	.micd_detect_debounce = 200,
> +	.micd_ranges = arizona_micd_aosp_ranges,
> +	.num_micd_ranges = ARRAY_SIZE(arizona_micd_aosp_ranges),
> +	.hpdet_channel = ARIZONA_ACCDET_MODE_HPL,
> +
> +	/* Below settings come from Android kernel sources */
> +	.micd_bias_start_time = 1,
> +	.micd_rate = 6,
> +	.micd_force_micbias = 1,
> +	.micd_configs = lenovo_yt3_wm5102_micd_config,
> +	.num_micd_configs = ARRAY_SIZE(lenovo_yt3_wm5102_micd_config),
> +        .micbias={
> +           [0]={ /*MICBIAS1*/
> +                 .mV =2800 ,
> +                 .ext_cap=1,
> +                 .discharge =1 ,
> +                 .soft_start =0,
> +                 .bypass =0,
> +           },

Note I messed up the indentation here (spaces instead of tabs)
when copy pasting this from one terminal to another,
I'll go and fix this up locally.

Regards,

Hans




> +           [1]={ /*MICBIAS2*/
> +                 .mV =2800 ,
> +                 .ext_cap=1,
> +                 .discharge =1 ,
> +                 .soft_start =0,
> +                 .bypass =0,
> +           },
> +           [2]={ /*MICBIAS3*/
> +                 .mV =2800 ,
> +                 .ext_cap=1,
> +                 .discharge =1 ,
> +                 .soft_start =0,
> +                 .bypass =0,
> +           },
> +        },
> +};
> +
> +static const struct x86_spi_dev_info lenovo_yt3_spi_devs[] __initconst = {
> +	{
> +		/* WM5102 codec */
> +		.board_info = {
> +			.modalias = "wm5102",
> +			.platform_data = &lenovo_yt3_wm5102_pdata,
> +			.max_speed_hz = 5000000,
> +		},
> +		.ctrl_path = "\\_SB_.PCI0.SPI1",
> +		.irq_data = {
> +			.type = X86_ACPI_IRQ_TYPE_GPIOINT,
> +			.chip = "INT33FF:00",
> +			.index = 91,
> +			.trigger = ACPI_LEVEL_SENSITIVE,
> +			.polarity = ACPI_ACTIVE_LOW,
> +			.con_id = "wm5102_irq",
> +		},
> +	}
> +};
> +
>  static int __init lenovo_yt3_init(void)
>  {
>  	int ret;
> @@ -720,14 +805,28 @@ static struct gpiod_lookup_table lenovo_yt3_hideep_gpios = {
>  	},
>  };
>  
> +static struct gpiod_lookup_table lenovo_yt3_wm5102_gpios = {
> +	.dev_id = "spi1.0",
> +	.table = {
> +		GPIO_LOOKUP("INT33FF:00", 75, "wlf,spkvdd-ena", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("INT33FF:00", 81, "wlf,ldoena", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("INT33FF:00", 82, "reset", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("arizona", 2, "wlf,micd-pol", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
>  static struct gpiod_lookup_table * const lenovo_yt3_gpios[] = {
>  	&lenovo_yt3_hideep_gpios,
> +	&lenovo_yt3_wm5102_gpios,
>  	NULL
>  };
>  
>  const struct x86_dev_info lenovo_yt3_info __initconst = {
>  	.i2c_client_info = lenovo_yt3_i2c_clients,
>  	.i2c_client_count = ARRAY_SIZE(lenovo_yt3_i2c_clients),
> +	.spi_dev_info = lenovo_yt3_spi_devs,
> +	.spi_dev_count = ARRAY_SIZE(lenovo_yt3_spi_devs),
>  	.gpiod_lookup_tables = lenovo_yt3_gpios,
>  	.init = lenovo_yt3_init,
>  };

