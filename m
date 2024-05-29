Return-Path: <linux-spi+bounces-3133-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BD68D4004
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 23:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F2E1C21F2B
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4F91C8FB0;
	Wed, 29 May 2024 21:04:34 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424051C8FB8
	for <linux-spi@vger.kernel.org>; Wed, 29 May 2024 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717016674; cv=none; b=mWXGry5f9+khZbXTSlsruHKpuL/j4OvtNY1NpBTRpQpq1OxAUmJgIcdUIqvfsFemAkxRCNX1XtgNXAPT4fv1i/FGWPLY0J2AS4enTyC5DTHHj+ZE4FaYmsHTOpkb+W0QA66Rph4Rl7lsmF8/QvgFFGUhIxxhWsFGiY3smhYS8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717016674; c=relaxed/simple;
	bh=QGN6nTaLRATuAanyY2JWCC/5zV4E2mNZXxlfOcaB6dE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjsuRhGEiZ9uz8+w6Q5tGpmNFEW3k9bIgwFVCteEvnBpBiLjCTFbE3Hw9NbxaEl7CwQhvqNbInEhcNbl5kPwDtc4/79oESMqNqRqhnKl9th5VkCY7Qxxx/bMBsIaEcwkcF0fY5qyQy+VOQdrmhB3nF6NveDShKuaIsuejXObn1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 0a7d1c25-1dff-11ef-8e2d-005056bdf889;
	Thu, 30 May 2024 00:04:30 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 30 May 2024 00:04:30 +0300
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, kernel@collabora.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Assign dummy scatterlist to unidirectional transfers
Message-ID: <ZleYXoesgdAboMoF@surfacebook.localdomain>
References: <20240529-dma-oops-dummy-v1-1-bb43aacfb11b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529-dma-oops-dummy-v1-1-bb43aacfb11b@collabora.com>

Wed, May 29, 2024 at 11:42:35AM -0400, Nícolas F. R. A. Prado kirjoitti:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Commit 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
> introduced a regression: unmapped data could now be passed to the DMA
> APIs, resulting in null pointer dereferences. Commit 9f788ba457b4 ("spi:
> Don't mark message DMA mapped when no transfer in it is") and commit
> da560097c056 ("spi: Check if transfer is mapped before calling DMA sync
> APIs") addressed the problem, but only partially. Unidirectional
> transactions will still result in null pointer dereference. To prevent
> that from happening, assign a dummy scatterlist when no data is mapped,
> so that the DMA API can be called and not result in a null pointer
> dereference.

I feel that with this the da560097c056 ("spi: Check if transfer is mapped
before calling DMA sync APIs") can be reverted as unneeded. Nícolas, can
you check that? If it works, we better revert the unneeded checks.

-- 
With Best Regards,
Andy Shevchenko



