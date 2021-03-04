Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D1832DA78
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhCDTgT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 14:36:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53700 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhCDTgP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 14:36:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 124JYToM121432;
        Thu, 4 Mar 2021 13:34:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614886469;
        bh=lF0mQ5MhA2gJ1UfDZX2ECvmj+tO2BOviRmsIssFGgDs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xqoWjfnMH38CtxwUzyVEBMuVzY6as8fblOPuh25JxtPNgeZRUrD7+6HtQA7rfzQYX
         wx4mMgLShcpXACNmlhlsufB869xNEO7ty6h2EodDKixLFLdDT2jlRUgbsdbGafSAiR
         o1qGmFBqm7vogR61xAEGhRHK9uYvpenKaCBgGens=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 124JYTl2126840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 13:34:29 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 13:34:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 13:34:28 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 124JYRAN036390;
        Thu, 4 Mar 2021 13:34:28 -0600
Date:   Fri, 5 Mar 2021 01:04:27 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Jay Fang <f.fangjian@huawei.com>, <linux-spi@vger.kernel.org>,
        <broonie@kernel.org>, <huangdaode@huawei.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Silence shiftTooManyBitsSigned
 warning
Message-ID: <20210304193427.rdtu75tv6invjq2d@ti.com>
References: <1614854872-8694-1-git-send-email-f.fangjian@huawei.com>
 <20210304130845.GE2222@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210304130845.GE2222@kadam>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/03/21 04:08PM, Dan Carpenter wrote:
> On Thu, Mar 04, 2021 at 06:47:52PM +0800, Jay Fang wrote:
> > drivers/spi/spi-cadence-quadspi.c:267:18: warning: Shifting signed 32-bit
> > value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
> >     return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
> >                     ^
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Jay Fang <f.fangjian@huawei.com>
> > ---
> >  drivers/spi/spi-cadence-quadspi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> > index 442cc7c..9a2798a5 100644
> > --- a/drivers/spi/spi-cadence-quadspi.c
> > +++ b/drivers/spi/spi-cadence-quadspi.c
> > @@ -264,7 +264,7 @@ static bool cqspi_is_idle(struct cqspi_st *cqspi)
> >  {
> >  	u32 reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
> >  
> > -	return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
> > +	return reg & (1UL << CQSPI_REG_CONFIG_IDLE_LSB);
> 
> This is always going to be false because reg is a u32.

Hmm... I don't see why it would always be false. reg would promoted to 
unsigned long and the result should then depend on the actual value of 
the bit, which can be represented by an unsigned long. There is no loss 
of information.

Anyway, it still makes more sense to make it 1U because reg is u32. Just 
keep the types same and avoid all the conversion rules.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
