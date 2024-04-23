Return-Path: <linux-spi+bounces-2463-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFA68AE286
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 12:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA7F1F211C4
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60898D527;
	Tue, 23 Apr 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nBj/5ext"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E4D6311D;
	Tue, 23 Apr 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869055; cv=none; b=CwaI0GpfV30G9Ygg6rQilIY4wWKO2mZ0f+UyWAevGPnPCmR8RDQJ7k5TQgMTnp8hmqYTYiqxvogUK1HfLZh2foRPwTNrHPoyOtgZTlM3ffCiZYucHmpLlrFDZZjUKi81QkxlBtRNOTpda9/mcbtSRaOXzpDQZ7vLDFL/5kiPUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869055; c=relaxed/simple;
	bh=1dTtsgeM59cvtJRfDUVbO/OyyxO6CoadL/dmBvfpNXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kk+/lF75hlhHU/G18x3OUzplmNXTef0F5zk4B6u7uIrCFMcNQE+rjXt2Uugr669ZOP68cF1EvCZ514S3TcXp9nQJqyh1YYjBbu2pyrTxmYwIHhtyVrnZFK6MW6zcqRinl1/adOOHtvehRfUr4u92iC05EHrlJ9e3FxabKYnQV2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nBj/5ext; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713869052;
	bh=1dTtsgeM59cvtJRfDUVbO/OyyxO6CoadL/dmBvfpNXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nBj/5extWL+WgxEoHWinqDGHzKwLpv8zIXzmoNuBtOCDW4WZzieEyvAnEuyr8/YyW
	 arIr7a0ttqXbaU6wLKuYAoa5VCv1uypihOyzwtkXUb2WGD0Q5mlGal9EZpsuM2Etb2
	 Ml3EwsS7ibxk2VSODu1LQbZLdC35FPlbVRRqmn9L4Grx7ZvL8JgnkACI0J2+rBJtgr
	 T89L509sRih0415Lo2wSz1WETpgNUy8QO7G1i/o9PZfEd932gekaNSREvoc8f/MHFX
	 hiu/3RYimmGQWpXYTQEMOxi7PjTSTxRXCy0p0RAIr4BreXegbtgVlaFBm3NhN8dVez
	 daOS9FO7F3qoA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 794CE3782111;
	Tue, 23 Apr 2024 10:44:11 +0000 (UTC)
Message-ID: <4166f515-6229-440a-bf3d-b7efc8ba90a7@collabora.com>
Date: Tue, 23 Apr 2024 12:44:11 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI
 controller
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-spi@vger.kernel.org
Cc: conor@kernel.org, broonie@kernel.org, lorenzo.bianconi83@gmail.com,
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org, dd@embedd.com,
 catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com
References: <cover.1713866770.git.lorenzo@kernel.org>
 <a4ebcf779496200cb44844c5b203ed9399afa6ab.1713866770.git.lorenzo@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <a4ebcf779496200cb44844c5b203ed9399afa6ab.1713866770.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/04/24 12:16, Lorenzo Bianconi ha scritto:
> Introduce Airoha EN7581 SPI NAND controller binding
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



