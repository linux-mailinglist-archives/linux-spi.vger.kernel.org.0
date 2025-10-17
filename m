Return-Path: <linux-spi+bounces-10709-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412BCBE6B69
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 08:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485AD7419BF
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 06:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E71230F920;
	Fri, 17 Oct 2025 06:28:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C730F556;
	Fri, 17 Oct 2025 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682481; cv=none; b=FvU9As+aSKzXAg0TeKGIDupLZm1KD1KQM93p8pPn/xgqF1sHHTG2+EUDMGiRYR9BiD8X8bmvEmqA6GbGPdqyhHraLodrxVMZ4AfPeE+GM6inn3YcBPCKJmPNhfMuSsg1h6lQ1cK2ciLEmvBjLobZx4yiszxHzapLQTQrE0iB1hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682481; c=relaxed/simple;
	bh=NpTlKfY25LgjoVMMnZ26LO6Gn4v3gfw3kdZONyvEuyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkEXtdGKl+6x2iDturTZyQrP7iSyEu41vCRnbW8hlSEbUUZykByx6Rfiu847pcUYXVjvpcGVrNGHATgdFmiN/8bIy1jTQp7BXhGkl7MLCST97HqQ/EHLxd587c2+pOeR8JdhpkEjhM0z5Yw/OU6/52/t0LawG+EUXsn0sDRrIvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af782.dynamic.kabel-deutschland.de [95.90.247.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EA4F16028F341;
	Fri, 17 Oct 2025 08:26:57 +0200 (CEST)
Message-ID: <8fa346e3-308f-4ecb-af57-0fd643351765@molgen.mpg.de>
Date: Fri, 17 Oct 2025 08:26:56 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] spi: aspeed: fix spelling mistake "triming" ->
 "trimming"
To: Colin Ian King <coking@nvidia.com>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251016153000.9142-1-coking@nvidia.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251016153000.9142-1-coking@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Colin,


Thank you for the patch.

Am 16.10.25 um 17:30 schrieb Colin Ian King:
> There is a spelling mistake in a dev_warn message. Fix it.
> 
> Signed-off-by: Colin Ian King <coking@nvidia.com>
> ---
>   drivers/spi/spi-aspeed-smc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 0c3de371fd39..f3a7189afd51 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -539,7 +539,7 @@ static int aspeed_spi_trim_window_size(struct aspeed_spi *aspi)
>   	} while (total_sz > aspi->ahb_window_size);
>   
>   	if (trimmed) {
> -		dev_warn(aspi->dev, "Window size after triming:\n");
> +		dev_warn(aspi->dev, "Window size after trimming:\n");
>   		for (cs = 0; cs < aspi->data->max_cs; cs++) {
>   			dev_warn(aspi->dev, "CE%d: 0x%08x\n",
>   				 cs, chips[cs].ahb_window_size);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

