Return-Path: <linux-spi+bounces-11418-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C54EC751E6
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 16:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6B254F2AE5
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE05376BE2;
	Thu, 20 Nov 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpMkDx8W"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4182376BDC;
	Thu, 20 Nov 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652630; cv=none; b=sWv0Vuy9p63kaqlkU2HneuVa+HahIp440+F3osiCGQmSwD8+ljrVr9fqRqMr3mnp0q8jACIYu6okD+435nQPVC71cvhjGoJ5ptLH/IjEBsqrXRSGR73WFbi8IN1UjLpN5IuJ3ppisQq6ntjYKYt2b5T4uERtZR2IIkeaNMxVjpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652630; c=relaxed/simple;
	bh=bPg/R9Wznk/YBW4XG8j/l4XkmMD7c5N7cN+JHj+YmR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ82NboohtLT+aw6/agNk0hkOlVBz3pgWg130R+GbPZrpsxXQMTm8YTwz0CebLS82LKI1jC+Ba1axQTeN6TmRL3dkEuUQ1HUaF2Ovp5zPrHbjQASyuNyZB5zd5TKLk15JKX7qTu/EgQmZMqOPSAjKYV5FNn4OkqEqncQCFiGrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpMkDx8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B432C4CEF1;
	Thu, 20 Nov 2025 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763652629;
	bh=bPg/R9Wznk/YBW4XG8j/l4XkmMD7c5N7cN+JHj+YmR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpMkDx8WbjXZ60pHs2f6G/+pyXUIDadgt4nyH5x+IpCXIotODRfSx3fDcqqgAjiEU
	 AmKEFKd+bG0AR1ruu63ypENFbK/zWGU6ZbGPLXFqv7i6oi3BOR3F+IHBTjfYVLI3mO
	 6mo5IvNrB1YsEgyyUjfvZQa7LR2tGwTz2EyFt3hYEamHfW29mHGSgRNwxbx76hoVc9
	 5aVz/XHs7zdzViGf/sfCZh7AYUnYy25n3xuwd0uyqZhQJtiXJmWgKdRxb+LSzgCaZi
	 GzTBeZ8hrspCXwlI/fl02yCOapYD/beeFHiFPSYGoRJ57RlvbiMVo9J4t2fpza4WC2
	 jlg2M+RwJ7Eng==
Date: Thu, 20 Nov 2025 15:30:24 +0000
From: Lee Jones <lee@kernel.org>
To: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: sprd-sc27xx: Integrate power off and reboot
 support
Message-ID: <20251120153024.GI661940@google.com>
References: <20251110-sc27xx-mfd-poweroff-v2-0-fd5842e732fe@abscue.de>
 <20251110-sc27xx-mfd-poweroff-v2-1-fd5842e732fe@abscue.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110-sc27xx-mfd-poweroff-v2-1-fd5842e732fe@abscue.de>

On Mon, 10 Nov 2025, Otto Pflüger wrote:

> The SC27xx PMICs allow restarting and powering off the device. Since
> this functionality is rather simple and not configurable in any way,
> make it part of the main PMIC driver.

This sounds like more of a drivers/power thing.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 148 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)

-- 
Lee Jones [李琼斯]

