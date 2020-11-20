Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4021B2BB162
	for <lists+linux-spi@lfdr.de>; Fri, 20 Nov 2020 18:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgKTR01 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Nov 2020 12:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgKTR00 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Nov 2020 12:26:26 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B01AC0613CF;
        Fri, 20 Nov 2020 09:26:25 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so14559544lfh.2;
        Fri, 20 Nov 2020 09:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0FNuqTxZiVdZvCKIaMhFHO5hsVuZlt9HijAik4opiSY=;
        b=laXKPYPbodGHDivuoXyCh8HOY5sk4x7GNEDP6hvX/E61HvK4vqG+QsieO+bKCWNCuJ
         xg67leHCo8tjSP4DxH6NlZCGxyvCIUQbS0FX3c/5flXvoIxI7gmhUsKb/kUJsir9VOpU
         BV71Y9LMtNp5nxYl4ueu6BWBEwSgmFRljlT2DtHcFqfRi1lN4FiZVHbWxsKk3Q89VkTK
         GoDAovNt44AGs9zrPkhUBZDVmh0ci5UnPl6Q42asX0ssp5fjHNtO6D/f7QsxZBusqp/3
         978TwshA7up3A0DRM/Y7Je+jW21TakN96Ra52f7QY548TUTmRYLqz4F3j1Y850+gPep8
         yu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0FNuqTxZiVdZvCKIaMhFHO5hsVuZlt9HijAik4opiSY=;
        b=Z5+Wn7nwqb+qPaNWN0oxoeH/66YUWUirmEbHd/E6sQKI9Dd/kQWZQ+kWff3e1bBLuw
         f66RaVlefH+0dm+8xg5z0fIUnfX1QZdfy6xRdj52pgKx+GHJ6/cpVrm4WozD379O2HJq
         Q0LkbVp8oVmr2n6oH/5LjQKO2qfMAgfqoKb2BJIi7z1Q+F8EYWsXiHY1supA1XviPB5n
         5uWRkPDrCr0bXMDKIllAVnuoWpxZw5Amt9aKimKOJRIAYoTQNeb+EJoR6q8DIPWbwtXP
         +7U+SU6W5udlezUU6/yovfrDKz1NTkQgkV4fkJpT0p1ZGWSOJQiOym1Lae1XYB7e067m
         GqJQ==
X-Gm-Message-State: AOAM533Y5taZCawclBMhTzbvoC7fvfMcuasc9MQwzZplb3AlQOX0ccMB
        6AFMF2Ejd/iXkrXHSmFkjJc=
X-Google-Smtp-Source: ABdhPJxpqlBClq7RATwlPnXZjOlb9Z29noXJLEYKPisI7LBG5K4FKkX755etrr2qeqyD/dKYr8PDMQ==
X-Received: by 2002:a19:87d6:: with SMTP id j205mr7841124lfd.601.1605893183898;
        Fri, 20 Nov 2020 09:26:23 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id a26sm340748ljn.137.2020.11.20.09.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 09:26:23 -0800 (PST)
Date:   Fri, 20 Nov 2020 20:26:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] spi: Take the SPI IO-mutex in the spi_setup() method
Message-ID: <20201120172621.ixemrwjkyef7tcfj@mobilestation>
References: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
 <20201120171629.GH6751@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120171629.GH6751@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 20, 2020 at 05:17:48PM +0000, Mark Brown wrote:
> On Tue, Nov 17, 2020 at 12:45:17PM +0300, Serge Semin wrote:
> 
> > Of course I could have provided a fix affecting the DW APB SSI driver
> > only, for instance, by creating a mutual exclusive access to the set_cs
> > callback and setting/clearing only the bit responsible for the
> > corresponding chip-select. But after a short research I've discovered that
> 

> I think the driver needs a fix anyway for the case where there's a mix
> of devices with standard and inverted chip selects, it assumes they all
> have the same polarity AFAICT.

No. The polarity inversion isn't supported by the DW APB SSI
controller. Native chip-select is always active-low, while a
corresponding peripheral is activated by setting a bit in the SER
register (Slave Enable Register). So as long as the dw_spi_set_cs()
callback isn't called while there is a SPI-message execution going on
it shall be save do preserve the current version of the method.

-Sergey
