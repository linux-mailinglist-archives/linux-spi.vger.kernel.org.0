Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A7227D40B
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 18:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgI2Q67 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 12:58:59 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:35548 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgI2Q67 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Sep 2020 12:58:59 -0400
Received: by mail-oo1-f66.google.com with SMTP id k13so1452588oor.2;
        Tue, 29 Sep 2020 09:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qL1+dUVZc7/FRZNXOFrFvDJ142erdjwjd9zJZIOHq50=;
        b=kVMspgCJdV6RJBQBFVLKSqwnDd4ow6UmUS88IQSmj/T6JEm535U0ufv7U8De03EBQk
         zBeevLojvW//waNuIG/0wYfHtWKJK0DTjdQ0H+WevT7vrWAyXYispXNciyDzhacbNoXP
         DjtW3qb9a6tHKOJdbJZWfILprZZ2LPPeKM8mHKsxS2n+qyKPS3t0U+vsDd/PgItJ76Pm
         KSDVbH+zarkHD0IlYTRWFVdw+y5NwMSfhK8OyETrQxQtSSq52CcBIYEJqS/o27y4USAV
         /dDCLOeNTOLnAAjMcrp5b4ilkIehKTI1AJitJMjRUtHIokO3Alsk2tBIUo1NMytqXFXW
         Spwg==
X-Gm-Message-State: AOAM531t/y5fXBFcYyiFDua+PAc8SpxGrWkc5X9jzJZO1YGKAWKySnQu
        aZlI3bN7tXHbecrEAvFgBg==
X-Google-Smtp-Source: ABdhPJz+hm6g2H8hVGsLti0LBkjY2MyJFyjhR0LdDpUD3Zw8SCc4VQurzB6MLyErzsdi2oDudi+X4A==
X-Received: by 2002:a4a:d80a:: with SMTP id f10mr5379686oov.76.1601398738179;
        Tue, 29 Sep 2020 09:58:58 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j16sm1118642ota.1.2020.09.29.09.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 09:58:57 -0700 (PDT)
Received: (nullmailer pid 772313 invoked by uid 1000);
        Tue, 29 Sep 2020 16:58:56 -0000
Date:   Tue, 29 Sep 2020 11:58:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        devicetree@vger.kernel.org,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 29/30] dt-bindings: spi: dw: Add Baikal-T1 SPI Controllers
Message-ID: <20200929165856.GA772254@bogus>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-30-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920112914.26501-30-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 20 Sep 2020 14:29:13 +0300, Serge Semin wrote:
> These controllers are based on the DW APB SSI IP-core and embedded into
> the SoC, so two of them are equipped with IRQ, DMA, 64 words FIFOs and 4
> native CS, while another one as being utilized by the Baikal-T1 System
> Boot Controller has got a very limited resources: no IRQ, no DMA, only a
> single native chip-select and just 8 bytes Tx/Rx FIFOs available. That's
> why we have to mark the IRQ to be optional for the later interface.
> 
> The SPI controller embedded into the Baikal-T1 System Boot Controller can
> be also used to directly access an external SPI flash by means of a
> dedicated FSM. The corresponding MMIO region availability is switchable by
> the embedded multiplexor, which phandle can be specified in the dts node.
> 
> * We added a new example to test out the non-standard Baikal-T1 System
> Boot SPI Controller DT binding.
> 
> Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 33 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
