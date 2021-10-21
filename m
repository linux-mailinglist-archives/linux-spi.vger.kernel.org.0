Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67964435FC9
	for <lists+linux-spi@lfdr.de>; Thu, 21 Oct 2021 12:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJUK7N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Oct 2021 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJUK7N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Oct 2021 06:59:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91991C06161C
        for <linux-spi@vger.kernel.org>; Thu, 21 Oct 2021 03:56:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y22-20020a1c7d16000000b003231ea3d705so2730146wmc.4
        for <linux-spi@vger.kernel.org>; Thu, 21 Oct 2021 03:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=39afoYGUkYPdTo99bikNZ1ltN9VTjEDU2ENwyEnc/5Y=;
        b=ULyLaKQTcMO3bWLg15IZyPvQwZijHgvO4Rj+TL3TnNp+8VtdilSuXC1D3L9TM0QvMq
         nnDGxvgMKiZWvpXi9zuV8HZ1erpPoaR8vyNaI62WjIQkX4soEQMrAslzjxr6T9+XVX1a
         a4BBJNMNGK6JaxNAaVx7rwRig/G2qN6kg9bZoBYFA+YVF1gNBx9nQvtSEY6BF26b/7HQ
         IflbR3UaO8SmOT3Lc9WNeiHUwGejgTQrtOMuLX82mqBL2vyLb3brPQtNRtkmX2X2OzOI
         CTo5v1XPQiwouOSmVFhV3mE74Uv0pfcafJXWVAZZ+BP0q7zOAk3wjKH+cF4EGlgxKNtz
         m5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=39afoYGUkYPdTo99bikNZ1ltN9VTjEDU2ENwyEnc/5Y=;
        b=PUIjfWxg8lKJJM76tUnmVYJI0PutMta1F78O1y+rMxn7aMyhLaVi+CXH4KHF8EFybq
         2NRMeAoRCdJsVhYCepiAwwOApF6OSSeXWFJuoWKeifMGRBj8hNQtzWay20dFKTI0RYDu
         /n17LAD8n5o8PLj1qBChzSHuVOpwmLXI91lKnnJ/b2iTeChswaTIWRl7Ofyrrcpcfk9b
         VN4wIqpwdV/MFBvrznUvKTnd7ZIachSnKF5kgicX/4NvFzHDZSRgCe1mcHGFnCnm3nO7
         4DtAkrL6EhD+oTA0mPildoFaeP7mbNRfonWsCOjq71ERxA3bfhp03z+Wt3iEy4G/x3aI
         oAIQ==
X-Gm-Message-State: AOAM532MCKQsS73XD/maLRtdfm/lkxaLQ6fXNJAxpJLex3LVJnj+c4s2
        vsXR5bUL4pdH2jWbVL1Rs+Cokw==
X-Google-Smtp-Source: ABdhPJzwYAtbGrx2TS7FcUijvbw0vcgFSZMTwkU2IG6ZYWcxgIPJyHBFL+RaxBRuqeFFKDFw6s628Q==
X-Received: by 2002:a05:600c:1d1f:: with SMTP id l31mr20128477wms.44.1634813816174;
        Thu, 21 Oct 2021 03:56:56 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id o6sm7708225wms.3.2021.10.21.03.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:56:55 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:56:53 +0100
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
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: intel-spi: Disable write protection
 only if asked
Message-ID: <YXFHdXE91+PjSDv2@google.com>
References: <20211007112132.30934-1-mika.westerberg@linux.intel.com>
 <20211007112132.30934-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211007112132.30934-2-mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 07 Oct 2021, Mika Westerberg wrote:

> Currently the driver tries to disable the BIOS write protection
> automatically even if this is not what the user wants. For this reason
> modify the driver so that by default it does not touch the write
> protection. Only if specifically asked by the user (setting writeable=1
> command line parameter) the driver tries to disable the BIOS write
> protection.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/mfd/lpc_ich.c                         | 59 +++++++++++++++++--
>  .../mtd/spi-nor/controllers/intel-spi-pci.c   | 29 +++++----
>  drivers/mtd/spi-nor/controllers/intel-spi.c   | 41 ++++++-------
>  include/linux/platform_data/x86/intel-spi.h   |  6 +-
>  4 files changed, 96 insertions(+), 39 deletions(-)

For the MFD parts:

 Acked-by: Lee Jones <lee.jones@linaro.org>

Whoever ends up taking this needs to send out a pull-request to an
immutable branch please.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
