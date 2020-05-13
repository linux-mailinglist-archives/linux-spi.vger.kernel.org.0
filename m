Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A54E1D11F9
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 13:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgEML5C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 07:57:02 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57762 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgEML5C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 07:57:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id CCC60803087C;
        Wed, 13 May 2020 11:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7N8KV2RDK2yq; Wed, 13 May 2020 14:56:56 +0300 (MSK)
Date:   Wed, 13 May 2020 14:56:55 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/17] spi: dw: Clear DMAC register when done or stopped
Message-ID: <20200513115655.s2i65tfy5m4skl35@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-9-Sergey.Semin@baikalelectronics.ru>
 <20200508173134.GP4820@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508173134.GP4820@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 06:31:34PM +0100, Mark Brown wrote:
> On Fri, May 08, 2020 at 04:29:33PM +0300, Serge Semin wrote:
> > If DMAC register is left uncleared any further DMAless transfers
> > may cause the DMAC hardware handshaking interface getting activated.
> > So the next DMA-based Rx/Tx transaction will be started right
> > after the dma_async_issue_pending() method is invoked even if no
> > DMATDLR/DMARDLR conditions are met. This at the same time may cause
> > the Tx/Rx FIFO buffers underrun/overrun. In order to fix this we
> > must clear DMAC register after a current DMA-based transaction is
> > finished.
> 
> This also looks like a bugfix so should be pulled forwards to the start
> of the series if possible.

Ok.

-Sergey
