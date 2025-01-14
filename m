Return-Path: <linux-spi+bounces-6355-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D6A10D84
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2025 18:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FEB1881F28
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2025 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EE51D516C;
	Tue, 14 Jan 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="evtzxkAk"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67671CF2B7;
	Tue, 14 Jan 2025 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875318; cv=none; b=ihVdsb2v5bwuHzkIWdtt/3HiaAL7ASYyHwUuFKRL0RAjZxMeO1J6HwOF9IZ/BKpiUFEriNMOA9YuDXtK5OZ6/MknPndyI+GVKv0A12lKZEaz3JTiN84zSbNJGbMhfQI3PRdRnSCZCPrXdcsV/33P1jrW/WjZ47xJEGkiYQjWugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875318; c=relaxed/simple;
	bh=f1jnjPBz0jrzSorNyeb+kRK5Sj7xK0hTXRSeKIgtI+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e5RUeJ+IdDwUS74ZeTC7Lk8wI9AAeG4gMss23McKJ+jHD29uJ17dyNYJ8onDJIvSjF7ep1X2yWxUC9XRsdV/dipxZze5tmB/80etq+FJ57s3UMRooMJhruc0w1TQU/jr2XckIEXhQq9/6XeBPqRtFHoA7Hg3z0Z98RNR5vtsMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=evtzxkAk; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E30A5A0D96;
	Tue, 14 Jan 2025 18:21:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=mail; bh=5lb7kJrxaj9Um8RxeR+IiRmrPwaOg
	Ur3Pt6kJJDIgew=; b=evtzxkAkT89iOfINLBGKnnxmPBfOVQ8gPJYeEH3I8zMON
	7T0AdPZK8fkNO8oWU5dBnEp61cMH3Ipqia/r6GcwmCQH+RhenTeTX79RftTa79vH
	IEalU0LEil/7FLF0MI3+tGGOCpnG51xtZyaKLWSeR/cIhgBsCWBVcqDO8R8B478F
	KYvz6GsHbrYfranKeknzhzZVZXvYlqjzBSUV58ubspUCdSePkCdfbVIagiBegclK
	JHMjokkM5lWw7izhhVt01Aid54avD1M55r9lB8njwe2+SChmOP/tJ9Z+Dtq18B4H
	wRgcJlgiDVAmICtCsfSMs0CLJxKkW/oyWuS4QGrguWlsyq7B7hpwZv/6n6Pu7fWn
	87l8qJj2hlrXSy8HJU5BsmLwGoLYboh3bhfYc7GBt/Wr6MfOHGUTXchpB7aK4ia8
	Bbf3wcmObLhyq2d/4Jtzcu3rATxVMl5I7GaobKni4cd7H3LOusmACQSqLa7I5QmX
	3tinew/YEnoQZJMYbm2LaAJitoT1Md2LfqgPZUC7AGg8pJPtrXEM7hduxqtuvRAL
	yU8maZ6oLxlHVaIhW8nlJlEe1Iti/w99jIE6zlVJ3l7Qu0Msa0QP3XObtEqkYoiU
	LiuZkGCk0bdqvbwbizv5VPMFccywbSW8cDvWzZoO/ei6uPxnqLXDYggQLG2Cxc=
Message-ID: <2768b17c-bba8-452c-8148-cfbf1ed5393f@prolan.hu>
Date: Tue, 14 Jan 2025 18:21:52 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: atmel-quadspi: Add support for sama7g5 QSPI
To: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Tudor Ambarus <tudor.ambarus@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>, Mark Brown
	<broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
References: <20241128174316.3209354-1-csokas.bence@prolan.hu>
 <20241128174316.3209354-3-csokas.bence@prolan.hu>
 <20250110-paycheck-irregular-bcddab1276c7@thorsis.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250110-paycheck-irregular-bcddab1276c7@thorsis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852647167

Hi,

On 2025. 01. 10. 8:56, Alexander Dahl wrote:
> Hello,
> 
> found another suspicious area regarding pm_runtime in
> atmel_qspi_probe(), see below (irrelevant stuff dropped this time) …
> 
> Am Thu, Nov 28, 2024 at 06:43:15PM +0100 schrieb Csókás, Bence:
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
> 
> […]
> 
>>   	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
>>   	pm_runtime_use_autosuspend(&pdev->dev);
>> @@ -745,7 +1444,9 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>>   	pm_runtime_enable(&pdev->dev);
>>   	pm_runtime_get_noresume(&pdev->dev);
>>   
>> -	atmel_qspi_init(aq);
>> +	err = atmel_qspi_init(aq);
>> +	if (err)
>> +		goto dma_release;
> 
> This error handling leads to unbalanced pm_runtime right?  The block
> below rolls back pm_runtime before jumping to 'dma_release', this here
> does not.
> 
>>   	err = spi_register_controller(ctrl);
>>   	if (err) {
>> @@ -753,13 +1454,16 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>>   		pm_runtime_disable(&pdev->dev);
>>   		pm_runtime_set_suspended(&pdev->dev);
>>   		pm_runtime_dont_use_autosuspend(&pdev->dev);
>> -		goto disable_qspick;
>> +		goto dma_release;
>>   	}
> 
> This hunk got it right?

Hm, I think this would be best handled by switching to 
`devm_pm_runtime_enable()`... I'll add that to my upcoming "make 
everything use devm_*()"-series... (but I'm waiting on new functions to 
be added to dmaengine for that).

Bence


