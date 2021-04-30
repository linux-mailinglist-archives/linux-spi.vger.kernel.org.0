Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDBD36F56B
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 07:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhD3FnM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Apr 2021 01:43:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42408 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhD3FnL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Apr 2021 01:43:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13U5gBwK061470;
        Fri, 30 Apr 2021 00:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619761331;
        bh=GU3XCSNVHhrz0byCodnolDUzfyAhgWLfmDqWa9yFTCg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CJERJ7+lqAer2TSuJFXKSmzB4hvQjvFFt2dY8TSUbuRRP/567f4w633Dh7oVe47FD
         KysV6VsxUAEiapzv5TvK/NVU/+WiCIhz1Sgpu8lL221tjf7fKsWEB3h2x8Sgm7ABVW
         gO1ViMcpyPiWgdH7TvlZ9wg9+sQorl75FpyZLx04=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13U5gBej116963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Apr 2021 00:42:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 30
 Apr 2021 00:42:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 30 Apr 2021 00:42:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13U5gAVf094450;
        Fri, 30 Apr 2021 00:42:10 -0500
Date:   Fri, 30 Apr 2021 11:12:09 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 5/6] spi: cadence-qspi: Tune PHY to allow running at
 higher frequencies
Message-ID: <20210430054207.gakq7evf47igzcm4@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-6-p.yadav@ti.com>
 <143b24c61109823f6e616cf91d28d16c@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <143b24c61109823f6e616cf91d28d16c@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 30/04/21 12:48AM, Michael Walle wrote:
> Am 2021-03-11 20:12, schrieb Pratyush Yadav:
> > +	if (of_property_read_u32(np, "cdns,phy-tx-start",
> > &f_pdata->phy_tx_start))
> > +		f_pdata->phy_tx_start = 16;
> > +
> > +	if (of_property_read_u32(np, "cdns,phy-tx-end", &f_pdata->phy_tx_end))
> > +		f_pdata->phy_tx_end = 48;
> > +
> 
> I didn't see a dt-bindings patch for these.

Right. Will add them in the next re-roll.
 
> -michael

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
