Return-Path: <linux-spi+bounces-11038-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA79C36178
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 15:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA0424F2A7E
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9276630C60A;
	Wed,  5 Nov 2025 14:37:23 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3E2FD68F;
	Wed,  5 Nov 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353443; cv=none; b=ZKV6800ms4dyIaO0xZGVW7Z8W3j/bdmkjDAN6uEte50PkGLakPnd238Cqhk8AMjVnTaub629KAiv5ZykUimkNgOIFMvsTUTT5k4ovAuVBJuo9IZukVadha0Ja8LIK4MEubUFMHAXORJnKH39CKgKj0LSoUTelILat5qmM0OzdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353443; c=relaxed/simple;
	bh=kDx9NVbfjMqSRvUQnl70aXc8T7ee2IjayPBvPHh6Mbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/dRxFndxpk+Z9efdPsZBB6bX/Nf8MOWu/1ECJt5vbXEp0uav/RO+hH2H7f4WULRXmkMFXESaZmdQCo57Xacayb3MgX0H9luVhWdXvr3VfvCRWmqqBXt793SEAfG6vMeHAvYkxIVYmWG+f9qSk6Pz3Cy/T/9cBCQdXSCEDox8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5B22461E6484C;
	Wed, 05 Nov 2025 15:35:23 +0100 (CET)
Message-ID: <e16c3bd4-38c4-4c77-aa61-0affb40b0be2@molgen.mpg.de>
Date: Wed, 5 Nov 2025 15:35:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: aspeed: Use devm_iounmap() to unmap devm_ioremap()
 memory
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, clg@kaod.org,
 broonie@kernel.org, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lkp@intel.com
References: <20251105084952.1063489-1-chin-ting_kuo@aspeedtech.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251105084952.1063489-1-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Chin-Ting,


Thank you for your patch.

Am 05.11.25 um 09:49 schrieb Chin-Ting Kuo:
> The AHB IO memory for each chip select is mapped using
> devm_ioremap(), so it should be unmapped using devm_iounmap()
> to ensure proper device-managed resource cleanup.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510292356.JnTUBxCl-lkp@intel.com/
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>   drivers/spi/spi-aspeed-smc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index e8bd8fe6c4e7..179c47ffbfeb 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -396,7 +396,7 @@ static int aspeed_spi_set_window(struct aspeed_spi *aspi)
>   
>   	for (cs = 0; cs < aspi->data->max_cs; cs++) {
>   		if (aspi->chips[cs].ahb_base) {
> -			iounmap(aspi->chips[cs].ahb_base);
> +			devm_iounmap(dev, aspi->chips[cs].ahb_base);
>   			aspi->chips[cs].ahb_base = NULL;
>   		}
>   	}

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

