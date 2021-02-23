Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A96D322D73
	for <lists+linux-spi@lfdr.de>; Tue, 23 Feb 2021 16:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhBWP0T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Feb 2021 10:26:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51360 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhBWP0S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Feb 2021 10:26:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11NFP8Qp114773;
        Tue, 23 Feb 2021 09:25:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614093908;
        bh=vJH/8KaeieGBdQA2joYS5Fbf1bvQAgysVSFnFpGe35k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=NMn1cKpxh8UIir/6S8Zf1tBXMgsTJCFMRZ4oSsRPgZHtjU4TeW/5ioIz6jXRGxi1A
         UPaqxC3qEQbCNcxf+blvgtADBEhn+3ogQ9SDX8Br4ap8yG7/QOpYm+7INj9rPs7qgC
         ZnhLLHCowmnmhpo6G384DeluDzY9GcXUYRlXF27E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11NFP89T083036
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Feb 2021 09:25:08 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 23
 Feb 2021 09:25:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 23 Feb 2021 09:25:08 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11NFP7n0061432;
        Tue, 23 Feb 2021 09:25:08 -0600
Date:   Tue, 23 Feb 2021 20:55:06 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        zhengxunli <zhengxunli@mxic.com.tw>, <vigneshr@ti.com>,
        <juliensu@mxic.com.tw>, <ycllin@mxic.com.tw>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
Message-ID: <20210223152504.jtq4uxfepz7bdxhl@ti.com>
References: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
 <1612517808-10010-2-git-send-email-zhengxunli@mxic.com.tw>
 <20210205104736.2771074c@xps13>
 <20210205133404.esqqeokhlp4askpq@ti.com>
 <20210223141344.7ad25831@xps13>
 <20210223133649.GD5116@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210223133649.GD5116@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 23/02/21 01:36PM, Mark Brown wrote:
> On Tue, Feb 23, 2021 at 02:13:44PM +0100, Miquel Raynal wrote:
> > Pratyush Yadav <p.yadav@ti.com> wrote on Fri, 5 Feb 2021 19:04:04 +0530:
> 
> > > [0] Since SPI NOR has no way of knowing what speed the controller is 
> > > running at, assume the fastest speed the flash can run at.
> 
> > Ok, I am not entirely clear about what is available/not available from
> > the SPI core.
> 
> > If this is true then I guess we can't do better with the current code
> > base and this can be improved in the future if needed. So I'm fine with
> > the current implementation.
> 
> For normal SPI operations you can set the speed (really, top speed) on a
> per transfer basis.

To select the optimal number of dummy cycles we need to know what speed 
the controller is running at, not the other way around. The flash would 
always set the top speed to its maximum (say 200 MHz). But if the 
controller is only capable of running at 50 MHz, you will end up wasting 
dummy cycles. I don't see any API to communicate speed from controller 
to flash.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
