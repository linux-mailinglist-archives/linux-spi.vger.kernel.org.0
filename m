Return-Path: <linux-spi+bounces-10393-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1BFBB02D9
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EFC176A6F
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001782D949E;
	Wed,  1 Oct 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mrWkuQe7"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAE92D0608;
	Wed,  1 Oct 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318453; cv=none; b=o/qgxnuAF/20gRZpH05bvAyfExKUZzuXbaJlM5rr4uQnrk4D/MuSaK8bCyAbuTHv5pd5yx0jdhxL+U2RLYJgEzDskLOgr973ZlSDEE15TYuSwMxre+K8/PsTLLhsW1gxP4vJ7WVlE/Cu0oSAnY9hhFlqwn8WcxWA0Tr3Ux8YiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318453; c=relaxed/simple;
	bh=4nawdXc4eyk/VRtI7cEaa4MxpNns7MBDbxectNvL5lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fydJzEiutvlXwF7IFq503PmNuD27YL/BjXOm18JvCSRSb5sa4TUvGxlFaKq95Bt935JKikRTG0tm26NQ5urUNvrJFUGQWZNRdroo34rA/59bp0DJ91ZZfo1BNOK6RMC4nLViLSAovB9VSL9AORzHC8KWf9rN2BGC/q5ULFXt8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mrWkuQe7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318450;
	bh=4nawdXc4eyk/VRtI7cEaa4MxpNns7MBDbxectNvL5lc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mrWkuQe7Ksr9ofNw4KTpyHjbUBKQj5HuWRdWghdz/vJJtHvUjGAaGlgJr66VPuxD7
	 m92gK85GTWcx8FPX5kad9CoPb4dAYwB+fPE6PtUmLNlLVxOSbboifeBlGAiFXYxoxR
	 eHYkjug0l9rYbh/W/4/TusINVRlYICg5mW8IM1l7diQmspquiNXQQaGOlGFmjOelf7
	 XS3tNBfjNdka4AXSqrSG/viSnSUUJdSVOE/XZUPF915sUi6H1+VIb2/Cf7PSf9ihVT
	 Zy4Y/qaXME/Xg5Ul+7fpm15sCRIUp+OaQY/jVcmLbsmabxUy+lQgA4I/vyZa0eYvmp
	 1hRHubXygDPDQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4943117E1345;
	Wed,  1 Oct 2025 13:34:10 +0200 (CEST)
Message-ID: <43313fde-19fd-4686-a63f-4d15f005aac0@collabora.com>
Date: Wed, 1 Oct 2025 13:34:10 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 08/13] spi: airoha: support of dualio/quadio
 flash reading commands
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
 <20250930022658.1485767-9-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250930022658.1485767-9-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/25 04:26, Mikhail Kshevetskiy ha scritto:
> Airoha snfi spi controller supports acceleration of DUAL/QUAD
> operations, but does not supports DUAL_IO/QUAD_IO operations.
> Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
> so we can issue corresponding DUAL/QUAD operation instead of
> DUAL_IO/QUAD_IO one.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



