Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F316A45724E
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 17:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhKSQGa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 11:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbhKSQG3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 11:06:29 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3380C06173E
        for <linux-spi@vger.kernel.org>; Fri, 19 Nov 2021 08:03:27 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id f9so13230208ioo.11
        for <linux-spi@vger.kernel.org>; Fri, 19 Nov 2021 08:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aRUizR/SQ3aER24HlrQ8e7XvTXAi4MwCK2pl0JDXiP8=;
        b=VoMZ0mJkG43tbEre0wd4u0+XMHFAoG+1NuvCHKZrw3p5GcnYdvzK+V8q0NHHKEVBRk
         KBz7jXriBnCj8sd1G91+BPH2dGXGjwcM84nni7j5QaFJqwVQCEiDSJ4nTOXGKT+Cuyl3
         J4XyDgt4em9+BVZLup9Sg3AvAdNRCGVQ07ytJRzjjY39s3eKlh3pCuwRzGQxu4Ge7Kg5
         YaCmV1eAGK7YrY9iw95RlrINaTQpvJ9vI99p5HQt7GS4pfTx3WmXy3mHB/Q15EPIaiVi
         GkxGqlzxFcX4xvklzByAj+eI7dCnsdvA82JxQ/crXR/m0D1FLlUOICwuBO10U/jJ0AFk
         9/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aRUizR/SQ3aER24HlrQ8e7XvTXAi4MwCK2pl0JDXiP8=;
        b=TCdFQ4FtW3CJJBQESFNRGAP8P/hRNDaAUlWWs81am39bfj/b9mBXXPl+739vmSmL8B
         8qmfVo/lWwEMAheQncX9XkNtKDhGt2Te9lkvrirOtTvHI4B6/Ob6zh030ZSrlB3V+rLc
         iQ5D1+S9TZlt0jFSvwHpKSMPWixz00eo/2+CQwv/lt3zqyYkDfvhsIwChaCuwQ4BoAu+
         uLaIJMWSC9qxETfokj73nEofXzPzpw8WXb5OD2YVGSM9W//uMG4s8SNzf91+P4Yv+kWF
         r8YTEMMDJSm2l8t1jiA1B42OUSYs8yYIwmjRJQhRKQDW8WzYiTlt5RWSnknBhyy2zTzQ
         WVYQ==
X-Gm-Message-State: AOAM532Mw91j0PvpDQPoxcdafjwHC5M2svIS8h/fj2t9ZJLtxPpKusZQ
        U2KcBEE23JVeQ7A/0cbkzF48FE/7UYBVVQ==
X-Google-Smtp-Source: ABdhPJxRlagOU0TteSIxHa68NlISJ71ARnIqqiul2RQQkUSUGJjDWVfK+aGSQ4hr1fLhvK7pEroLpg==
X-Received: by 2002:a05:6602:27ce:: with SMTP id l14mr6063997ios.193.1637337806919;
        Fri, 19 Nov 2021 08:03:26 -0800 (PST)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id t2sm88695iob.1.2021.11.19.08.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:03:26 -0800 (PST)
Date:   Fri, 19 Nov 2021 11:03:25 -0500
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: docs: improve the SPI userspace API documentation
Message-ID: <20211119160325.GA1591448@maple.netwinder.org>
References: <20211118213143.2345041-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211118213143.2345041-1-javierm@redhat.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Javier,

On Thu, Nov 18, 2021 at 10:31:43PM +0100, Javier Martinez Canillas 
wrote:
>This doc is fairly outdated and only uses legacy device instantiation
>terminology. Let us update it and also mention the OF and ACPI device
>tables, to make easier for users to figure out how should be defined.

Thanks for putting this together! Overall it is a definite improvement.

>+NOTE: it used to be supported to define an SPI device using the "spidev"
>+      name.  For example as .modalias = "spidev" or compatible = "spidev".
>+      But this is no longer supported by the Linux kernel and instead a
>+      real SPI device name as listed in one of the tables should be used.

This note is factually correct, but it might be a little too terse for 
folks who are not full-time kernel developers. I'd suggest making it a 
bit more prescriptive. As well, the focus can probably be on the case of 
device tree, since that is the one that generates the warning (and with 
your patch, causes the driver to fail to load).

I've struggled to put it into the right words, so the following is just 
an idea. I've intentionally included the exact wording of the warn/err 
to improve google-ability. As well, it is interesting to do a google 
search for the message, and see what kinds of advice is offered. A few 
that came up for me include:
https://community.nxp.com/t5/i-MX-Processors/spidev-spidev-listed-directly-in-DT/m-p/426381/highlight/true#M64609
https://yurovsky.github.io/2016/10/07/spidev-linux-devices.html

Anyhow, here is a possible addition to the NOTE in your patch.

spidev listed directly in DT is not supported
=============================================

Spidev devices are typically declared in the device tree, see
Documentation/devicetree/bindings/spi/spi-controller.yaml

spi@0 {
	compatible = "vendor,device";
	reg = <0>;
	spi-max-frequency = <10000000>;
}

In the past, it was common to use compatible = "spidev" rather than
a more descriptive and device-specific name. For some time this has
been deprecated, and as of kernel version X.Y it is no longer allowed.

The preferred way to fix this is to use a device-specific name. This
means picking a name, usually in the format "vendor,device". This name 
must then be specified in:
- the device tree for your board (instead of compatible = "spidev")
- the spidev_dt_ids[] table in drivers/spi/spidev.c

Regards,
Ralph
