Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C229D36EF69
	for <lists+linux-spi@lfdr.de>; Thu, 29 Apr 2021 20:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbhD2SUV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 14:20:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57176 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbhD2SUU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Apr 2021 14:20:20 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13TIJB2E064801;
        Thu, 29 Apr 2021 13:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619720351;
        bh=qn9kzRdRLypsLGuwsWHINLPGN27LGJ4D1oTG14gSrhQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XxMhfy7DhE9uwt78+5kErww92qqIjMvt17+diJMmsltgv+9LOtJwyenI4lwnJy9SL
         DBcZyt75V1rWchPr+n4ecd8EbenekLHTf8Qg1CY7jTIT9c2zbhAvCIxF2tIahtcjQ0
         2CGHGv6FbOa4ql+DcvCpP53SmH2zY5TTOYS9Wh9o=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13TIJBdB131020
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Apr 2021 13:19:11 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 29
 Apr 2021 13:19:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 29 Apr 2021 13:19:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13TIJAWs025236;
        Thu, 29 Apr 2021 13:19:11 -0500
Date:   Thu, 29 Apr 2021 23:49:10 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <Tudor.Ambarus@microchip.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 4/6] spi: cadence-qspi: Use PHY for DAC reads if
 possible
Message-ID: <20210429181908.bwb45eljn5nxscf6@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-5-p.yadav@ti.com>
 <2f26456e-59ff-2625-5d65-c1537052839d@microchip.com>
 <20210312101757.sqeyledbwjnpqdoy@ti.com>
 <ee2b753b16e76ecbede4c1373b6f2d77@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ee2b753b16e76ecbede4c1373b6f2d77@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 29/04/21 06:28PM, Michael Walle wrote:
> Am 2021-03-12 11:17, schrieb Pratyush Yadav:
> > On 12/03/21 09:13AM, Tudor.Ambarus@microchip.com wrote:
> > > On 3/11/21 9:12 PM, Pratyush Yadav wrote:
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > >
> > > > Check if a read is eligible for PHY and if it is, enable PHY and DQS.
> > > 
> > > DQS as in data strobe? Shouldn't the upper layer inform the QSPI
> > > controller
> > > whether DS is required or not?
> > 
> > Yes, DQS as in data strobe. I need to check this again, but IIRC the
> > controller cannot run in PHY mode unless DS is used. Ideally the upper
> > layer should indeed inform the controller whether DS is supported/in-use
> > or not. That can be used to decide whether PHY mode (and consequently
> > the DS line) is to be used or not.
> > 
> > Currently there are only two flashes that use 8D-8D-8D mode (S28HS512T
> > and MT35XU512ABA), and both of them drive the DS line.
> 
> The LS1028A datasheet explicitly states that the calibration is only
> used for non-DQS flashes. Which makes sense, because it just determine at
> which point the input data is sampled. And if the flash provides a data
> strobe, it already know when to sample it. What I am missing here?

If there was 0 delay in transferring the signals from flash to 
SoC/controller, you would be right. But in practice there is a small but 
noticeable delay from when the flash launches the signal and when it is 
received by the device. So by the time the DQS signal reaches the SoC it 
might already be too late and the data lines might not be valid any 
more. The calibration accounts for these (and some others) delays.

See [0] for a somewhat similar discussion I had with Tudor.

[0] https://lore.kernel.org/linux-mtd/20210312181447.dlecnw2oed7jtxe7@ti.com/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
