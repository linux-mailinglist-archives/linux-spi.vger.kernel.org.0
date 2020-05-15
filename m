Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A701D54F3
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgEOPnP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 11:43:15 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:38004 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgEOPnP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 11:43:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4EE888029EC9;
        Fri, 15 May 2020 15:43:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IQ3PdJDbfO6V; Fri, 15 May 2020 18:43:10 +0300 (MSK)
Date:   Fri, 15 May 2020 18:43:08 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        <linux-mips@vger.kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/19] dt-bindings: spi: dw: Add Tx/Rx DMA properties
Message-ID: <20200515154308.7s3wauq5edwj437y@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-2-Sergey.Semin@baikalelectronics.ru>
 <20200515115151.GU185537@smile.fi.intel.com>
 <20200515122715.GC5066@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515122715.GC5066@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:27:15PM +0100, Mark Brown wrote:
> On Fri, May 15, 2020 at 02:51:51PM +0300, Andy Shevchenko wrote:
> > On Fri, May 15, 2020 at 01:47:40PM +0300, Serge Semin wrote:
> 
> > > Since commit 22d48ad7bfac ("spi: dw: Add Elkhart Lake PSE DMA support")
> > > the spi-dw-mid.c module supports a platform DMA engine handling the DW APB
> > > SSI controller requests. Lets alter the DW SPI bindings file to accept the
> > > Rx and Tx DMA line specifiers.
> 
> > I'm wondering if these properties are implied by the SPI generic one?
> > (forgive me if I'm not understanding all DT schema relations)
> 
> Which SPI generic DMA bindings are you thinking of here?  There aren't
> any in spi-controller.yaml.

There are default schemas in the dt-core, which defines the dmas and dma-names
type, but the exact naming and number of phandler+identifiers are implementation
specific. So it's either supposed to be implemented on the generic SPI controller
basis (like in someplace of spi-controller.yaml) or in individual controllers DT
schema. As Mark said we don't have any DMA properties definition in the generic
SPI controller schema (spi-controller.yaml), so the particular SPI controllers
DT schemas have got their own DMA properties declared. Most of them BTW use the
same naming as we do here: "rx" and "tx", but some alas don't.

-Sergey
