Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A1E27EDEE
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgI3PyA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 11:54:00 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41154 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgI3PyA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 11:54:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 93ADB803071A;
        Wed, 30 Sep 2020 15:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f07XY6Mu8Rdm; Wed, 30 Sep 2020 18:53:57 +0300 (MSK)
Date:   Wed, 30 Sep 2020 18:53:56 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/30] spi: dw: Add DWC SSI capability
Message-ID: <20200930155356.sukgijepskotuj73@mobilestation>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-12-Sergey.Semin@baikalelectronics.ru>
 <20200929135233.GG4799@sirena.org.uk>
 <20200929221737.fiwjr4y3vhme4546@mobilestation>
 <20200930150312.ipt724uihixblr3a@mobilestation>
 <20200930154149.GL4974@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200930154149.GL4974@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 30, 2020 at 04:41:49PM +0100, Mark Brown wrote:
> On Wed, Sep 30, 2020 at 06:03:12PM +0300, Serge Semin wrote:
> > On Wed, Sep 30, 2020 at 01:17:37AM +0300, Serge Semin wrote:
> 
> > > > > -	/*
> > > > > -	 * SPI mode (SCPOL|SCPH)
> > > > > -	 * CTRLR0[ 8] Serial Clock Phase
> > > > > -	 * CTRLR0[ 9] Serial Clock Polarity
> > > > > -	 */
> > > > > -	cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DWC_SSI_CTRLR0_SCPOL_OFFSET;
> 
> > anyway. If you are agree with me having that done here, then please, accept the
> > patch the way it is. If you disagree, or have any other though, please give me
> > your answer, why.
> 
> Those comments did seem to help mitigate the wall of acronym soup issue
> that the code has, it seems a shame to drop them.

I see your point, but still don't think that those comment give much help like you
said, because the mode->register mapping can be easily derived from the macro
naming and values.

Anyway since you insist on having the comments left here, I'll get them back and
add the similar ones for the standard DW-APB-SSI version of the controller so
the code would look coherent.

-Sergey
