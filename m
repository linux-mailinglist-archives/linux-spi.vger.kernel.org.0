Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DDA1DB05D
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 12:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgETKh7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 06:37:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48788 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKh6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 May 2020 06:37:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04KAbWLQ107478;
        Wed, 20 May 2020 05:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589971052;
        bh=+KF9k6cB/JfAPmPQy9MafpFdMwFT47tOFEMgTwRcw9M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Mc56S6dJwa52OQndl3nGDOF8ZS6pRdbj54zRKH0Qk1G1vNJkapaLZEUp1JxevQGmV
         RKngxvJDyRnBBS6bG5jWfjHen+AK0SKDiWGSL4ufV6lWPofk9t83hgyhWRYSzhm7JU
         pCV5jP/4zlTMk2N6hpgLtId95Q8gn6m0trDx3xRw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04KAbWc3060215
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 05:37:32 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 20
 May 2020 05:37:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 20 May 2020 05:37:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04KAbVvo036664;
        Wed, 20 May 2020 05:37:31 -0500
Date:   Wed, 20 May 2020 16:07:30 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <masonccyang@mxic.com.tw>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mark Brown <broonie@kernel.org>, <juliensu@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v5 09/19] mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
Message-ID: <20200520103728.jtbslowdfrv3o5yz@ti.com>
References: <20200519142642.24131-1-p.yadav@ti.com>
 <20200519142642.24131-10-p.yadav@ti.com>
 <OF83616464.480FA751-ON4825856E.002A4483-4825856E.002BE6AF@mxic.com.tw>
 <20200520085534.yra4f5ww5xs23c4j@ti.com>
 <OF98344913.4BF4C313-ON4825856E.0032A810-4825856E.00352141@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OF98344913.4BF4C313-ON4825856E.0032A810-4825856E.00352141@mxic.com.tw>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20/05/20 05:40PM, masonccyang@mxic.com.tw wrote:
> 
> Hi Pratyush, 
>  
> > > > +/**
> > > > + * spi_nor_parse_profile1() - parse the xSPI Profile 1.0 table
> > > > + * @nor:      pointer to a 'struct spi_nor'
> > > > + * @param_header:   pointer to the 'struct sfdp_parameter_header' 
> > > describing
> > > > + *         the 4-Byte Address Instruction Table length and version.
> > > > + * @params:      pointer to the 'struct spi_nor_flash_parameter' to 
> be.
> > > > + *
> > > > + * Return: 0 on success, -errno otherwise.
> > > > + */
> > > > +static int spi_nor_parse_profile1(struct spi_nor *nor,
> > > > +              const struct sfdp_parameter_header *profile1_header,
> > > > +              struct spi_nor_flash_parameter *params)
> > > > +{
> > > > +   u32 *table, opcode, addr;
> > > > +   size_t len;
> > > > +   int ret, i;
> > > > +
> > > > +   len = profile1_header->length * sizeof(*table);
> > > > +   table = kmalloc(len, GFP_KERNEL);
> > > > +   if (!table)
> > > > +      return -ENOMEM;
> > > > +
> > > > +   addr = SFDP_PARAM_HEADER_PTP(profile1_header);
> > > > +   ret = spi_nor_read_sfdp(nor, addr, len, table);
> > > > +   if (ret)
> > > > +      goto out;
> > > > +
> > > > +   /* Fix endianness of the table DWORDs. */
> > > > +   for (i = 0; i < profile1_header->length; i++)
> > > > +      table[i] = le32_to_cpu(table[i]);
> > > > +
> > > > +   /* Get 8D-8D-8D fast read opcode and dummy cycles. */
> > > > +   opcode = FIELD_GET(PROFILE1_DWORD1_RD_FAST_CMD, table[0]);
> > > > +
> > > > +   /*
> > > > +    * Update the fast read settings. We set the default dummy 
> cycles to 
> > > 20
> > > > +    * here. Flashes can change this value if they need to when 
> enabling
> > > > +    * octal mode.
> > > > +    */
> > > > + spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
> > > > +              0, 20, opcode,
> > > > +              SNOR_PROTO_8_8_8_DTR);
> > > > +
> > > 
> > > 
> > > I thought we have a agreement that only do parse here, no other read 
> > > parameters setting.
> > 
> > Yes, and I considered it. But it didn't make much sense to me to 
> > introduce an extra member in struct spi_nor just to make this call in 
> > some other function later.
> > 
> > Why exactly do you think doing this here is bad? The way I see it, we 
> > avoid carrying around an extra member in spi_nor and this also allows 
> > flashes to change the read settings easily in a post-sfdp hook. The 
> > 4bait parsing function does something similar.
> 
> I think it's not a question for good or bad. 
> 
> 4bait parsing function parse the 4-Byte Address Instruction Table
> and set up read/pp parameters there for sure.
> 
> Here we give the function name spi_nor_parse_profile1() but also 

