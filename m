Return-Path: <linux-spi+bounces-7179-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4FEA65E42
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 20:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE287A77AF
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 19:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687951EB5FB;
	Mon, 17 Mar 2025 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi78Tk/a"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D0F1EB5F0;
	Mon, 17 Mar 2025 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742240577; cv=none; b=LcKLrkIC+jwB1+/arZfRRSBkTsVkBXnzpQOR15hVQGgCDDrrAlbW3YpV+Cwq7ftugDi6ag3kASZOttg36Lv2SwmnXlvuy9K4uwuZIZVAVE0PEyPx6mfitQyzLwLBasYm1sPhEURO/Nv/k+W+np9+9Rqh1S3p6TEEG7wylmIANI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742240577; c=relaxed/simple;
	bh=64zn1LRxMzHp3tIf8hLdxbOnspuHEvhaTuqVA+YAIgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MfUy9Xqu8QxuJ61bDJbcPGhZR/5vkEjo5soNse5et/wB2zLZWn6V5Nb8n+P4ZyQBsq+L+LVLvjlr9BFNHzj0eJq2Y+2rc8NVZ99cFObm+RRDxRtmwpOLsyDCNuQHPahP2CplcZ0BHRSUUlYaFWNUnEIIfLpH5rCakQGGiCNPHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gi78Tk/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE14C4CEED;
	Mon, 17 Mar 2025 19:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742240575;
	bh=64zn1LRxMzHp3tIf8hLdxbOnspuHEvhaTuqVA+YAIgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Gi78Tk/aFyrmSqPr6r0twWm53fbEmOgDu7/u3xOBv6CbxIdsDkpE0E2rZ3MipPjGc
	 Yo3QlbRPqnN2p3US4v3EGmJSveywjjCXJ9VxdIrD3cTlD2XwLKLbnxD1sF29pnFldn
	 CzK+C1oBgcDt5obs2DmqJVJ1hlNB4sofMG6RcvbuaMrmfZQrZJfDmcbKibPrrkyZeZ
	 sGCWHjazCTkF4avKEyemvSVoe+PXSuFaNCyfVmPoyfRRENiiRIzxHXSy/RN/xjgtZq
	 oLK0CEKOtnQZxixMNtcUvX+1e9nXb1ab1fxo1lP6PETUYBf1a+H+nHbLpipuhCkyA1
	 IhbfUYeXjNxgA==
From: Mark Brown <broonie@kernel.org>
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250313-qpic-snand-memleak-fix-v1-1-e54e78d1da3a@gmail.com>
References: <20250313-qpic-snand-memleak-fix-v1-1-e54e78d1da3a@gmail.com>
Subject: Re: [PATCH next] spi: spi-qpic-snand: avoid memleak in
 qcom_spi_ecc_init_ctx_pipelined()
Message-Id: <174224057417.315737.5360981783264401396.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 19:42:54 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 13 Mar 2025 19:31:21 +0100, Gabor Juhos wrote:
> When the allocation of the OOB buffer fails, the
> qcom_spi_ecc_init_ctx_pipelined() function returns without freeing
> the memory allocated for 'ecc_cfg' thus it can cause a memory leak.
> 
> Call kfree() to free 'ecc_cfg' before returning from the function
> to avoid that.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: avoid memleak in qcom_spi_ecc_init_ctx_pipelined()
      commit: d450cdd9c4398add1f2aa7200f2c95f1e3b9f9fa

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


