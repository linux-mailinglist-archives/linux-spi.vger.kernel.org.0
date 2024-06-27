Return-Path: <linux-spi+bounces-3623-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F9291A338
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 11:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BEE6B20BB9
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 09:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA0013C697;
	Thu, 27 Jun 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="dEcwHAM4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295F113BC31;
	Thu, 27 Jun 2024 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482195; cv=none; b=DvSKmBDKm+tCKppXbi58HakPYgGjCHaWmOGN5K4DMePphhdLYErf+fsys5SJk4qQiJIx9G61fQvPyI56NnQkGVoQGY4oCK0OPbVJurVxgUQAP/uKt0e5IVkdefpr1e7TDzi9uJDfHYRpl/VFUOdViON48Tn8h2gOp4ti87b65Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482195; c=relaxed/simple;
	bh=g111cGAkJJTUrT6/h3T0ahXLLEM8F6CtuB/wl8swSwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rARsAumL7mFljwIjghr+ZIx8e568eE2JeRnQRpxeYd6RdVDL2xa4IltGjTyAO2aEkTPluynt/WglF20KBz7dIcp+qWByljrCYfjaXOBI0TvzZOjaP+MqxKD6LBb7a7yhLJ8teh7GpXOi52SJSa6JosLVsY7psdiaiL61T/oDZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=dEcwHAM4; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=QgffzqFvBeb2vCh8ycMNWRHSaKdYSTlWByp7ExuDxWc=;
	b=dEcwHAM4Wwu7kzOdABbHPJ5sxhgJ2mFAWpGLyeuQCXD1QVZpoazQi+YYxs2BPY
	R63YQxC3a3nmBlGsTzKjknJRfa1RBqfsgTS84jBEvQE6u0Z7hl/uyZFB6Uyn2M+U
	R1ThYetEeLkD33Y2OJW5FgIAUvMc8IPwRzQxep0BsXJWg=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD33x0wN31mYjcaAA--.52891S3;
	Thu, 27 Jun 2024 17:56:02 +0800 (CST)
Date: Thu, 27 Jun 2024 17:56:00 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 3/3] arm64: dts: fsl-ls1043a-rdb: use common
 spi-cs-setup(hold)-delay-ns
Message-ID: <Zn03MAkHz4sqWYfk@dragon>
References: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
 <20240624-ls_qspi-v4-3-3d1c6f5005bf@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624-ls_qspi-v4-3-3d1c6f5005bf@nxp.com>
X-CM-TRANSID:M88vCgD33x0wN31mYjcaAA--.52891S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVeTYUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQYLZWZv-cysUwABs-

On Mon, Jun 24, 2024 at 02:55:29PM -0400, Frank Li wrote:
> Use SPI common properties 'spi-cs-setup-delay-ns' and
> 'spi-cs-hold-delay-ns', mark private properties 'fsl,spi-cs-sck-delay'
> and 'fsl,spi-sck-cs-delay' as deprecated.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


