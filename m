Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBDB47CDDE
	for <lists+linux-spi@lfdr.de>; Wed, 22 Dec 2021 09:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhLVIMg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 22 Dec 2021 03:12:36 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57593 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhLVIMf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Dec 2021 03:12:35 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0124D6000C;
        Wed, 22 Dec 2021 08:12:24 +0000 (UTC)
Date:   Wed, 22 Dec 2021 09:12:23 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v8 01/14] spi: spi-mem: reject partial cycle transfers
 in
Message-ID: <20211222091223.5bf11221@xps13>
In-Reply-To: <20211221184148.pw4blwxdvxcoerjo@ti.com>
References: <20211221174844.56385-1-miquel.raynal@bootlin.com>
        <20211221174844.56385-2-miquel.raynal@bootlin.com>
        <20211221184148.pw4blwxdvxcoerjo@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

p.yadav@ti.com wrote on Wed, 22 Dec 2021 00:11:50 +0530:

> Hi,
> 
> On 21/12/21 06:48PM, Miquel Raynal wrote:
> > From: Pratyush Yadav <p.yadav@ti.com>
> > 
> > In 8D-8D-8D mode two bytes are transferred per cycle. So an odd number
> > of bytes cannot be transferred because it would leave a residual half
> > cycle at the end. Consider such a transfer invalid and reject it.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> Sorry, I didn't realize this before. This patch would break a couple of 
> SPI NOR flashes. You need patch 1, 2, and 3 from my series as well to 
> make sure this does not happen. Since those patches have some pending 
> comments, can you just drop this patch and I will re-roll it on top of 
> your series later when I can find some time for it? Again, sorry for not 
> noticing this before.

Yes no problem, I might as well drop it when applying.

Thanks,
Miquèl
