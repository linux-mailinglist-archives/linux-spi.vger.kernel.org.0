Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066D237A6A0
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 14:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhEKM3n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 08:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhEKM3m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 May 2021 08:29:42 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91321C061574;
        Tue, 11 May 2021 05:28:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v13so10732296ple.9;
        Tue, 11 May 2021 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKD/eHrXVQc862e3xW+RKYQk7t6rr2oE2k183wwBGWE=;
        b=no6PvmCZNOHK7T8MzNOftaTg3KRqY9xkrlt3cT1/tzJ4GMn5/UPlIfoIvhjAD8g1Q5
         ZCZKIXHFpfMNrWDb+6tpAg9BrxEv/sESyu/pbUKclgXqTCY4DM2y3RDBSEIzZ935oWhB
         6ASRnQAruT+Kewh8VGXjahPRGMr7L0pKwoTOd9SOSuAoOM5opREM1miUcpU9+iZANPqb
         KxMQalLnboi0MnuQLq25iPdd/Hspi4E+uIeYOfAir+33rIFhl4xB6uSXsfztAP6NZukT
         3P5sRZUiyUJajqKA4zY9tLsgEQejuDV4O9OaNUOHgYhdECQEkij92VRK17ibR+GuIACe
         UVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKD/eHrXVQc862e3xW+RKYQk7t6rr2oE2k183wwBGWE=;
        b=WxfihxCySQZb+3HLqlbyIbeLfq4RknpivJT7EzlqJ8MvbGRvv6hcS+cCjgaUHbflms
         VAhHRCZcXcxkbdFrWidQwrN/ls2ssC9cr8YgntULGerdx/8f/YmExW0MqHdZLpTWAaV5
         PasdG3Pga2Srlrg3MW9V6rqjbPDn5JSh0yi29X3xWRTN/fRtGLm3UdFN4LwQyCDo6BW3
         E9jk8CmznGrDCOHHUEC0lcOizeXRyvSAJow+mFd/qrZfrgxFVKZ0/w/63OvX78u3borw
         ugX6LdIAulXo8wfW/PNTdTKioDDxhBse0OeVBQ5oIHrxQ+l4goKZP1oce1ttStARwhzL
         hkdQ==
X-Gm-Message-State: AOAM5319URBs7e8tE814YAWT5M/83Rn3BwBDRGFUxC5pc07kX88hetXY
        SdyIPAz/ANIU6RBX7Un4TySl0kXd5vbc+Sgwx8I=
X-Google-Smtp-Source: ABdhPJzGDCPmEuN7Q7ctqKms6Zsa/sPn/lHUOehvHz/mqJ5cO2zN4n12zeOaR0SXr/9znZeBDLDx65xxnk/wTnprqkM=
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id
 91-20020a1709020264b02900eb3d3aa09cmr29235247plc.0.1620736114987; Tue, 11 May
 2021 05:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com> <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
In-Reply-To: <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 May 2021 15:28:18 +0300
Message-ID: <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 11, 2021 at 11:27 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, 23 Apr 2021 21:24:27 +0300, Andy Shevchenko wrote:
> > Set of cleanups here and there related to the SPI PXA2xx driver.
> > On top of them, adding the special type for Intel Merrifield.


> [07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
>         (no commit info)
> [08/14] spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
>         (no commit info)
> [09/14] spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
>         (no commit info)
> [10/14] spi: pxa2xx: Extract pxa2xx_spi_update() helper
>         (no commit info)
> [11/14] spi: pxa2xx: Extract clear_SSCR1_bits() helper
>         (no commit info)
> [12/14] spi: pxa2xx: Extract read_SSSR_bits() helper
>         (no commit info)
> [13/14] spi: pxa2xx: Constify struct driver_data parameter
>         (no commit info)
> [14/14] spi: pxa2xx: Introduce special type for Merrifield SPIs
>         (no commit info)

The above patches are effectively missed.
Anything to fix in your scripts / my patches?

The below does not shed a light.

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

-- 
With Best Regards,
Andy Shevchenko
