Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503A6493F51
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 18:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356513AbiASRsZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jan 2022 12:48:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356507AbiASRsX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jan 2022 12:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642614503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpDeVNV5+zY/wtrGfYxy2lEajeSHJy9f5dUQzPImNNs=;
        b=flnxuyNqoC820CGLeScUXn67qerYhTgi8KDBU3JdKt6SbvO4gv7vu9OtQQQ7MWSy4kQ/4a
        J6JpKnr3ZBNWpVMR/Dh3aMjOCNP5gLG6w9gxZ2PgSxJJrMaYZJNDeejanea8u1ajnNjYmp
        PbQmoJQeWBt2JNJh26asYqYPNZU8EPY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-2ZrOo-RwMoKnCX3bd-dm2Q-1; Wed, 19 Jan 2022 12:48:21 -0500
X-MC-Unique: 2ZrOo-RwMoKnCX3bd-dm2Q-1
Received: by mail-ed1-f70.google.com with SMTP id ej6-20020a056402368600b00402b6f12c3fso3349245edb.8
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 09:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YpDeVNV5+zY/wtrGfYxy2lEajeSHJy9f5dUQzPImNNs=;
        b=XWzu5hBTsb8ddDqn03jxGSJKC2jtk6Vh2mF/U2HsRFpwTSitPjpuWDj+zbPAl3Ol9z
         XAxKywhlDEoAkgqJ5osbzdILtONf/JcQeix/L2tUvhJ4UmzKFOdB/3x7cLet6ShcdLhK
         tKWPAj6yCPkuhZnZbNZrMIl2OTDW6OvGPyPcZisy7ACNpuy8fDb9FFmTEY4gplWOsIHF
         GifX16YhOgOTwRP2Vuu8efgDSIB+g39/c6DJkE8yZo37B17FO9RO/b+nDw+BPHTjO2Ek
         VnxlFKkWDvDTiSECGJ4pkAAK3YVupSmyQjDACOfauyxS+VnNsbA1mzOfs9sO3gIMWCjh
         l/ZA==
X-Gm-Message-State: AOAM532we6Gp7a0qcdVoNcOm6q+uxI2yjhjiqiZSSa4dq+kp4L35lnhz
        XOVr14E2YoidKbTBq4+eHf6KnfVWnbSLq6s8VvN/WPEJc09FELIn2060NNwaFKkTUn4n06p8dnj
        0cYaUuaOz0LM/Zua8P6Qa
X-Received: by 2002:a17:907:3e24:: with SMTP id hp36mr17603777ejc.584.1642614499593;
        Wed, 19 Jan 2022 09:48:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5iWS79JAvreWf3L6gIVZPiqWXYyiPVTLJMjomwG6E2H8+WN4B3GQwRNVgVkLtSBGLy4Uh7w==
X-Received: by 2002:a17:907:3e24:: with SMTP id hp36mr17603759ejc.584.1642614499311;
        Wed, 19 Jan 2022 09:48:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id r18sm172741edq.25.2022.01.19.09.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 09:48:18 -0800 (PST)
Message-ID: <f55ff70c-1578-afa7-999e-ba504aa325eb@redhat.com>
Date:   Wed, 19 Jan 2022 18:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 05/10] platform/x86: i2c-multi-instantiate: Move it to
 drivers/acpi folder
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lucas tanure <tanureal@opensource.cirrus.com>
Cc:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        patches@opensource.cirrus.com
References: <20220118145251.1548-1-sbinding@opensource.cirrus.com>
 <20220118145251.1548-6-sbinding@opensource.cirrus.com>
 <CAJZ5v0g0n201FPcG9LBNG3e4UdNYSWmj_1sN3MxLxmK=GoF+tA@mail.gmail.com>
 <a3522b5e-fb36-b959-d2ea-d141d3ad9999@opensource.cirrus.com>
 <CAJZ5v0h8MWb3sSuqWHUcm9TVWP0uJ+=GmzAuqVtNag2LP+0kYQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0h8MWb3sSuqWHUcm9TVWP0uJ+=GmzAuqVtNag2LP+0kYQ@mail.gmail.com>
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

