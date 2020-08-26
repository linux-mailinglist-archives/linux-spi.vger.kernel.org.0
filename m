Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF21253851
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 21:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHZTeX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 15:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHZTeW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 15:34:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102CCC061574;
        Wed, 26 Aug 2020 12:34:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m34so1585666pgl.11;
        Wed, 26 Aug 2020 12:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TldKm6UYrDqQCB8UevAGIccUxXWB4Kosvte/jze7YQU=;
        b=kLSOwOQwTvHZVDY6z2gnIIs2Mx5UlcXYJW4rd0W/h7CldAnnQJoRXjdI6g8EnhgTUT
         7HpokCM1WdWTAX85W7tWBJoV8b3JY4wki1YZmYNbzGTtnPK/kL2dSP6xwx0PuxA/5Tpd
         4SNVnsJLHX+2BvIgdcFQIaTsJvPRVAmLtFUeNIwYjmkpVIFxfBq6SiOnepU0/WwwfWJH
         T5tiFVj6TFI9Ev8QH/YQFLy7QFHwslP1kZVGXG82aYinvEfHXZyCgv0gEtrtfpU4c3eG
         6svBClrltN/JIU/duo2wJDcr8rVA4xx/mChjloBBvzLAEi0txKut8BmOydqUoNVQk0Ke
         HfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TldKm6UYrDqQCB8UevAGIccUxXWB4Kosvte/jze7YQU=;
        b=B6XqqgWedtd2jaywKJlW6FwXvWBEDJm1B8umBVpDvPMXrjwt2ygSustXenCzBjlVfW
         zg5aleGz+Oo2HmJYmhFg62S5SnOpS3wYu1B91zNBcuXHwww+d+O884k/zD6gqkaiAQFU
         BioXLkV0dE327zZDaNv2XEE1eHgbbE5LToh8NvYg5w4xk5NBwvheRl3iiBisia2Lns1v
         EHCNBtOLsIDyoH6LnmbnYXnhf9Xi3kXDcVnnkQlcx7ZzNdoqMf7pQKDOC4j9g6llSRYF
         IfW0klk6Y8P7FEOr+tGoGxuqjmElZQIxDZtcicZzgeCxbldCKtIFBZ2M/S1rZtEQGMjc
         /jkg==
X-Gm-Message-State: AOAM5317lKF4TTEXXWWAUoMitKhts48oN+zNyEbxL6pDbdMim6011o28
        yW1OJKV4EGPLE+FqXo5JQC121Sh4gEym8Uy8T4Q=
X-Google-Smtp-Source: ABdhPJxU5LveNLI3N+AP3CiHJqnh/ejkN1V0tbzNHVbFjNlLP1SQr1TkF1bumcE9knyZOIH371onyWTP682ulHVzwUQ=
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr1690183pln.65.1598470461445;
 Wed, 26 Aug 2020 12:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com> <20200822183342.6sdhp6yq6i7yvdia@skbuf>
In-Reply-To: <20200822183342.6sdhp6yq6i7yvdia@skbuf>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Aug 2020 22:34:04 +0300
Message-ID: <CAHp75VeNXy1jWNWMuZc0bfXruKc3=0H4ezwpE8jbj6GLYk5QBA@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        tanveer <tanveer.alam@puresoftware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Aug 22, 2020 at 9:37 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> On Fri, Aug 21, 2020 at 06:40:29PM +0530, kuldip dwivedi wrote:

> Just noticed this now.
> So for device tree, spi-fsl-dspi supports the following compatibles:
>
> fsl,vf610-dspi
> fsl,ls1021a-v1.0-dspi
> fsl,ls1012a-dspi
> fsl,ls1028a-dspi
> fsl,ls1043a-dspi
> fsl,ls1046a-dspi
> fsl,ls2080a-dspi
> fsl,ls2085a-dspi
> fsl,lx2160a-dspi
>
> Depending on the compatible string, the driver knows whether to use DMA
> or XSPI mode, and what the FIFO size is.
>
> Now, of course not all of the above SoCs are going to support ACPI, but
> it is reasonable to expect that more than one will. And in that case,
> the driver should still be able to know on what SoC it's running,
> because for example LS1043A doesn't support DMA, and LS2085A doesn't
> support XSPI.
>
> How is this dealt with in ACPI?

Theoretically you may declare your HID in the same / similar way as
PRP0001 and use same compatible strings and all other DT properties
(when they make sense and not duplicate ACPI functionality).
But better if ACPI people can tell you (I Cc'ed Rafael and ACPI
mailing list) if it is gonna work.

-- 
With Best Regards,
Andy Shevchenko
