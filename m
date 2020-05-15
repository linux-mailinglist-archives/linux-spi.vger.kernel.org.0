Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACDA1D5903
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 20:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEOSXZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 14:23:25 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:38480 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOSXZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 14:23:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6FC1980005C9;
        Fri, 15 May 2020 18:23:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ti73dIEaZ6s6; Fri, 15 May 2020 21:23:22 +0300 (MSK)
Date:   Fri, 15 May 2020 21:23:22 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] spi: dw: Clear DMAC register when done or stopped
Message-ID: <20200515182322.mmsfe5zu5tqmovmf@mobilestation>
References: <20200515174856.1406-1-Sergey.Semin@baikalelectronics.ru>
 <20200515175100.GL5066@sirena.org.uk>
 <20200515175420.qgejailgnzswxtdz@mobilestation>
 <20200515181219.GN5066@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515181219.GN5066@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 07:12:19PM +0100, Mark Brown wrote:
> On Fri, May 15, 2020 at 08:54:20PM +0300, Serge Semin wrote:
> > On Fri, May 15, 2020 at 06:51:00PM +0100, Mark Brown wrote:
> > > On Fri, May 15, 2020 at 08:48:54PM +0300, Serge Semin wrote:
> 
> > > > Acked-by: Mark Brown <broonie@kernel.org>
> 
> > > I didn't ack this but Andy did (or at least the for-5.8 version)?
> 
> > Andy said he needs Fixes field to get his RB tag. You said:
> > "This and patch 4 look good ..." Normally this means to get Acked-by.
> 
> Unless someone explicitly gives you a tag for something you shouldn't
> usually assume that one applies, especially with maintainers giving acks
> on their own trees since that has process meaning - it's saying that the
> maintainer is OK with it being applied to some other tree which is
> something it's worth being careful about.

Hm, it depends on maintainer and sub-system then. I did such "looks good" ->
Acked-by conversions before. Not that many, but noone argued. [1] also says it's
sometimes possible. Anyway, sorry for inconvenience. I'll get to remember that
I'd better ask explicit acked-by from you, no assumption.

[1] Documentation/process/submitting-patches.rst

-Sergey

> 
> On the other hand if someone says "if you do X you can add tag Y" and
> you do X then you can generally add the tag if you do Y.


