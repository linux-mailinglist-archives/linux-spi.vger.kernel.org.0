Return-Path: <linux-spi+bounces-8887-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CBEAEDA0A
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 12:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD62188CD94
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 10:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BDE258CC1;
	Mon, 30 Jun 2025 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e7RfufcJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379725A2A5;
	Mon, 30 Jun 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280035; cv=none; b=i2eksSk5QZGpQIvk1RwPGaHdhmVReR8IJEzVbxJ/qYrNDpNDNt1i3/dNaZ6pBYcrCv9cahx/DmwRFnCXzQf1B7syl1cSqISpzC550Xv2KrdPzFYcSWpvjYVTgFH/UklDgypzZ8oKb8HRZkkCvhbc9tk28uW8lDdN3ohG5fcWiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280035; c=relaxed/simple;
	bh=3t3k7Ct3a0HRwaDOGed+FMIfYKuOY32Y2DX1uImXJSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=URDeCJKPnl+utj/7nCNUhar0Z00fqUkDd6TIIo5tSxzPllTB9b7xSN5rYtdfocsVKsoUmf8iiS2hAJ/Be4VHY5W76gOgYirq82kvyOzrfYKIWTclLrrAZXd9Th2mUnwv7qRoKr9HFD2Hu0EFoeva/KP27C+XA3+WwQaYI6seGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e7RfufcJ; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55UAeSM22595858;
	Mon, 30 Jun 2025 05:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751280028;
	bh=Or3Fb/WF8EJOLX3hfbXxuApssXPXU/JG/S4dM81jnbs=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=e7RfufcJ/YrCholWO71bIGFe2swBBPtYrdBAHh9Uag8WSD69ZH9FSSaU4WiD+y4Er
	 4J6szct9oFfmNo1La4D5KXIlsAieTOFb9Sj+VDGx9c/K++81ANtIt+HrM4yt+vCixd
	 vBq/fgmjZXtP0tV3XCtkk7Yx9VMDFxiktvtm/aEI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55UAeSFx1816172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 30 Jun 2025 05:40:28 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 30
 Jun 2025 05:40:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 30 Jun 2025 05:40:27 -0500
Received: from [172.24.227.241] (santhoshkumark.dhcp.ti.com [172.24.227.241])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55UAePCl3467470;
	Mon, 30 Jun 2025 05:40:26 -0500
Message-ID: <dc6a3c05-27cf-4e72-aacd-0d374610ae60@ti.com>
Date: Mon, 30 Jun 2025 16:10:24 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] spi: cadence-quadspi: fix cleanup of rx_chan on
 failure paths
To: <khairul.anuar.romli@altera.com>, Mark Brown <broonie@kernel.org>,
        "open
 list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@altera.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <cover.1751274389.git.khairul.anuar.romli@altera.com>
 <89765a2b94f047ded4f14babaefb7ef92ba07cb2.1751274389.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <89765a2b94f047ded4f14babaefb7ef92ba07cb2.1751274389.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Khairul,

On 30/06/25 14:41, khairul.anuar.romli@altera.com wrote:
> From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> 
> Remove incorrect checks on cqspi->rx_chan that cause driver breakage
> during failure cleanup. Ensure proper resource freeing on the success
> path when operating in cqspi->use_direct_mode, preventing leaks and
> improving stability.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

Please add 'Fixes' tag and add stable in cc.

Regards,
Santhosh.

> ---
>   drivers/spi/spi-cadence-quadspi.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index aa1932ba17cb..d3c78f59b22c 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1960,11 +1960,6 @@ static int cqspi_probe(struct platform_device *pdev)
>   
>   	pm_runtime_enable(dev);
>   
> -	if (cqspi->rx_chan) {
> -		dma_release_channel(cqspi->rx_chan);
> -		goto probe_setup_failed;
> -	}
> -
>   	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
>   	pm_runtime_use_autosuspend(dev);
>   	pm_runtime_get_noresume(dev);

