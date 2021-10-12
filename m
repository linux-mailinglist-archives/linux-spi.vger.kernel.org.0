Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3584E42A8E3
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhJLP4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234892AbhJLP4v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634054089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKcfhdVqfkpd0KNcl7uSyc4SWQzXE5GXNGJiUf3+7ao=;
        b=YjtykSVIwVFfjMVS6y1zamGdbWk6bt6qbozkvy3TzxqTsiVNo0kTQwEjaFja6/RORAhLnt
        h7WmRucFB0cvaGcJRZT4Sx61Q+WO1bA+RrjLZ3Zh8F1Ocyk9OdXHjAU8tdUA3a/vQlQSFY
        va5oQuyRJWR4PyUfDJKgGcgwYyexLmA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-T1zeWRPgOjWsXirL5c-vDA-1; Tue, 12 Oct 2021 11:54:48 -0400
X-MC-Unique: T1zeWRPgOjWsXirL5c-vDA-1
Received: by mail-ed1-f69.google.com with SMTP id u23-20020a50a417000000b003db23c7e5e2so331634edb.8
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKcfhdVqfkpd0KNcl7uSyc4SWQzXE5GXNGJiUf3+7ao=;
        b=ow8EAd2XBK3GoVAL2sv8gZ1XGaGc4xq/Hs2n4Ar3XfmR/6Fv+YvG8SUKdaJgyrpcjR
         tt+y5Lx8grypl2gqYEhWPPhcKKw8qSySCIdd4c6sIkZM59OsqWnkhBSv00eb1XKQNv1a
         F1LjQysI7cZVjqlp4ov4Q3NFB46xVg+PphC5Bue32i+cry2aNvffCrxC7KQpuHlMVwPE
         p7jB/IeOBVZ7xMSLQIGW3srFlzl9TTwvik5Yur/FNEN344kWXmh1N3GGGnAtSeJsTEb1
         lpyCntfPuiYtzC2ik5oxdQG2N2czm6wyDO08D22Vuz/N/OPEpReLJawmgOroy4MMMQFd
         oz4A==
X-Gm-Message-State: AOAM533DGtnVovYTxaLT+51msJJ4Y0rIHnxatiZBQiRaBkYfY5ufGGOY
        BDfnfzlBqIMQkazn44FzeEKXMHy02218TD52ulV6wu1ZRZdoWj2dDJhPJ4WftKTdCPDg+L6qmAa
        JetAO0QTm05qeEZAYds72
X-Received: by 2002:a17:906:1bf2:: with SMTP id t18mr19670029ejg.340.1634054087276;
        Tue, 12 Oct 2021 08:54:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPqbgLk1hBABtjOounE1ddW9bk4p3yz3ex1QkxmBw4gZ2oNtmsKSacA/Yyvw8HUjRH65UtBg==
X-Received: by 2002:a17:906:1bf2:: with SMTP id t18mr19670002ejg.340.1634054087072;
        Tue, 12 Oct 2021 08:54:47 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g26sm2340336ejb.84.2021.10.12.08.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 08:54:46 -0700 (PDT)
Subject: Re: [PATCH v2 12/20] misc: lis3lv02d: Make lis3lv02d_remove_fs()
 return void
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-13-u.kleine-koenig@pengutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bc739810-abb4-d7bc-e901-227b43bc5a71@redhat.com>
Date:   Tue, 12 Oct 2021 17:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211012153945.2651412-13-u.kleine-koenig@pengutronix.de>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 10/12/21 5:39 PM, Uwe Kleine-König wrote:
> Up to now lis3lv02d_remove_fs() returns zero unconditionally. Make it return
> void instead which makes it easier to see in the callers that there is
> no error to handle.
> 
> Also the return value of i2c and spi remove callbacks is ignored anyway.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Also please consider this as my ack for merging the
drivers/platform/x86/ part of this through whatever
tree is convenient.

Regards,

Hans

> ---
>  drivers/misc/lis3lv02d/lis3lv02d.c     | 3 +--
>  drivers/misc/lis3lv02d/lis3lv02d.h     | 2 +-
>  drivers/misc/lis3lv02d/lis3lv02d_spi.c | 4 +++-
>  drivers/platform/x86/hp_accel.c        | 3 ++-
>  4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
> index 70c5bb1e6f49..3a7808b796b1 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d.c
> +++ b/drivers/misc/lis3lv02d/lis3lv02d.c
> @@ -878,7 +878,7 @@ static int lis3lv02d_add_fs(struct lis3lv02d *lis3)
>  	return sysfs_create_group(&lis3->pdev->dev.kobj, &lis3lv02d_attribute_group);
>  }
>  
> -int lis3lv02d_remove_fs(struct lis3lv02d *lis3)
> +void lis3lv02d_remove_fs(struct lis3lv02d *lis3)
>  {
>  	sysfs_remove_group(&lis3->pdev->dev.kobj, &lis3lv02d_attribute_group);
>  	platform_device_unregister(lis3->pdev);
> @@ -894,7 +894,6 @@ int lis3lv02d_remove_fs(struct lis3lv02d *lis3)
>  		pm_runtime_set_suspended(lis3->pm_dev);
>  	}
>  	kfree(lis3->reg_cache);
> -	return 0;
>  }
>  EXPORT_SYMBOL_GPL(lis3lv02d_remove_fs);
>  
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d.h b/drivers/misc/lis3lv02d/lis3lv02d.h
> index c394c0b08519..195bd2fd2eb5 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d.h
> +++ b/drivers/misc/lis3lv02d/lis3lv02d.h
> @@ -312,7 +312,7 @@ int lis3lv02d_joystick_enable(struct lis3lv02d *lis3);
>  void lis3lv02d_joystick_disable(struct lis3lv02d *lis3);
>  void lis3lv02d_poweroff(struct lis3lv02d *lis3);
>  int lis3lv02d_poweron(struct lis3lv02d *lis3);
> -int lis3lv02d_remove_fs(struct lis3lv02d *lis3);
> +void lis3lv02d_remove_fs(struct lis3lv02d *lis3);
>  int lis3lv02d_init_dt(struct lis3lv02d *lis3);
>  
>  extern struct lis3lv02d lis3_dev;
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d_spi.c b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
> index f664ed123730..9e40dfb60742 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d_spi.c
> +++ b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
> @@ -102,7 +102,9 @@ static int lis302dl_spi_remove(struct spi_device *spi)
>  	lis3lv02d_joystick_disable(lis3);
>  	lis3lv02d_poweroff(lis3);
>  
> -	return lis3lv02d_remove_fs(&lis3_dev);
> +	lis3lv02d_remove_fs(&lis3_dev);
> +
> +	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
> index cc53f725c041..b183967ecfb7 100644
> --- a/drivers/platform/x86/hp_accel.c
> +++ b/drivers/platform/x86/hp_accel.c
> @@ -349,7 +349,8 @@ static int lis3lv02d_remove(struct platform_device *device)
>  	led_classdev_unregister(&hpled_led.led_classdev);
>  	flush_work(&hpled_led.work);
>  
> -	return lis3lv02d_remove_fs(&lis3_dev);
> +	lis3lv02d_remove_fs(&lis3_dev);
> +	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> 

