Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B921CFEF4
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 22:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgELUHh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 16:07:37 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:54834 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELUHh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 16:07:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id EF38A803080B;
        Tue, 12 May 2020 20:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0qIQxjXwpsZz; Tue, 12 May 2020 23:07:34 +0300 (MSK)
Date:   Tue, 12 May 2020 23:07:33 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] spi: dw: Add generic DW DMA controller support
Message-ID: <20200512200733.bdbbhkjkwjd5yzqq@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508133336.GK4820@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508133336.GK4820@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 02:33:36PM +0100, Mark Brown wrote:
> On Fri, May 08, 2020 at 04:29:25PM +0300, Serge Semin wrote:
> 
> > Serge Semin (17):
> >   dt-bindings: spi: Convert DW SPI binding to DT schema
> 
> Please don't make new feature development dependent on conversion to the
> new schema format, there's quite a backlog of reviews of schema
> conversions so it can slow things down.  It's good to do the conversions
> but please do them after adding any new stuff to the binding rather than
> before.

So by saying this do you want me to revert an order of the first two patches
in the series, right? So the series would first add the DMA properties support
to the binding, then would convert the binding file to DT schema.

-Sergey

