Return-Path: <linux-spi+bounces-5880-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB00B9E0939
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 17:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A96165654
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D51D95AA;
	Mon,  2 Dec 2024 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSPWq743"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111DD1D959E;
	Mon,  2 Dec 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158273; cv=none; b=kxGpQXNjEW6xVwei/HCdpEFoQ5OmikMKLa6E+tPqfTDKSUcqQu/F0V3qII+spNxXkVFlS9WkKbvSOsgFzOsB9v7FJQWfVQ3cEoPOU8fyIcOnRNJj810FSJD0ZL76nuv/KuGyplw66mQXFaG4vqaNeu71BBcWcH1ca6+HRN+WWq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158273; c=relaxed/simple;
	bh=ZdAQdXXjCYljteTFBRHsVw/rpxpZmdzMc5aDBqCIVy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N6+xrhMKbUx88J7FeY7g/DO543GrFU1DUjc9G9RUtANl6HltETZGg/CJNrk5BQ6xrXqOqHJ3dkvhUD35Adj/XoWHELeDFQ70gBy6ahm9phXWxcMyDB8upAUoDt36shARBSwp6bzN1/PG+1Nz35iNmuO5+AWh6oEy+A194llQRaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSPWq743; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CCDC4CED6;
	Mon,  2 Dec 2024 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158272;
	bh=ZdAQdXXjCYljteTFBRHsVw/rpxpZmdzMc5aDBqCIVy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iSPWq743CIYZAfEvP/0i+dSExVhNx/pKe3BLTKkZnq3y/0UZ77r7x0LTj+kgtS7AR
	 A1TjutON18aDwgk8Bt3aBPP13pwhirJDhK2wXkAWoyfkA8nBqev6K824bYl6YSm0wD
	 KYe+90UjI6hP4o7JrCVXKE0ciu0xWPLIEl1+rvz2Bs3T0rYacZrvYHsxcEvOEDIPqS
	 KP1GOM2kzMsD/oZacBAaaiikbsaPezHv2LkjfnenxqyQczcoUfMhezH8hcqzvK/ieK
	 /afc03wEG5xP+oJNb8TU3bhqI2GkTTLV0FgF1fhgzZSMkklV5R+Hj4k8iLSbrb1YtG
	 AFGisWHbX9mWA==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, Fabio Estevam <festevam@gmail.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-spi@vger.kernel.org, shawnguo@kernel.org, 
 linux-arm-kernel@lists.infradead.org, lukma@denx.de, 
 Fabio Estevam <festevam@denx.de>
In-Reply-To: <20241023120015.1049008-1-festevam@gmail.com>
References: <20241023120015.1049008-1-festevam@gmail.com>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: misc: lwn,bk4-spi: Add
 binding
Message-Id: <173315826769.126887.7195905602758530196.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 16:51:07 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 23 Oct 2024 09:00:13 -0300, Fabio Estevam wrote:
> Add a lwn,bk4-spi.yaml binding for Liebherr's BK4 external SPI controller.
> 
> Currently, the compatible string used for this device is "lwn,bk4",
> which is the same as the board compatible string documented at fsl.yaml.
> 
> This causes several dt-schema warnings:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: misc: lwn,bk4-spi: Add binding
      commit: 36e7886075262429158aec6f258e6a5a92f025b1
[2/3] spi: spidev: Add an entry for lwn,bk4-spi
      commit: 096c34ddf5835f02f5260719cd8a16fcf5e5e56f

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


