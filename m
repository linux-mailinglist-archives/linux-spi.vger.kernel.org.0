Return-Path: <linux-spi+bounces-9917-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E43B455B4
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 13:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A6C18942E8
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C1930EF77;
	Fri,  5 Sep 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y8/Nz5um"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C42C028F;
	Fri,  5 Sep 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070300; cv=none; b=BuMFTNr40ynMR45ZgPz+hR6GDGw3h0hy1sMPboa1JyFvgrGrpVhiz5bis0StKMTQh5k9krj3VzWfohY1S1Avi7dFbUQbQDkWDLPkJw7w0oFbR+QqsvZGxfPx7DROJrW0Y0bnnqRDIqzQ+hk5cjXbKoC5QCWTKceNExdlaCWZHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070300; c=relaxed/simple;
	bh=EpAWTnA0ZnhGgrRsfJ/hwLbEyGNGPdnqOjUA/fdzGV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W4LKTCa8fOnTlMRRkwRwe1FoIo52BsJpgEZiSEhxvR8AO2lFKP4mkhv1DiXQkzywWMl5VKvoNsHRDJip26xD1t/XT1s73GW1FapOrliuB+FlMACdhTtSxD9X8oND/xCiKwoqp/q9kcCZzGkgN5s8c6FvA3DAuL3fsQn0DH95Wa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y8/Nz5um; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585B4ggY3241033;
	Fri, 5 Sep 2025 06:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757070282;
	bh=8POGANUaGtk8l/kZY4KsjfjRvxgMxfmAgPnwN0aOE10=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=y8/Nz5umPHsWtDoSLToQwA959r73Ea1TItfSmRlMs8MTPFrzNIdW8ajgO5F9wVrCA
	 8Z9Nz5iWCPEG1+0J6Ke6ttkk3ZJvICBh4XpoCINhiLlc+SD9TNKOUXaX2a6a92tGlg
	 pYkBv4gXOpcMsDA4rL+wwhbxtiB/X4p7HOCqs2/Y=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585B4fcc846507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 06:04:42 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 06:04:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 06:04:41 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585B4blY345501;
	Fri, 5 Sep 2025 06:04:38 -0500
Message-ID: <8ea6162e-5154-48ec-9570-07a800c9235b@ti.com>
Date: Fri, 5 Sep 2025 16:34:36 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] spi: cadence-quadspi: Fix cqspi_setup_flash()
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        <miquel.raynal@bootlin.com>, <broonie@kernel.org>, <vigneshr@ti.com>,
        <marex@denx.de>, <computersforpeace@gmail.com>,
        <grmoore@opensource.altera.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <s-k6@ti.com>
References: <20250904133130.3105736-1-s-k6@ti.com>
 <20250904133130.3105736-4-s-k6@ti.com>
 <DCK4I00CCR4R.2K7P9IEDI0OA2@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <DCK4I00CCR4R.2K7P9IEDI0OA2@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Theo,

On 04/09/25 21:02, Théo Lebrun wrote:
> Hello Santhosh,
> 
> On Thu Sep 4, 2025 at 3:31 PM CEST, Santhosh Kumar K wrote:
>> The 'max_cs' stores the largest chip select number. It should only
>> be updated when the current 'cs' is greater than existing 'max_cs'. So,
>> fix the condition accordingly.
> 
> Good catch. Current code can only work with one chip-select.
> 
> Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> Maybe we should error out if we don't enter the loop, ie if we have no
> flash declared?
>   - Before your patch, cqspi->num_chipselect was set to num-cs DT prop or
>     CQSPI_MAX_CHIPSELECT as fallback.
>   - After your patch, cqspi->num_chipselect is set to one.
> 
> In neither case do we get an error if no flash is defined in DT.
> 
> We could either return some error code or set cqspi->num_chipselect=0
> which will lead to spi_register_controller() to fail [0].

Yeah, we can use max_cs for this. Initiate max_cs with -1, check if it's 
still negative after the loop part - if yes, then it didn't enter the 
loop as there was no flash declared - return failure. I'll add this 
logic in v2. Thanks!

Regards,
Santhosh.

> 
> [0]: https://elixir.bootlin.com/linux/v6.16.4/source/drivers/spi/spi.c#L3322-L3329
> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
> 


