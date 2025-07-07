Return-Path: <linux-spi+bounces-9065-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8334AFAFDA
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 11:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7C1420A8E
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0273290BC4;
	Mon,  7 Jul 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RVrqUW/T"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F52261595;
	Mon,  7 Jul 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880923; cv=none; b=HxKUYK6KecqfmEdyFOj4XVs0IL0/MML3dzyF5rDM1Y47ek5U6i8w9WOf0B7xXrMTsNpZyW+wIQd/s3a89W82J7C2ENyT7LmT2n+agY/4bOmaUB9vJAcVFaH78agdMJfT53zknrIbqqGooJA8Ks9U6yiRDgbvJmILteLEoL/I/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880923; c=relaxed/simple;
	bh=KxcW44ReYaXX/YVr1c81zqjDrt3qzOZtstbYqbhmd0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRceA0q1DJJu8w2tIvRfel0W5DdS4lK3oBLjsq39luCiX3lvW8qnTkxCP73gCKWSDRe3DqzJX2QYM7OJgaW0mDpEfb1ZceFdRSxbrfLJTcTwnxZcftz+7OFf3I/P32eYeB7rpEjj42OrBq/ydyKaadfz2ZKvXULGiGIsoJMqMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RVrqUW/T; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751880920;
	bh=KxcW44ReYaXX/YVr1c81zqjDrt3qzOZtstbYqbhmd0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RVrqUW/TeUiGBqU56GhCWxR6xUF9bMyVuoV9RIM2fcly3Xf6kk1UPv1ndiBzimuJy
	 kCsjio3fRjwlrLB89Iixw3UdsNpk+Sm2QlQR6xh22XGkzRUW5UsjxvW7S8LdJzi4E4
	 We5WcoLLeOaToKRzi8MEOzqyhJeAFOvDKOf/DBwcdOAL5HxeKOWUcxK15QozjharVZ
	 V8OO8AbSoaNXza/iJnHPGaTTY9wAo7XkX0gJaNWDIznjcYAQZbWnlUoetyEFz1OvWJ
	 7oJpewOJyjN8u+JXvKIk4dy1I5yC50PulWkNc+LW9nMCJ3n5IeWDRBuHHuQ/MaI80P
	 XawMBmqBF/kkA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A5B5917E07C9;
	Mon,  7 Jul 2025 11:35:18 +0200 (CEST)
Message-ID: <57398fc7-2955-4717-9868-eee16d3a00d3@collabora.com>
Date: Mon, 7 Jul 2025 11:35:17 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 61/80] spi: Remove redundant pm_runtime_mark_last_busy()
 calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Frank Li <Frank.Li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Han Xu <han.xu@nxp.com>,
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Andi Shyti <andi.shyti@kernel.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alain Volmat <alain.volmat@foss.st.com>, Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
 <20250704075447.3221784-1-sakari.ailus@linux.intel.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250704075447.3221784-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/07/25 09:54, Sakari Ailus ha scritto:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>


For MediaTek:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


