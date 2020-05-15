Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041221D5857
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 19:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgEORyY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 13:54:24 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:38410 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEORyY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 13:54:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A881780005C9;
        Fri, 15 May 2020 17:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P4PssopfJv9P; Fri, 15 May 2020 20:54:21 +0300 (MSK)
Date:   Fri, 15 May 2020 20:54:20 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] spi: dw: Clear DMAC register when done or stopped
Message-ID: <20200515175420.qgejailgnzswxtdz@mobilestation>
References: <20200515174856.1406-1-Sergey.Semin@baikalelectronics.ru>
 <20200515175100.GL5066@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515175100.GL5066@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 06:51:00PM +0100, Mark Brown wrote:
> On Fri, May 15, 2020 at 08:48:54PM +0300, Serge Semin wrote:
> 
> > Acked-by: Mark Brown <broonie@kernel.org>
> 
> I didn't ack this but Andy did (or at least the for-5.8 version)?

Andy said he needs Fixes field to get his RB tag. You said:
"This and patch 4 look good ..." Normally this means to get Acked-by.

-Sergey
