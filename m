Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EF837B442
	for <lists+linux-spi@lfdr.de>; Wed, 12 May 2021 04:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhELCs5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 22:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhELCs4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 May 2021 22:48:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E117C06175F;
        Tue, 11 May 2021 19:37:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z17so2952903wrq.7;
        Tue, 11 May 2021 19:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ovlhWp09w0d8k/xEPNYMS8w0FWb3azKCCtg/eZhLEo4=;
        b=jsAs/ghvjrW08O9h3c91MwKegIoAIyxtpwO4pXOwhWOZ5q+itFws+eNJph5rLEkejx
         kgq8ln2y8G7yLaoO21c7rvGxjLUCAfF54dT6vh4wNpaP8FMxwQooHssg7JHuoPoFHySs
         GEvAhQdMiroosUPHAXxPsd/ZUDkHVSadGDxTAOGcWPVlKVTCX6hcWWj5o91huHomOhcs
         ggGjd6s0Y+zzDjMeB5hQX74LvMavgMS3rzBFdMmPrFzhj8dcq7qsZsaThQ/PIQkaupQW
         He9hIQBf0IHOvW61XILETT3KX1nGJiuu+tAHGKuKFn5noXVvnxPM/ZqiINrUlAJMDti6
         FtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovlhWp09w0d8k/xEPNYMS8w0FWb3azKCCtg/eZhLEo4=;
        b=YU96e9bkIvK81K4yYQUr7mZItWEU/M5UXdQ83rBQ+TKl2D+AhhvIn794Vxpba4G+3a
         x+SEdvbQfe89lg5VIvGbQPkmrHuOcXqfcfpfQ9g/q8xZiwWPqE4hs9KeNHN4SMRoHF/u
         u5p/YE9NdyTRR2t7iLs2m49zmgXKvaEyvxnFDCGjDqUN4G8QwjJk/mjus1qvWcmXXWf/
         oxjE1iForRJ+1FfSzi4RsAZGjBqh2X3SdcMYeuS0QJ5FIJpmKK+JEkADvU0jj0riTQjK
         OVhQhh4GM2PXGUm2J/lYHEVQivkpmkHYmEF5Z7oKrZzZurdTTTOZx6deBvRPkWVWNvX2
         IQ8w==
X-Gm-Message-State: AOAM5303hbHvscqjNk13txsNECT18XBXOh1R7swN6MDUmmK8dGYq94eo
        FvdC7fkpsXHHK/Hfz4B5Pu10T+7vQfx039+Ndo1F+1L6c4w=
X-Google-Smtp-Source: ABdhPJx5MIATq3apNO+s8IoAIC1UpehnB2960d0cmDlWcAGkJ0yTBX2JMZrR6J3zSTB6K4A9gUeA0rBLA70j8dxmp3c=
X-Received: by 2002:adf:d215:: with SMTP id j21mr42747152wrh.251.1620787033000;
 Tue, 11 May 2021 19:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210511140912.30757-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210511140912.30757-1-andriy.shevchenko@linux.intel.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 11 May 2021 22:37:02 -0400
Message-ID: <CAGngYiUusLPsMXFY-vYdLXL5cXn2CgewFdQjRiTAMCGhOrxLmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] spi: Assume GPIO CS active high in ACPI case
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Xin Hao <xhao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 11, 2021 at 10:08 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Currently GPIO CS handling, when descriptors are in use, doesn't
> take into consideration that in ACPI case the default polarity
> is Active High and can't be altered. Instead we have to use the
> per-chip definition provided by SPISerialBus() resource.

I don't have access to the hardware to test this right now, but the
patch is small enough to determine that the OF case will stay the
same.
LGTM.
