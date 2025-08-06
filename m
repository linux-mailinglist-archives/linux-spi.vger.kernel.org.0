Return-Path: <linux-spi+bounces-9302-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFDEB1C5E1
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFBF626128
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0153228B4EF;
	Wed,  6 Aug 2025 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFJ/g13i"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD78192D68;
	Wed,  6 Aug 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483490; cv=none; b=Ux+2F7HdcfO7tyKL00LVgGJWDeNgHVVwiHveS4mfSNH/YPN8JNytzREzZsLxNdvXyRnFTZ1fkEmevtT+8JAkHiuxNNvYggmFvYeoMmP+cLw/NXr7EWagi+2aZLsLEbDHua6PWUG659ainqdqvp9aU7thuV3h0oYo9E5MQjA2Lso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483490; c=relaxed/simple;
	bh=pddWyPwjs2fOn7Jr05/MG2ACl0zA9Y4SSHMKsBzkDy8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vc+HKLeMCJua97Ec3A4eyfMVpRCiHOLisP1l7dROBXWKan999Lwb4bC4cdZ+fi2a9XBfZqDda+XQxwhcl90yfFf8toKULQSeCPkzhlfZDZxS9PKgjdnNqF8oKtwm1uC74phKGhSuP6kuCNlBcgHWdWMvfGICnp+L4DOF50Rrrmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFJ/g13i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4665C4CEF7;
	Wed,  6 Aug 2025 12:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754483490;
	bh=pddWyPwjs2fOn7Jr05/MG2ACl0zA9Y4SSHMKsBzkDy8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WFJ/g13iFNkaHr2ywCr9SJjhaz+5pikuyhff1olloeRcHEszoBfd6GjeLMNBN3IDL
	 HIyBIZp77EEgz4E/RcZ9pU/AnOmxutrgAWP4XYGQsABk7My9W7279xSBw4vSyZcrL1
	 ZYEjplmCBrxt9r4DylI4d8nh1eyDZYq/VfdZ586lgDaOQEkbvWPpbMazpSjecLHxqo
	 7iEqIRBgoR2DV3S8/DatxIY4SE/kWMtLr2tbTBgBSxRI9/THGBP005p9XK85JMCw1r
	 MYL3xADx07My/pFHLIZ5cDqt18z6cXqt4WUTu0oKird956Dpdh1IBQYbBivvLp11Ve
	 bl1cf5xgiEuJQ==
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250801-qpic-snand-oob-cwpp-fix-v1-1-f5a41b86af2e@gmail.com>
References: <20250801-qpic-snand-oob-cwpp-fix-v1-1-f5a41b86af2e@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: use correct CW_PER_PAGE value for
 OOB write
Message-Id: <175448348842.51843.4908652099889522195.b4-ty@kernel.org>
Date: Wed, 06 Aug 2025 13:31:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 01 Aug 2025 09:58:35 +0200, Gabor Juhos wrote:
> The qcom_spi_program_oob() function uses only the last codeword to write
> the OOB data into the flash, but it sets the CW_PER_PAGE field in the
> CFG0 register as it would use all codewords.
> 
> It seems that this confuses the hardware somehow, and any access to the
> flash fails with a timeout error after the function is called. The problem
> can be easily reproduced with the following commands:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: use correct CW_PER_PAGE value for OOB write
      commit: 6bc829220b33da8522572cc50fdf5067c51d3bf3

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


