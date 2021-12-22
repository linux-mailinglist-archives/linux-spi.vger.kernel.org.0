Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301CF47CE51
	for <lists+linux-spi@lfdr.de>; Wed, 22 Dec 2021 09:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhLVIcS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Dec 2021 03:32:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38356 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhLVIcS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Dec 2021 03:32:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BM8Vs7R084180;
        Wed, 22 Dec 2021 02:31:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640161914;
        bh=Vc58ap0YNTCV3EPPiHIaPaA65V79GNUwSwP0Gs0Yvj8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=nxUWP//6VYxiiUJpHyrqeXLk33zDgBHRpfcosvue+3A378IiyOhLv9j59undxonyN
         3HD7kqUCyl4OfowxpjHopGxvOykaKMSBiConM7XlLzXThNgGwK2DkZIhw314PYISr/
         gsbnOT6wsRBUP6IuKNnCD6phwBf7MJUmOBi/o+pg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BM8VsEU119910
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Dec 2021 02:31:54 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 22
 Dec 2021 02:31:53 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 22 Dec 2021 02:31:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BM8Vrjb113455;
        Wed, 22 Dec 2021 02:31:53 -0600
Date:   Wed, 22 Dec 2021 14:01:52 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v8 01/14] spi: spi-mem: reject partial cycle transfers in
Message-ID: <20211222083150.i4semnybo2l4aede@ti.com>
References: <20211221174844.56385-1-miquel.raynal@bootlin.com>
 <20211221174844.56385-2-miquel.raynal@bootlin.com>
 <20211221184148.pw4blwxdvxcoerjo@ti.com>
 <20211222091223.5bf11221@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211222091223.5bf11221@xps13>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22/12/21 09:12AM, Miquel Raynal wrote:
> Hi Pratyush,
> 
> p.yadav@ti.com wrote on Wed, 22 Dec 2021 00:11:50 +0530:
> 
> > Hi,
> > 
> > On 21/12/21 06:48PM, Miquel Raynal wrote:
> > > From: Pratyush Yadav <p.yadav@ti.com>
> > > 
> > > In 8D-8D-8D mode two bytes are transferred per cycle. So an odd number
> > > of bytes cannot be transferred because it would leave a residual half
> > > cycle at the end. Consider such a transfer invalid and reject it.
> > > 
> > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > Reviewed-by: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> > 
> > Sorry, I didn't realize this before. This patch would break a couple of 
> > SPI NOR flashes. You need patch 1, 2, and 3 from my series as well to 
> > make sure this does not happen. Since those patches have some pending 
> > comments, can you just drop this patch and I will re-roll it on top of 
> > your series later when I can find some time for it? Again, sorry for not 
> > noticing this before.
> 
> Yes no problem, I might as well drop it when applying.

And drop the changes from patch 3 as well.

> 
> Thanks,
> Miquèl

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
