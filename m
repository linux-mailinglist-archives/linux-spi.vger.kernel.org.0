Return-Path: <linux-spi+bounces-4121-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A880944F50
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D904B28CA4D
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3F21B3748;
	Thu,  1 Aug 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NRItRBSJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD321B373D;
	Thu,  1 Aug 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526301; cv=none; b=WDt4v4L6BeW021jPZSwlwbNIbXAkJR2bz1XSfZCiF4waLgfa+idaU8UszW7Hp+/Kbnj7q5l+jX7wcT8KwgEs6XE/8HR6EyBfeinuFux6fDWlK0Wsqs/j2T+UnYDbWuQkta3z1dV/7R90IbrKMh9wQsFdmjUEQTc3enCceFdabVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526301; c=relaxed/simple;
	bh=2jRCBWR/aLkT7KAayor4Iw2u43asLIbw0roCYH6ypl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyKhXDU+FOvyML8BMuVFMwTSVmAfvPz+XOh+Iu5eymO7uZv9p2Jm3XLgIiiS+toQhJ8rcU+6cRh3tMPVtbuD4kmCEj9M0AFDYu/4W4ZVvjdDB+auLKLAca9Ym+8KjjrnKPnZdKMK9DcPLU3zMzxVY05+LNMO8rf1a2WKXBngJhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NRItRBSJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722526297;
	bh=2jRCBWR/aLkT7KAayor4Iw2u43asLIbw0roCYH6ypl4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NRItRBSJRVegw4rJC0J9/rKUdd8kB6WSh/ypdAC20YBBk6SiK9yV6T7tXikomfHaF
	 l7wqwu3noUyBWGuu6BTESX60m5Nc+/xCOBpvUHn7X5aO2RrkkWKoQrZlVHPr6YUYtV
	 uFbXhaKqDPCWfM9bj1wB5IxEqxBgMctVu5fix3l0PXofOFuxXR5DBIg8bcV7IYSeeu
	 z2Bi3oMv/eC7ym6KkKWuwmpHiFUSsd65EqK7o3oiYwWfuXmVdeYklhp0VbauyGapez
	 w0wxMioaDEzxa1gBrxK/CXtiDVeGqYgGxnsASJhMJdSu0hKEz7KpRcXht6DZFovW9j
	 /RLVBHtACtoEw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B69703782139;
	Thu,  1 Aug 2024 15:31:36 +0000 (UTC)
Message-ID: <c4d6da27-3b23-4a96-bad0-17f2392287ef@collabora.com>
Date: Thu, 1 Aug 2024 18:31:33 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mfd: rk8xx: Fix shutdown handler
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Lee Jones <lee@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Urja <urja@urja.dev>,
 Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, stable@vger.kernel.org
References: <20240730180903.81688-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240730180903.81688-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/24 21:05, Sebastian Reichel wrote:
> +	/*
> +	 * Currently the Rockchip SPI driver always sleeps when doing SPI
> +	 * transfers. This is not allowed in the SYS_OFF_MODE_POWER_OFF
> +	 * handler, so we are using the prepare handler as a workaround.
> +	 * This should be removed once the Rockchip SPI driver has been
> +	 * adapted.
> +	 */
> +	if (is_spi)
> +		pwr_off_mode = SYS_OFF_MODE_POWER_OFF_PREPARE;

This prevents the syscore_shutdown() step from execution. Is it better
than not powering off?

I'd rather skip registration of the power-off handlers in a case of SPI :)

-- 
Best regards,
Dmitry


