Return-Path: <linux-spi+bounces-10188-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E06CB8CE4D
	for <lists+linux-spi@lfdr.de>; Sat, 20 Sep 2025 19:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1044E7ADD5D
	for <lists+linux-spi@lfdr.de>; Sat, 20 Sep 2025 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1242F0C5C;
	Sat, 20 Sep 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ON08U9Zv"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0815539A;
	Sat, 20 Sep 2025 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758390960; cv=none; b=mEgJ1G7CyZY0gxwPRScgz+jOfHVuRglLTe4V5cTdlS04KWdrDtWm2Pp5m0yRO16RgCGS6dY6ZBuyUdMSSUFkXV4lF4tRDfGDTLJs6CzwmjTp6T76VVy0N5LsabAtY/PtSrWoe+Y6qMSbTajtqZS9wb1M4RDfZ+ocnwL/g5V0RhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758390960; c=relaxed/simple;
	bh=hvsLPsaWGE3SSKTm5QeJKWjCIEloK0onEaDClNua8Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZcFpk5n/f8gPXFQBZTMMXtkNZ6u1ikd6S+rg0EfcV09Cosf0kvvNwJkgnOe/m2My3UFLalwnqgjNNGJ+02sBu8UejM0zRyE2YvTofwoOWKk1oOfAt3aigfrsf8ztARNSVkq/m6ZsYjjlv3KBsHAikEhblsPDlKt75zlNPKVENvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ON08U9Zv; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58KHtaJS451963;
	Sat, 20 Sep 2025 12:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758390936;
	bh=BsNE+Rm+oKuRjY6iHdZNAQBmBYyxgggjvzqX7HyUEoI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ON08U9ZvIobizkKCBtBe5WC+CstDEr6XTYVVONCv21GzgeO1bcz+k3+DlHFge2Qqk
	 L381ZSqjSE8ZdFYZi8DunmcSrZMODLMe1QZcuvLYA+02QIbL+zyaEZ+XOiKNk+HPOE
	 Gaspig6XJ6wWxOtF7G+OflWhmYiTDAF5rUkmawKk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58KHtarK4055058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 20 Sep 2025 12:55:36 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 20
 Sep 2025 12:55:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 20 Sep 2025 12:55:36 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58KHtVZH4111233;
	Sat, 20 Sep 2025 12:55:32 -0500
Message-ID: <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com>
Date: Sat, 20 Sep 2025 23:25:31 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <p-mantena@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <a-dutta@ti.com>, <u-kumar1@ti.com>, <praneeth@ti.com>, <s-k6@ti.com>
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87seguemzu.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

On 10/09/25 13:51, Miquel Raynal wrote:
> On 12/08/2025 at 01:02:10 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> From: Pratyush Yadav <pratyush@kernel.org>
>>
>> Some controllers like the Cadence OSPI controller need to perform a
>> tuning sequence to operate at high data rates. Tuning is needs to happen
>> once the device is switched to appropriate mode (say 8S-8S-8S or
>> 8D-8D-8D).

Apologies for the delay in response - I started prototyping new solution
based on our discussions earlier, which took some additional time.

> 
> This is actually wrong. Tuning is way more generic than that :)
> 
> If someone wants to use a chip at a high frequency (50MHz in your case,
> but whatever, there is a threshold above which additional care must be
> taken), it must go through the calibration step. It does not matter in
> which mode you are. Calibration would still be relevant in single SDR
> mode.
> 
> 
> This 50MHz bothered Mark because it is too Cadence specific. Maybe this
> should be a controller parameter? If the spi-mem core (or even the spi
> core, by extensino) sees that the design allows running at XMHz (due to
> the SPI peripheral properties or simply the absence of any limitation),
> and if the controller states that it requires an extra tuning step above
> YMHz (and X > Y), then it launches the calibration.
> 
>  From a core perspective, I would like the calibration hook to be as
> simple as possible, because what "calibration" means is highly
> controller and chip specific.

I understand the concern here.

Let me point out the options for launching the tuning procedure, along
with the issues in each approach.

Option 1: Launch tuning as part of spi_mem_exec_op()
    - After spi_mem_access_start(), introduce a spi_mem_needs_tuning()
check (a new callback to SPI MEM controller) to check whether the
current op requires tuning
    - If yes, we call spi_mem_execute_tuning()
         - on success, mark tuning complete in a flag within SPI MEM
Controller private data
         - on failure, we attempt a fallback by calling
spi_mem_adjust_op_freq() and drop to a lower supported frequency

Option 2: Launch tuning within spi_controller->exec_op() implementation
    - Very similar to option 1, except that the spi_mem_execute_tuning()
is triggered from within the controller's exec_op() implementation
(no need for spi_mem_needs_tuning())

Drawbacks in option 1 and 2:
    - Tuning requires multiple reads of a known pattern, but the flash
may not always be in a state to allow read commands
    - No fallback on failures, can't make flash-specific adjustments in
case of a tuning failure
    - No access to write_op() to write known pattern temporarily to an
on-die cache. Pattern needs to be always burnt into the flash

    - Plus, in option 2 - we can't call spi_mem_adjust_op_freq()

While the need for tuning is dictated by Controller specific
characteristics the ops (and state of the chip) required to complete
tuning is under the control of spi-mem users (spi-nand/spi-nor).
So, it's impossible to achieve tuning without the help of spi-mem users.

So, Option 3: Launch from SPI MEM clients
                           (mtd/nand/spi or mtd/spi-nor, etc.,)
    - Once the spi-mem chip is completely enumerated and best read and
write ops are chosen call spi_mem_needs_tuning(read_op, write_op) as
a part of .probe()
    - If tuning is required, call
spi_mem_execute_tuning(read_op, write_op)
         - If only read_op is provided, it implies the tuning pattern is
pre-flashed to the partition
    - On tuning failure, retry by re-running spi_mem_needs_tuning() with
the second best set of ops (max throughput - 1)

With option 3, spi_mem users are limited to calling
spi_mem_needs_tuning() and spi_mem_execute_tuning(). Rest is hidden
within the controller drivers. If spi-mem users change read/write ops,
the above sequence can be re-issued.

The controller can store the read_op and write_op in case of a tuning
success and periodically re-run tuning, ensuring we always have valid
tuning parameters.

One concern with option 3 is that we may not be able to make use of
static data on certain flash as tuning patterns (like reading parameter
page or SFDP table for tuning instead of controller specific attack
patterns).

Please let me know your thoughts on which of these directions makes the
most sense.

Thanks,
Santhosh.


