Return-Path: <linux-spi+bounces-2580-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809FD8B546E
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 11:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC1F282E62
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC0324B34;
	Mon, 29 Apr 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="piN0CQ31"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5A175A4;
	Mon, 29 Apr 2024 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714383860; cv=none; b=EsgwPCZcOzoycHJ39ZNbCXKHX3FzCNHTmxEZjhcj0yqhCwUxy9tqCy4idvK1W5rNLNUT0tOjUORbtuNyymQhKSa09XQ9myxGAbXGrw70FHmmjJkihkxFfm3LqX7mZNgVFuzYd2nCSy+3hjMkTV7iUHpM+2OoocQd0vP8qABejF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714383860; c=relaxed/simple;
	bh=bJRzbEzz4XnbuC33ec/y3P3o2pnoIs8tWxU1u6I+zEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WG1MgQvknuNobz8gIshTwb88jSNbsyGt/8xS0UVElDXEgqFiFuzaRo3a7NdHYyIn6djbciXC03BypB3FCuTF3EqYNGNqL0Hh3VrbBK7c1wi+m58mYtUywcXABwEOLm2rOUxqSGbkdKO2KTNQOw88PjJ2OcMiWrLqUMr0H9dv46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=piN0CQ31; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714383857;
	bh=bJRzbEzz4XnbuC33ec/y3P3o2pnoIs8tWxU1u6I+zEk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=piN0CQ311+NZAT05oy23wCqyx3O5hz57Qdd9GFCtK2pGRhUuYGy+wkAUr/D7rTvr5
	 vgU9XTviPPZ7x4PBm2yXj8a3oA+IE5/0LiCF3xIRvUFnwkoBFS25wCmwsN49Nqyoom
	 XF87tUqaL1uQs6BH02Z+E3VLWjpzmewFn/7sHiMJVV8oH8FClNhaz0br2h//wVuo/0
	 Lcl52o+XqDHec5o4EovRW6y+7EcG1tEDee8OdNZhy2+tmd62avQOYrlvcOpB+ebW8U
	 lk3ur/xO6YwffEUDqXBM4WdybtsSjwtDt6XVjKfeCYqj92y6z3ieUnW3RDQh92uHnC
	 8ex2CFv0ZjooQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1C35A3781FE9;
	Mon, 29 Apr 2024 09:44:16 +0000 (UTC)
Message-ID: <a3759c61-22a1-4b01-84f5-67f6913f1bce@collabora.com>
Date: Mon, 29 Apr 2024 11:44:15 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] spi: airoha: add SPI-NAND Flash controller driver
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-spi@vger.kernel.org
Cc: conor@kernel.org, broonie@kernel.org, lorenzo.bianconi83@gmail.com,
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org, dd@embedd.com,
 catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com,
 andy.shevchenko@gmail.com
References: <cover.1714377864.git.lorenzo@kernel.org>
 <6c9db20505b01a66807995374f2af475a23ce5b2.1714377864.git.lorenzo@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <6c9db20505b01a66807995374f2af475a23ce5b2.1714377864.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/04/24 10:13, Lorenzo Bianconi ha scritto:
> Introduce support for SPI-NAND driver of the Airoha NAND Flash Interface
> found on Airoha ARM SoCs.
> 
> Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



