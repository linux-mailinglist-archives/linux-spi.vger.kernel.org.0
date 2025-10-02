Return-Path: <linux-spi+bounces-10425-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64429BB2B8C
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 09:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220063B980A
	for <lists+linux-spi@lfdr.de>; Thu,  2 Oct 2025 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2042BE7BB;
	Thu,  2 Oct 2025 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eUDbntwe"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBB2848AF;
	Thu,  2 Oct 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391077; cv=none; b=cPGUUgT0dBXrXCKbzrzv304j3hKX9GQPWM0Gpl3gv+yzDCNrHB5hqGUDDa3H+F3gNmAJrwHWABkERkvYjuMHt/hmAx9y6ufl6vA2FFDRTB0C4O9dTLn5GVc9Zc8UQ7YDrCO9O2rNoSdM/9ecI2KdoyIbMAiAmOXRsvNAmG8kw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391077; c=relaxed/simple;
	bh=744QVoJ7dfQabamJOCeDrnH9qRWpL6zFPcLc5xF5yik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBzyPAswsfRzCSsi3tgzZ3GWLh6QWubyShNEwfkBsyztoGtlZYl9GzkwuzSwrUeWTfvaHShrnhmwIbqOoErGemJnS7r4lTWq/+Idpia5hPZYPKxa+1n2ntM+GjoPC5wCVMev7oxwTwiyxO2TXKkcWYraGbbBmR6veNRccZsWMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eUDbntwe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759391069;
	bh=744QVoJ7dfQabamJOCeDrnH9qRWpL6zFPcLc5xF5yik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eUDbntwe1xa6hiTHUNzeaKlans/S/GFpvMagRZiQiJ75x7aWU1heM0UQDe0K89yzg
	 +ZTlKYDrkdiN8iXRLHrQxMJPuW3srUTkQ5E5JnUR7tMjW7Bj8dC63AKeZ7KkHzDuJj
	 fbscVDgUe9Z+5qYS8rpTh73GTHlIfQKOgh6t+/kWuGsBrxTfLAiRx3zOTrROZkgwfx
	 +BSTfd60AuEj6ELtceY0McpHsHJ471gOj8FZWrNcgpVR7DE52pE3lmeh4MelD7t6eM
	 Is3sZr2ojnuBzOxCp//yb243MxPhpPlTqtGqhxh9g5HC3XVSJ+Y4QVFZUb723zZMP1
	 yTcu/gW1NIf8w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 535C617E0AC3;
	Thu,  2 Oct 2025 09:44:29 +0200 (CEST)
Message-ID: <bcfb637a-79bb-42d8-a2b9-508a2fab6025@collabora.com>
Date: Thu, 2 Oct 2025 09:44:28 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/13] spi: airoha: buffer must be 0xff-ed before
 writing
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
 <20251001222347.3386506-14-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251001222347.3386506-14-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/10/25 00:23, Mikhail Kshevetskiy ha scritto:
> During writing, the entire flash page (including OOB) will be updated
> with the values from the temporary buffer, so we need to fill the
> untouched areas of the buffer with 0xff value to prevent accidental
> data overwriting.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



