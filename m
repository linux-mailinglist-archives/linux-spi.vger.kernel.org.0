Return-Path: <linux-spi+bounces-9590-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7ADB30E7E
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 08:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6CDAC03DE
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 06:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BA22135AD;
	Fri, 22 Aug 2025 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iXk0uX+a"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F920B80D;
	Fri, 22 Aug 2025 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842768; cv=none; b=DCSNf8pHYhDssqRCOgSWKj4emgd+KI5pOajJJRDNnB5gUVhoOJ0gXw8uj2qFYosYK4BDVjnFrXOvwzs636GUtJBAbZ2YFSrHtIOSUMHz4qAUH5plkKR+IX4cJSfZgoXajqHQRpzBmoJbBK7AMgOz9KKoUi4HYRyTAEttqWWZEI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842768; c=relaxed/simple;
	bh=avaUdtd8uIq7wFou8OzSkuIra5wtAQyyi9R4rOMTRDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t/flaZQ4xZc9eiNxkqfRwZTVCjSlNLMtqfe+WvFxc38BOC0FAjg+hd4LdbzWxRemuRawlM9Ihg4xhEa01VNijkZHn2cjRqX4y6bq89gCLnoYJ+u3b7hutzx/Oai6oAJ3ITR5ObA3X0uexlQzF5lniC1AHlLbWXxX1zyppXWNcRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iXk0uX+a; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57M65cf9183015;
	Fri, 22 Aug 2025 01:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755842738;
	bh=nEe6gWDkfZ9f0+KLOCH9wNiWwtvjebZTmJiRwDqdgs0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=iXk0uX+aWiYJwGCDH9zEt0Oz43gHcXph91uQsqo1F6mIGvVfWpkzEXXpuLMfhFGEl
	 aV9JcJ5w0gAYw3fq0o9TrQuNmAozmvvbp9wNZEkx3raX5mkbX+XcD7Bc2Rsg3qWYK5
	 h+YCZeJQuy/qAVa+Dq9qhwZvmamLsxWIoilRuAo4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57M65cY72495184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 01:05:38 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 01:05:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 01:05:37 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57M65XPJ3071881;
	Fri, 22 Aug 2025 01:05:34 -0500
Message-ID: <59c49efa-20b9-4d81-b66e-e9a363322274@ti.com>
Date: Fri, 22 Aug 2025 11:35:32 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
To: Mark Brown <broonie@kernel.org>
CC: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <p-mantena@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <a-dutta@ti.com>, <u-kumar1@ti.com>, <praneeth@ti.com>, <s-k6@ti.com>
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com>
 <6c35baad-a332-4b0a-96ca-1cdb3840ad94@sirena.org.uk>
 <20487e7f-33dd-4b65-b1a8-5bb8a06ef859@ti.com>
 <2f051eae-61c7-4bff-9f85-cf37b02a7ea3@sirena.org.uk>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <2f051eae-61c7-4bff-9f85-cf37b02a7ea3@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 14/08/25 18:04, Mark Brown wrote:
> On Thu, Aug 14, 2025 at 05:04:33PM +0530, Santhosh Kumar K wrote:
>> On 14/08/25 01:56, Mark Brown wrote:
> 
>>> Should we have something that blocks these tuning required modes without
>>> the appropriate tuning, and/or allows discovery of which modes require
>>> this tuning?  This all feels very landmineish - client drivers just have
>>> to know when tuning is required.
> 
>> The flash's maximum operating frequency determines whether PHY tuning is
>> required, as we need tuning in case of Cadence controller for frequencies
>> over 50 MHz.
> 
> That's entirely specific to the Candence controller from the sounds of
> it, that makes it hard to write a client driver if you need to know
> exactly what the controller you're dealing with is and what it's
> requirements are.

PHY tuning is not very specific to the Cadence controller; this has been 
added for other controllers as well. [1] - [3]

spi_mem simply verifies the execute_tuning hook within the controller's 
mem_ops and invokes it if it exists, and the tuning implementation is 
entirely controller-dependent - ranging from straightforward parameter 
configuration of PHY registers to advanced tuning algorithms such as the 
one implemented in this tuning series.

Currently, spi_mem_execute_tuning() is called by default from flash. In 
the future, this could be improved by asking the controller if tuning is 
actually needed (considering different factors such as frequency), 
similar to *_get_tuning_params implementation. Let me know your opinion 
in this.

The get_tuning_params and execute_tuning hooks in spi_mem can also be 
utilized by any non-MTD spi-mem users.

> 
>> And we do check for this condition - see Patch 07/10,
>> cqspi_phy_op_eligible_sdr(), which currently verifies the flash frequency
>> against 166 MHz. This logic can be improved by implementing both min and max
>> frequency checks, will update in the following version.
> 
> I can't actually tell how that verifies if the tuning has been done
> appropriately TBH, at least not without more effort than I'd care to

The *_execute_tuning function takes the read_op as an argument from 
flash, and considering flash continues to utilize the same read_op and 
frequency, it should make sure the tuning is appropriately completed. In 
the Cadence controller, the tuning process is validated by performing a 
read-back of a pre-defined tuning pattern using the read_op provided by 
flash.

> (and the tuning only gets added in patch 10?).

Patches 7 and 8 add PHY read/write support, and patch 9 adds tuning. 
These three patches could be squashed into one, but kept them separate 
to make it more granular for the reviewers.

[1] https://lore.kernel.org/linux-spi/20220509175616.1089346-1-clg@kaod.org/
[2] https://lore.kernel.org/all/20230322090451.3179431-2-haibo.chen@nxp.com/
[3] 
https://lore.kernel.org/all/20241128174316.3209354-1-csokas.bence@prolan.hu/

