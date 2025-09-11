Return-Path: <linux-spi+bounces-9982-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B756BB528AE
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 08:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63FC7AEFE4
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 06:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2918258ED8;
	Thu, 11 Sep 2025 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jr18M6bk"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CE11CBA;
	Thu, 11 Sep 2025 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572047; cv=none; b=d1Uvv5Hs4j8s5WxF5bhCiTDW24V+Yh2BQVp+wVo+2Kt/UURjsq0FR7pQ8C4PKdwprYtiKqGuLvDUQMC9nkRujE8FAMonv17FSyoPdFDykjfbFX54GmrH09pkWs0m0EKkq0oalfjPZqLjeo6TZm3wsi/ZjY8ItobNS9LaVv4BoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572047; c=relaxed/simple;
	bh=EUvYqGDiJLGmIwW1ylFx+Hel2HdePd43zUQeNp8WenY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bsCyR0MDemVrfd3tmhHdwlGVvpiCzb1i+qBhVJoZlEx1uIR8zUUQE+0A2i0KHmeO9+yKaVeY+MGKq4T+q6T4dr7vfYcwxAgzBGuf347YDPPtQsO/jF0RkS9qneFMdemN8ltUoyaa97fc0CPMb8n+ajamcNrpM7r4ya8vk6nMHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jr18M6bk; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58B6RBpI686260;
	Thu, 11 Sep 2025 01:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757572031;
	bh=pynGki2wuhAp/x5o6nU8x3fWXbJe9s1R84Vuq3q03wQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Jr18M6bkjXJa/7VWlDecx5vJX78aoEdqz2z1VC9rWBqQBDo7e5j54wIj3EU64raSm
	 8Lk00DpMgrtD+lQ9VW6apgwCjlphSScm1N2zBpIb7DGy5WvKbBBbeD8X2rT74JGXrU
	 a6CMIazA47lkEHVHCN/Aj8F5UH21F4OZHxsiUwuc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58B6RBKB859708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 01:27:11 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 01:27:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 01:27:10 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58B6R6jr1691109;
	Thu, 11 Sep 2025 01:27:07 -0500
Message-ID: <96bc8718-8902-4f2e-be96-1cd5e19a6355@ti.com>
Date: Thu, 11 Sep 2025 11:57:05 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Miscellaneous fixes and clean-ups
To: <miquel.raynal@bootlin.com>, <broonie@kernel.org>, <vigneshr@ti.com>,
        <marex@denx.de>, <computersforpeace@gmail.com>,
        <theo.lebrun@bootlin.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <s-k6@ti.com>
References: <20250905185958.3575037-1-s-k6@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20250905185958.3575037-1-s-k6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

On 06/09/25 00:29, Santhosh Kumar K wrote:
> This series introduces some small but important fixes and cleanups in
> the Cadence QSPI Controller.
> 
> Changes in v2:
>   - Use max_t() instead of if case
>   - Add a logic to return failure if there are no flash device declared.
>   - Convert all the open coded bit shifts to BIT() macro
>   - Link to v1: https://lore.kernel.org/linux-spi/20250904133130.3105736-1-s-k6@ti.com/T/#m2a5b6024ae6f147615e54e12688d8ceb5acc6228
> 
> Tested on TI's AM62A SK and AM62P SK:
> Logs: https://gist.github.com/santhosh21/0d25767b58d9a1d9624f2c502dd8f36b
> 
> Signed-off-by: Santhosh Kumar K s-k6@ti.com

Gentle ping on this!

Regards,
Santhosh.

> 
> Pratyush Yadav (2):
>    spi: cadence-quadspi: Flush posted register writes before INDAC access
>    spi: cadence-quadspi: Flush posted register writes before DAC access
> 
> Santhosh Kumar K (1):
>    spi: cadence-quadspi: Fix cqspi_setup_flash()
> 
> Vignesh Raghavendra (1):
>    spi: cadence-quadspi: Use BIT() macros where possible
> 
>   drivers/spi/spi-cadence-quadspi.c | 34 +++++++++++++++++++------------
>   1 file changed, 21 insertions(+), 13 deletions(-)
> 


