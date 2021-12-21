Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066A847C6CB
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 19:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhLUSmS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Dec 2021 13:42:18 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55474 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbhLUSmR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 13:42:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BLIfqgG112219;
        Tue, 21 Dec 2021 12:41:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640112112;
        bh=aLRckghuZIZgRpANh5EJJ7wkLHZv7TBPJZa7KiUv/ss=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=V60k8UylfO2mhZrH+uNe18qEMxs516y35e348j1I5ccPi7q1B1M/6/anlb6ymsf7C
         f76LU3zApUVieJqBKqgheh9Hd8Bmo40tTdG5JkIFoPHUE0t2zqgFEabiC9DuL2D1z0
         3S0x8e0+OduGP6oFKSOd559xlJUfDHkbYM9xQdfQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BLIfqRl038931
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Dec 2021 12:41:52 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Dec 2021 12:41:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Dec 2021 12:41:51 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BLIfpY5077765;
        Tue, 21 Dec 2021 12:41:51 -0600
Date:   Wed, 22 Dec 2021 00:11:50 +0530
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
Message-ID: <20211221184148.pw4blwxdvxcoerjo@ti.com>
References: <20211221174844.56385-1-miquel.raynal@bootlin.com>
 <20211221174844.56385-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211221174844.56385-2-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 21/12/21 06:48PM, Miquel Raynal wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> In 8D-8D-8D mode two bytes are transferred per cycle. So an odd number
> of bytes cannot be transferred because it would leave a residual half
> cycle at the end. Consider such a transfer invalid and reject it.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Sorry, I didn't realize this before. This patch would break a couple of 
SPI NOR flashes. You need patch 1, 2, and 3 from my series as well to 
make sure this does not happen. Since those patches have some pending 
comments, can you just drop this patch and I will re-roll it on top of 
your series later when I can find some time for it? Again, sorry for not 
noticing this before.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
