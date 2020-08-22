Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E7F24E948
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgHVSds (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 Aug 2020 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgHVSdr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 14:33:47 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E0BC061573;
        Sat, 22 Aug 2020 11:33:46 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m20so4528547eds.2;
        Sat, 22 Aug 2020 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gjUEZM3lBlIm0cVrAjftDy1KM/TMOAosVCGT9uQgxg4=;
        b=pZkK4jeoOTURv+2V3If9ZnNx88Ch1Pyco91gvp0Tz3SHWoEIaP5fcIW/2tuAQ1cnQL
         JzaeMXTT+LX3rtb+Xy1tLGGbjX8E/qU/nzLN79Q4rdWD1sEGdT6ud7hHDXX5XPm5fG+Z
         B6R0dayfA5zntmMyaETOElUe3PMHEa1gnLhaSWfzymdrix/6JT7idR9iBq6Q9OyzX5kk
         ghbZjG6bKAma7z5k7WbPgRMXXhvYy63QSbJ0DmDY/gcwp/BZrqDo0zCS4K2g3oL839cT
         ycXmD+DK82xdjKfaZ39f/gUWxqWPvX4JkEzCh3SUQaimQTUaNO4HqXsXQGllYN/t0oI2
         9wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gjUEZM3lBlIm0cVrAjftDy1KM/TMOAosVCGT9uQgxg4=;
        b=GyLcrQwmkkjiK+7jKg3z25oMzhLtyrANeuqGmcDsNzXNh16IvztHYVme0en7TbQmf4
         j6YKku1NAiY/Ge5hvKorbNIhUrijn4qIC10RUZejrTuv+1H+jb49+S5n5hzMvEXkB6KE
         aoDoe6xWy/KtIlDWto48uV2MQdQH4puByxLy2jDVkRaH5dQzuuayMaY4eg1+vGLX2SbX
         WXq47LMqhJT42bY4Yp8YwvxcT1sc3TpBjPAMBYU/YeXssxKDIoDDxqvUYQH4E4JY1/g2
         Xr5UocCcHkp6j4KKlbTeRObuWm0hJk6cleRIqFtVTjkfVdNl/99zUhy1LvM7r0lCCD7I
         F0lw==
X-Gm-Message-State: AOAM532IupCbFu+s1tlqZaqbbnxrjlS0tRwMFNcHbFfHQYg9AIPeThdg
        hGiBy3XsZBSfmnE4fnTfjmw=
X-Google-Smtp-Source: ABdhPJwHuJ6YunThrHWhYkKjSCk17dLUii9bv6xPRyBeI+2Cvwo9c4dSoPimWu4tWZNkonYWS04kyg==
X-Received: by 2002:a05:6402:1016:: with SMTP id c22mr3888099edu.89.1598121225104;
        Sat, 22 Aug 2020 11:33:45 -0700 (PDT)
Received: from skbuf ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id p12sm3390837edt.27.2020.08.22.11.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 11:33:44 -0700 (PDT)
Date:   Sat, 22 Aug 2020 21:33:42 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        tanveer <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200822183342.6sdhp6yq6i7yvdia@skbuf>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 21, 2020 at 06:40:29PM +0530, kuldip dwivedi wrote:
> Currently fsl DSPI driver has support of DT only. Adding ACPI
> support to the drive so that it can be used by UEFI firmware
> boot in ACPI mode. This driver will be probed if any firmware
> will expose HID "NXP0005" in DSDT table.
> 
> Signed-off-by: tanveer <tanveer.alam@puresoftware.com>
> Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 91 +++++++++++++++++++++++++++++---------
>  1 file changed, 69 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 91c6affe139c..7100a8a0a30e 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -1070,6 +1072,12 @@ static void dspi_cleanup(struct spi_device *spi)
>  	kfree(chip);
>  }
>  
> +static const struct acpi_device_id fsl_dspi_acpi_ids[] = {
> +	{ "NXP0005", .driver_data = (kernel_ulong_t)&devtype_data[LS2085A], },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, fsl_dspi_acpi_ids);
> +

Just noticed this now.
So for device tree, spi-fsl-dspi supports the following compatibles:

fsl,vf610-dspi
fsl,ls1021a-v1.0-dspi
fsl,ls1012a-dspi
fsl,ls1028a-dspi
fsl,ls1043a-dspi
fsl,ls1046a-dspi
fsl,ls2080a-dspi
fsl,ls2085a-dspi
fsl,lx2160a-dspi

Depending on the compatible string, the driver knows whether to use DMA
or XSPI mode, and what the FIFO size is.

Now, of course not all of the above SoCs are going to support ACPI, but
it is reasonable to expect that more than one will. And in that case,
the driver should still be able to know on what SoC it's running,
because for example LS1043A doesn't support DMA, and LS2085A doesn't
support XSPI.

How is this dealt with in ACPI?

Thanks,
-Vladimir
