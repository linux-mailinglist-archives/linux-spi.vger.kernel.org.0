Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4953C8A34
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhGNRy6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 13:54:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50116 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhGNRy6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Jul 2021 13:54:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16EHq5G6082091;
        Wed, 14 Jul 2021 12:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626285125;
        bh=JziqwQOA18s/BhyA6d+1O9yvyc7NI67Qf+66o6UqUpQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Rn8SOkQ9N8AwxZ0/ShnJqcNoW7Ma/wJjTO1MTND6MnlCU2mRBwjxBUNAEtUkmxtxb
         5Xr2TEl36nvRVnyYxecYMPO54JvqN0g1mDLQ9f024RAyxdQSQjUrpjUNH5RJ0t79jQ
         0zU6oePpTwLTuacacU9hqsg5YSeV12Fy9qYKyx2g=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16EHq5ts079532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jul 2021 12:52:05 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 14
 Jul 2021 12:52:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 14 Jul 2021 12:52:04 -0500
Received: from [10.250.234.142] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16EHq0es100061;
        Wed, 14 Jul 2021 12:52:01 -0500
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: Disable Auto-HW polling
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20210713125743.1540-1-a-nandan@ti.com>
 <20210713125743.1540-2-a-nandan@ti.com> <20210713182550.GG4098@sirena.org.uk>
 <f1947183-81d2-3519-d25f-71d93f59e434@ti.com>
 <20210714162805.GE4719@sirena.org.uk>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <dfa38823-b63f-1807-6141-682930de2f3a@ti.com>
Date:   Wed, 14 Jul 2021 23:21:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714162805.GE4719@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 14-Jul-21 9:58 PM, Mark Brown wrote:
> On Wed, Jul 14, 2021 at 06:52:12PM +0530, Nandan, Apurva wrote:
>> On 13-Jul-21 11:55 PM, Mark Brown wrote:
>>> On Tue, Jul 13, 2021 at 12:57:41PM +0000, Apurva Nandan wrote:
> 
>>>> cadence-quadspi controller doesn't allow an address phase when
>>>> auto-polling the busy bit on the status register. Unlike SPI NOR
> 
>>> Would it not be better to only disable this on NAND rather than
>>> disabling it completely?
> 
>> I am not sure how it is possible currently in the controller, could you
>> please suggest a way? Also, should we have this logic of checking flash
>> device type in the cadence-quadspi controller? SPI controller should be
>> generic to all flash cores right?
> 
> Surely the controller can tell if an address phase (or other unsupported
> feature) is present?
> 

Yeah sure, understood.

>> In my opinion, it shouldn't harm as spi-nor core doesn't depend on HW
>> polling anyways and auto-HW polling is a minor overhead.
> 
> Flash stuff seems to quite often end up happening when the system is
> heavily loaded for other reasons, it's much more of an issue with things
> that are done more with PIO but still seems useful to avoid having to
> poll in software, either it'll reduce CPU load or reduce latency and
> increase throughput.
> 

Yes, got the point. Will amend it.

Thanks,
Apurva Nandan
