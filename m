Return-Path: <linux-spi+bounces-10936-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D850FC25D7D
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 16:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5B33BC942
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86372D3A75;
	Fri, 31 Oct 2025 15:32:15 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA72D190C;
	Fri, 31 Oct 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924735; cv=none; b=m59lKX6m7+bRgKUvRmmyeVhT45JfkOAnwWjQgpbf+x/wy00eNBr6BN4JtxFOC2B3EqZlfSfdF14OMTGAttmW65m6VP8G4sEMo44I+Fl8goxL822q7I1hpAw/TDrNHqmZ7PuvC286U9ao0f8ihMon9BNA1Ixl5T5LZWKy9/HvuTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924735; c=relaxed/simple;
	bh=WcgFF4PkKNvA0xUIOYiPTH3prKFPwpV8G0/bf8Qb3+8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bry8EPGNha5haXNgL2V/bMOBevr8J3yrTWfsk4RCYPQh9YekRUeIAS0LNC5XSnxt4UFY/f1W8X6hhUQUEDRYQ78rUpnIQN8jmRvGen3NhfEKbxHX/+Mlxq8dO/JfjHLi1m7GIPqNTVuS8tLDic3eWbsmPjEeCJVoDwxgcrfEvJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cylHN0BWLz6M4GQ;
	Fri, 31 Oct 2025 23:28:16 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id EDAE41402F2;
	Fri, 31 Oct 2025 23:32:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 31 Oct
 2025 15:32:09 +0000
Date: Fri, 31 Oct 2025 15:32:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Devyn Liu <liudingyuan@h-partners.com>
CC: <shenyang39@huawei.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kangfenglong@huawei.com>, <liuyonglong@huawei.com>,
	<lujunhua7@h-partners.com>, <yubowen8@huawei.com>, <liudingyuan@huawei.com>
Subject: Re: [PATCH] spi: hisi-kunpeng: Fixed the wrong debugfs node name in
 hisi_spi debugfs initialization
Message-ID: <20251031153207.000031ee@huawei.com>
In-Reply-To: <20251024063133.3796584-1-liudingyuan@h-partners.com>
References: <20251024063133.3796584-1-liudingyuan@h-partners.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 24 Oct 2025 14:31:33 +0800
Devyn Liu <liudingyuan@h-partners.com> wrote:

> In hisi_spi_debugfs_init, spi controller pointer is calculated by
> container_of macro, and the member is hs->dev. But the host pointer cannot
> be calculated offset directly by this, because hs->dev points to the
> device in platform device(pdev->dev), and it is the host->dev.parent
> points to the pdev->dev, which is set in __spi_alloc_controller.
> 
> In this patch, this issues is fixed by getting the spi_controller data
> from pdev->dev->driver_data directly, driver_data points to the spi
> controller data in the probe stage.
> 
> Signed-off-by: Devyn Liu <liudingyuan@h-partners.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/spi/spi-hisi-kunpeng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
> index dadf558dd9c0..7458a4bc0856 100644
> --- a/drivers/spi/spi-hisi-kunpeng.c
> +++ b/drivers/spi/spi-hisi-kunpeng.c
> @@ -164,7 +164,7 @@ static int hisi_spi_debugfs_init(struct hisi_spi *hs)
>  
>  	struct spi_controller *host;
>  
> -	host = container_of(hs->dev, struct spi_controller, dev);
> +	host = hs->dev->driver_data;
>  	snprintf(name, 32, "hisi_spi%d", host->bus_num);
>  	hs->debugfs = debugfs_create_dir(name, NULL);
>  	if (IS_ERR(hs->debugfs))


