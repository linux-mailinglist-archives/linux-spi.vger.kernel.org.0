Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7E174CAA
	for <lists+linux-spi@lfdr.de>; Sun,  1 Mar 2020 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgCAKEN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Mar 2020 05:04:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41975 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgCAKEM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 1 Mar 2020 05:04:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id u26so8260301ljd.8
        for <linux-spi@vger.kernel.org>; Sun, 01 Mar 2020 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gQOIXTEcnm6Zvy+v64CfP+Ch3mLFqBCQbXn3Tlz+cv4=;
        b=WFURwnTZQb7t133i6Ra+Rtg1WBZedlcLlLHCZn4uC75JNmyONO8Bj0u4Tbnk83la/Z
         qwMSzQBjsRNhGPCXMXUAlfenimSZGTMwJbTHXDTHnEHcUAb9hhWXtz8ELtd/1ktdMWHz
         q9PsTs1FbNVOH++uTHZStEGLEkHWtJG6yvJcHUzPqY/HyLX3uYPY2X09CaaI9Kj9CfOy
         Abw/ZiBYHclQfm2cpwWyKvV1NQNW35y+KW807sdzw0ylxlMrEH+nFUP++FVD/5RlJCfx
         X3MUBzk4HezPioiqEd+JdKaHp+aXd8MCs36eJxwm01Fl/u6hPoy4TTpONB0X3aB6KwbC
         oqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQOIXTEcnm6Zvy+v64CfP+Ch3mLFqBCQbXn3Tlz+cv4=;
        b=LDSJsDaGiWy/6jML91qwgHSgwZxtOLkVAnZzhIUADvFedXzxTf9rDandTlXZ1cGOV/
         DP60ITI+eFlAeUjrFoIY1XeBaa/OT5bu4T/KvfI9IZzl64ds2eiwvY1Ykt5AGRaWhOqL
         o591ITZQusUX0yTpuCnP940xrtX9xhPCdkWGZ4YI6ci8Tmg5Rrykz5lN+XsRmnYt56g5
         HmpXfuXVOr1A22nam1p02JhwS0HM6AqRxYkB6V8QwSIM9iypuMCq/+d8pG4LQ761gKiv
         D/ShBCYXaO+sc8NsMRLtU49Uh5bczkYHXe8PZtbIzgGgiICirFbwF1MFg3GcO6i4i2AZ
         YV7A==
X-Gm-Message-State: ANhLgQ3UEbSgi1u3mBm2IeRj57gtbVjO2KgIE2aSxJs0XaeqsscNpLGX
        JjZL2PhZl3gRVdGkwuNjq1cygw==
X-Google-Smtp-Source: ADFU+vvqjg4oqW6Uft9xNiaGvdKNChYfA3uFUApT5e92F7fDueZjTaYxnnQS6pWe+xILajfzC2Bmmg==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr8320982ljj.55.1583057050588;
        Sun, 01 Mar 2020 02:04:10 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:631:be36:41f9:a0d4:22df:3c65? ([2a00:1fa0:631:be36:41f9:a0d4:22df:3c65])
        by smtp.gmail.com with ESMTPSA id i1sm9597287lji.71.2020.03.01.02.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 02:04:09 -0800 (PST)
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
To:     John Garry <john.garry@huawei.com>, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        andriy.shevchenko@linux.intel.com
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <52ecb988-d842-c04b-a0e8-93e8850009c4@cogentembedded.com>
Date:   Sun, 1 Mar 2020 13:04:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582903131-160033-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 28.02.2020 18:18, John Garry wrote:

> Currently ACPI firmware description for a SPI device does not have any
> method to describe the data buswidth on the board.
> 
> So even through the controller and device may support higher modes than
           ^^^^^^^
    Though?

> standard SPI, it cannot be assumed that the board does - as such, that
> device is limited to standard SPI in such a circumstance.
> 
> As a workaround, allow the controller driver supply buswidth override bits,
> which are used inform the core code that the controller driver knows the
> buswidth supported on that board for that device.
> 
> A host controller driver might know this info from DMI tables, for example.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/spi/spi.c       | 4 +++-
>   include/linux/spi/spi.h | 3 +++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 38b4c78df506..292f26807b41 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -510,6 +510,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
>   	spi->dev.bus = &spi_bus_type;
>   	spi->dev.release = spidev_release;
>   	spi->cs_gpio = -ENOENT;
> +	spi->mode = ctlr->buswidth_override_bits;
>   
>   	spin_lock_init(&spi->statistics.lock);
>   
> @@ -2181,9 +2182,10 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>   		return AE_NO_MEMORY;
>   	}
>   
> +

    What for?

>   	ACPI_COMPANION_SET(&spi->dev, adev);
>   	spi->max_speed_hz	= lookup.max_speed_hz;
> -	spi->mode		= lookup.mode;
> +	spi->mode		|= lookup.mode;
>   	spi->irq		= lookup.irq;
>   	spi->bits_per_word	= lookup.bits_per_word;
>   	spi->chip_select	= lookup.chip_select;
[...]

MBR, Sergei
