Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC81378ABD
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 14:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhEJLwC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 07:52:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49466 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242091AbhEJLko (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 May 2021 07:40:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14ABdArH113218;
        Mon, 10 May 2021 06:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620646750;
        bh=gETgHZ5jeRjeZNAOjDn4ZoH956iUzOSYPpFRThSr55s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YLb3ty6YRg1lTSLxEUEmqXIFE6B7Mi6GAvx9n+KagbEscefDpAX2SejoVRBi83+LB
         ihjZBx95kWB8SBdLKqTHTdRv9BU92+zCYjog5eu0Wu6RvDZVYvJ/5ONNN0yY5j35me
         H+rHgF7FFQAx4XNMZyIDy6o3l8iqJr68iOWt0zow=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14ABdAAU119001
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 06:39:10 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 06:39:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 06:39:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14ABd98E061711;
        Mon, 10 May 2021 06:39:10 -0500
Date:   Mon, 10 May 2021 17:09:09 +0530
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
Message-ID: <20210510113907.75mkhuby74yoinkp@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-5-p.yadav@ti.com>
 <2f26456e-59ff-2625-5d65-c1537052839d@microchip.com>
 <20210312101757.sqeyledbwjnpqdoy@ti.com>
 <ee2b753b16e76ecbede4c1373b6f2d77@walle.cc>
 <20210429181908.bwb45eljn5nxscf6@ti.com>
 <e17722c30deb7f2dcb94a9aa43bbc6dd@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e17722c30deb7f2dcb94a9aa43bbc6dd@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 30/04/21 12:20AM, Michael Walle wrote:
> Am 2021-04-29 20:19, schrieb Pratyush Yadav:
> > On 29/04/21 06:28PM, Michael Walle wrote:
> > > Am 2021-03-12 11:17, schrieb Pratyush Yadav:
> > > > On 12/03/21 09:13AM, Tudor.Ambarus@microchip.com wrote:
> > > > > On 3/11/21 9:12 PM, Pratyush Yadav wrote:
> > > > > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > > > >
> > > > > > Check if a read is eligible for PHY and if it is, enable PHY and DQS.
> > > > >
> > > > > DQS as in data strobe? Shouldn't the upper layer inform the QSPI
> > > > > controller
> > > > > whether DS is required or not?
> > > >
> > > > Yes, DQS as in data strobe. I need to check this again, but IIRC the
> > > > controller cannot run in PHY mode unless DS is used. Ideally the upper
> > > > layer should indeed inform the controller whether DS is supported/in-use
> > > > or not. That can be used to decide whether PHY mode (and consequently
> > > > the DS line) is to be used or not.
> > > >
> > > > Currently there are only two flashes that use 8D-8D-8D mode (S28HS512T
> > > > and MT35XU512ABA), and both of them drive the DS line.
> > > 
> > > The LS1028A datasheet explicitly states that the calibration is only
> > > used for non-DQS flashes. Which makes sense, because it just
> > > determine at
> > > which point the input data is sampled. And if the flash provides a
> > > data
> > > strobe, it already know when to sample it. What I am missing here?
> > 
> > If there was 0 delay in transferring the signals from flash to
> > SoC/controller, you would be right. But in practice there is a small but
> > noticeable delay from when the flash launches the signal and when it is
> > received by the device. So by the time the DQS signal reaches the SoC it
> > might already be too late and the data lines might not be valid any
> > more. The calibration accounts for these (and some others) delays.
> 
> DQS and the data signals are trace length matched, so for data reads
> they will end up on the IO pad of the SoC at the same time. This is
> also mentioned in [1] (Fig 1.1, point 4 and 5). So while there needs
> to be a delay on the clock line for the receiving FF, the best value
> for this should be half the SCK clock period.

In the explanation below Figure 1-1, I see:

  The DQS and data are edge aligned at points 4 and 5 in Figure 1-1. DQS 
  must be delayed by the RX PDL to a point inside the data eye to sample 
  valid data at point 2.

So the RX delay is being used to tune exactly when to sample the data 
lines. From what I understand, the delay is not set to SCK / 4 because 
this delay might change with temperature. This calibration algorithm has 
been designed to be reslilent to temperature changes so it performs some 
other heuristics to find the ideal delay for the DQS. Plus, part of the 
delay comes from the time taken by the controller to sample the data. 
The algorithm takes care of that delay as well.

To be completely honest, I'm not very well versed with the internal 
details of the calibration. I only have a high level view of it. I hope 
my explanation was clear enough. If not, I can spend some more time to 
understand how the internals of the controller work and get a clearer 
understanding of what is going on in the background.

> 
> Does this work without DQS? That should be the main purpose for a
> calibration, no? Because in this case, you'll have to determine
> the delay between SCK and the data signals (for reads).

It should, but I have not tested it without DQS.

> 
> Btw. I can't get my head around how the TX delay search would work.
> Basically you shift the SCK to the command / data to the flash. So
> the flash will either recognize a valid read command or if the delay
> is too short/too long the flash will (hopefully) ignore the wrong
> command, correct? Might there be any misinterpreted commands which
> might be harmful? Are there any flashes which actually need a delay
> between data out and SCK?

Yes, it is possible to send an invalid read command. Section 2.1 says:

  TX min and max (side walls of the passing region) are formed by the 
  setup and hold time requirement of the OSPI device. TX delays outside 
  this range cause command and address bytes to be latched incorrectly 
  by the OSPI device, resulting in an unsuccessful read.

Currently, the TX limits are hard coded such that this does not happen 
for the two flashes I have tested with: Micron MT35 and Cypress S28. If 
later the need comes up such that the limits are not enough to encompass 
all the flashes we need to support, I can look into setting the limits 
via device tree.

> 
> Of course, the calibration might help with broken hardware where the
> SCK/DQ/DQS traces are not length matched.
> 
> -michael
> 
> > 
> > See [0] for a somewhat similar discussion I had with Tudor.
> > 
> > [0]
> > https://lore.kernel.org/linux-mtd/20210312181447.dlecnw2oed7jtxe7@ti.com/
> 
> [1] https://www.ti.com/lit/an/spract2/spract2.pdf

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
