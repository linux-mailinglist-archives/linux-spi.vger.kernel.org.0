Return-Path: <linux-spi+bounces-3400-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B8C907D4E
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 22:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588E71F20C95
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 20:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EE7F48E;
	Thu, 13 Jun 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sM4I4ZHm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAEF824A4;
	Thu, 13 Jun 2024 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309880; cv=none; b=NfMYfN3rdNacRJBMhTTdatMZWaNMwsBEvKwcMTtca3L6jK9njH1hpH7UxiYzZdofKq9RZ7wJwI9df3k9IhzeUK8b5ZiNnN3n6CGGLTaBQ7o8iE0FNk9I+84CUqOR8CPf74+4TwSeToPqDkvXFLKvWDSQEf1aFOtLrtMZewRDrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309880; c=relaxed/simple;
	bh=SeoW3pQUv+7r5hH9UutJVNk3geg6YNYfWR6URRa1t0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTcSgxs1o6g2o2/M+2LUDCnKJ7RCxsR7ZMcdDzdx3ZzOINSxaRo2wdPZOMkMxe96PaXHpQByyNOb/WRDU7mj8+WIRtezt/9cHMlmtydTaakAKRh/ZK9YjnaJdj+ZT7Idtkn4H0b6P/lObKHTMDUVDgxcY/8aHr7ZOojSZTZ714o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sM4I4ZHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA8AC2BBFC;
	Thu, 13 Jun 2024 20:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718309879;
	bh=SeoW3pQUv+7r5hH9UutJVNk3geg6YNYfWR6URRa1t0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sM4I4ZHmFl9zudcj8FKpOoM2BO2TXzDlCjiGjrvsIB/y3HVPD3QA5qFQ2X+hnc95u
	 uxXuKHimDuNs6MAzDAGgA76gZQDldLo7Io2NUxrsana47vNYbWKLxunAQJkE/v2mTa
	 qEQhNRVHH+rxGhWWsyQX53FgZtIPkKH9jkNNlLuPu1bTJqitdtMvndVJW48q765bUk
	 NVJhEkUjlmSFkf5skF7sl36kVWMgI2EOA8kKEsM+bQ/Ohth+qVT0AQkhsIpdasJVcG
	 KNqMBu3nYvly1LKtLOy6tLmprpoFwhwk9OKRJ0wCghMGWbLYAnsSyP7BQQhg+oZonn
	 VZKRqAERGg72Q==
Date: Thu, 13 Jun 2024 14:17:58 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
Message-ID: <20240613201758.GA2396297-robh@kernel.org>
References: <20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com>
 <20240613-ls_qspi-v2-2-b288f6f5b736@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-ls_qspi-v2-2-b288f6f5b736@nxp.com>

On Thu, Jun 13, 2024 at 03:00:38PM -0400, Frank Li wrote:
> Convert dt-binding spi-fsl-dspi.txt to yaml format.
> 
> Addtional changes during convert:
> - compatible string "fsl,ls1028a-dspi" can be followed by
> fsl,ls1021a-v1.0-dspi.
> - Change "dspi0@4002c000" to "spi@4002c000" in example.
> - Reorder properties in example.
> - Use GIC include in example.
> - Remove fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay by use common SPI
> property.

You can't just remove them. These are mature platforms using them and 
replacing the properties would break kernels without your driver change. 
The only compatible change would be put both properties in the DT.

You need to pick up what Vladimir did:

https://lore.kernel.org/linux-spi/20221111224651.577729-1-vladimir.oltean@nxp.com/

> - Use compatible string 'jedec,spi-nor' in example.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/spi/fsl,dspi.yaml          | 115 +++++++++++++++++++++
>  .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  65 ------------
>  2 files changed, 115 insertions(+), 65 deletions(-)

