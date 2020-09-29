Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11C27DB71
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 00:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgI2WIh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 18:08:37 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:36994 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgI2WIf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Sep 2020 18:08:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0983D803086A;
        Tue, 29 Sep 2020 22:08:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nx-0X0aVciPz; Wed, 30 Sep 2020 01:08:32 +0300 (MSK)
Date:   Wed, 30 Sep 2020 01:08:29 +0300
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
Subject: Re: [PATCH 04/30] Revert: spi: spi-dw: Add lock protect dw_spi rx/tx
 to prevent concurrent calls
Message-ID: <20200929220829.27cfe7a47beecmfa@mobilestation>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200920112914.26501-5-Sergey.Semin@baikalelectronics.ru>
 <20200929132811.GF4799@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200929132811.GF4799@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 29, 2020 at 02:28:11PM +0100, Mark Brown wrote:
> On Sun, Sep 20, 2020 at 02:28:48PM +0300, Serge Semin wrote:
> > There is no point in having the commit 19b61392c5a8 ("spi: spi-dw: Add
> > lock protect dw_spi rx/tx to prevent concurrent calls") applied. The
> > commit author made an assumption that the problem with the rx data
> 

> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Ok. Thank you for pointing that out. I'll do like you said next time on a
patch reversion.

-Sergey
