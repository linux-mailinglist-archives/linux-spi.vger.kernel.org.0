Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45AA36C57D
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhD0LrC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhD0LrB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Apr 2021 07:47:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1682C061574;
        Tue, 27 Apr 2021 04:46:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e15so4386989pfv.10;
        Tue, 27 Apr 2021 04:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMMjjV+PTIV4vm6/IEmRAWhSVzJiCXiZU3/huO/x0nI=;
        b=ZJ5BlTICDUmG7DguAEd0jOWxjwIIhOaHp4R6eP8WhcGhNHC51J05uSg8I6KYz03BN7
         Gjdaf+CiMhQyG6HVJLl+RLDlLuxIyFICDTrM2iBH78c57SiT4P/QFvk4NhlTMWy0zsrz
         YZCmbyMFpX9+/2dUK3valgqZBYVthS6aZBo9554CiRGCJ93prSUyJSVjSbJq3pg/Kts7
         ZwIvwzkOgnEHhx+38D5EslxeSIcZNyFn/4If/iTP/5JwzQ6HQxGV1NL7yO9utIdh9fwP
         OIRyaTMRRni21LQU12CZ8qc3FLxRIDbNEbCf7SRpr2TRSPXm7b1fmptX1R4tYhEdtzTm
         Rkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMMjjV+PTIV4vm6/IEmRAWhSVzJiCXiZU3/huO/x0nI=;
        b=t48Bke7wBSXBXf059TFLxzyN2cGWPLsyv+6zzXWze3bQcDXSbsXmp4ZiojOvdRG+Is
         2xFaQkU2ZdW1hxGhKGJ+xLD5Q+Ml7vAzmRqCdivOqAdHi8nngfydDG451Vxqk9yjEkWB
         D8fOprzZIskJa2VPxdDnBnGyS9Q1p7bqN3zZ9wkM6tMoQ2Pq72W2QEuq4cGjxuL2tyqb
         EqlhSRHcATFckB25ZkII565MU9uCAT05hTNcGxVgn8k9yKVHz19o+5Xh6gA73EJ8XKb1
         PQY+CKWbm8uPnBXANLudPfrUB+sYDQpyqVLSjWopT8Pf7VIUXfmpYlYaMpk933YMQiyH
         crUw==
X-Gm-Message-State: AOAM531MzrHEVSyWnqz5kJuZpM2gJlSAYk9pdcbfQhZ6aUy1n6EZ5vih
        /CP89cjwbu5Xrdd+wJdOsZpf4v3MXBORunGPSdQ=
X-Google-Smtp-Source: ABdhPJyGaaSUm4K/1Z1ekcXcdw6ghOy8irdARQN0sjPb9GGewDmareqf3Qe4B4ZpG2WE8B1kUCUoVXdCRvOb+eKZlf4=
X-Received: by 2002:a62:e50f:0:b029:214:8e4a:ae46 with SMTP id
 n15-20020a62e50f0000b02902148e4aae46mr22977757pff.73.1619523978223; Tue, 27
 Apr 2021 04:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Apr 2021 14:46:02 +0300
Message-ID: <CAHp75VeiHsk15QoG3X-OV8V8jqzCNeKkif9V=cx4nvKVHaKbKA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Apr 23, 2021 at 9:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Set of cleanups here and there related to the SPI PXA2xx driver.
> On top of them, adding the special type for Intel Merrifield.

Mark, are you accepting patches for v5.14 now, or should I resend
after v5.13-rc1 is out?

(I have few more in my queue :-)

> In v2:
> - cover letter (Mark)
> - drop moving the header in patch 5 (Mark)
>
> Andy Shevchenko (14):
>   spi: pxa2xx: Use one point of return when ->probe() fails
>   spi: pxa2xx: Utilize MMIO and physical base from struct ssp_device
>   spi: pxa2xx: Utilize struct device from struct ssp_device
>   spi: pxa2xx: Replace header inclusions by forward declarations
>   spi: pxa2xx: Unify ifdeffery used in the headers
>   spi: pxa2xx: Group Intel Quark specific definitions
>   spi: pxa2xx: Introduce int_stop_and_reset() helper
>   spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
>   spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
>   spi: pxa2xx: Extract pxa2xx_spi_update() helper
>   spi: pxa2xx: Extract clear_SSCR1_bits() helper
>   spi: pxa2xx: Extract read_SSSR_bits() helper
>   spi: pxa2xx: Constify struct driver_data parameter
>   spi: pxa2xx: Introduce special type for Merrifield SPIs
>
>  drivers/spi/spi-pxa2xx-dma.c   |  37 +++----
>  drivers/spi/spi-pxa2xx-pci.c   |   4 +-
>  drivers/spi/spi-pxa2xx.c       | 190 +++++++++++++++++----------------
>  drivers/spi/spi-pxa2xx.h       |  52 ++++-----
>  include/linux/pxa2xx_ssp.h     |  42 +++++++-
>  include/linux/spi/pxa2xx_spi.h |   9 +-
>  sound/soc/pxa/pxa-ssp.c        |  16 ---
>  7 files changed, 185 insertions(+), 165 deletions(-)
>
> --
> 2.30.2
>


-- 
With Best Regards,
Andy Shevchenko
