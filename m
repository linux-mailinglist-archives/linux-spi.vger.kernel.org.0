Return-Path: <linux-spi+bounces-3568-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDF291586C
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 23:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC62FB211D5
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 21:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE8C1A00DE;
	Mon, 24 Jun 2024 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUR2uRlp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B70FBEF;
	Mon, 24 Jun 2024 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262922; cv=none; b=fMq0+HxWqCbot/E2lY5OjL119ruuS1MqV0WQPucxqPL4EzlUtpNny1LI1OVvidFo7mvXc0CyM2kPTzO6k0RkvsmFWWAy/0j72EPfj8D8shWMdvFv4ej2Dmzl2XrBN5YXmtrS58/jJ0O4jo/gpH2xqDW3ot10pvuDCo+cdZm9iR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262922; c=relaxed/simple;
	bh=rvvBVnTHEEzHKhjgXbOAJVsRmGU99H3KQBF7g04WdhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmktUziFph1NFFBwqWRa3AUkcYkfVKIuUfja2SvBL2+etMWT0yConB3TalO+YlOgZ9nCrRwsOOVwFMDR8IwJ8yvypmp3v4uHzDThij2BOrX+JUd7UpCQ60pDl4FMrLqsYpcL4vQcT+bZoluuCzEMI583KxOCda/B7zLKxaEHJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUR2uRlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B6CC2BBFC;
	Mon, 24 Jun 2024 21:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719262921;
	bh=rvvBVnTHEEzHKhjgXbOAJVsRmGU99H3KQBF7g04WdhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUR2uRlp5ABwUnI5/d5ts7U/DGQ1OTmAph7cOSw6x38hFnbtjQR2RprASVmqSMQ47
	 yj25++1QmiiMNbl0A/hHZ/39dhGWBJTuiSrbpw2f3zFFtl5+VAGmlLDxEFJBLnH3NC
	 z8cve5iuY11kSH2gIkP5Uexx39FKeSjCKruIw066rm7liptb+Ex7CgfJnCEJ4dLolo
	 p7nBrOzUOfuJy8Jye4tSitZPByQVV4fdpo8+TxkDAfk/tMo3j9Z4sLD3WVGDwn+kol
	 RMT5/ol2XCNo9Q4Qx0xVmOvYSOyiU/U14OgEb4hHOE81pYgO2RhDVoHFoNjrDYl9Ym
	 cLKf8giSYvjDA==
Date: Mon, 24 Jun 2024 15:02:00 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH v4 2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
Message-ID: <171926291748.413012.792839544759127895.robh@kernel.org>
References: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
 <20240624-ls_qspi-v4-2-3d1c6f5005bf@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624-ls_qspi-v4-2-3d1c6f5005bf@nxp.com>


On Mon, 24 Jun 2024 14:55:28 -0400, Frank Li wrote:
> Convert dt-binding spi-fsl-dspi.txt to yaml format.
> Use part Vladimir Oltean's work at of
> https://lore.kernel.org/linux-spi/20221111224651.577729-1-vladimir.oltean@nxp.com/
> 
> Additional changes during convert:
> - compatible string "fsl,ls1028a-dspi" can be followed by
> fsl,ls1021a-v1.0-dspi.
> - Change "dspi0@4002c000" to "spi@4002c000" in example.
> - Reorder properties in example.
> - Use GIC include in example.
> - Deprecated fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay by use common SPI
> property.
> - Use compatible string 'jedec,spi-nor' in example.
> - Split peripheral part to fsl,dspi-peripheral-props.yaml.
> - Remove 'interrupts' and 'pinctrl' from required list.
> - Update 'bus-num' description.
> - Update 'spi-num-chipselects' description by add "cs-gpios don't count
> against this number".
> - Remove 'big-endian' description.
> 
> Co-developed-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> ---
> Change from v3 to v4
> - Add Co-developed-by and Signed-off-by from Kuldeep and Vladimir
> - Remove 'interrupts' and 'pinctrl' from required list
> - Update 'bus-num' descripton.
> - Update 'spi-num-chipselects' description by add "cs-gpios don't count
> against this number".
> - Remove 'big-endian' description.
> ---
>  .../bindings/spi/fsl,dspi-peripheral-props.yaml    |  30 ++++++
>  .../devicetree/bindings/spi/fsl,dspi.yaml          | 103 +++++++++++++++++++++
>  .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  65 -------------
>  .../bindings/spi/spi-peripheral-props.yaml         |   1 +
>  MAINTAINERS                                        |   2 +-
>  5 files changed, 135 insertions(+), 66 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


