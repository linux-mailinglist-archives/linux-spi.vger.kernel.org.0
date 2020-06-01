Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BFD1E9EE0
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jun 2020 09:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgFAHIF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jun 2020 03:08:05 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55012 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgFAHIE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jun 2020 03:08:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05177vKN045270;
        Mon, 1 Jun 2020 02:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590995277;
        bh=HujvC9+RO9ZJaECM24aGaK8D8JBb+/kqNVtAgxq9pPk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=l55CFcoKJdXDqmzmZVtq7ZhWprtMMwoVo9BWlss94YxE0W86YSb1BhWbk29trdCxC
         aEzLmuauiBuyrfDEAJsK5fRsYbUSTG6WSVjg61evXUl07ybSEAlxdHet1DadubUAo0
         D+V/6/Yuuv79zH17So/H2EupzTZ67lRtzA0Anr90=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05177vM0089087
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jun 2020 02:07:57 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Jun
 2020 02:07:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Jun 2020 02:07:57 -0500
Received: from [10.250.234.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05177rAQ015505;
        Mon, 1 Jun 2020 02:07:54 -0500
Subject: Re: [PATCH v3 8/8] spi: Move cadence-quadspi driver to drivers/spi/
To:     <Tudor.Ambarus@microchip.com>, <broonie@kernel.org>
CC:     <bbrezillon@kernel.org>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
References: <20200601054725.2060-1-vigneshr@ti.com>
 <20200601054725.2060-9-vigneshr@ti.com> <2051214.IORyQiarUF@192.168.0.120>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <2af92a25-02a7-0441-636c-d2853873f4c2@ti.com>
Date:   Mon, 1 Jun 2020 12:37:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2051214.IORyQiarUF@192.168.0.120>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 01/06/20 12:30 pm, Tudor.Ambarus@microchip.com wrote:
> Hi, Mark,
> 
> On Monday, June 1, 2020 8:47:25 AM EEST Vignesh Raghavendra wrote:
>> From: Ramuthevar Vadivel Murugan
>> <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Now that cadence-quadspi has been converted to use spi-mem framework,
>> move it under drivers/spi/
>>
>> Update license header to match SPI subsystem style
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan
>> <vadivel.muruganx.ramuthevar@linux.intel.com> Signed-off-by: Vignesh
>> Raghavendra <vigneshr@ti.com>
>> ---
>>  drivers/mtd/spi-nor/controllers/Kconfig            | 11 -----------
>>  drivers/mtd/spi-nor/controllers/Makefile           |  1 -
>>  drivers/spi/Kconfig                                | 11 +++++++++++
>>  drivers/spi/Makefile                               |  1 +
>>  .../spi-cadence-quadspi.c}                         | 14 +++++++-------
>>  5 files changed, 19 insertions(+), 19 deletions(-)
>>  rename drivers/{mtd/spi-nor/controllers/cadence-quadspi.c =>
>> spi/spi-cadence-quadspi.c} (99%)
> 
> If this patch set looks good to you, would you take it through the SPI tree? 
> If so, I would need an immutable tag, so I can merge back in spi-nor/next in 
> order to fix a small conflict that will appear in drivers/mtd/spi-nor/
> controllers/Kconfig. Vignesh would have to respin this patch on top of v5.7-
> rc1. With this addressed:
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 


I have resent v3 on top of v5.7-rc1 (also applies cleanly on spi tree's
for-next branch):

https://lore.kernel.org/linux-spi/20200601070444.16923-1-vigneshr@ti.com/T/#t
