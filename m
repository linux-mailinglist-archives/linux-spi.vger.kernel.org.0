Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87EB1BF807
	for <lists+linux-spi@lfdr.de>; Thu, 30 Apr 2020 14:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725280AbgD3MSG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Apr 2020 08:18:06 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54772 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgD3MSF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Apr 2020 08:18:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03UCHfEm094635;
        Thu, 30 Apr 2020 07:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588249061;
        bh=2760Yo1AKc3mP3fvGFHPMjiwBzw8xIguNCDLvnnh1ms=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Fba1VIoUSzAO9O42yqqZqnx8s6p68o3IbJPWB7DQ7+oM1uWdB4owDcI1J5tZiyXBE
         XdmsYQZF38oDYcRdVkv5335936BRJ+D0wl7UsWhzIzVZTbDPi21mxjhn2WxH/zec39
         GH6wnA1J8G80tKugvOqd7CNHci5UV5GfdWMtzVgw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03UCHeMZ126557
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Apr 2020 07:17:40 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Apr 2020 07:17:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Apr 2020 07:17:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03UCHdgn101368;
        Thu, 30 Apr 2020 07:17:40 -0500
Date:   Thu, 30 Apr 2020 17:47:39 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 02/16] spi: atmel-quadspi: reject DTR ops
Message-ID: <20200430121737.37dghomlluzqcxxi@ti.com>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <20200424184410.8578-3-p.yadav@ti.com>
 <20200430113243.GB4633@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200430113243.GB4633@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 30/04/20 12:32PM, Mark Brown wrote:
> On Sat, Apr 25, 2020 at 12:13:56AM +0530, Pratyush Yadav wrote:
> 
> > Double Transfer Rate (DTR) ops are added in spi-mem. But this controller
> > doesn't support DTR transactions. Since we don't use the default
> > supports_op(), which rejects all DTR ops, do that explicitly in our
> > supports_op().
> 
> It's not ideal that we'd need to explicitly add checks in individual
> controller drivers - are we sure that all the others do?

Most other controllers either don't specify a supports_op function at 
all, in which case spi_mem_default_supports_op() is called, or do their 
custom logic and then call spi_mem_default_supports_op(). In both those 
cases, DTR ops would get rejected because of the call to 
spi_mem_default_supports_op(). So they do not need to add the check 
explicitly there.

The two exceptions are atmel-quadspi and spi-mtk-nor (which I missed 
updating). They don't call the default supports_op, so they need to be 
updated to explicitly to reject DTR ops.

Earlier versions of this series discovered the DTR capability from 
devicetree. In that case, no change would be required at all, but review 
comments suggested I drop those changes. Instead, the controllers should 
accept/reject DTR ops in their supports_op hooks.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
