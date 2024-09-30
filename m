Return-Path: <linux-spi+bounces-5064-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C0598AF55
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B134282ABD
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8DE188934;
	Mon, 30 Sep 2024 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boGWg1XH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A918455C;
	Mon, 30 Sep 2024 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732530; cv=none; b=g+j4/3BjvfrrbF/7/+P6E8qJCYFD6sUfqPr2pmqLzo8/5tYFdekpXpO7El8nAs36+urd649XHRhYA+eitYfEivD4jgrJn+jKcj06Dp9uOuRzNakvyHGmhWqczeloGqbfoQfyXTlAC/3vywoCBQ/sV9R3LKqB4OaH9C0hvl3shNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732530; c=relaxed/simple;
	bh=Dn96bU5RDQHiDmv8e2NgNB7Bq0BNcPhghDqoQS72P78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l6t+zFQfmzbppVrdifGNV+1isQz88VjVJx8TGdc6AhgI4HqI+2la9rd53OmMx+750lwp0B0gXvKnf3t3ILmVqzTibMRQBP6vyrA5FcvQn1HkOz68YXl06Xl2i6CiwPwW/NEFQ1FCos9Z8fN839ZfscwDnO6bixyvVPwBZG9caVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boGWg1XH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657C1C4CEC7;
	Mon, 30 Sep 2024 21:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727732530;
	bh=Dn96bU5RDQHiDmv8e2NgNB7Bq0BNcPhghDqoQS72P78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=boGWg1XHwXmMl6mz8JjoxRu40teFJdXsIF5gWiRpIpnhnXsUBIV9UK8RDcst+aCby
	 Tgb8W+GCQMxYXtEqTDEsXnUT0Ut2oF1/sNP15CYA0rKb+D5/eoIl6UYGxvF/kFbuuk
	 rQrhGGyl3RGCvzIb0z+RMPxJwwookg78VS7QM9UJ8kG96kcHSTH5++RgncF4qXCPDZ
	 EKpstg6+VL6ahFnMN0SDSbjykpm4TJF/dvI9HPpkfpwN9OKM9GCeu5OcpW8A/1S6L3
	 pwvlIGcufkbMuQEIWajaHc+/7X6mPH3PrYmeV98Hn248eonS+Xa8xY4gMT3/uiyO2D
	 ljehyOFnLkyzg==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: michal.simek@amd.com, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com, 
 amitrkcian2002@gmail.com
In-Reply-To: <20240925114203.2234735-1-amit.kumar-mahapatra@amd.com>
References: <20240925114203.2234735-1-amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH v2] dt-bindings: spi: zynqmp-qspi: Include two 'reg'
 properties only for the Zynq UltraScale QSPI
Message-Id: <172773252820.2210210.14417397745650065241.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:42:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 25 Sep 2024 17:12:03 +0530, Amit Kumar Mahapatra wrote:
> Linear mode is only supported by the Zynq UltraScale QSPI controller,
> so update the bindings to include two 'reg' properties only for the
> Zynq UltraScale QSPI controller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: zynqmp-qspi: Include two 'reg' properties only for the Zynq UltraScale QSPI
      commit: 759541d78eb8d6ac12dab7df14d4434cf5756e14

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


