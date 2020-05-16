Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3D51D641C
	for <lists+linux-spi@lfdr.de>; Sat, 16 May 2020 23:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgEPU75 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 16 May 2020 16:59:57 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41012 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgEPU75 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 16 May 2020 16:59:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0322E8030875;
        Sat, 16 May 2020 20:59:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 55Mvyz7LEB48; Sat, 16 May 2020 23:59:54 +0300 (MSK)
Date:   Sat, 16 May 2020 23:59:53 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
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
        <linux-mips@vger.kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 19/19] dt-bindings: spi: Convert DW SPI binding to DT
 schema
Message-ID: <20200516205953.2wbhe35d5ql4uklu@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-20-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-20-Sergey.Semin@baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Rob,
Could you take a look at this patch? We are getting closer to merging the series
into the spi/for-next branch and then to the kernel 5.8. It would be great to
have the bindings converted by the next merge window.

-Sergey

On Fri, May 15, 2020 at 01:47:58PM +0300, Serge Semin wrote:
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

[nip]
