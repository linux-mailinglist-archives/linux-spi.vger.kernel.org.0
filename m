Return-Path: <linux-spi+bounces-9275-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AE7B1A530
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 16:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4198C189FD04
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 14:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B332AEE1;
	Mon,  4 Aug 2025 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPA1wPSs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13141CF96
	for <linux-spi@vger.kernel.org>; Mon,  4 Aug 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318751; cv=none; b=p60YGn6TNfSM/yiYASLbP4el7F5FVZgOkv5xXZ8uI0jyuQfFRvs3vAQ2NGp9nQTrLkPw1THhDpLfsudqFOgOo7guPLyU4CtgY8LK/5KShpTJjPxk6/Mwujw4SY0pebpYFaD44dZgD6e6zNTBMr1URTbxRbiPeqFKavKRbwfBwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318751; c=relaxed/simple;
	bh=dwEq30ziGgIruEqeTWeroZquDpTLXH1I7TzORUqkt7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ok+p2+GOGpt6FYLQyceADcYJ+0KsGRjmozkzv8/CPnNaOrdoIsHJYTr4aXwlgZ2nfkexlGzX/btOFkbk7yhfQ4SwC3zvP1riXO6VjV9oCGezbEiU5x/DSNKK+PXV8a55yEQQhuHVBlBuq10Ecymo0ILPE5VcQ9I7NFivy//klFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPA1wPSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6182C4CEE7;
	Mon,  4 Aug 2025 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754318750;
	bh=dwEq30ziGgIruEqeTWeroZquDpTLXH1I7TzORUqkt7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GPA1wPSsoFmg+e6fCSviUUN8pYv9XYYDESDtHvhEeBwH5gbCFBKnUXMPOxTz7ld+1
	 /GEQVdHCx80Df/27K820seo/rCvb0GdpXAw5aQd+HetwW1P9je1cxbdE9pcgqEEynY
	 314Du2BFQeESZJjVo59QLXUi4LMGAayh+FePje2fRHd98M+bSKyoAnEyjsiJscJImT
	 b9aPVvStc9fDdj/QuK6p+GlDNwcSxys98aSTUEODg/Spk4bLs9mHUrhOzIGAwLjW/E
	 9/61wPygIYBZgENVa23I3p3PyTsU/yzgGwKimxZHHDnGrcI6jRGL0VboXQKI/eqtAg
	 jOo4CuQvOPm8A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>,  <linux-spi@vger.kernel.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <michael@walle.cc>,
  <linux-mtd@lists.infradead.org>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: spi-mem: Add missing kdoc argument
In-Reply-To: <20250804095013.409700-1-miquel.raynal@bootlin.com>
References: <20250804095013.409700-1-miquel.raynal@bootlin.com>
Date: Mon, 04 Aug 2025 16:45:47 +0200
Message-ID: <mafs0ms8fcfhg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 04 2025, Miquel Raynal wrote:

> The "*mem" pointer has been added without description, describe it in
> the kdoc comment in order to fix the following W=1 warning:

Hmm, this warning does not show up for me with W=1, but does with W=2. I
am running:

   make drivers/spi/spi-mem.o LLVM=1 ARCH=arm W=1

Am I doing something wrong? I usually test with W=1 for SPI NOR patches
to make sure no new warnings are added.

Anyway,

Acked-by: Pratyush Yadav <pratyush@kernel.org>

>
> Warning: drivers/spi/spi-mem.c:594 function parameter 'mem' not
> described in 'spi_mem_calc_op_duration'
>
> Fixes: a11a51896572 ("spi: spi-mem: Take into account the actual maximum frequency")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507310409.fnuQ21qb-lkp@intel.com/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-mem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index d3b7e857b377..841b0995c8ea 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -577,6 +577,7 @@ EXPORT_SYMBOL_GPL(spi_mem_adjust_op_freq);
>   * spi_mem_calc_op_duration() - Derives the theoretical length (in ns) of an
>   *			        operation. This helps finding the best variant
>   *			        among a list of possible choices.
> + * @mem: the SPI memory
>   * @op: the operation to benchmark
>   *
>   * Some chips have per-op frequency limitations, PCBs usually have their own

-- 
Regards,
Pratyush Yadav

