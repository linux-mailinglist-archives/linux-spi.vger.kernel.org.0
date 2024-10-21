Return-Path: <linux-spi+bounces-5281-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AEA9A6865
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 14:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590D728423E
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D863F1E9070;
	Mon, 21 Oct 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="HqtSjTaf"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C51D0E15;
	Mon, 21 Oct 2024 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513703; cv=none; b=Lj02sPweEybTd2dpVrNXq0tf56zxn4x0FxpdKRtNE6IXH5Lf3Q1yutNj6BFxmIjT/icOMMin3B3iVHevjKox83t09Ldqc88eS98dVoaQYig9Bdo2N6+EaQhB8Mg/qvCtP9yEfB32ij2ndGOQkZi/6PiWVo7T8k+iZvPOJtRLsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513703; c=relaxed/simple;
	bh=AWIWDMVcoZMFoL0I33M3dhyRPFg891LL/NaNnJJwlEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H6cArTmdcO2hQnb7XtkdCw/iBz46uoX5Hjif8s83E1tiWmaM5CQ1W80yJAp9Nb1b/qNv7ulTuAG8HSIoN/Qh08bM0Zgdc2tF03L7k5pZIkjs7tY3sKTpAuk1ryHvlPU9MZWSCznjJyHnfSKX6UtjQaPbCvF7LGoQjLqgiYzEByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=HqtSjTaf; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D73E2A0767;
	Mon, 21 Oct 2024 14:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=19R2T/P5bYh8LMjLk5vV
	rkn4FuMNiEEmfkBlSoRm6XU=; b=HqtSjTafIWn5xUHXauvx0kFCpQq/lj6Q4eoG
	LCyO9sHjre/d2MNhSLtA6c0VaD2dioLFLSXTJtUtie+a6atoDBh4ILbwzNR+C16Y
	xlYt26HEQ86ulDmV4wNx2t00D6AHiWizQL24GAiy2lNgTU/7UwxLMvjoUqP3e99u
	0vgmRtVZhfPTlE7QPriFHmfUXmBuZx4WrMVntPxHSV3GAnEq+R/FTYnnVOzihUhC
	BbM7JRANPY7yS6G8Tj4tDHbnwDVN6ef4qhhgQXLH5DB5rQ9jjcsZwyeqlXHo7XeX
	FflyhpCOdfS1kyP8dfW6a6w+P/CmAefgYO8fkh1Uc2PkIsQSzBHOoDNpE6o1YAaa
	3ci5Y/OeWnEPuVn0NlZuMcbti4AExrCVDsv81ffBB5dEnDVqJWxddSFUocF8QY7d
	C30DEZeuwYfEBBNmLgzOKimrQlwnHYffExLwIGOjkdIN5nzd4GQlWH6MbdDG0N83
	6AlJN0PQWlzodGYg1xqB8spk5CEedBJpdkmrmE8ypVsbnd0vEkwifeWuY9JD758R
	uBeTkmrbPnI+v5ynsvssu1TktloU7Ii9IDLidnSK9FjsWl/cjLO7cQhWULhbUJYq
	GejXt7KCrtJoEJrPu21Dzkt15WC1A8UAZdczEGTP/manOBoe2B5+re1bk2SCNv6J
	rhRdLCI=
Message-ID: <eae501a6-d210-4576-afa0-010f9cc8c5fd@prolan.hu>
Date: Mon, 21 Oct 2024 14:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: atmel-quadspi: Add support for sama7g5 QSPI
To: Tudor Ambarus <tudor.ambarus@microchip.com>, <broonie@kernel.org>
CC: <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<ludovic.desroches@microchip.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Varshini Rajendran <varshini.rajendran@microchip.com>, Claudiu Beznea
	<Claudiu.Beznea@microchip.com>
References: <20211214133404.121739-1-tudor.ambarus@microchip.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20211214133404.121739-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855677761

Hi,

On 2021. 12. 14. 14:34, Tudor Ambarus wrote:
> The sama7g5 QSPI controller uses dedicated clocks for the
> QSPI Controller Interface and the QSPI Controller Core, and
> requires synchronization before accessing registers or bit
> fields.
> 
> QSPI_SR.SYNCBSY must be zero before accessing any of the bits:
> QSPI_CR.QSPIEN, QSPI_CR.QSPIDIS, QSPI_CR.SRFRSH, QSPI_CR.SWRST,
> QSPI_CR.UPDCFG, QSPI_CR.STTFR, QSPI_CR.RTOUT, QSPI_CR.LASTXFER.
> 
> Also, the QSPI controller core configuration can be updated by
> writing the QSPI_CR.UPDCFG bit to ‘1’. This is needed by the
> following registers: QSPI_MR, QSPI_SCR, QSPI_IAR, QSPI_WICR,
> QSPI_IFR, QSPI_RICR, QSPI_SMR, QSPI_SKR,QSPI_REFRESH, QSPI_WRACNT
> QSPI_PCALCFG.
> 
> The Octal SPI supports frequencies up to 200 MHZ DDR. The need
> for output impedance calibration arises. To avoid the degradation
> of the signal quality, a PAD calibration cell is used to adjust
> the output impedance to the driven I/Os.
> 
> The transmission flow requires different sequences for setting
> the configuration and for the actual transfer, than what is in
> the sama5d2 and sam9x60 versions of the IP. Different interrupts
> are handled. aq->ops->set_cfg() and aq->ops->transfer() are
> introduced to help differentiating the flows.
> 
> Tested single and octal SPI mode with mx66lm1g45g.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

This patch doesn't seem to have been merged. Is it no longer needed? Has 
Claudiu's comment been addressed? Likely not, as the vendor kernel 
(linux4microchip) still contains the un-amended commit.

Bence


