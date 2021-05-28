Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B757394350
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 15:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhE1NTA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 09:19:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60234 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhE1NS7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 09:18:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14SDH1rJ008626;
        Fri, 28 May 2021 08:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622207821;
        bh=KF6yZbuvWoHQNXUVivVR6Y1MSRapQUxyWpoZwH2+GjY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Uwy0HDIeILYv0B1lXoif0bl02X6s/PIF6ef/Fi771FifGNgQGtEfITIKzG7JkqjdK
         qKETZmKMxETgSB3fXzB9b2IsRWe2/xX1O4B0Bw6KZ0+xUri8ot1rGc4fJBcsKFIkdq
         c0Tw3M1kFzJH7f1SrHhSQuBj0vteCLoxQUIeIAHg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14SDH1Y1086672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 May 2021 08:17:01 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 08:17:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 28 May 2021 08:17:01 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14SDH0YE057370;
        Fri, 28 May 2021 08:17:01 -0500
Date:   Fri, 28 May 2021 18:47:00 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
CC:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
Subject: Re: [PATCH v3 3/3] mtd: spinand: add SPI-NAND MTD resume handler
Message-ID: <20210528131658.jtveyvdtxrwj2lgx@ti.com>
References: <20210527161252.16620-1-patrice.chotard@foss.st.com>
 <20210527161252.16620-4-patrice.chotard@foss.st.com>
 <20210528120508.f6viglv3gkzgweqq@ti.com>
 <3238725c-d7ff-c000-23d1-f18298e1556f@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3238725c-d7ff-c000-23d1-f18298e1556f@foss.st.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/05/21 02:51PM, Patrice CHOTARD wrote:
> Hi Pratyush
> 
> On 5/28/21 2:05 PM, Pratyush Yadav wrote:
> > On 27/05/21 06:12PM, patrice.chotard@foss.st.com wrote:
> >> From: Patrice Chotard <patrice.chotard@foss.st.com>
> >>
> >> After power up, all SPI NAND's blocks are locked. Only read operations
> >> are allowed, write and erase operations are forbidden.
> >> The SPI NAND framework unlocks all the blocks during its initialization.
> >>
> >> During a standby low power, the memory is powered down, losing its
> >> configuration.
> >> During the resume, the QSPI driver state is restored but the SPI NAND
> >> framework does not reconfigured the memory.
> >>
> >> This patch adds SPI-NAND MTD PM handlers for resume ops.
> >> SPI NAND resume op re-initializes SPI NAND flash to its probed state.
> >>
> >> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> >> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> >> ---
> >> Changes in v3:
> >>   - Add spinand_read_cfg() call to repopulate cache
> >>
> >> Changes in v2:
> >>   - Add helper spinand_block_unlock().
> >>   - Add spinand_ecc_enable() call.
> >>   - Remove some dev_err().
> >>   - Fix commit's title and message.
> >>
> >>  drivers/mtd/nand/spi/core.c | 33 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 33 insertions(+)
> >>
> >> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> >> index 1f699ad84f1b..e3fcbcf381c3 100644
> >> --- a/drivers/mtd/nand/spi/core.c
> >> +++ b/drivers/mtd/nand/spi/core.c
> >> @@ -1099,6 +1099,38 @@ static int spinand_block_unlock(struct spinand_device *spinand)
> >>  	return ret;
> >>  }
> >>  
> >> +static void spinand_mtd_resume(struct mtd_info *mtd)
> >> +{
> >> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> >> +	int ret;
> >> +
> >> +	ret = spinand_reset_op(spinand);
> >> +	if (ret)
> >> +		return;
> >> +
> >> +	ret = spinand_read_cfg(spinand);
> >> +	if (ret)
> >> +		return;
> >> +
> >> +	ret = spinand_init_quad_enable(spinand);
> >> +	if (ret)
> >> +		return;
> >> +
> >> +	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
> >> +	if (ret)
> >> +		return;
> >> +
> >> +	ret = spinand_manufacturer_init(spinand);
> >> +	if (ret)
> >> +		return;
> >> +
> >> +	ret = spinand_block_unlock(spinand);
> >> +	if (ret)
> >> +		return;
> >> +
> >> +	spinand_ecc_enable(spinand, false);
> >> +}
> >> +
> > 
> > I don't think you quite get what me and Miquel are suggesting.
> > 
> > The helper should call all these functions like read_cfg() 
> > quad_enable(), etc. So it should look something like:
> 
> Yes, this series was sent too quickly on my side, and i misunderstood 
> what you suggested, sorry for that.

Ah, I thought this was the v4. I see Miquel clarified already in reply 
to this patch.

> 
> > 
> > int spinand_init_flash()
> > {
> > 	ret = spinand_read_cfg(spinand);
> > 	if (ret)
> > 		return;
> > 
> 
> The new helper spinand_read_cfg() must not be called in spinand_init_flash()
> but directly in spinand_resume().
> This because spinand_read_cfg() only performs a REG_CFG read without doing the
> memory allocation of spinand->cfg_cache.
> 
> In spinand_init(), spinand_init_cfg_cache() must be called as previously as it does spinand->cfg_cache
> memory allocation and call the new helper spinand_read_cfg(). 
> Then after, spinand_init_flash() can be called.

I think it would be simpler for spinand_init_cfg_cache() to just 
allocate the spinand->cfg_cache array and then for spinand_init_flash() 
to call spinand_read_cfg().

> 
> > 	ret = spinand_init_quad_enable(spinand);
> > 	if (ret)
> > 		return;
> > 
> > 	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
> > 	if (ret)
> > 		return;
> > 
> > 	ret = spinand_manufacturer_init(spinand);
> > 	if (ret)
> > 		return;
> > 
> > 	ret = spinand_block_unlock(spinand);
> > 	if (ret)
> > 		return;
> > 
> > 	spinand_ecc_enable(spinand, false);
> > }
> > 
> > Then spinand_mtd_resume should look something like:
> > 
> > int spinand_mtd_resume()
> > {
> > 	ret = spinand_reset_op(spinand);
> > 	if (ret)
> > 		return;
> > 
> > 	return spinand_init_flash();
> > }
> > 
> > And spinand_init() should look something like:
> > 
> > int spinand_init()
> > {
> > 	...
> > 	spinand->oobbuf = ...
> > 
> > 	spinand_init_flash();
> > 
> > 	spinand_create_dirmaps();
> > 
> > 	...
> 
> As explained just above, spinand_init() will look like :
> 
> int spinand_init()
> {
> 	...
> 	spinand->oobbuf = ...
> 
> 	spinand_init_cfg_cache();     => perform cfg cache memory allocation and read the REG_CFG
> 
> 	spinand_init_flash();
> 
> 	spinand_create_dirmaps();
> 
> > }
> > 
> > 
> >>  static int spinand_init(struct spinand_device *spinand)
> >>  {
> >>  	struct device *dev = &spinand->spimem->spi->dev;
> >> @@ -1186,6 +1218,7 @@ static int spinand_init(struct spinand_device *spinand)
> >>  	mtd->_block_isreserved = spinand_mtd_block_isreserved;
> >>  	mtd->_erase = spinand_mtd_erase;
> >>  	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
> >> +	mtd->_resume = spinand_mtd_resume;
> >>  
> >>  	if (nand->ecc.engine) {
> >>  		ret = mtd_ooblayout_count_freebytes(mtd);
> >> -- 
> >> 2.17.1
> > 
> 
> Thanks
> Patrice

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
