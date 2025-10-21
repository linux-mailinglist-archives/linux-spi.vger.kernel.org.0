Return-Path: <linux-spi+bounces-10763-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC4BF78E6
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 18:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B5819A16B6
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DC52DECB0;
	Tue, 21 Oct 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+tcV8to"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C07340A79
	for <linux-spi@vger.kernel.org>; Tue, 21 Oct 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062424; cv=none; b=ervYkXF3yht5q28W3jd2m4HP2ayu1B96OMO/B7BT6mdwcNhmKh9NJ8J70TWE+FZFAXAberGya19epXWqiLEiB6UeAnxvE00nZTLrbKnVrZIcv+9WMpZp+QSXIzPPXt2ol2Ujl73l+YnId+FGINHQWoVKrWw05Qi7Qnp8iTBW7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062424; c=relaxed/simple;
	bh=g9I3vNWxc7hTwmQQk9OG3bbthVCeNvrmtwByepdmR5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Pho/jDULphMYj3nnluE/iyoNBpSuCIuyL269YHoGcuwNhXySQOZJz7JyyvMFY8tfcvxGqZ7WI/Ayhf9VkjG1znVfDHbSiZEei/mS1RQ5IP3LhmZe0AmA5eSL66lytKC4/vOsKjO25Fvg03xmyN7asMpd8H4rDsI24UsnghNvop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+tcV8to; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71320C4CEF1;
	Tue, 21 Oct 2025 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761062424;
	bh=g9I3vNWxc7hTwmQQk9OG3bbthVCeNvrmtwByepdmR5o=;
	h=Subject:From:Date:To:From;
	b=g+tcV8tofwXMeqaHr1gmL5hRXiYrLt2HZ0Cd2WkCwn+SGvnAlC3QmYhXW7iT5W7Ip
	 yxacHE/pgdOOiuo2J07oG3DLoH8veMXXBS2Ui00wrYlA0w1uchJfqvCI6pkaQ5By8T
	 gfBt2BGixrn8oN5VkYdabX0zZoFbKwGrjoOYY2gToAED4FPNqxG88F3Ym4CyoRkwwU
	 AF12Qjt5Yw1WP6OwEeL1PR7BfJhE1vqNfx7IRKj3MXPG3Qqh2VGozD2oDHtPtA4YTP
	 prwR2MbGQ3mKJkB18OLztQWDqn2pimxIdHjqejlLfWHcygyE4VX4PjaWD3VhFCUXac
	 W3FDjpSApsuOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 039A93A55F8E;
	Tue, 21 Oct 2025 16:00:06 +0000 (UTC)
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
 <176106240541.1137541.12161639894207520295.git-patchwork-summary@kernel.org>
Date: Tue, 21 Oct 2025 16:00:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: intel: Add support for Arrow Lake-H and Wildcat Lake
  Submitter: Mika Westerberg <mika.westerberg@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1013624
  Lore link: https://lore.kernel.org/r/20251020145415.3377022-1-mika.westerberg@linux.intel.com
    Patches: [1/3] spi: intel: Add support for 128M component density
             [2/3] spi: intel-pci: Add support for Arrow Lake-H SPI serial flash
             [3/3] spi: intel-pci: Add support for Intel Wildcat Lake SPI serial flash


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



