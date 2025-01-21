Return-Path: <linux-spi+bounces-6420-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A14A181D8
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 17:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7C51881FAB
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BA51F4298;
	Tue, 21 Jan 2025 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iCT1BKHx"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8A5028C
	for <linux-spi@vger.kernel.org>; Tue, 21 Jan 2025 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737476236; cv=none; b=Nk2H4lX8mW+eth8/sLPxd5Ii0WjCeisenp8Vx8aAT96Oy/JjY6pG7GTzA560qJLJSrsMjKCLQvzu/EsCg7ve5RRllZ5EY3V4rOnd3oYFJxpVHYHPAgaPSdSOKWhaRecr6oLPnMzq3xjy1NQ7M0Nsv6JghWbMoBMosGqY+LHjm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737476236; c=relaxed/simple;
	bh=Dghs9siubkgtkaZ3i0SC7IvTxG8AoPnGvWCxTUvupNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouWi4AmFtSd56ob7Iqlyuc0NfRDOKPQA2z78RH9LomT1MQO8qE8hNNvGB2JEf13eSwyQ6sUfQjFo9GUMiDtUtiRnsqvCux2VLbnz+o32FMULoIXK/R9+YMM4sdC7YX4sRRHUIsmORHATD4cXU4fdTduL4sVDfbGXdy5Aod8SyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iCT1BKHx; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0ee72316-11e1-4930-8c49-92db8d148b8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737476226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pohg729KqjlON/Y3qVQcQ7ga5GWM9jcQEdryp7KPBOQ=;
	b=iCT1BKHxy6GTT5TGP9OPEs5MRsWamD58cdpjuWiozNK06H7Xhzzt6y+XTjQCUiKS2AQ5sI
	sJTZA4n/kv8Q4XFqDqdQK1BdSl+x8ND896elX4zKQGhQxhbTJ4l+j4xvEAiLKm9KFXOhkT
	WFwYDIsCzpvhLGkMqSqqh2ItH2plyB0=
Date: Tue, 21 Jan 2025 11:17:03 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/7] spi: zynqmp-gqspi: Split the bus
To: Mark Brown <broonie@kernel.org>
Cc: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
 <20250116232118.2694169-6-sean.anderson@linux.dev>
 <DM4PR12MB76932590B9A6BB1CC17AD67FDCE62@DM4PR12MB7693.namprd12.prod.outlook.com>
 <1f7cb52d-31a4-458c-9b81-b46bf56fd8a8@linux.dev>
 <f1310bb6-48ef-4bdf-a359-f34b0d849a4d@sirena.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <f1310bb6-48ef-4bdf-a359-f34b0d849a4d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/21/25 11:01, Mark Brown wrote:
> On Tue, Jan 21, 2025 at 10:53:53AM -0500, Sean Anderson wrote:
>> On 1/21/25 08:19, Mahapatra, Amit Kumar wrote:
> 
>> > IMHO, restricting users to fixed names is not ideal. A better approach would be to 
>> > introduce a Device Tree (DT) property for the bus number and select the bus 
>> > accordingly.
> 
>> Why? It's not an artificial restriction; it reflects the hardware. And this is how
>> SPI busses are typically represented. If you have two SPI busses, there should be
>> two devicetree nodes.
> 
> Perhaps the thing is more that the buses are named instead of numbered?

Well, we could number them, but it's not like they have different
addresses in memory. They use all the same registers except for a bit in
the genfifo. So it doesn't make sense to do address translation (e.g.
with reg/ranges).

As for the names, these are the names used by the documentation, as well
as the exising driver. There are some references to SPI0/SPI1, but there
are more to upper/lower. If you want to bikeshed spi-0/spi-1 instead of
spi-lower/spi-upper, be my guest.

--Sean

