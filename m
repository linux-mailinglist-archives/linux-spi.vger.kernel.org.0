Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF811E1731
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 23:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgEYVgU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 17:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgEYVgT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 May 2020 17:36:19 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361BFC061A0E;
        Mon, 25 May 2020 14:36:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so22165951ljj.1;
        Mon, 25 May 2020 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oth1KexUB+FsUoOYKeg78MRq+7smeSq/8UsnVtGlaks=;
        b=oHIcuttoLald5GlP7EJCAhpNtOvQYbC5KLwNgxj6w+p4IDisM1e6iP/kiGn1AtaIaN
         KUZn5Fh39pkqJoUY6m0S5fcg6GpEnUaeUq1Z7eqdkOnkp/gNOu2oCvUQksV5p9H6zGjg
         tq0973ORHFL6eKR5cEqvLqWhLI6cJVAu7fb6nSo6/FyLDCbmc6v178oNMbVq9Iuf1M8q
         mkts9N8PuWtgoVQw0WIcQd5lv1SavLzNuUHKH/0JQIrcfl0TOo1bOP+SXmDBdYfDiLwa
         N4fSJ2toDNtc1Ote8zWlIOCdrs+EmH4jeBtpoD8zsF6smOyI3VVYwKNBKi8oRynbsiUi
         HRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oth1KexUB+FsUoOYKeg78MRq+7smeSq/8UsnVtGlaks=;
        b=ctTDFo9kiCRJlJddJvW7x07B5VZvro2ru8PrqyvrwW43fm4WS4gNOx83e5OqLBNCy5
         NE4D57Db+h2arq05uI1DdK5oc5Q4GXOgHj7Zh5RMuCve3v0hOEEIMZ43CwaPJiOn49TW
         c8sXcL98B366dk3NNzTx3S60R0PZFy3ej4cleeiQOep7dvDcvuGlzGXCGo57o1Qw1Gjg
         40aqXkWo8ax6M7nQrtfC8ljsnkcKYeIj0EPv+3/MBd9+MYu10rWcS99zNE0iATwL4GVF
         miRiagBcpWIj6a6iYJ0/EJpNq94jsB/ZBkxr+69wMNT8BvqAhUMS56sEVqC7j8jDrMKC
         gIyA==
X-Gm-Message-State: AOAM533UEyAY3M5GWfCukXfcTvbI6gZxoTtyGGHC9Ra9QpO9P2V5iD/U
        r+EEvKhhdMCpfdJUWNjnARQ=
X-Google-Smtp-Source: ABdhPJzaUPjez1Vfl7UAmA7nCR6v6/Jv8o4QyzmOpysnLeKWkDcdWjl+RB5g2upMT//w2edcMXL8fQ==
X-Received: by 2002:a2e:a544:: with SMTP id e4mr4256451ljn.264.1590442576830;
        Mon, 25 May 2020 14:36:16 -0700 (PDT)
Received: from mobilestation ([95.79.222.123])
        by smtp.gmail.com with ESMTPSA id q25sm3073111lfb.43.2020.05.25.14.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:36:16 -0700 (PDT)
Date:   Tue, 26 May 2020 00:36:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/16] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200525213613.fqwb6xdb6qsh6xy7@mobilestation>
References: <20200522123427.GD1634618@smile.fi.intel.com>
 <20200522124406.co7gmteojfsooerc@mobilestation>
 <20200522131013.GH5801@sirena.org.uk>
 <20200522132742.taf2ixfjpyd5u3dt@mobilestation>
 <20200522140025.bmd6bhpjjk5msvsm@mobilestation>
 <20200522143639.GG1634618@smile.fi.intel.com>
 <20200522144542.brhibh453wid2d6v@mobilestation>
 <20200522152241.GK5801@sirena.org.uk>
 <20200523083410.3qarkfkwsmodvxwk@mobilestation>
 <20200525114132.GC4544@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525114132.GC4544@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 25, 2020 at 12:41:32PM +0100, Mark Brown wrote:
> On Sat, May 23, 2020 at 11:34:10AM +0300, Serge Semin wrote:
> > On Fri, May 22, 2020 at 04:22:41PM +0100, Mark Brown wrote:
> 
> > > Right, that definitely needs to be fixed then - 8MHz is indeed a totally
> > > normal clock rate for SPI so people will hit it.  I guess if there's a
> > > noticable performance hit to defer to thread then we could implement
> > > both and look at how long the delay is going to be to decide which to
> > > use, that's annoyingly complicated though so if the overhead is small
> > > enough we could just not bother.
> 
> > As I suggested before we can implement a solution without performance drop.
> > Just wait for the DMA completion locally in the dw_spi_dma_transfer() method and
> > return 0 instead of 1 from the transfer_one() callback. In that function we'll
> > wait while DMA finishes its business, after that we can check the Tx/Rx FIFO
> > emptiness and wait for the data to be completely transferred with delays or
> > sleeps or whatever.
> 
> No extra context switches there at least, that's the main issue.

Right. There won't be extra context switch.

> 
> > NOTE Currently the DW APB SSI driver doesn't set xfer->effective_speed_hz, though as
> > far as I can see that field exists there to be initialized by the SPI controller
> > driver, right? If so, strange it isn't done in any SPI drivers...
> 
> Yes.  Not that many people are concerned about the exact timing it turns
> out, the work that was being used for never fully made it upstream.
> 
> > What do think about this?
> 
> Sure.

Great. I'll send a new patchset soon. It'll fix the Tx/Rx non-empty issue in
accordance with the proposed design.

-Sergey

> 
> > patchset "spi: dw: Add generic DW DMA controller support" (it's being under
> > review in this email thread) ? Anyway, if the fixup is getting to be that
> > complicated, will it have to be backported to another stable kernels?
> 
> No, if it's too invasive it shouldn't be (though the stable people might
> decide they want it anyway these days :/ ).


