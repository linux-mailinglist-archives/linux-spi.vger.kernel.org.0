Return-Path: <linux-spi+bounces-9412-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12592B26462
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 13:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A677B6F05
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3CD2BE63A;
	Thu, 14 Aug 2025 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iicrYriF"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF6A1A9F9D;
	Thu, 14 Aug 2025 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171300; cv=none; b=YcxAWxEDLSKLxRjTLBU4BIjUdrJs8w9hKxEQtz+JZSHPebs/BT+uIIzczkr1GP/xlUyR9uvghaiTbrm0+YeXgt3x4G7+Zc985tdDXqv5XdTKh7KxekScWMdNk6XQ5viVa/0s9BtJAVbLVkY8AvIgkMISLDsh7XIcfD4HZyVGYhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171300; c=relaxed/simple;
	bh=+qIU5841RvYEt8uMguyqbcYHK9dBC2sIctCw+Y6F39Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FFSHEm9ukE6QE0K3ZmWC1IirpmC1R+v5FYmItMRQpxe5Eqs67KMG0YYmE3BV1erlvcLJVeZgGoBIj0QzL9vycpnSR29jG3ttX2pKtNo2/G3ErnLUgefHybm+8SivhGP8/jZHqyfTtEK1zoOD2IicORuQbNv/xDB8pYlPxC8PbtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iicrYriF; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EBYdtT1922781;
	Thu, 14 Aug 2025 06:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755171279;
	bh=7LbU+yv2+Y6jnYq61nIb7SKpWsz0Z9nUrQStSnTQjvg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=iicrYriFr/xt9We9t8/o/L9I1Wxtp+0cnkPfNnoE9Jgh3U33Uhcu0k6a3pWYfE/Y4
	 eiDza8w56ia5wKHqjjk4IeNZHmP8hhLjj9p9AXK0ew2EpB4/642IRTPkJz4mcIFvwZ
	 X+K+6OaD17VSnvwbZDPu9MQ52FO8rfEuFQASjBv4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EBYdEl1118411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 06:34:39 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 06:34:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 06:34:38 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EBYY1g3540111;
	Thu, 14 Aug 2025 06:34:34 -0500
Message-ID: <20487e7f-33dd-4b65-b1a8-5bb8a06ef859@ti.com>
Date: Thu, 14 Aug 2025 17:04:33 +0530
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
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <6c35baad-a332-4b0a-96ca-1cdb3840ad94@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Mark,

On 14/08/25 01:56, Mark Brown wrote:
> On Tue, Aug 12, 2025 at 01:02:10AM +0530, Santhosh Kumar K wrote:
>> From: Pratyush Yadav <pratyush@kernel.org>
>>
>> Some controllers like the Cadence OSPI controller need to perform a
>> tuning sequence to operate at high data rates. Tuning is needs to happen
>> once the device is switched to appropriate mode (say 8S-8S-8S or
>> 8D-8D-8D). Add a hook that spi-mem client devices can call in order to tune
>> the controller to operate in a given mode and data rate.
>>
>> This is somewhat similar to eMMC/SD tuning for higher speed modes like
>> HS200, but there isn't a standard specification around the same though.
> 
> Should we have something that blocks these tuning required modes without
> the appropriate tuning, and/or allows discovery of which modes require
> this tuning?  This all feels very landmineish - client drivers just have
> to know when tuning is required.

The flash's maximum operating frequency determines whether PHY tuning is 
required, as we need tuning in case of Cadence controller for 
frequencies over 50 MHz.

And we do check for this condition - see Patch 07/10,
cqspi_phy_op_eligible_sdr(), which currently verifies the flash 
frequency against 166 MHz. This logic can be improved by implementing 
both min and max frequency checks, will update in the following version.

Thanks,
Santhosh.


