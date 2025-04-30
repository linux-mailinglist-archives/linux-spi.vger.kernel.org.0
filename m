Return-Path: <linux-spi+bounces-7806-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD4AA5857
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 00:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3489E28BD
	for <lists+linux-spi@lfdr.de>; Wed, 30 Apr 2025 22:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9834C22D7AC;
	Wed, 30 Apr 2025 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTJO18YA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B906229B35;
	Wed, 30 Apr 2025 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053531; cv=none; b=ZGMrNKO3nelJYxK2Va6Pv7RhOUXyDMDSCYF71uF9753pXJ1l32SMg9DAuoCAUbtk7ySmOXkZuDyhavlagODfmAId7NvS4VsHv5NMuU+SQeuKZ/1V3JTLxE/HfE50C5oko94fzYGW3eb8xRifZNixVQUGrMdbwVsABtgMnf+lxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053531; c=relaxed/simple;
	bh=VTTdecSWqZkIwO84VU3RpF9g0JpkxMMekW8Vy/pnaEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dBR0Nob+kHbiaHMm6iEW3OK5Nw2n9xIVk75e2UQDCEZ0/Ioi+TnvJZ6efWJ5IX5fhu6u/TLJ3/q79iOCncwbCERcry5nztbuhQ08mxvSwUmrLQQ7h0gdJGxhHZNpTi2/an/5CnlnkxQ9uEgYM8VdxkHZjzwFgLbDkUslHut50dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTJO18YA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DC9C4CEE9;
	Wed, 30 Apr 2025 22:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746053530;
	bh=VTTdecSWqZkIwO84VU3RpF9g0JpkxMMekW8Vy/pnaEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lTJO18YAIi3d0IroYi+EBORuVl7CoLb7ElhpSraEB6Wkwqt4Qd2VQsBZdEbkBT5Hk
	 gVxx0mVwUzHTYKgYJCma3P1qB6POfhPEGY4aZQaZINUxl5G8K0O8QlZpmA88nzC4Ph
	 wOnXsjHPeoCsJ8ZJ0FuDfRRZu+k7t81ddBMdNPHASY4WKo66GrOukFYfCeVXIBcWM+
	 gN/R3G9WWayuAowhazXT8lhihsmb65nxqTOBMZMWpq0rCsecOfGTc8BeL6GyTW5gCd
	 TnXxU6UZTLlH9F4gBGxLubX9tMxj8tIWLwSIOKVOpcJxceItntCivN8x8BQ3CmRTw7
	 YsYSLTC5Ext7Q==
From: Mark Brown <broonie@kernel.org>
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250428-qpic-snand-readloc2-fix-v1-1-50ce0877ff72@gmail.com>
References: <20250428-qpic-snand-readloc2-fix-v1-1-50ce0877ff72@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: fix NAND_READ_LOCATION_2 register
 handling
Message-Id: <174605352845.3987999.9189042209512194365.b4-ty@kernel.org>
Date: Thu, 01 May 2025 07:52:08 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Mon, 28 Apr 2025 09:30:55 +0200, Gabor Juhos wrote:
> The precomputed value for the NAND_READ_LOCATION_2 register should be
> stored in 'snandc->regs->read_location2'.
> 
> Fix the qcom_spi_set_read_loc_first() function accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: fix NAND_READ_LOCATION_2 register handling
      commit: 36fd6275818e93d5bc44140d546bf2a45e88feee

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


