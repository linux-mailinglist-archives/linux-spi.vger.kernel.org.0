Return-Path: <linux-spi+bounces-6418-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41FA18165
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 16:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF0B1888F06
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 15:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7F31F2C57;
	Tue, 21 Jan 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ltTGjO+N"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76FC1F1505
	for <linux-spi@vger.kernel.org>; Tue, 21 Jan 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737474854; cv=none; b=Z7w2l9LttaXVwl9PMnlCcMkU0654iLQFP2/oqbV+houPJuwl9TbDvgt80EWt4Guxy0pJW3C3qwaVDDpVkYo3yqfGebwUiJ7GP1LVOyDdcqwHD7zW94WuiB1jWq9CWQ37WRYUzMb0vb61J0GrzlO8CIpd8eghXa0zOzehC7/VSgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737474854; c=relaxed/simple;
	bh=wBQC14Rt/PgkQysycXVr1cBMxuDlIaZjTmrTbSFTbzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCroylcoxkK48HNFgWiJWYod7O/vAblJzVV6w8Iodqmaf4DAsZ1ReBi1m+SE9fZzCbKmaXyWPHdKAxG0XJHyilrZvwtKfkPBe1qvWhScZQW9/e4PWAccKqO7qMT8YKdMDkGDgh9W3PKwAxGIuuAGqSwplG/jzcXXOwWHCbt4r5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ltTGjO+N; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f7cb52d-31a4-458c-9b81-b46bf56fd8a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737474836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZokMrKPeHOXql6MRfjxfjyRJSF/rWwkzlkixJHlCYg=;
	b=ltTGjO+NrkTZGtg6DDswxPOrt10T//WbFgRH7INoiGNS2JmVu/erqpzFMmavJFLS/1mbim
	3jk5NqepV0m767M+qKoffQOtGu4lzfGqM+Zjfp9i35l+HchGxpX9LXKAhtxnPajDBkPiyx
	2LClPhSaD2LptmXdKGcVazYE2C1MUXQ=
Date: Tue, 21 Jan 2025 10:53:53 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/7] spi: zynqmp-gqspi: Split the bus
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 Mark Brown <broonie@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
 <20250116232118.2694169-6-sean.anderson@linux.dev>
 <DM4PR12MB76932590B9A6BB1CC17AD67FDCE62@DM4PR12MB7693.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <DM4PR12MB76932590B9A6BB1CC17AD67FDCE62@DM4PR12MB7693.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/21/25 08:19, Mahapatra, Amit Kumar wrote:
> Hello Andreson,
> 
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Friday, January 17, 2025 4:51 AM
>> To: Mark Brown <broonie@kernel.org>; Simek, Michal <michal.simek@amd.com>;
>> linux-spi@vger.kernel.org
>> Cc: Jinjie Ruan <ruanjinjie@huawei.com>; linux-arm-kernel@lists.infradead.org;
>> Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>; linux-
>> kernel@vger.kernel.org; Miquel Raynal <miquel.raynal@bootlin.com>; Sean
>> Anderson <sean.anderson@linux.dev>
>> Subject: [PATCH 5/7] spi: zynqmp-gqspi: Split the bus
>> 
>> This device supports two separate SPI busses: "lower" (SPI0) and "upper"
>> (SPI1). Each SPI bus has separate clock and data lines, as well as a hardware-
>> controlled chip select. The busses may be driven independently, with only one bus
>> active at a time, or in concert, with both busses active. If both busses are driven at
>> once, data may either be duplicated on each bus or striped (bitwise) across both
>> busses.
>> 
>> The current driver does not model this situation. It exposes one bus, where CS 0
>> uses the lower bus and the lower chip select, and CS 1 uses the upper bus and the
>> upper chip select. It is not possible to use the upper chip select with the lower bus
>> (or vice versa). GPIO chip selects are unsupported, and there would be no way to
>> specify which bus to use if they were.
>> 
>> To conserve pins, designers may wish to place multiple devices on a single SPI bus.
>> Add support for this by splitting the "merged" bus into an upper and lower bus. Each
>> bus uses a separate devicetree node and has a single native chipselect 0. If "lower"
> 
> IMHO, restricting users to fixed names is not ideal. A better approach would be to 
> introduce a Device Tree (DT) property for the bus number and select the bus 
> accordingly.

Why? It's not an artificial restriction; it reflects the hardware. And this is how
SPI busses are typically represented. If you have two SPI busses, there should be
two devicetree nodes.

--Sean


