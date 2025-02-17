Return-Path: <linux-spi+bounces-6846-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2FA38306
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2025 13:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB819188DB36
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2025 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032857F9;
	Mon, 17 Feb 2025 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8N/ZRGt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30DCD529
	for <linux-spi@vger.kernel.org>; Mon, 17 Feb 2025 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795459; cv=none; b=mMEQH+277y8LxP8cEYqJTqnNLnjKF0iw/rjtIwUrorGu1CPrTN7xjrmSrY4KkSjRTGwT6/Pm4VvqKAbNdNgblBGHkTXXHYb2LGMa4Ql8jOHe8oAQeH2I/HgrPOR8XJfhl26+72F/JFsEhBzCNyLcg85jJWIPzPhAHygvipjfBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795459; c=relaxed/simple;
	bh=8xDJSRU7MqizTL1SvK7Z5gqs0s5uyTVLgtxC4VsUkNE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=iFIwU9/n5tL7zZ42+xE286klVPdSMAcM8C62oKKxhlhW9WYKTkL7YSAyi4t8wMP+2xZF18slj+CC5gIgCu6KR603qUyfvc3svT6KxvNrTWh54ehWysRS0OhDrw6RlNTr3W91+98i9oUxQpQYx6I1Q2SqtHQvFbFysLMuYnlFGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8N/ZRGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5170DC4CED1;
	Mon, 17 Feb 2025 12:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739795459;
	bh=8xDJSRU7MqizTL1SvK7Z5gqs0s5uyTVLgtxC4VsUkNE=;
	h=Subject:From:Date:To:From;
	b=t8N/ZRGtlY7RtNNoVp1+dE04FbzkE1TSIUdRAnrED/EmYquvRb/zYS9KsWrDIDpyU
	 JekYRJct8eWDOkT6ksMpYOhPlo1vGoHj6QlTPIkh712HIgOPMhwHBbexyZMbx0bbSh
	 j8uDMPjVY6pt/1lQ3O1Nue6BdUNsfzj7zCC4NT0lM+t0n6cTtyxBcv84gfEZ9Pmq0X
	 fRDYCbVmr9w8U3FkrYzrC7kBsAzZbhQp1ef9woT6GzPKdZeigQbBHmIjhf/dPBRJbi
	 mHQBfWKQXFmfQS3gM2qVR/yKw2JOuLSgpc69qybMCy40jbXEZTkwVSRen8CpV5ozX5
	 IXmf1cp/8jGQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 75A9F380AAD2;
	Mon, 17 Feb 2025 12:31:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <173979548897.3405233.7072418922607588393.git-patchwork-summary@kernel.org>
Date: Mon, 17 Feb 2025 12:31:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [resubmit2] spi: atmel-quadspi: remove references to runtime PM on error path
  Submitter: Bence Csókás <csokas.bence@prolan.hu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=931571
  Lore link: https://lore.kernel.org/r/20250207122145.162183-2-csokas.bence@prolan.hu

Patch: MAINTAINERS: add tambarus as R for Samsung SPI
  Submitter: Tudor Ambarus <tudor.ambarus@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=933503
  Lore link: https://lore.kernel.org/r/20250213-gs101-spi-r-v1-1-1e3ab8096873@linaro.org


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



