Return-Path: <linux-spi+bounces-2115-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF028921F1
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 17:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A1AB230CE
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280A42C6B2;
	Fri, 29 Mar 2024 16:49:58 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32BA92E
	for <linux-spi@vger.kernel.org>; Fri, 29 Mar 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730998; cv=none; b=kLQ+diFhSDYgg2vV5PfsJ87efsuITV+ydtGRSPv/JRjmgeyXH+5cUfEzvMB+zobSlWdTyIgivuCcsSz1i4ci0W9zj2I0nuXPs/MkzUs1/m41zbLt4ktQIqLr4HQrFII3p95DbXCQlBEM3TNWSm5uD5gZ8aCAIHy8LMv52xCbSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730998; c=relaxed/simple;
	bh=5C20/ZKHXuSQJ16k3wCbs2KBoQaCmtX6xMsYneOWEdE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7OcQJtI9MYLPVFcMav3eVIs141Z5Zf4EBIdu5Y9NGiOC7jMy++x6H2ZBDm+hL0ZokknI0EZSscmpOPQ1MPdH4ZbSa5h1oGVg3RT7xsok9j1hWPW3UgNtFzOEkKLEXOJJczgXzWgZmhBHFNo6d6zlOkO9VuXwp3dZo7bzBhVHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 5da4657b-edec-11ee-b972-005056bdfda7;
	Fri, 29 Mar 2024 18:49:53 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Mar 2024 18:49:53 +0200
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] spi: more tx_buf/rx_buf removal
Message-ID: <ZgbxMUF3wWdRBKqB@surfacebook.localdomain>
References: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>

Thu, Mar 28, 2024 at 03:51:44PM -0500, David Lechner kirjoitti:
> I found a couple more controller drivers that were checking if the
> tx_buf and rx_buf fields in the spi_transfer structure were set by a
> peripheral driver that I missed in [1]. These checks can be removed
> as well.

He-he,
84a6be7db9050 ("mmc: mmc_spi: remove custom DMA mapped buffers").

> [1]: https://lore.kernel.org/linux-spi/20240325-spi-remove-is_dma_mapped-v2-1-d08d62b61f1c@baylibre.com/

-- 
With Best Regards,
Andy Shevchenko



