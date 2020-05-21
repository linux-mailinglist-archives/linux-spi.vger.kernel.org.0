Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A8B1DC9B3
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 11:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgEUJPD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 05:15:03 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53910 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgEUJPC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 05:15:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04L9EdMR013665;
        Thu, 21 May 2020 04:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590052479;
        bh=6TWapEuxg8nAckEhBpE445YKmDj0TJ/xlqg6Fj94UN0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MaaiESZ6aMqcrpmJHO1mfIi6xcBPy89FLOWsTC7LaSKeRbpKblQVGffGtUkHPmsGz
         KtTJ6G2zE9wgGcvBYU37tyagCvHpizRCMMgOcroPyoWwWwrT8AucyU/I2e2Pw/IwO9
         c3yoOkpPkfW2mWbh18+Ej1+oCaJOw0jBQh2uczPA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04L9EdvO010693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 04:14:39 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 04:14:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 04:14:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04L9EcT0062434;
        Thu, 21 May 2020 04:14:39 -0500
Date:   Thu, 21 May 2020 14:44:36 +0530
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
Message-ID: <20200521091434.rigqlyuwszyyikj4@ti.com>
References: <20200519142642.24131-1-p.yadav@ti.com>
 <20200519142642.24131-10-p.yadav@ti.com>
 <OF83616464.480FA751-ON4825856E.002A4483-4825856E.002BE6AF@mxic.com.tw>
 <20200520085534.yra4f5ww5xs23c4j@ti.com>
 <OF98344913.4BF4C313-ON4825856E.0032A810-4825856E.00352141@mxic.com.tw>
 <20200520103728.jtbslowdfrv3o5yz@ti.com>
 <OFF5A6BA99.395182B5-ON4825856F.002B2F98-4825856F.002CD973@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OFF5A6BA99.395182B5-ON4825856F.002B2F98-4825856F.002CD973@mxic.com.tw>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 21/05/20 04:09PM, masonccyang@mxic.com.tw wrote:
> 
> Hi Pratyush, 
> 
> > > > > > +   /* Get 8D-8D-8D fast read opcode and dummy cycles. */
> > > > > > +   opcode = FIELD_GET(PROFILE1_DWORD1_RD_FAST_CMD, table[0]);
> > > > > > +
> > > > > > +   /*
> > > > > > +    * Update the fast read settings. We set the default dummy 
> > > cycles to 
> > > > > 20
> > > > > > +    * here. Flashes can change this value if they need to when 
> > > enabling
> > > > > > +    * octal mode.
> > > > > > +    */
> > > > > > + 
> spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
> > > > > > +              0, 20, opcode,
> > > > > > +              SNOR_PROTO_8_8_8_DTR);
> > > > > > +
> > > > > 
> > > > > 
> > > > > I thought we have a agreement that only do parse here, no other 
> read 
> > > > > parameters setting.
> > > > 
> > > > Yes, and I considered it. But it didn't make much sense to me to 
> > > > introduce an extra member in struct spi_nor just to make this call 
> in 
> > > > some other function later.
> > > > 
> > > > Why exactly do you think doing this here is bad? The way I see it, 
> we 
> > > > avoid carrying around an extra member in spi_nor and this also 
> allows 
> > > > flashes to change the read settings easily in a post-sfdp hook. The 
> > > > 4bait parsing function does something similar.
> > > 
> > > I think it's not a question for good or bad. 
> > > 
> > > 4bait parsing function parse the 4-Byte Address Instruction Table
> > > and set up read/pp parameters there for sure.
> > > 
> > > Here we give the function name spi_nor_parse_profile1() but also 
> > 
> > But the function that parses 4bait table is also called 
> > spi_nor_parse_4bait(). 
> > 
> > > do others setting that has nothing to do with it, 
> > 
> > Why has setting read opcode and dummy cycles got nothing to do with it? 
> > The purpose of the Profile 1.0 table is to tell us the Read Fast 
> > command and dummy cycles, among other things. I think it _does_ have 
> > something to do with it.
> 
> As you know I mean this function just do parse parameter of profile 1 
> table
> and keep these value data for later usage.
> 
> A device supports xSPI profile table could work in either 8S-8S-8S or 
> 8D-8D-8D mode.
> It seems to setup these parameters somewhere out here is betters.

As far as I know, the Profile 1.0 table only describes 8D-8D-8D mode. I 
see no mention of 8S-8S-8S in JESD251 or JESD216D.01. No field in the 
table describes anything related to 8S. In fact, searching for "8S" in 
the JESD251 spec yields 0 results. 

Anyway, you should set up 8S parameters in SNOR_CMD_READ_8_8_8, not 
SNOR_CMD_READ_8_8_8_DTR. 8D configuration is independent of 8S 
configuration.

PS: If you have any more comments, please send them now. The merge 
window is getting close, and I'd like to see this make it in.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
