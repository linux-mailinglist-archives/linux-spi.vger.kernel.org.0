Return-Path: <linux-spi+bounces-9838-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 569E5B3F0E9
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 00:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4651A869FC
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07BA23D7E8;
	Mon,  1 Sep 2025 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElAZSesP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A7188715;
	Mon,  1 Sep 2025 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756764927; cv=none; b=SElTIKUMHKzME+PvxOX9h2DTToJF+IH4+rmXKD9QZJYn87/KmRELPPbUGF5H7kbkL1VS/DOzdbEi4/O5MEFSUDaANa2TLs8JQSdX9+vUomnFNhghi5xFHx+MI8viI4xwtaO9vHhC23THrEHRfl1XkZRnw9A1Hfu4Q3baS7gOmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756764927; c=relaxed/simple;
	bh=A5C4e1z8sW6QvmbwOIiYp+LFhDtXndxxYvLSqp0kA+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YCSTHVbZdXUbqmPHDdtM4W8A7AKIPI4Uv5tpJXM0JSle0sCC28FAVVjy33f4fmUa6XZ6rudmHYv2slgiNrY9IW+6tqV/6vLBtzxBeWhrY9yic78mQ5QkuPPs3n5EgQlLua34q9EgZL8dV5K/KnMnb+ntKONPXXDRU6SN0UvtaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElAZSesP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE197C4CEF0;
	Mon,  1 Sep 2025 22:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756764926;
	bh=A5C4e1z8sW6QvmbwOIiYp+LFhDtXndxxYvLSqp0kA+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ElAZSesPkTvvxhtpONOletka8rVQZblEpL9ldovoiBZ//i3oQ3g0afAE4qMy1hvei
	 50i5DWTxc6mTjpSzGRzJyMsqxshqNjENb/zSNloWSxtt+V9sPgTVzrlFSEpjPdMOSw
	 KE21LiQkCmK7DlQeNjmKlFyxP82vUmhraRtX8+rHFQ2mc31rYudoTavnxzmfXe7VLc
	 q5OchuDUtqELAYoElWkCjTH7n2JfMVc1TQoTJml9j7PWFjeNx+Zz2LaYCKGKdqsDJQ
	 wd3u0SXW/f0Xd2ETZPBrmNUROzfud1kDupQS64bLx6PcT00DRfFsAYecqnUcgoNfBc
	 AVBlkgRyKnUwg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
 Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250825-during-ploy-939bdd068593@spud>
References: <20250825-during-ploy-939bdd068593@spud>
Subject: Re: [PATCH v1] spi: microchip-core-qspi: stop checking viability
 of op->max_freq in supports_op callback
Message-Id: <175676492358.901095.2384047110451067593.b4-ty@kernel.org>
Date: Mon, 01 Sep 2025 23:15:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 25 Aug 2025 12:53:28 +0100, Conor Dooley wrote:
> In commit 13529647743d9 ("spi: microchip-core-qspi: Support per spi-mem
> operation frequency switches") the logic for checking the viability of
> op->max_freq in mchp_coreqspi_setup_clock() was copied into
> mchp_coreqspi_supports_op(). Unfortunately, op->max_freq is not valid
> when this function is called during probe but is instead zero.
> Accordingly, baud_rate_val is calculated to be INT_MAX due to division
> by zero, causing probe of the attached memory device to fail.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: microchip-core-qspi: stop checking viability of op->max_freq in supports_op callback
      commit: 89e7353f522f5cf70cb48c01ce2dcdcb275b8022

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


