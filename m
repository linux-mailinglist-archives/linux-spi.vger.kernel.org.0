Return-Path: <linux-spi+bounces-8138-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC8BAB8515
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 13:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9941F4C22AD
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 11:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE5A222586;
	Thu, 15 May 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEipzLMQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86089819
	for <linux-spi@vger.kernel.org>; Thu, 15 May 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309191; cv=none; b=jJ4NpRC+8nlopqiBw+sh+rUbQFAkpMJJIaX1cnvexsTSBraXe1JaLtbqMdhtHR3X5sZuPHGLA03dIiqZGAZGY53hIf+LXTFIqcqZrfh6ytqUGvTZmLSWqhFbvIIoFwN7t5ni/QkDDEhRa5YFyV2qMEtNDSGf7jrkDzSNX4FOQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309191; c=relaxed/simple;
	bh=vkaA0w/3X/EaoRZAK8zDjAu+rujwgecVYjzy28oQQ7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hkAs3/hI5Plh1z5zxe2KFqD2gM15UFz5s6czven6IlNSsmCLxv5mhx40U44i5Am5SWk+kZs1vkIYGYxH2hFkpR3WRT4QegX/YXcB747hLotugpXZlGZT+Hwagw9cYWYW+OrUKxq85PkQ5DvucIRkrX0eWcLAvs4bngG5/UuzL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEipzLMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B26C4CEE7;
	Thu, 15 May 2025 11:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747309191;
	bh=vkaA0w/3X/EaoRZAK8zDjAu+rujwgecVYjzy28oQQ7w=;
	h=Subject:From:Date:To:From;
	b=VEipzLMQX0roWDmInxXo2uAJP3WfyTjVZXoZRAOqUKrkHVLvsVvWu808cK3HXgVtu
	 9lj7wY88kuQzD1AKdwop0F8woZvx6VsTajuTYKQgokJQ+o4LDt+rOuAHQJa9keCsM6
	 Z4Oj+ddZuU4KfZCcc0P4jnHYzZnmfB1s7xBLgXT4BiO2QmZJ5kkt4zuo905jCNBkL7
	 r83b5ZEKB3+pEtBMn7F73+NUFvJvYm3zTKuft4B5MYzX/IHxV5jAdPG2FnAIdw0ZAV
	 DD5RBgyE2/LnC4Xoi7XCcZPlF7NDCoRSHFYVVeTG8w+mSZL64xh40b2Jxzv8u4m7YI
	 xq2HbGoEaTvNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 377C93806659;
	Thu, 15 May 2025 11:40:29 +0000 (UTC)
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
 <174730922779.3072533.16835473715742271441.git-patchwork-summary@kernel.org>
Date: Thu, 15 May 2025 11:40:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [V4,1/2] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI
  Submitter: Vishwaroop A <va@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=962555
  Lore link: https://lore.kernel.org/r/20250513200043.608292-1-va@nvidia.com
    Patches: [V4,1/2] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI
             [V4,2/2] spi: tegra210-quad: Add support for internal DMA


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



