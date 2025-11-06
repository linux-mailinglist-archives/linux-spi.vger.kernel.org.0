Return-Path: <linux-spi+bounces-11100-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AEFC3DE80
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 00:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8AA3AE450
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 23:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39608355819;
	Thu,  6 Nov 2025 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXSlAOXu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F5E34FF54;
	Thu,  6 Nov 2025 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473272; cv=none; b=gvlpTzIjA99X9X1AozGmA607hWN30uo3aJYrJLkB0Q/sADHS9nOLNq90n1FIAPgzPYROkmfnCjm62abr1ZxTXdHD93XA6yakedIz8tDrOpq3JenQQjKaZj0LnOr4CRQFWBkfYtaZb5sF/JVlYvTBIWavC1AcF4epa5olyYh6rds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473272; c=relaxed/simple;
	bh=rL5lonvJ+6XWhO7NtUniCQhRINHtr54lMYQRxenrnUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jBxAj9SfQoM60MGlQ/qtOk1F0tIPFDk+YOkS21CJwd8+X1+pCVR0XKAT+fi6o2dnl66vWw7NV1ST2Z2ZOEVUyT+8wv4RWw+dDc20ae4ZaRmkDPahm6GvPgcZI09TKA9hqxVK8BFA6xFyrrW2uPND58YVt8wbfsfCrpzY03ZSzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXSlAOXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FCCC113D0;
	Thu,  6 Nov 2025 23:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762473271;
	bh=rL5lonvJ+6XWhO7NtUniCQhRINHtr54lMYQRxenrnUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LXSlAOXuzj8yYF5vRIyjoo32M8xD4WpMBiQw3/y2dcSNUfQBQWJyIEnkzsXHAoGvU
	 vwsMbYsiSFvqFmC06vYCoMjLA1GqOangYFDp5Ul+p24FmeAr7o8oDyCauT4UF5yOwC
	 Sw32h0l/wdv2xuZ2XTTxgps28KKohElsQfIak3qUIz0+aqdtbuUoc2KDRwFz674LCK
	 8QFpNVo9e20SfZAQ9KvKfp1+yjEuFmci37uJJA5IiiohmMeaCigy0xbBLcRkmjyVTf
	 M2I9yCCJTLmSIfjqw5ZzJC8PBvvXG+uF2dPtKshfKygalyJI163LREp9ecdzxdGQ+Q
	 Schr4wgHirzJQ==
From: Mark Brown <broonie@kernel.org>
To: frank.li@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251024055211.408440-1-carlos.song@nxp.com>
References: <20251024055211.408440-1-carlos.song@nxp.com>
Subject: Re: [PATCH] spi: imx: remove CLK calculation and check for target
 mode
Message-Id: <176247326802.2483158.5597170860062557920.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 23:54:28 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Fri, 24 Oct 2025 13:52:11 +0800, carlos.song@nxp.com wrote:
> In target mode, the clock signal is controlled by the master. Target does
> not need to check, calculate and configure the clock frequency division.
> The target can directly use the root clock to sample the SCL signal.
> 
> Therefore, remove check, calculation and frequency division function of
> the clock for target mode.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: remove CLK calculation and check for target mode
      commit: 55d03b5b5bdd04daf9a35ce49db18d8bb488dffb

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


