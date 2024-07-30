Return-Path: <linux-spi+bounces-4076-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C1940D1B
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7538281661
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39920194087;
	Tue, 30 Jul 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="03U7/hSj"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F76193061;
	Tue, 30 Jul 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330707; cv=none; b=UM/ie9LLyGn4bYGjEWIF9kUyQ7wvyx1PYFgZhqaGDzILn+4vLVRhHgfB/vl4G3YREPehLjHvCjfIUFiL+7XqU1i2ucnFqfsYqUMDySbfM2yUiT9/J5RwdOgXVOagX5pECYxKr1j5oL78BXM15JSHrT4pxWvbhWFIGi1HQpFks2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330707; c=relaxed/simple;
	bh=VcHUV45OnR/P4rH+ZMKCrwA6z7qM9dVHe0VZ6bJuT5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHHxmK075P6v7K+CTK0YLYu47QLjUsYj2ubWLY8la21j2nxUvZoqusm4WulErJNx2egyjU4T9jZwaDRENXiHwgBAyi85SlVe2lLuqEEiuOmNOXYI6xpHt/ZtNZ6s5HcaJS4P9GjHRLOlNigM0GJC17Z4IDvxmhqPJjrHXx3zG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=03U7/hSj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722330703;
	bh=VcHUV45OnR/P4rH+ZMKCrwA6z7qM9dVHe0VZ6bJuT5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=03U7/hSjHPnwcRt2nA/bVEJReHSHah/YVmM+DP5olTU/asgL+dWtJepumPCVLHIhl
	 xLL++d+KPLMWFnQ1wJfqO6GdNJQYFPuMh1mcxrkTybYFlLl947NDTJAPPk/Mr5iqBp
	 6sElZDfC1Cp7zDu7NT96grsRBxFqvm933xnZLZM2DZr1AAFNK25NVvxjE3FkGp7ilH
	 XI1RcpfnGphQf4CY25dqc6dTzhqI2dPzWiNVi8v4kDsI4J/FIGlHWtb60AlEMsi+EK
	 6jhKUMqzX+ydzlcNFdK20Fn1BZ5c18gbP089ynGfOpY2MXOicznkJsguJDmzftWV/v
	 Gitu7cmJSaPTg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DD31D3781360;
	Tue, 30 Jul 2024 09:11:42 +0000 (UTC)
Message-ID: <7773be18-a767-455b-8914-4e84b578a8eb@collabora.com>
Date: Tue, 30 Jul 2024 11:11:42 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt7981: add SPI controllers
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Leilk Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>,
 Daniel Golle <daniel@makrotopia.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240727114828.29558-1-zajec5@gmail.com>
 <20240727114828.29558-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240727114828.29558-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 27/07/24 13:48, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7981 (Filogic 820) has three on-SoC SPI controllers.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


