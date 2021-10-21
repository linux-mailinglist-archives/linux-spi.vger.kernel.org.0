Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA781435EE5
	for <lists+linux-spi@lfdr.de>; Thu, 21 Oct 2021 12:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJUKVn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Oct 2021 06:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJUKVn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Oct 2021 06:21:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50929C06161C
        for <linux-spi@vger.kernel.org>; Thu, 21 Oct 2021 03:19:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r7so191151wrc.10
        for <linux-spi@vger.kernel.org>; Thu, 21 Oct 2021 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HcuIt7/7PaI53mxMN1zYIYC7d3hS/MtLZOfEoIwhomI=;
        b=cL/9bzy7HR6WRfHYo7K1Fxw4FWYZhPptGiCRn9fQERQ4E0r+/+p0LuezBf2VkADPUY
         3dmBZhv6nJBirFy27vmSGfZWq6xfmWBKK4ZyQrJZqrm1zloSDLB3iUZhs1n0p4jyWKq9
         4nEr2tvsPKi+eixU1hq0h8c+qjCVdpH7eC7ib0AsGB3fXtmeYAXWAP5g9hY34IU20SWc
         js/q31V29Z/dWp+IA8snrIALGSidN/oOX/umonuc2KHsKRiHJvciAjDhrvKL6nBEivKY
         gFQn0IyFdqSfgdyb7nFl9luDb/XKh91MiGnvdgkG8hVkggSZRH9X3KsiwTe6hsPlLt4e
         DIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HcuIt7/7PaI53mxMN1zYIYC7d3hS/MtLZOfEoIwhomI=;
        b=sZOUVkTG9dKJ7dvnR4i5w44lMPm4/A8YRbAb6yrw4oLS2TMfo7WB0ySyo9CvUfMDpp
         /+uODO3TKNjpZO72DZMwLYT3AZwC47hz50eiPnibsq4YBeqxVzmco0y6qn+7Ovc8MXJs
         B9nQPxxvIPEXz+k0PymuKb0QEGak6Cxm/AWvOYpycS5x3vkg4b/tYbOvisr51grlvHRD
         WBd/ATR41/GdQHUb8rnuCRzoYGb2gs9N4fpi8ChimlychtQ96LNVKWVEyuZYse33Fsqe
         vDx9UYjg1WorDCZRpoo0QOvE8wr+r53h6kNhn06s1JTaWobN0ql3hz/7xg4VspQSynM8
         N5dg==
X-Gm-Message-State: AOAM531JMBzV7nhBUqe9n2seYKsrs33O7sZoUjyvs7ju/153eQr1m/K1
        WFx/jHBOoGrz3BOCSSaxQrW9v5EUq8bkHw==
X-Google-Smtp-Source: ABdhPJzwV4llaBHW3GPEKFOSStvceavjRaL8orYDfMptOnOkOdVq+p2+QBVgeWrzCKaDMSgV+ExHjg==
X-Received: by 2002:adf:ab46:: with SMTP id r6mr6189970wrc.71.1634811565959;
        Thu, 21 Oct 2021 03:19:25 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id m8sm4414195wri.33.2021.10.21.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:19:25 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:19:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 09/20] mfd: stmpe: Make stmpe_remove() return void
Message-ID: <YXE+qx6hZ4T9B+QP@google.com>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-10-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012153945.2651412-10-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 12 Oct 2021, Uwe Kleine-König wrote:

> Up to now stmpe_remove() returns zero unconditionally. Make it return
> void instead which makes it easier to see in the callers that there is
> no error to handle.
> 
> Also the return value of i2c and spi remove callbacks is ignored anyway.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/stmpe-i2c.c | 4 +++-
>  drivers/mfd/stmpe-spi.c | 4 +++-
>  drivers/mfd/stmpe.c     | 4 +---
>  drivers/mfd/stmpe.h     | 2 +-
>  4 files changed, 8 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
