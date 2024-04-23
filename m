Return-Path: <linux-spi+bounces-2462-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3788AE284
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 12:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F6E1F2152D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD336633E5;
	Tue, 23 Apr 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HNMl4pzY"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A830D527;
	Tue, 23 Apr 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869054; cv=none; b=H8m3Rfp76ZNn2SHd9kqILSjgaMyRDKfSHrO5Y/OrjFMlYZG0G85uclrwlZIPop2pkG2pZJHwjnK6kvai5D1zJUdBZ4+bHkLHU7vycqnR+QIWed95fhCPGmqGkLAJPnZPclBmqoAcOlvcPW3MEMX4yNFsWiH4/zln7RqZjJq1vOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869054; c=relaxed/simple;
	bh=MvpYrX57zS+xaJ0vCpM7VDXggQlTTN/Fv532Gc1WONo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmTP7hbtqmEL5iqXow1EvbK/ptLde+tVzLEvKXWvH257f9SVKjf17n+cu3Ms0ke1rYAyIMny1tIpmRMPkOsnKIGWXl1HNdOW1Lnd8UCNwhxq5su4Dd2AMmHDqKUQZuRc273GhJcrzc8QYHe4q54EbJhb798doGoV862cvWb/a8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HNMl4pzY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713869051;
	bh=MvpYrX57zS+xaJ0vCpM7VDXggQlTTN/Fv532Gc1WONo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HNMl4pzYQvgP7sdAdn2GyfYTf4ze6pE2RFKgQEd+g3FSAgeh9Hv0FLE99eUBgAaBk
	 bFqrjIgugK8nOjarB9bqk3Bbq8tNDlRvSIdg1vornq2TB8N0u/0jCT784UjV+kWB51
	 e3Vm4WwouMshSNYHRWU2NDZbXLO4SlerG8t6l0HBD5TT2RzvVzeTSR0Hk0NQ8EMswB
	 AiMmCPMUW35OEJ6peLB3/iICHUYJx+JSv++CynjpmrM0XIUNrf5X4DUPbTBgD6TUIp
	 IXcX9zTphmGkfyz0wS9fHzT9Iw7rhEsUuA9qwjMqHGm/bxUc8YSDkYklkNOJTo2c9a
	 Vy03LqXPVf6eQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5CF3637820AB;
	Tue, 23 Apr 2024 10:44:10 +0000 (UTC)
Message-ID: <bd110a28-2da6-4817-a16e-70313b3fb09e@collabora.com>
Date: Tue, 23 Apr 2024 12:44:10 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: airoha: add EN7581 spi-nand node
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-spi@vger.kernel.org
Cc: conor@kernel.org, broonie@kernel.org, lorenzo.bianconi83@gmail.com,
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org, dd@embedd.com,
 catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com
References: <cover.1713866770.git.lorenzo@kernel.org>
 <44d066871ca08d1ebb233bba1a1c86620f3036f4.1713866770.git.lorenzo@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <44d066871ca08d1ebb233bba1a1c86620f3036f4.1713866770.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/04/24 12:16, Lorenzo Bianconi ha scritto:
> Introduce the Airoha EN7581 spi-nand node in Airoha EN7581 dtsi
> 
> Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



