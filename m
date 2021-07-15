Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3A3CA23F
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 18:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhGOQau (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 12:30:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50078 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhGOQat (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Jul 2021 12:30:49 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16FGRtvi097106;
        Thu, 15 Jul 2021 11:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626366475;
        bh=yqdDGVMZGZw7Dd8p/1raa8mEn1N+JmX9OWjoB0Uc0II=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=QCtBQmnTIC3Rw9sJqGO8Uyd151LXCGeJr9rIXcEI+5D/pdEhEIQdIaWVpF0zev2wt
         hvecoqFk4BpB4SpgpWef9t86enTVHNVwnDEtoHJ6bksiQyu7rfoQ7VWnD/i5JwdXB1
         DjYyICgBPTnvL0flYwRP0bTSAainLZezktOvFdBw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16FGRt3g018620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jul 2021 11:27:55 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Jul 2021 11:27:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 15 Jul 2021 11:27:54 -0500
Received: from [10.250.234.142] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16FGRqtD053964;
        Thu, 15 Jul 2021 11:27:53 -0500
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: Disable Auto-HW polling
From:   Apurva Nandan <a-nandan@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20210713125743.1540-1-a-nandan@ti.com>
 <20210713125743.1540-2-a-nandan@ti.com> <20210713182550.GG4098@sirena.org.uk>
 <f1947183-81d2-3519-d25f-71d93f59e434@ti.com>
 <20210714162805.GE4719@sirena.org.uk>
 <dfa38823-b63f-1807-6141-682930de2f3a@ti.com>
Message-ID: <1cebc261-e0aa-572a-8083-1e3ec0d09195@ti.com>
Date:   Thu, 15 Jul 2021 21:57:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <dfa38823-b63f-1807-6141-682930de2f3a@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 14-Jul-21 11:21 PM, Apurva Nandan wrote:
> 
> 
> On 14-Jul-21 9:58 PM, Mark Brown wrote:
>> On Wed, Jul 14, 2021 at 06:52:12PM +0530, Nandan, Apurva wrote:
>>> On 13-Jul-21 11:55 PM, Mark Brown wrote:
>>>> On Tue, Jul 13, 2021 at 12:57:41PM +0000, Apurva Nandan wrote:
>>
>>>>> cadence-quadspi controller doesn't allow an address phase when
>>>>> auto-polling the busy bit on the status register. Unlike SPI NOR
>>
>>>> Would it not be better to only disable this on NAND rather than
>>>> disabling it completely?
>>
>>> I am not sure how it is possible currently in the controller, could you
>>> please suggest a way? Also, should we have this logic of checking flash
>>> device type in the cadence-quadspi controller? SPI controller should be
>>> generic to all flash cores right?
>>
>> Surely the controller can tell if an address phase (or other unsupported
>> feature) is present?
>>
> 
> Yeah sure, understood.
> 

There are issues in this, I noticed it when tried to implement.

So, the controller driver can't tell if an address phase is present, as
it is just dealing with write page/reg operation and auto HW poll
operation (whose address phase we are concerned with) isn't visible to
it (as it is running solely on hardware).

Now, whether the poll instruction should have an address phase or not
depends on the connected flash chip, which the controller wouldn't be
aware of as it only takes in a spimem op from the flash cores for execution.

Hence, it can't disable auto HW polling by checking the the address
phase and passing any flag information for this from flash cores would
be inappropriate.

More to this, not just address phase but any kind of variation in the
read register operation would result in polling failure.

Suppose, SPI-NOR flash is in QuadSPI/QPI mode, should the controller
send poll instruction in 4s-4s-4s, 1s-4s-4s, or 1s-1s-1s mode? Some
flashes keep it in 1s-1s-1s mode others keep it in 4s-4s-4s i.e it
varies. For example, Winbond W25Q256FV SPI-NOR requires 4s-4s-4s read
reg op when in QPI mode but it requires 1s-1s-1s read reg op when using
QuadSPI instead of QPI mode. There can be other variations as well e.g.
Gigadevice GD25LB256E requires 8 "don't care" bytes after command phase
in QPI mode above 140MHz.

Any SPI operation that is going underneath the visibility of flash core
can can problems. I agree offloading the status polling process to
controller HW is beneficial but on the other hand it restricts the flash
on having a fixed type of polling operation. This would reduce the
number of flash devices it will support (out of the box).
What should be the right way out for this situation?

>>> In my opinion, it shouldn't harm as spi-nor core doesn't depend on HW
>>> polling anyways and auto-HW polling is a minor overhead.
>>
>> Flash stuff seems to quite often end up happening when the system is
>> heavily loaded for other reasons, it's much more of an issue with things
>> that are done more with PIO but still seems useful to avoid having to
>> poll in software, either it'll reduce CPU load or reduce latency and
>> increase throughput.
>>
> 
> Yes, got the point. Will amend it.
> 
> Thanks,
> Apurva Nandan
> 

Thanks,
Apurva Nandan
