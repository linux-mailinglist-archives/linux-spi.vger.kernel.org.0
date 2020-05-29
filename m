Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F152B1E89F0
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 23:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgE2VWa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 17:22:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42631 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgE2VW3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 17:22:29 -0400
Received: by mail-io1-f68.google.com with SMTP id d5so860279ios.9;
        Fri, 29 May 2020 14:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qZYvDr2j6Dv3sRGAtruzxneua5DcH3zuqmue20TSj2E=;
        b=BLp9qmw5gcU0zKx3SVABPMzUUkHIu6s3uB8KuV7PtuzI5sk9X8SeXuqu1AyljJ6mL5
         Ubx7/Et56jMsWqIOYhpI3jmAns3YGIWsnvUyZlijOX2DcggoiZZbUtZdBkVu3IYeoLjw
         TDLVeMtg9BvyhS98Oi4N6qYgDOuHIDbDlshCOoRmse4Veam47hNGnX8tp5LJHMs94PDL
         ohFUHsZDBTqoV3affN5jOm6aobmCUxsgtlbVC/s05hIOXJz7I08X3CZFsxIDf+fTEmz6
         bBiK7KnQsaLxBkA3Kisq9TElXsRM6NXrxhfP5fKwTRnHz7xAKXsgJ2TkLcwRJ2ptgC3V
         DzBA==
X-Gm-Message-State: AOAM532LPY3lxDUgceuWFs9vwWr1Nn/tk6sfpRL/4/GhS2wjhkwjeY82
        GiF1luda02SBL1+Xq2Pqng==
X-Google-Smtp-Source: ABdhPJwVWPTcpvZek2C4OAFK9fa1KtWLIaDBiGIryiDD1izJ8OIhWd6dYL11PZoj7cvyVedQ/KZzNQ==
X-Received: by 2002:a05:6638:38a:: with SMTP id y10mr9407413jap.131.1590787348508;
        Fri, 29 May 2020 14:22:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h15sm2473595iol.9.2020.05.29.14.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:22:27 -0700 (PDT)
Received: (nullmailer pid 2991462 invoked by uid 1000);
        Fri, 29 May 2020 21:22:26 -0000
Date:   Fri, 29 May 2020 15:22:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Feng Tang <feng.tang@intel.com>, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-mips@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Subject: Re: [PATCH v6 00/16] spi: dw: Add generic DW DMA controller support
Message-ID: <20200529212226.GA2984630@bogus>
References: <20200529131205.31838-1-Sergey.Semin@baikalelectronics.ru>
 <159077271266.17043.13820488074564153429.b4-ty@kernel.org>
 <20200529172642.hcnvyzv2ocizsvpy@mobilestation>
 <20200529173325.GR4610@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529173325.GR4610@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 06:33:25PM +0100, Mark Brown wrote:
> On Fri, May 29, 2020 at 08:26:42PM +0300, Serge Semin wrote:
> 
> > You must have missed the patch 16:
> > 0e8332aaf059 dt-bindings: spi: Convert DW SPI binding to DT schema
> > As you can see it has been acked by Rob. So you can also merge it into your
> > repo. Though It has to be rebased first due to the Dinh Nguyen patches
> > recently merged in. Do you want me to do the rebasing?
> 
> Please rebase.  TBH I'd not noticed Rob's review so I just left it
> waiting for that, there's such a huge backlog there it didn't occur to
> me that it might've been reviewed.

Hey, I'm down to about 10 patches now. I think I'll take the rest of the 
week off.

Rob
