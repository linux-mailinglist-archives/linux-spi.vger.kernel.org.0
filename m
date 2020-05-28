Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08AB1E70F9
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 01:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437842AbgE1X5m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 19:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437807AbgE1X5j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 19:57:39 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D04C08C5C6;
        Thu, 28 May 2020 16:28:13 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p20so359268iop.11;
        Thu, 28 May 2020 16:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TyiQfJD3hL2bx61mfoIKfduMebYmrhxlynjYDT9d88c=;
        b=fRSTGJBTMBF5GN7OzR7s8m65l6lActjAnbcMSKFaXnAo0WZUdBH99yw6nCi60ahaOj
         KEnNay58BxuIqc5PVm4dsmu47meqO+X+lOvTFl3+3BM4x9oGFLEeapzNSjBTmTd87I9u
         9jd88QNuNHMeajPIofkd0vutDcWjEIdqnthSZ4XegK6xUXLz+Qxb3z1big4T0nAE99SG
         12jWitgrlhwLcErp4YPj4ibuRV+o+sL9jp+Yw3Dq06X1Bpc4L53FoJnk086FvLHhIMzi
         EIATGHwVwgIoRuZi+kVdOrjr9XTcfezxxDvxhzzoCZjNK+wp0swvrO4zGaRovp3rG3fA
         g1Dg==
X-Gm-Message-State: AOAM533GHq/bJoetDC8ZxCq6JoS09QQB75RywIlxMZCRhgJBN7dkXmzW
        L0zEhtDQBasWww6MqGZ0dg==
X-Google-Smtp-Source: ABdhPJzwZW2EhMkkbIXtdNTMdB0TlTz41GM4zNjP0y8P8k5r4zwMXjiSzqqL6GY48s44vD79gjqgtg==
X-Received: by 2002:a5e:970a:: with SMTP id w10mr4276081ioj.114.1590708492723;
        Thu, 28 May 2020 16:28:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b26sm1585795ilg.84.2020.05.28.16.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:28:11 -0700 (PDT)
Received: (nullmailer pid 875402 invoked by uid 1000);
        Thu, 28 May 2020 23:28:10 -0000
Date:   Thu, 28 May 2020 17:28:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ralf Baechle <ralf@linux-mips.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Subject: Re: [PATCH v4 16/16] dt-bindings: spi: Convert DW SPI binding to DT
 schema
Message-ID: <20200528232810.GA875356@bogus>
References: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
 <20200522000806.7381-17-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522000806.7381-17-Sergey.Semin@baikalelectronics.ru>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 22 May 2020 03:08:05 +0300, Serge Semin wrote:
> Modern device tree bindings are supposed to be created as YAML-files
> in accordance with dt-schema. This commit replaces two DW SPI legacy
> bare text bindings with YAML file. As before the bindings file states
> that the corresponding dts node is supposed to be compatible either
> with generic DW APB SSI controller or with Microsemi/Amazon/Renesas/Intel
> vendors-specific controllers, to have registers, interrupts and clocks
> properties. Though in case of Microsemi version of the controller
> there must be two registers resources specified. Properties like
> clock-names, reg-io-width, cs-gpio, num-cs, DMA and slave device
> sub-nodes are optional.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-mips@vger.kernel.org
> ---
>  .../bindings/spi/snps,dw-apb-ssi.txt          |  44 ------
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 127 ++++++++++++++++++
>  .../devicetree/bindings/spi/spi-dw.txt        |  24 ----
>  3 files changed, 127 insertions(+), 68 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
