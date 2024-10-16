Return-Path: <linux-spi+bounces-5245-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 210859A01A7
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2024 08:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63B4B24F6C
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2024 06:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3901B0F07;
	Wed, 16 Oct 2024 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH6y+fQE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7584198856;
	Wed, 16 Oct 2024 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060943; cv=none; b=BDJMJsLkcVYh7Tv9Q9MAreTIyNEuRp6HYL7MWmLKKNdcTCEKmYpYU047WTVSHiJGNIv6RACLROS7eZL978diCbplskb+gFJXwO05isriHaeOH0gfZraOh1mfK/Wv/S0eiBzr31klxtDg3fTrOzdrmqPVD19ueJ+dWRPh6jHMgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060943; c=relaxed/simple;
	bh=4Ex82LlFgpHyaw4FgxltJEPSWklCxg+DLUOAI+TxEWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+VK+L8XTZKkdWATqiS2RbNEfHlXUmn9DPWdLG+dsOlhEREoyftMXTQfPxgMlDOg22KmImoqshQGWqiiyEdVs/yhb0dY6fGHDeYYpCm5fklB0DWLD8EtmW9sY+b5k9UY4NRw64BIntTWrPgqkIKKxsqV8v80TZneO10iYpJXrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH6y+fQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA827C4CEC5;
	Wed, 16 Oct 2024 06:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729060943;
	bh=4Ex82LlFgpHyaw4FgxltJEPSWklCxg+DLUOAI+TxEWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gH6y+fQElXa+XnBopH0jeB8dffUgUFd9q/QDMSkWN8IF20rrsUmRMBTlzvMrIIMl3
	 f8oT5G47KFpsLq8yfdGJv7MBTwgwjfqpKjkJyDipb4PD6a5yE3b/2SKFbuGt3DWnTo
	 Z4x2Gw888PWdUkSABQvVD9e8P/LPNA3bgzbTdTwVZfzbM66cPb+FbgLQmqyqMuArjh
	 hbg3LOtikCf8Jovy8R7yP6J1TBbFar6aXIOSuxSWZulWmm1xBPnHlShwXVFOkNN/fq
	 7b/uPjt+ZYOrmpeL+GMbqhS1yvhN/eqWv6fGZq/zUKGBiRckPc+FlROIL8sg5dB9+D
	 CgYM6526P43bA==
Date: Wed, 16 Oct 2024 08:42:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tsbogend@alpha.franken.de, markus.stockhausen@gmx.de, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: spi: Add realtek,rtl9301-snand
Message-ID: <3pps6ayndngfvc2jflkozhdvga74fjblmfjhmmdpvxx2mpmnwv@sp4s7hgt56eo>
References: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
 <20241015225434.3970360-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015225434.3970360-2-chris.packham@alliedtelesis.co.nz>

On Wed, Oct 16, 2024 at 11:54:32AM +1300, Chris Packham wrote:
> Add a dtschema for the SPI-NAND controller on the RTL9300 SoCs. The
> controller supports
>  * Serial/Dual/Quad data with
>  * PIO and DMA data read/write operation
>  * Configurable flash access timing
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


