Return-Path: <linux-spi+bounces-3366-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18BE902ACA
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 23:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78E51C2131E
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 21:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0438D1514CB;
	Mon, 10 Jun 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECzMlU8k"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE01514C9;
	Mon, 10 Jun 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055902; cv=none; b=jYHDsIZ1UDY5TQhkHCpQEvsNlUPNaDtJzTjuC+ivDuHucox5QIcBXcqC21gKWpxoEtIqp6auMyWl5incRgV+SWMrf5DRGlUijs3T+ko9vm4DZS+JzR9Wdhm/JgfvS6gNppGKcXi7+JpxUYAyPEGYFgAsYFyCGXSeRyK5u+V5UbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055902; c=relaxed/simple;
	bh=CIrpJsQHJ1oAoHohV5FV+ZOP5zr4LCUK8FCMtTs1PcQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bUy++klgs60Sv7c5LfotH41M+hylpssd0Pxx3oxWwKDSlqrCjrZWhN5ugNp8AJaSKp5BX/nTgzkOBBJkzw0T3EKJH8yhSumOBgU8xLgcpz1hAJnMM6xApMutbbx85bcHah0LdvUu6xefd1gGmB6qHQ2sgMyIieeGZF5Dl3qHeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECzMlU8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F36C4AF1C;
	Mon, 10 Jun 2024 21:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055902;
	bh=CIrpJsQHJ1oAoHohV5FV+ZOP5zr4LCUK8FCMtTs1PcQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ECzMlU8k7E3mQjMXJpraXWefsrEn04R4fio9Pt23U/XU+WMiWONv59lQftCD23Cr6
	 ZizCb8WI9vF0kPh3MdjPdbCEyZlf9OYJEjeP9W8BVdKnspHeb5S9bSvV3lYZ4kUj12
	 gANkYLgu87wZJrYkHBxTlGjgkaZGEjDb8pVhraNprMkB+0CaQPbv6jOyFhinnxFIhi
	 wkUPP9W1LmJlo3LVWstFLwBDH4F2ovfUjkTA2CaObBE5xF+Es0yXm2WFvqIydtu69j
	 6vM9J//vghujQWUERek2mzzSDYBoTR6PG6vmi0CX1Nm55air+TBIzNjy9IJ8niHC0U
	 IWn2M4fLpnVaA==
From: Mark Brown <broonie@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240609-md-drivers-spi-v1-1-1c7444f53cde@quicinc.com>
References: <20240609-md-drivers-spi-v1-1-1c7444f53cde@quicinc.com>
Subject: Re: [PATCH] spi: add missing MODULE_DESCRIPTION() macros
Message-Id: <171805589958.166358.8036553201290116562.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 22:44:59 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Sun, 09 Jun 2024 15:18:58 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-altera-core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-fsl-lib.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-omap2-mcspi.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-qup.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: add missing MODULE_DESCRIPTION() macros
      commit: 8a71710bb4797174733a16df2bcb8683fbe7caea

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


