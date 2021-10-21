Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D41435FCE
	for <lists+linux-spi@lfdr.de>; Thu, 21 Oct 2021 12:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJUK7e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Oct 2021 06:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhJUK7d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Oct 2021 06:59:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E826FC06161C
        for <linux-spi@vger.kernel.org>; Thu, 21 Oct 2021 03:57:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d198-20020a1c1dcf000000b00322f53b9b89so387467wmd.0
        for <linux-spi@vger.kernel.org>; Thu, 21 Oct 2021 03:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2q8epunI2YJhS7Y5OvXRSfgnjSjIlOxQhWm8Zime4ZA=;
        b=wzK981VLSe8rOftFqyi7FSQznuKzeJC7z9un27zFAQKuoZaLfKG+i6biCvyisY7FSn
         zP8ZeN28SeeIlOCbB5YLgUvfTp0AdPc3HHatbOdQWH+iPb3dZcdvHe8u5phYwiBwUYvX
         yuVhM3qbhR11RJQzT75URYmoIeBXBfZCApiliAPma5gmh0gfMmZJtwGuQvat131RkNSF
         fKnE1gqepZtoaGLI4oh21Oaf+Rx+oI902OfGpeZD1Yi4xfMAeILgyRjHJ6A8CGSL1d8n
         PSv0ZGM/CctnF5vQP97w039WJ+upPbg3VIzC+kS/RWWA0bPmUdwuNJFLrUEqQI2TInzP
         2urA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2q8epunI2YJhS7Y5OvXRSfgnjSjIlOxQhWm8Zime4ZA=;
        b=KoB4QQQJWmgdbAD6MQ7WjlO+kDQUnX5pWyA3LbcjJ88t9Xb15dB8ycuZ/mfqsqkJi1
         Mj1X0eGmB1IjjWD+GmWuiP2/PCckgmIEv+PmlIb2bXiLZ/V76BvdY7y7tukFZsaEnXNK
         1aG1wd7VOtCaXd7sN8auhbGu3Pv6RhP5rPJP5coUeOfRphLVWqJnW8D25rfVNYiAzToj
         giYxgLszebyruM+xHiVek1XPs9OO0wP867K+T6Kiq8NNiUbFh8gOeOVv9TgAZG+IKS2Y
         MyZuID1OAfmJyMcucyIzzH1ZxdHFEckSCBPwFNyD+Lo/PGxHfNsxMpb9JbtBSzxXBMol
         JHKg==
X-Gm-Message-State: AOAM5305Urb/iWqy1tWFINWc7EKwIuKvJv1NQeiEkihX9lz0lXKG7wrn
        EjF6WmzJZZBnCfhwGVQzAswelA==
X-Google-Smtp-Source: ABdhPJwq6IzyGk5NqRL6jkJfSRsLMIAxvgYpLGUX6cV1w4RGXuY5ZSGXnYWzepTgkl78EuNFZdHfkA==
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr5795779wmc.128.1634813836516;
        Thu, 21 Oct 2021 03:57:16 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id l40sm4871132wms.31.2021.10.21.03.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:57:16 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:57:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <YXFHimJ75Bpg5sSP@google.com>
References: <20211007112132.30934-1-mika.westerberg@linux.intel.com>
 <20211007112132.30934-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211007112132.30934-3-mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 07 Oct 2021, Mika Westerberg wrote:

> The preferred way to implement SPI-NOR controller drivers is through SPI
> subsubsystem utilizing the SPI MEM core functions. This converts the
> Intel SPI flash controller driver over the SPI MEM by moving the driver
> from SPI-NOR subsystem to SPI subsystem and in one go make it use the
> SPI MEM functions. The driver name will be changed from intel-spi to
> spi-intel to match the convention used in the SPI subsystem.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/mtd/spi-nor/controllers/Kconfig       |  36 ---
>  drivers/mtd/spi-nor/controllers/Makefile      |   3 -
>  drivers/mtd/spi-nor/controllers/intel-spi.h   |  21 --
>  drivers/spi/Kconfig                           |  39 +++
>  drivers/spi/Makefile                          |   3 +
>  .../intel-spi-pci.c => spi/spi-intel-pci.c}   |  20 +-
>  .../spi-intel-platform.c}                     |  21 +-
>  .../intel-spi.c => spi/spi-intel.c}           | 304 +++++++++++-------
>  drivers/spi/spi-intel.h                       |  19 ++
>  include/linux/mfd/lpc_ich.h                   |   2 +-
>  .../x86/{intel-spi.h => spi-intel.h}          |   6 +-
>  11 files changed, 254 insertions(+), 220 deletions(-)
>  delete mode 100644 drivers/mtd/spi-nor/controllers/intel-spi.h
>  rename drivers/{mtd/spi-nor/controllers/intel-spi-pci.c => spi/spi-intel-pci.c} (86%)
>  rename drivers/{mtd/spi-nor/controllers/intel-spi-platform.c => spi/spi-intel-platform.c} (65%)
>  rename drivers/{mtd/spi-nor/controllers/intel-spi.c => spi/spi-intel.c} (80%)
>  create mode 100644 drivers/spi/spi-intel.h
>  rename include/linux/platform_data/x86/{intel-spi.h => spi-intel.h} (89%)

For the MFD parts:                                                
                                                                  
 Acked-by: Lee Jones <lee.jones@linaro.org>                       
                                                                  
Whoever ends up taking this needs to send out a pull-request to an
immutable branch please.                                          

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
