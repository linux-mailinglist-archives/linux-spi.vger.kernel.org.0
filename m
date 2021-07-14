Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3227D3C8534
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 15:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbhGNNZJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 09:25:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57266 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhGNNZJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Jul 2021 09:25:09 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16EDMGXc038264;
        Wed, 14 Jul 2021 08:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626268936;
        bh=Kif3yVHVsP1HagVf7aotmktuL7VhKJnfgoj839DTBnE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=USuPLU+3d6yPSzbPyxnZ4ffVOIWP/sUATTmcBdUv3vaqVp2pF34o4yqN91JGPxm36
         GY8UkxA9AqNE8yEKW+gZNKQ6JjmIZF416j1JH3r0xOersiJCMrvWvaGbtMcCMkmTH2
         VBwNX14ch1o8JFwZslKJ89lTpHctLSyiFQRTodV4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16EDMGwd029918
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jul 2021 08:22:16 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 14
 Jul 2021 08:22:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 14 Jul 2021 08:22:16 -0500
Received: from [10.250.150.52] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16EDMDRj129461;
        Wed, 14 Jul 2021 08:22:14 -0500
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: Disable Auto-HW polling
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20210713125743.1540-1-a-nandan@ti.com>
 <20210713125743.1540-2-a-nandan@ti.com> <20210713182550.GG4098@sirena.org.uk>
From:   "Nandan, Apurva" <a-nandan@ti.com>
Message-ID: <f1947183-81d2-3519-d25f-71d93f59e434@ti.com>
Date:   Wed, 14 Jul 2021 18:52:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713182550.GG4098@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 13-Jul-21 11:55 PM, Mark Brown wrote:
> On Tue, Jul 13, 2021 at 12:57:41PM +0000, Apurva Nandan wrote:
> 
>> cadence-quadspi controller doesn't allow an address phase when
>> auto-polling the busy bit on the status register. Unlike SPI NOR
>> flashes, SPI NAND flashes do require the address of status register
>> when polling the busy bit using the read register operation. As
>> Auto-HW polling is enabled by default, cadence-quadspi returns a
>> timeout for every write operation after an indefinite amount of
>> polling on SPI NAND flashes.
> 
>> Disable Auto-HW polling completely as the spi-nor core, spinand core,
>> etc. take care of polling the busy bit on their own.
> 
> Would it not be better to only disable this on NAND rather than
> disabling it completely?
> 

I am not sure how it is possible currently in the controller, could you
please suggest a way? Also, should we have this logic of checking flash
device type in the cadence-quadspi controller? SPI controller should be
generic to all flash cores right?

In my opinion, it shouldn't harm as spi-nor core doesn't depend on HW
polling anyways and auto-HW polling is a minor overhead.

Regards,
Apurva Nandan
