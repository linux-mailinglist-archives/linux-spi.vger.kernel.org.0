Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99163389DA
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 11:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhCLKSY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 05:18:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47534 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhCLKSL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 05:18:11 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12CAI0DD050060;
        Fri, 12 Mar 2021 04:18:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615544281;
        bh=MfHMI0fXR00zadLL4T1wsZcvbhBWRv7oQ2OBFrlNjNw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MXOcBS2aVAK1p98zHHFlckstB1IISDTdfsSWGLIlwWt7drpjXT+cJjlh4Ll4GY+2F
         bPTBW7zyv8AU8t3T/EnJg3Zscvo7XtLoCV/FcarOSY2n20oqPVIaC5yn297i5XdgWR
         BAbnrt0N6STmXSIJQLETiNiYX0y6PDq9PIMXSD8g=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12CAI0CB033573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Mar 2021 04:18:00 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 12
 Mar 2021 04:18:00 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 12 Mar 2021 04:18:00 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12CAHxaA123485;
        Fri, 12 Mar 2021 04:18:00 -0600
Date:   Fri, 12 Mar 2021 15:47:59 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 4/6] spi: cadence-qspi: Use PHY for DAC reads if
 possible
Message-ID: <20210312101757.sqeyledbwjnpqdoy@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-5-p.yadav@ti.com>
 <2f26456e-59ff-2625-5d65-c1537052839d@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f26456e-59ff-2625-5d65-c1537052839d@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/03/21 09:13AM, Tudor.Ambarus@microchip.com wrote:
> On 3/11/21 9:12 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Check if a read is eligible for PHY and if it is, enable PHY and DQS.
> 
> DQS as in data strobe? Shouldn't the upper layer inform the QSPI controller
> whether DS is required or not?

Yes, DQS as in data strobe. I need to check this again, but IIRC the 
controller cannot run in PHY mode unless DS is used. Ideally the upper 
layer should indeed inform the controller whether DS is supported/in-use 
or not. That can be used to decide whether PHY mode (and consequently 
the DS line) is to be used or not.

Currently there are only two flashes that use 8D-8D-8D mode (S28HS512T 
and MT35XU512ABA), and both of them drive the DS line.

> 
> > 
> > Since PHY reads only work at an address that is 16-byte aligned and of
> > size that is a multiple of 16 bytes, read the starting and ending
> > unaligned portions without PHY, and only enable PHY for the middle part.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/spi/spi-cadence-quadspi.c | 203 ++++++++++++++++++++++++++----
> >  1 file changed, 182 insertions(+), 21 deletions(-)
> > 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
