Return-Path: <linux-spi+bounces-8125-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95245AB7EEC
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 09:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA738677CB
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 07:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2962027E7D1;
	Thu, 15 May 2025 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRoFcG1S"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05262797BB;
	Thu, 15 May 2025 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294544; cv=none; b=ExwzDXv7HEsIlYJ9LLKlCxn3v13Bb1xrLi8BthHcKUyg+hRcPxgPI2j8LLMoft7nBcizyJeXG9eEUdww34fluIuCFyHI4aDxHhVO92d5LoyTRjZFWw3v0rz78O7nlJ91Sa95tS+lJmFYutWZ6SCXTuJihFCG76FDnw41u2qY53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294544; c=relaxed/simple;
	bh=ZGqhlVU+6Emh7nm8gXe/l4szD7AQKdUsT7UjppTo/Hc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gQlu+izxfd1VhGZs0KyACn+jKZlTxTVw2JAJGK4DhKjZQP+KECetyMYhZBFNaklMo9tQyP4bIae2ePtJjNhDmSsy2+BbbfYpdjAUsi8M/xMhz+WOM5vWbhBE2hZcNXUnidIfeqekNvgSmynpUPwVI6ZFvSWQtYdotVLeMeMxcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRoFcG1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7B9C4CEE7;
	Thu, 15 May 2025 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747294543;
	bh=ZGqhlVU+6Emh7nm8gXe/l4szD7AQKdUsT7UjppTo/Hc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bRoFcG1SGszUdhO8yF6/iWM2ASI88v+yD+FMjtga4NajMtvxYMmKnhSadVU6m6YZB
	 fMJP7UuJNH3o2CWQx59nSf7vHBEJhe+ra1CRbL+0vg4zOdBYXibpiwSbN9eu/m8GQ3
	 jrECyqJ5tNOesY5uVqwc2IPM6hRTOyRhmsxe85VyqnbjOO9O5EKPtva5SMvo5iZwmG
	 1WPp3WyeNmvuJzgrYpEv79LXOX2Nxrm5NaTs3rnkWqe5O/LKvWdDgFywLzlo45kpA0
	 rGOgT88iJCt6yT5Nn0qtfk4t58bFfikBKx2RMlIqQTHmGsGakldAQzdSGYZrQiqLgp
	 LMbP/Y8oUeyXQ==
From: Mark Brown <broonie@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250501-qpic-snand-validate-ecc-v1-1-532776581a66@gmail.com>
References: <20250501-qpic-snand-validate-ecc-v1-1-532776581a66@gmail.com>
Subject: Re: [PATCH next] spi: spi-qpic-snand: validate user/chip specific
 ECC properties
Message-Id: <174729453999.272648.10698524382095396308.b4-ty@kernel.org>
Date: Thu, 15 May 2025 09:35:39 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 01 May 2025 18:19:16 +0200, Gabor Juhos wrote:
> The driver only supports 512 bytes ECC step size and 4 bit ECC strength
> at the moment, however it does not reject unsupported step/strength
> configurations. Due to this, whenever the driver is used with a flash
> chip which needs stronger ECC protection, the following warning is shown
> in the kernel log:
> 
>   [    0.574648] spi-nand spi0.0: GigaDevice SPI NAND was found.
>   [    0.635748] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
>   [    0.649079] nand: WARNING: (null): the ECC used on your system is too weak compared to the one required by the NAND chip
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: validate user/chip specific ECC properties
      commit: 65cb56d49f6edea409600a3c61effc70ee5d43d8

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