On 1/19/22 18:44, Rafael J. Wysocki wrote:
> On Wed, Jan 19, 2022 at 6:33 PM Lucas tanure
> <tanureal@opensource.cirrus.com> wrote:
>>
>> On 1/19/22 16:53, Rafael J. Wysocki wrote:
>>> On Tue, Jan 18, 2022 at 3:53 PM Stefan Binding
>>> <sbinding@opensource.cirrus.com> wrote:
>>>>
>>>> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>>>>
>>>> Moving I2C multi instantiate driver to drivers/acpi folder for
>>>> upcoming conversion into a generic bus multi instantiate
>>>> driver for SPI and I2C
>>>>
>>>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
>>>> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
>>>
>>> Why are you moving it away from platform/x86?
>>>
>>> Adding SPI to the mix doesn't seem to be a sufficient reason.
>>>
>>> If this were going to be needed on non-x86, that would be a good
>>> reason for moving it, but is that actually the case?  If so, why isn't
>>> that mentioned in the changelog above?
>>>
>>
>> It was a request made by Andy Shevchenko:
>> https://lkml.org/lkml/2021/12/3/347
> 
> But he hasn't given any reasons why that'd be better.
> 
>> There is no plan to use our CS35L41 HDA with non-x86 platforms and we
>> can't comment about i2c-multi-instantiate use.
>> For us it can stay in x86 folder until an actual request.
> 
> I'd prefer that if Hans agrees.

Ack, keeping this in drivers/platform/x86 is fine with me.

I'll try to make some time to review this new version next week.

Looking at the subjects of the patches I see that this now
refactors the SPI code to re-use the existing SPI ACPI resource
parsing there, thank you for doing that!

Regards,

Hans





