Return-Path: <linux-spi+bounces-10098-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F544B83640
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 09:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078224A7324
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 07:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03B2E9EBC;
	Thu, 18 Sep 2025 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="od6Z1jk8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1806275AF6;
	Thu, 18 Sep 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181714; cv=none; b=PnwZcvZXqZgoImSRZ8wjk/tPzyctHlx8dECb7MRxLOPY+oOCG9oeBmIEnwLMsjz0dui5TmRu9q8yRSatcDWKeCRmcHA+9ORPfIrKyg5emWNnuIPZIdXpPe58RNNHBpiZKoEwwcv/XI5JdOciariBHQCKDuk0cZWLFt/NWKqT2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181714; c=relaxed/simple;
	bh=9lfc2Fj1bMSccZGCtOqi1S+FUb+q5SAFOr7SmGz0T6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6iOqSd+zvAyeadvSgQ3d6avht95j1GGHYTvLIy1eyOGIKP7QgFhHoqPaV9Me6NbCJLzR+V+Wrti1atVkU3AkvNSAWmXYnuVNkG8yhyQQ2i4I+0pKIZnX/WFZBJOTLJT8ieoL1tr+bajw8ueQ6Dhs+yFD6a3Obg4D/Y+cSs4yVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=od6Z1jk8; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758181676;
	bh=yrjO2XRs5IM/Lr/k6cLIhIZx2sFkrnGAyhn5oP54jOw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=od6Z1jk8Xn79AXMZ45Wxxl3pva61PJ48oEMPepHgPGPhCjJ1f/03jYCbyNoUpxyEn
	 zb7iDIOeCye1q+VpZQN5pKYxaMvzn17a8c/EccO5ZM89G+oD8sWqAsW9gbeCoXhVw1
	 NVSXTVATDBVUo5reQ7aYlAKkf0aYF7ESTky7Q+n8=
X-QQ-mid: esmtpsz18t1758181670te2195bfb
X-QQ-Originating-IP: 2P3awJ/rAckBQ5WJim/2vC85B1eBTLxK95O56RQ2eV8=
Received: from = ( [120.239.196.247])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Sep 2025 15:47:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5320209065315358107
EX-QQ-RecipientCnt: 17
Date: Thu, 18 Sep 2025 15:47:47 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Alex Elder <elder@riscstar.com>, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, dlan@gentoo.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller
 driver
Message-ID: <4C1E339412373423+aMu5I4jmngaN0rOy@LT-Guozexi>
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917220724.288127-3-elder@riscstar.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MMnP0fEUKo/hCQaf9kAgAl6sqLKLFHdobLwPxGk8qaNcXQ+EWLyMmbjO
	YRIrJvAMlDyb7Lc9ZeLE2A2S7LXBuz96DfTJ5GpDmMh41lVMIUzkqGZtyFLZySeA6eoPYPR
	Yhg+EWEUP72djT9TEyKiXg4XusP3l9QbaopojBPCpRYrq8TtB9uEwwRqbBPUQCXQkQeJojr
	mp/qJNHdUz1PLKtkWPVJoVl+SvqFxc3P1uXMWwR3bZGxYerKsyfACSmQpdWWqEEHQ2GKnzp
	9pk3RsF/p2OGJ+lGRh/mwY7pXQOuysLtZ/rpKuNAUtFyFeNsSkgzy3xL3V8bOichOwkFTM3
	88mFJ8xKuti9ruvyrHEVmfofrV0a2kJTh3F/acdeQMm3nMQxcNPKLh8rEpawiZG5hF1dlcW
	2+DaWMtuQoGwFm1MNcoJI7NerZ+f9ydYk22xFcIT5zPz38Uy6/YHNEz68qDIZqsiLCoXMup
	VlmLzAIdfsQSy2PRrCqlQvembuV6DyqeGU21oqBaslDCeSfCla3fpvKsOfQMUbUgm3WerVr
	V6Dzv0dvhA5grBebWPb1zs0ZGSeOIhRRRqH4eZiDGUeWheO45O/BDBebJN7aC9DXjQMwwQs
	lI9ayNsTcCRODea/7XsaMoU9x3Fr4imaQBLbyr35eQypKoERCWoKZsU9Y/QoDm9P7BnVzjH
	FzjsKS/KThXl+nYprRcvKUor+P/RMq7fRImpgxwM52nZskgSeg+y4TxZuOWKrSd5EGI5Gja
	Kn8hyw1btsABfPytIvpEVKs/NlIm2ZwiPpz+F7dDnsOInpaJwqL3B5O/gDDVF/c97XBNqoP
	5v7Db0Y0AnNxTFGQYmRrqWV4n5ZXgzRN0ujGCwG05St9KwOs+yuHQFAo5IMGJGwC6qTj5Rm
	MATjXmKS2EYhKIx6DD8Xx0eFxaN9B1P4UfBglEFXjTWmx+Bfi5qob7469wQu3NfWCUcwtE9
	GuiQjvT3JDHGHxt2p85zdV2vpFeXnAeSt9K5MHq1xo4T1CvEovsrQ8j1IhAQwFd5vaGJ8Kd
	ntI0dZJe/YHSlH0fo1G/Ttm6iwCs9swnxFKgNqHJn4Z2ygzsMSMlgJd61ndAetb/MZcnVy8
	Xf6CCAxz0W4Cla3Erhjzto=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Wed, Sep 17, 2025 at 05:07:22PM -0500, Alex Elder wrote:
> This patch introduces the driver for the SPI controller found in the
> SpacemiT K1 SoC.  Currently the driver supports master mode only.
> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
> supports both PIO and DMA mode transfers.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/spi/Kconfig           |   8 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-spacemit-k1.c | 985 ++++++++++++++++++++++++++++++++++
>  3 files changed, 994 insertions(+)
>  create mode 100644 drivers/spi/spi-spacemit-k1.c
> 
> +static void k1_spi_remove(struct platform_device *pdev)
> +{
> +	struct k1_spi_driver_data *drv_data = platform_get_drvdata(pdev);
> +
> +	k1_spi_register_reset(drv_data, false);
> +}
> +
> +static struct platform_driver k1_spi_driver = {
> +	.driver = {
> +		.name	= "k1x-spi",
k1x? iis it from vendor driver? please keep k1-spi

                - Troy

> +		.of_match_table = k1_spi_dt_ids,
> +	},
> +	.probe = k1_spi_probe,
> +	.remove = k1_spi_remove,
> +};
> +
> +module_platform_driver(k1_spi_driver);
> +
> +MODULE_DESCRIPTION("SpacemiT K1 SPI controller driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.48.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

