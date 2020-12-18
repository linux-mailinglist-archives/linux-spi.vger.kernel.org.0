Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58502DE9B0
	for <lists+linux-spi@lfdr.de>; Fri, 18 Dec 2020 20:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgLRTV2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Dec 2020 14:21:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41908 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLRTVX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Dec 2020 14:21:23 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BIJJeuJ086862;
        Fri, 18 Dec 2020 13:19:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608319180;
        bh=lUyXP+Ilz74qzBHmqg0zeX5IOpiJQ2uyKigfRmBGfFY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=eBbwuKRg4eSphx8BGI+BqFt6tBB4xcmE3WhWr5lLnrO0kkAnpvwDn9rXBmagJ6yKf
         qa2t8XPzA9nE+ExcBsaVHWXJGKwt/dpuQhjhxCxqQ2dvqWMN8tHXFATSmeygQEUOdv
         ZtyRBc7lnn1h7bYHeSE0JIKifKM7bl0a/Q/wrTRs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BIJJerD028360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 13:19:40 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Dec 2020 13:19:39 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Dec 2020 13:19:39 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BIJJdfb106366;
        Fri, 18 Dec 2020 13:19:39 -0600
Date:   Sat, 19 Dec 2020 00:49:38 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
CC:     Boris Brezillon <boris.brezillon@collabora.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>,
        <bbrezillon@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 5/9] spi: spi-mem: Mark dummy transfers by setting
 dummy_data bit
Message-ID: <20201218191936.hb6sq7zr3zdirar7@ti.com>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
 <1608236927-28701-6-git-send-email-skomatineni@nvidia.com>
 <20201218092106.skwej2g6bk3oksbb@ti.com>
 <20201218105759.43789ccf@collabora.com>
 <31c395ee-d7a6-edc5-a790-89fad91a0a27@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <31c395ee-d7a6-edc5-a790-89fad91a0a27@nvidia.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 18/12/20 10:09AM, Sowjanya Komatineni wrote:
> 
> On 12/18/20 1:57 AM, Boris Brezillon wrote:
> > On Fri, 18 Dec 2020 14:51:08 +0530
> > Pratyush Yadav <p.yadav@ti.com> wrote:
> > 
> > > Hi Sowjanya,
> > > 
> > > On 17/12/20 12:28PM, Sowjanya Komatineni wrote:
> > > > This patch marks dummy transfer by setting dummy_data bit to 1.
> > > > 
> > > > Controllers supporting dummy transfer by hardware use this bit field
> > > > to skip software transfer of dummy bytes and use hardware dummy bytes
> > > > transfer.
> > > What is the benefit you get from this change? You add complexity in
> > > spi-mem and the controller driver, so that must come with some benefits.
> > > Here I don't see any. The transfer will certainly take the same amount
> > > of time because the number or period of the dummy cycles has not
> > > changed. So why is this needed?
> > Well, you don't have to queue TX bytes if you use HW-based dummy
> > cycles, but I agree, I'd expect the overhead to be negligible,
> > especially since we're talking about emitting a few bytes, not hundreds.
> > This being said, the complexity added to the core is reasonable IMHO,
> > so if it really helps reducing the CPU overhead (we might need some
> > numbers to prove that), I guess it's okay.
> 
> Hardware dummy cycles feature of Tegra QSPI is to save SW transfer cycle of
> dummy bytes by filling FIFO.
> 
> I don't have numbers as we always use hardware dummy cycles with Tegra QSPI.

Most flashes use somewhere around 8-10 dummy cycles. Some of the faster 
ones working at 166 MHz or above use 20-25. From what I understand, the 
only time hardware transfer of dummy cycles will reduce CPU load 
significantly will be when multiple small transfers are made in quick 
succession. Unless you have such a usecase I don't know how much benefit 
you will get by it.

Anyway, if the SPI maintainers think this is worth it, I won't object.
 
> > > > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > > > ---
> > > >   drivers/spi/spi-mem.c   | 1 +
> > > >   include/linux/spi/spi.h | 2 ++
> > > >   2 files changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > > > index f3a3f19..c64371c 100644
> > > > --- a/drivers/spi/spi-mem.c
> > > > +++ b/drivers/spi/spi-mem.c
> > > > @@ -354,6 +354,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> > > >   		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
> > > >   		xfers[xferpos].len = op->dummy.nbytes;
> > > >   		xfers[xferpos].tx_nbits = op->dummy.buswidth;
> > > > +		xfers[xferpos].dummy_data = 1;
> > > >   		spi_message_add_tail(&xfers[xferpos], &msg);
> > > >   		xferpos++;
> > > >   		totalxferlen += op->dummy.nbytes;
> > > > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> > > > index aa09fdc..708f2f5 100644
> > > > --- a/include/linux/spi/spi.h
> > > > +++ b/include/linux/spi/spi.h
> > > > @@ -827,6 +827,7 @@ extern void spi_res_release(struct spi_controller *ctlr,
> > > >    *      transfer. If 0 the default (from @spi_device) is used.
> > > >    * @bits_per_word: select a bits_per_word other than the device default
> > > >    *      for this transfer. If 0 the default (from @spi_device) is used.
> > > > + * @dummy_data: indicates transfer is dummy bytes transfer.
> > > >    * @cs_change: affects chipselect after this transfer completes
> > > >    * @cs_change_delay: delay between cs deassert and assert when
> > > >    *      @cs_change is set and @spi_transfer is not the last in @spi_message
> > > > @@ -939,6 +940,7 @@ struct spi_transfer {
> > > >   	struct sg_table tx_sg;
> > > >   	struct sg_table rx_sg;
> > > > +	unsigned	dummy_data:1;
> > > >   	unsigned	cs_change:1;
> > > >   	unsigned	tx_nbits:3;
> > > >   	unsigned	rx_nbits:3;
> > > > -- 
> > > > 2.7.4

-- 
Regards,
Pratyush Yadav
Texas Instruments India
