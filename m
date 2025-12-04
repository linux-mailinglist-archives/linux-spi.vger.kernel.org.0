Return-Path: <linux-spi+bounces-11753-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 564CACA21F7
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 02:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56CDC300FA02
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 01:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C77A1F2BA4;
	Thu,  4 Dec 2025 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tU87TPXG"
X-Original-To: linux-spi@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC31FE471;
	Thu,  4 Dec 2025 01:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764812792; cv=none; b=HsfBeHKRNTbpUq74Zmz2xELFLHU/XJxfzvddYqa1KPknJLNxjjGgoVoLUZdttNlnCczte1FoCdu6HbAeTVaPiVPrSYI3/cW42JiNDCNBiDcY1qU19NcQiaNZPxWoVFXywCafkg4gzM6pbVEDTJinOOBT3j7nQddWpVX/sY1bcHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764812792; c=relaxed/simple;
	bh=Me/o6vXITmrakcjffEt+XLSkDwLMgGl2xAHdPx0o8lQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TYYPWjaDBupCojuNA5MnSS6jSuNFOhBaEVtopRxT3hWUNK1+gGWvdcGF8GolmZZoomsLkOlYjQ/g0Umcq3JC2Cd6zaOGMSgZ3HMSlHQ0VETSN+AHOmWmTkVuGXfWPwkeklC63/t3Er9dET8yZ89pm88qfD75pfbpvXuFnUWQBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tU87TPXG; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764812787; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Me/o6vXITmrakcjffEt+XLSkDwLMgGl2xAHdPx0o8lQ=;
	b=tU87TPXG8mTauZsV/ILOso+ygXheV4BzxQaHAwBt0n1qiN7uQ09dlJonCg/LuHH1eYoA1gVgKGJBYgQhf8/ORNsBEg0lxLUSIKVPUDPSTpjhEuiqpmugjlvkaASUaah0GA6HaAP6o6w92Sd2yjl2Ir94hTYZ3VypOY52aWAogmE=
Received: from 30.178.67.88(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Wu2E4N6_1764812786 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Dec 2025 09:46:27 +0800
Message-ID: <16bc32ff-2c10-448b-ab82-a21eaa91f4ce@linux.alibaba.com>
Date: Thu, 4 Dec 2025 09:46:26 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] spi: tegra210-quad: downgrade the log when fall back to
 PIO
From: Guixin Liu <kanie@linux.alibaba.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
References: <20251127130207.43754-1-kanie@linux.alibaba.com>
In-Reply-To: <20251127130207.43754-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Friendly ping...

Best Regards,
Guixin Liu

