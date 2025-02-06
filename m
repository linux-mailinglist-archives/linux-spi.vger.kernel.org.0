Return-Path: <linux-spi+bounces-6638-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7F2A2A341
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 09:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951023A2227
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F2A224B05;
	Thu,  6 Feb 2025 08:36:11 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3610421CFE8;
	Thu,  6 Feb 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830971; cv=none; b=JftMYRjl3ceuV2tZDo8M35HmYnX5SlQNvSpxjEXXZCT71h3Pw70U/w6qIkHdLHtkZf9NzcoR9n+jqSJtQgEcZ6oCsQTi2n7AwjZDFzPNW8muYBn7lWBXOInuEnh71nrNLgZxdovr2bL4CdAt0lAV6xwlVOixvAN8kytHKKQb8C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830971; c=relaxed/simple;
	bh=WyJziOCrYNiJVEcvVqZdVq6DD7WSAOUr4Lx0YbijaGQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z8EDDSpDsPoXO3g6cA29h2q5DERYzD78hnjpWxptQx/L5vphRVjBEIFDCeFMPr1bxw5OudfnI/Gx8GNUfOUCLHQ6/9Gr8d5IkIhdxRdIzep7UPFw8tAGHnEeoepw8KCkd3qgDuuQthy571Eb+rT0Pe/Z1jhn5lSqvZ2tMLV0ZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 06 Feb 2025 17:36:08 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 4A4B8200705C;
	Thu,  6 Feb 2025 17:36:08 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 6 Feb 2025 17:36:08 +0900
Received: from [192.168.1.141] (unknown [10.213.44.71])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id E910FAB188;
	Thu,  6 Feb 2025 17:36:07 +0900 (JST)
Message-ID: <e606acef-adff-4e19-beb0-b587f8c269c6@socionext.com>
Date: Thu, 6 Feb 2025 17:36:07 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: sn-f-ospi: Fix division by zero
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250206082717.3833004-1-hayashi.kunihiko@socionext.com>
Content-Language: en-US
In-Reply-To: <20250206082717.3833004-1-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/06 17:27, Kunihiko Hayashi wrote:
> When there is no dummy cycle in the spi-nor commands, both dummy bus cycle
> bytes and width are zero. Because of the cpu's warning when divided by
> zero, the warning should be avoided. Return just zero to avoid such
> calculations.
> 
> Fixes: 1b74dd64c861 ("spi: Add Socionext F_OSPI SPI flash controller
> driver")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>   drivers/spi/spi-sn-f-ospi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
> index adac645732fe..56ef114effc9 100644
> --- a/drivers/spi/spi-sn-f-ospi.c
> +++ b/drivers/spi/spi-sn-f-ospi.c
> @@ -116,6 +116,9 @@ struct f_ospi {
>   
>   static u32 f_ospi_get_dummy_cycle(const struct spi_mem_op *op)
>   {
> +	if (!op->dummy.nbytes)
> +		return 0;
> +
>   	return (op->dummy.nbytes * 8) / op->dummy.buswidth;
>   }
>   

Sorry, I missed a tag. I'll resend the patch.

Thank you,

---
Best Regards
Kunihiko Hayashi

