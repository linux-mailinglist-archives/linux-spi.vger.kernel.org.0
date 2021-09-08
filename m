Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A544038AB
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349207AbhIHLWo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:22:44 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32914 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351390AbhIHLWl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:22:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 188BLHtY004258;
        Wed, 8 Sep 2021 06:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631100077;
        bh=tQ/oRH0/DOAVAVT9DA6HnrABsHYorEoEFqH+SpdThGA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=VgIP4l5OdFTSp9xHKJ8kx0uOHSIhye0fvYqNqyPkwKfADE8bceIJ6f2YnXyzqTlyM
         7DvRhCha9ukSaAfD4gNffG8JbFWZw0DQjbL7sV3UjAnC/oBoeec7+kXjxWaGeK5KTV
         zWLcRR6F02bUlhoiFz7Lm0gqZggb5lEZnEJjMXEI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 188BLHwU121750
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Sep 2021 06:21:17 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Sep 2021 06:21:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Sep 2021 06:21:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 188BLGcW086516;
        Wed, 8 Sep 2021 06:21:17 -0500
Date:   Wed, 8 Sep 2021 16:51:15 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Message-ID: <20210908112113.smnwmayjb3jit3eg@ti.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499858-20456-1-git-send-email-pthombar@cadence.com>
 <20210903185653.7vrfn4qfzvuiaiq2@ti.com>
 <CY4PR07MB275737A008CBB58C4B108D2FC1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CY4PR07MB275737A008CBB58C4B108D2FC1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08/09/21 07:27AM, Parshuram Raju Thombare wrote:
> >Depends on SPI_MEM as well.
> 
> Ok
> 
> >I commented on this last time around as well. This does not look right
> >at all. A SPI MEM based driver should *not* need to know anything about
> >the subsystem driving it. That is the entire point of the API.
> >
> >The controller seems to be able to extract the read and write opcodes
> >from the SFDP on its own since you don't pass in that information to
> >cdns_xspi_nor_read(). It looks like it is tied very heavily to a NOR
> >flash, and I am not sure if it can really be used with a NAND flash, or
> >something else entirely.
> >
> >Which makes me wonder how we should handle controllers like these. I
> >don't think they fit in very well with the SPI MEM model, since they
> >can't execute arbitrary SPI MEM commands very well. At the same time we
> >are trying to get rid of mtd/spi-nor/controllers. Dunno...
> >
> >Mark, Tudor, Vignesh, any ideas?
> 
> Ok, then for now I will drop ACMD PIO mode and use only STIG mode.
> In STIG mode driver configures bus width and clock edge mode for
> command, address and data for each operation. 

But it would reduce performance by a lot, no? I think we should try to 
figure out how we can accomodate controllers like this before resorting 
to using the slower modes.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
