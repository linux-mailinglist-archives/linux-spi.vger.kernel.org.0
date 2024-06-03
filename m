Return-Path: <linux-spi+bounces-3205-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA738D8A76
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 21:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356791C2214F
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 19:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0691139D04;
	Mon,  3 Jun 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yKeDYqzn"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21020ED;
	Mon,  3 Jun 2024 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444151; cv=none; b=At1lxF4rDyu541txfux6P/C1aBYnH43r5+v/9TbouAi5aFL/b5+P3zupr2lYWtr2W3UzthY60RXwO9l31dewLfCvOli6I4N3sVb/T4rVtgQnvpxtX7R0MFzT/TB7pi99ZQ9ccnB2O762NQsdD5m168SukPZpvb7fkubOPBSE2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444151; c=relaxed/simple;
	bh=u+LtdUKeIquPtM3Gzq7t7e3fZ4iyQFikAJZQBux6nk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNTZVYd3ItNgcPTAKQr7zS79pzrDqe+mZ+em6DaaTYj2DW73OfYWux7JJ+gB8jjrLgzGJlTyamAGmftNy+0M2EfKTpWu1NjtYC/WsxDieZA+Tj1PEaoOjPSs+06kwhbw5FGNC/HicITayqhJhR/oQb+XLmT5wNdv4nffBN2iSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yKeDYqzn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717444148;
	bh=u+LtdUKeIquPtM3Gzq7t7e3fZ4iyQFikAJZQBux6nk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yKeDYqznxvMlnDjCxJ5nvSbpUHVOSiOzhSxfdZodzshS1XyCtvr2/mNnzmOl2VTqJ
	 s6bdjQYz6QiDp0PlUQ8zhJSN3+pc2X4U4vX1XzNTSacxJhxxAQ1eP+muwLboz/uqdG
	 mDdQDJLLiklJcdt2zmhtEAUTfzuxOwaDy77O7J6HgGQ109k6lAUBbX+f5ztj/0S/MS
	 HOHaWHihp2yZU+3riG0wuSzPi1z4s4LzEuw83cEC+j4H75LOsuVS8/h8T0edyAokC8
	 gCtlROFmbMUfE0fTeML5G3DptKY6VQKZbcn61iWuFvwnqqCy9DxwS22gPTku4IKPB8
	 KJiWYYzJDB0Hw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2FA1E3782192;
	Mon,  3 Jun 2024 19:49:06 +0000 (UTC)
Date: Mon, 3 Jun 2024 15:49:04 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thangaraj Samynathan <thangaraj.s@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Serge Semin <fancer.lancer@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 0/8] spi: Rework DMA mapped flag
Message-ID: <e9f6e8fe-7147-4caf-a7fc-e612069c2eaf@notapiano>
References: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531194723.1761567-1-andriy.shevchenko@linux.intel.com>

On Fri, May 31, 2024 at 10:42:32PM +0300, Andy Shevchenko wrote:
> The first part of the series (patches 1 to 7) is an introduction
> of a new helper followed by the user conversion.
> 
> This consolidates the same code and also makes patch 8 (last one)
> be localised to the SPI core part.
> 
> The last patch is the main rework to get rid of a recently introduced
> hack with a dummy SG list and move to the transfer-based DMA mapped
> flag. 
> 
> That said, the patches 1 to 7 may be applied right away since they
> have no functional change intended, while the last one needs more
> testing and reviewing.
> 
> Andy Shevchenko (8):
>   spi: Introduce internal spi_xfer_is_dma_mapped() helper
>   spi: dw: Use new spi_xfer_is_dma_mapped() helper
>   spi: ingenic: Use new spi_xfer_is_dma_mapped() helper
>   spi: omap2-mcspi: Use new spi_xfer_is_dma_mapped() helper
>   spi: pxa2xx: Use new spi_xfer_is_dma_mapped() helper
>   spi: pci1xxxx: Use new spi_xfer_is_dma_mapped() helper
>   spi: qup: Use new spi_xfer_is_dma_mapped() helper
>   spi: Rework per message DMA mapped flag to be per transfer

Tested on next-20240603. No issue noticed on sc7180-trogdor-kingoftown and
sc7180-trogdor-lazor-limozeen. So,

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Although patch 5 (pxa2xx) didn't apply, so I skipped it (but it's not used on
my platforms).

Thanks,
Nícolas

