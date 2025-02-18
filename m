Return-Path: <linux-spi+bounces-6864-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702C3A3AABE
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 22:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39BD3AC7E4
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4BE1C6FF8;
	Tue, 18 Feb 2025 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRRl3Oft"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21DA1BEF78;
	Tue, 18 Feb 2025 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913700; cv=none; b=l39U38WOcO0oMDwQd7bNJiJyQNL35F89zG94IzV/QGXb05rj7Aj0SAbXR3L+eS7EBpPsupr1X/630U804go03Vc3/9Mwb/NyJoNFCqT5pnKdghT+ib7IQUuqrKbCR0YvigD7OgmwbXHNy9e3gzcyWskjwCYYvSvsdenbIxnc2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913700; c=relaxed/simple;
	bh=B9lSIUKtKaBWlF14BOO6dZrB7G6K1Zk063vl/H8dksY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgwkSLI5UjhF13xNdq2IENMFpZ9CFemuPPugX6kDEidnchz3tHTxUlf6ulEBOPvUupBIx/6pX4EZ9wfIBcwoVprYFMpYAmrP16NU3nYP25YVzCse1vLw8xpICKQiqXPIM4zVyi9MQNTdyy6ECqQoXg9upSyC1ogdvcR9vweNAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRRl3Oft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6D0C4CEE2;
	Tue, 18 Feb 2025 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739913699;
	bh=B9lSIUKtKaBWlF14BOO6dZrB7G6K1Zk063vl/H8dksY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRRl3Oft5D1yNq8A/9GdXQlhT4a0/layZcEr6m168EFyUt483vukkReL1VrsLfdVW
	 zOO6npRBlyNM4X9gkvxRqfp6wI453gdsRZlmJofmiL8zFsCY0YRhJuey7zQfw9fWFU
	 xogFI9TFgXaaOcQZYVUhiS3aMAEuqHwyWwWSH0Dzt2B5hsdZV/dN0urTVADAhSk6G0
	 V9Ut2rkKOCfMDY7wY1cEm2cEiHavDVfRO2cvjELFHVIb0Z+e80RwGR/n6Z2ptYlHVt
	 r5EzUyJauBdauhOBLVtjpVAvKiMVdxIfXO/TXeUhmiYpot8O+xydOproUw8+D0zbPb
	 GGcv6XBWrNaOQ==
Date: Tue, 18 Feb 2025 15:21:38 -0600
From: Rob Herring <robh@kernel.org>
To: patrice.chotard@foss.st.com
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	christophe.kerello@foss.st.com
Subject: Re: [PATCH v4 0/8] Add STM32MP25 SPI NOR support
Message-ID: <20250218212138.GA1092771-robh@kernel.org>
References: <20250218130000.87889-1-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218130000.87889-1-patrice.chotard@foss.st.com>

On Tue, Feb 18, 2025 at 01:59:52PM +0100, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> This series adds SPI NOR support for STM32MP25 SoCs from STMicroelectronics.
> 
> On STM32MP25 SoCs family, an Octo Memory Manager block manages the muxing,
> the memory area split, the chip select override and the time constraint 
> between its 2 Octo SPI children.
> 
> Due to these depedencies, this series adds support for: 
>   - Octo Memory Manager driver.
>   - Octo SPI driver.
>   - yaml schema for Octo Memory Manager and Octo SPI drivers.
> 
> The device tree files adds Octo Memory Manager and its 2 associated Octo 
> SPI chidren in stm32mp251.dtsi and adds SPI NOR support in stm32mp257f-ev1
> board.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Changes in v4:
>   - Add default value requested by Krzysztof for st,omm-req2ack-ns, 
>     st,omm-cssel-ovr and st,omm-mux properties in st,stm32mp25-omm.yaml
>   - Remove constraint in free form test for st,omm-mux property.
>   - Fix drivers/memory/Kconfig by replacing TEST_COMPILE_ by COMPILE_TEST.
>   - Fix SPDX-License-Identifier for stm32-omm.c.
>   - Fix Kernel test robot by fixing dev_err() format in stm32-omm.c.
>   - Add missing pm_runtime_disable() in the error handling path in
>     stm32-omm.c.
>   - Replace an int by an unsigned int in stm32-omm.c
>   - Remove uneeded "," after terminator in stm32-omm.c.
>   - Update cover letter description to explain dependecies between 
>     Octo Memory Manager and its 2 Octo SPI children.
>   - Add Reviewed-by Krzysztof Kozlowski for patch 1 and 3.

No, you didn't.