> 
>>>> ---
>>>>   MAINTAINERS                                           |  2 +-
>>>>   drivers/acpi/Kconfig                                  | 11 +++++++++++
>>>>   drivers/acpi/Makefile                                 |  1 +
>>>>   .../{platform/x86 => acpi}/i2c-multi-instantiate.c    |  0
>>>>   drivers/acpi/scan.c                                   |  2 +-
>>>>   drivers/platform/x86/Kconfig                          | 11 -----------
>>>>   drivers/platform/x86/Makefile                         |  1 -
>>>>   7 files changed, 14 insertions(+), 14 deletions(-)
>>>>   rename drivers/{platform/x86 => acpi}/i2c-multi-instantiate.c (100%)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 4e828542b089..546f9e149d28 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -392,7 +392,7 @@ ACPI I2C MULTI INSTANTIATE DRIVER
>>>>   M:     Hans de Goede <hdegoede@redhat.com>
>>>>   L:     platform-driver-x86@vger.kernel.org
>>>>   S:     Maintained
>>>> -F:     drivers/platform/x86/i2c-multi-instantiate.c
>>>> +F:     drivers/acpi/i2c-multi-instantiate.c
>>>>
>>>>   ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
>>>>   M:     Sudeep Holla <sudeep.holla@arm.com>
>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>>> index ba45541b1f1f..2fd78366af6f 100644
>>>> --- a/drivers/acpi/Kconfig
>>>> +++ b/drivers/acpi/Kconfig
>>>> @@ -295,6 +295,17 @@ config ACPI_PROCESSOR
>>>>            To compile this driver as a module, choose M here:
>>>>            the module will be called processor.
>>>>
>>>> +config ACPI_I2C_MULTI_INST
>>>> +       tristate "I2C multi instantiate pseudo device driver"
>>>> +       depends on I2C
>>>> +       help
>>>> +         Some ACPI-based systems list multiple i2c-devices in a single ACPI
>>>> +         firmware-node. This driver will instantiate separate i2c-clients
>>>> +         for each device in the firmware-node.
>>>> +
>>>> +         To compile this driver as a module, choose M here: the module
>>>> +         will be called i2c-multi-instantiate.
>>>> +
>>>>   config ACPI_IPMI
>>>>          tristate "IPMI"
>>>>          depends on IPMI_HANDLER
>>>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>>>> index bb757148e7ba..d4db7fb0baf0 100644
>>>> --- a/drivers/acpi/Makefile
>>>> +++ b/drivers/acpi/Makefile
>>>> @@ -104,6 +104,7 @@ obj-$(CONFIG_ACPI_SPCR_TABLE)       += spcr.o
>>>>   obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>>>>   obj-$(CONFIG_ACPI_PPTT)        += pptt.o
>>>>   obj-$(CONFIG_ACPI_PFRUT)       += pfr_update.o pfr_telemetry.o
>>>> +obj-$(CONFIG_ACPI_I2C_MULTI_INST)      += i2c-multi-instantiate.o
>>>>
>>>>   # processor has its own "processor." module_param namespace
>>>>   processor-y                    := processor_driver.o
>>>> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/acpi/i2c-multi-instantiate.c
>>>> similarity index 100%
>>>> rename from drivers/platform/x86/i2c-multi-instantiate.c
>>>> rename to drivers/acpi/i2c-multi-instantiate.c
>>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>>> index 1331756d4cfc..3e85a02f6ba2 100644
>>>> --- a/drivers/acpi/scan.c
>>>> +++ b/drivers/acpi/scan.c
>>>> @@ -1738,7 +1738,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>>>>           * must be instantiated for each, each with its own i2c_device_id.
>>>>           * Normally we only instantiate an i2c-client for the first resource,
>>>>           * using the ACPI HID as id. These special cases are handled by the
>>>> -        * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
>>>> +        * drivers/acpi/i2c-multi-instantiate.c driver, which knows
>>>>           * which i2c_device_id to use for each resource.
>>>>           */
>>>>                  {"BSG1160", },
>>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>>>> index 24deeeb29af2..37c1c150508d 100644
>>>> --- a/drivers/platform/x86/Kconfig
>>>> +++ b/drivers/platform/x86/Kconfig
>>>> @@ -990,17 +990,6 @@ config TOPSTAR_LAPTOP
>>>>
>>>>            If you have a Topstar laptop, say Y or M here.
>>>>
>>>> -config I2C_MULTI_INSTANTIATE
>>>> -       tristate "I2C multi instantiate pseudo device driver"
>>>> -       depends on I2C && ACPI
>>>> -       help
>>>> -         Some ACPI-based systems list multiple i2c-devices in a single ACPI
>>>> -         firmware-node. This driver will instantiate separate i2c-clients
>>>> -         for each device in the firmware-node.
>>>> -
>>>> -         To compile this driver as a module, choose M here: the module
>>>> -         will be called i2c-multi-instantiate.
>>>> -
>>>>   config MLX_PLATFORM
>>>>          tristate "Mellanox Technologies platform support"
>>>>          depends on I2C && REGMAP
>>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>>>> index c12a9b044fd8..6c7870190564 100644
>>>> --- a/drivers/platform/x86/Makefile
>>>> +++ b/drivers/platform/x86/Makefile
>>>> @@ -110,7 +110,6 @@ obj-$(CONFIG_TOPSTAR_LAPTOP)        += topstar-laptop.o
>>>>
>>>>   # Platform drivers
>>>>   obj-$(CONFIG_FW_ATTR_CLASS)            += firmware_attributes_class.o
>>>> -obj-$(CONFIG_I2C_MULTI_INSTANTIATE)    += i2c-multi-instantiate.o
>>>>   obj-$(CONFIG_MLX_PLATFORM)             += mlx-platform.o
>>>>   obj-$(CONFIG_TOUCHSCREEN_DMI)          += touchscreen_dmi.o
>>>>   obj-$(CONFIG_WIRELESS_HOTKEY)          += wireless-hotkey.o
>>>> --
>>>> 2.25.1
>>>>
>>
> 

