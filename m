Return-Path: <linux-spi+bounces-10974-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B2EC2B414
	for <lists+linux-spi@lfdr.de>; Mon, 03 Nov 2025 12:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D8414E93B0
	for <lists+linux-spi@lfdr.de>; Mon,  3 Nov 2025 11:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6072FF670;
	Mon,  3 Nov 2025 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WgzFPnB+"
X-Original-To: linux-spi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73EC2F066D;
	Mon,  3 Nov 2025 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168190; cv=none; b=eRejXuif9a8KUR5o9qqDXHQAClZUCjbPPCMVtTFyOYTTVCdxgJQaiNv7octg5oL/ZDGSS+Jhw8/S1SCySL48HbxmumC20RFdw5ZUoShrrrMlCDlO3Fi0Du35HREevFWHMBz6Y1jBDqtLifFq03SPpaEOITAGnY/21vjitB9NfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168190; c=relaxed/simple;
	bh=MP8TOWK4yIX/QXjp+Fdcbw8KhrM8NDGkI0ouaBR7Z4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D3hx0uaFNc0c8fctdXJqHq+5MAUVnA4W8ok7l6UeFreQM7esGf1vjSeVztPCfg8E3YbsL9aSf5pKrUxzFY0cdyVFCC17cR9XKZC9t/Tak6OADUETt5zmTVzs99tBo/3WBiMo4CYFiimNRoduCKT+w+YnZeZHOTkBHRG1hKF0k/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WgzFPnB+; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jP2bDeY5asMtLQPSuORi5v1PdXadst8YVGwHrH0xpZQ=;
	b=WgzFPnB+5j7YnIPWfRRrFcOsg5PL7UkZxQkThiGbD6L/0PGyp0npT09yLNVDWh924qLEoz08K
	6sJsjtw8SSyx2UpeYBE+OyQe/hul/BOMm+hbCk/DwpAokcGAHDtmSWd6FSPMALwvQHj0D0WY7Ts
	iFaamdRGfUE/puW57ZHjpcM=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d0TND0zvLz1T4FV;
	Mon,  3 Nov 2025 19:08:28 +0800 (CST)
Received: from dggpemf500006.china.huawei.com (unknown [7.185.36.235])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D50E18048F;
	Mon,  3 Nov 2025 19:09:39 +0800 (CST)
Received: from [10.67.120.136] (10.67.120.136) by
 dggpemf500006.china.huawei.com (7.185.36.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 19:09:38 +0800
Message-ID: <f1e88438-c9ea-435d-ab6b-763a64fcbe95@huawei.com>
Date: Mon, 3 Nov 2025 19:09:37 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: hisi-kunpeng: Fixed the wrong debugfs node name in
 hisi_spi debugfs initialization
To: Devyn Liu <liudingyuan@h-partners.com>, <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <kangfenglong@huawei.com>,
	<liuyonglong@huawei.com>, <lujunhua7@h-partners.com>, <yubowen8@huawei.com>,
	<liudingyuan@huawei.com>
References: <20251024063133.3796584-1-liudingyuan@h-partners.com>
From: Yang Shen <shenyang39@huawei.com>
In-Reply-To: <20251024063133.3796584-1-liudingyuan@h-partners.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500006.china.huawei.com (7.185.36.235)



在 2025/10/24 14:31, Devyn Liu 写道:
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
> ---
>   drivers/spi/spi-hisi-kunpeng.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Yang Shen <shenyang39@huawei.com>

