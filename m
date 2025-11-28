Return-Path: <linux-spi+bounces-11662-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D966C933DA
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 23:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07713A935C
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC622DCC1F;
	Fri, 28 Nov 2025 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxECo2+F"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360612DC791
	for <linux-spi@vger.kernel.org>; Fri, 28 Nov 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367983; cv=none; b=Jj5v0DQd8dxW7sWcnwX7yFshLYr0Yt2+NCrFrIGp6VvgavGna+/jTdgHZNRHns9Rph+mKJJ0J9sFSsNXXw9HjtoUhoq8NrHfs7heuk1VD7yR20OlL9oui8sQsndrtmL1wOShP2et1wZPx4pAPf4EyYFDJpu7DnqpdSI6BSLKtbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367983; c=relaxed/simple;
	bh=bYM+BkUEfjD7OPaMOCFRbJOlsMjpaGflUr/3Bmhwp7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hIfgr9Cuz/eixFp9AWT70aVcXFch50YPF9CPdD4QmoIvIwl+o7QoZOeZPY0dTfVLvr9yQGvcCvow6M2OM/pF2atGr0EOT+Sr2tz4EEMlM2bCKQIkittvYgE/WlE65bmq8ETQfwkARomcAjb/I/rtiPGSxVi0J8rNolBQVqA+Cxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxECo2+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A65C4CEF1;
	Fri, 28 Nov 2025 22:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764367982;
	bh=bYM+BkUEfjD7OPaMOCFRbJOlsMjpaGflUr/3Bmhwp7Y=;
	h=Subject:From:Date:To:From;
	b=DxECo2+FY0+vJSNI/GVv7W/ODMj6wk00KK5mXCe0sRyHJYqgD3eTwUYjto5uEgJmM
	 RLcZ5mVBI2wDCge2iqthYtHoUHkzpBxsIB2Q0o1dqJp+Ryp12yCLvSteQVZeretpkt
	 ay7bVNr+5J3dCJfvXnGFotZMZOufQ1aZ3yACGILEVT9qJXTWxBsJLY6U5aIj/mvvBc
	 bvW9fbdjr8HGwYWRk8qRgfnf0AtkCNX9OjhRTxPzMnwjd2H6TXAA+A/aZTXk7AYFi3
	 m+cVCEuZwfsfgIeHdWn6Q46trLNyfO0Xh0EDvXE6cFpDjWyZGFZm3DoM/7D3MqSofA
	 /lfiTEnDs1rsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D61C380692B;
	Fri, 28 Nov 2025 22:10:05 +0000 (UTC)
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
 <176436780393.813286.17087598987642195942.git-patchwork-summary@kernel.org>
Date: Fri, 28 Nov 2025 22:10:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: microchip-core: Code improvements
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1028421
  Lore link: https://lore.kernel.org/r/20251127190031.2998705-1-andriy.shevchenko@linux.intel.com
    Patches: [v3,1/6] spi: microchip-core: use min() instead of min_t()
             [v3,2/6] spi: microchip-core: Refactor FIFO read and write handlers

Series: spi: microchip-core: Code improvements (part 2)
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1028777
  Lore link: https://lore.kernel.org/r/20251128185518.3989250-1-andriy.shevchenko@linux.intel.com
    Patches: [v4,1/2] spi: microchip-core: Refactor FIFO read and write handlers


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



