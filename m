Return-Path: <linux-spi+bounces-4655-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2380496CF94
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 08:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564F61C22530
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 06:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D39018FDB4;
	Thu,  5 Sep 2024 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpQ05TOp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020CE4C8E;
	Thu,  5 Sep 2024 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518617; cv=none; b=cfIg3yAF1K2ksUIkaQi0NbSvKnXW7KC6PleO0TvQ74Xt+S5Y7gnOwe44dn51SzqaymRddRn0FHDBULg/L5pSA4DWSRmgu+KPwxN6Bxs9rYL24UidN67IVcVO+Rh4LwTi3d34PlQT/X3OTvnFm9pb/kKxkkC2yES/ulMGl1K1NRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518617; c=relaxed/simple;
	bh=ZP9qkq3X6bx8KcZVPnpDkhxe1BRBqd2XkWPEnqT2Jpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC3BCyyUE1rD4Y7zOogZA3MBly9Q3aHqJQ2yKIEfkF0MeMbb21p7pbqXJTnV7J9UjE4SNCozgqxqG8sxj7dP+5Wyxghl6sd1EPEOXD9uSuWNcYvuuWCyfHeK6cmLjxWR2xhziMCHM4YcPs4/KjCO8wdTMcS8bXb9GxItrYdRO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpQ05TOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FC9C4CEC5;
	Thu,  5 Sep 2024 06:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725518616;
	bh=ZP9qkq3X6bx8KcZVPnpDkhxe1BRBqd2XkWPEnqT2Jpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpQ05TOpDUQxkf9MHz0+88deQpQH9WgXn1CKXwZxgybOYlXKEZgek6CA/1UQzepEq
	 zz3O8VVtCOZz2p1s4UmfEDZHpkHmuUqN0T1o2Tc7ZaonfCCB2qk0S4Sr4zb6ov5XI4
	 mI756tBadT84iR6ic0F9ZNyV+yHCn/BFl9I46p7G0c9/unZos+ZthftSuTsuQEulrZ
	 tMSvyBriTG+NQ3I3hSoHef8ADKh6zyuPZW9CPLhliQQwdZ0YKIMxouRxquI2NExkOa
	 dk5eZrAFlUMRQSjO558yCaMIJdjBg1LZoupvezwQuEyyOKuOaEaO2JOE14kAo9Qbvv
	 dqwxwr+yROGMw==
Date: Thu, 5 Sep 2024 08:43:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: haibo.chen@nxp.com
Cc: han.xu@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	singh.kuldeep87k@gmail.com, hs@denx.de, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: nxp-fspi: add imx8ulp support
Message-ID: <kgm2ytcwxs2dpszljpmuoyjpuf36tjyccpr4stp2dw5miygvl6@3qckkqdgxrmu>
References: <20240905012617.1864997-1-haibo.chen@nxp.com>
 <20240905012617.1864997-2-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905012617.1864997-2-haibo.chen@nxp.com>

On Thu, Sep 05, 2024 at 09:26:15AM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The flexspi on imx8ulp only has 16 number of LUTs, it is different
> with flexspi on other imx SoC which has 32 number of LUTs.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