But the function that parses 4bait table is also called 
spi_nor_parse_4bait(). 

> do others setting that has nothing to do with it, 

Why has setting read opcode and dummy cycles got nothing to do with it? 
The purpose of the Profile 1.0 table is to tell us the Read Fast command 
and dummy cycles, among other things. I think it _does_ have something 
to do with it.

Just like the 4bait table tells us the 4-byte opcodes and we set them up 
in our data structures, the profile 1.0 table tells us the 8D read 
opcode and dummy cycles, and we set them up in our data structures.

> it seems not good for SW module design. 
> oh, it's my humble opinion.
> 
> > 
> > What are the benefits of doing it otherwise?
> 
> For other Octal Flash like mx25*

I mean from a design perspective. How does it make the code better, or 
the job of people who need to read/change it easier?

> > 
> > Note that I did remove HWCAPS selection from here, which did seem like a 
> 
> > sane idea.
> > 
> > > Driver should get dummy cycles used for various frequencies 
> > > from 4th and 5th DWORD of xSPI table.[1]
> > > 
> > > [1] 
> > > 
> https://patchwork.ozlabs.org/project/linux-mtd/patch/1587451187-6889-3-git-
> 
> > send-email-masonccyang@mxic.com.tw/ 
> > > 
> > > 
> > > In addition, 20 dummy cycles is for 200MHz but not for 100MHz, 133MHz 
> and 
> > > 166MHz
> > > in case of read performance concern.
> > > 
> > > Given a correct dummy cycles for a specific device. [2] 
> > > 
> > > [2] 
> > > 
> https://patchwork.ozlabs.org/project/linux-mtd/patch/1587451187-6889-5-git-
> 
> > send-email-masonccyang@mxic.com.tw/ 
> > 
> > The problem is that we don't know what speed the controller is driving 
> > the flash at, and whether it is using Data Strobe. BFPT tells us the 
> > maximum speed of the flash based on if Data Strobe is being used. The 
> > controller can also drive it slower than the maximum. And it can drive 
> > it with or without DS.
> 
> This is for flash, not every Octal flash could work in 200MHz,
> The Max operation speeds for other Octal Flash is 100, 133 , or 166MHz.
> 
> If a specific Octal Flash could work in 166MHz(Max), and driver setup the
> correct 16 dummy cycles for it rather than 20 dummy cycles.
> it's for performance concern.

Agreed. Like I mentioned in the next paragraph, will fix.
 
> > 
> > So, we have to be conservative and just use the dummy cycles for the 
> > maximum speed so we can at least make sure the flash works, albeit at 
> > slightly less efficiency. I hard-coded it to 20 but I suppose we can 
> > find it out from the Profile 1.0 table and use that (though we'd have to 
> 
> > round it to an even value to avoid tripping up controllers). Will fix in 
> 
> > next version (or, Tudor if you're fine with fixup! patches, I can send 
> > that too because I suspect it will be a small change).
> > 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
