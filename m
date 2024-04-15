Return-Path: <linux-spi+bounces-2357-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226638A5ED0
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 01:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F83C1F2181B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44052158DB0;
	Mon, 15 Apr 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t16dUnNu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BC157A61
	for <linux-spi@vger.kernel.org>; Mon, 15 Apr 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225035; cv=none; b=qzjIR+QDWoMB7URkSwnYsE+/w9qjPgGM6juQmRG8XhHEZFKs+6TCNpyBteKAxUzfmLD7i0aW2U3QXjk9RHqWFK4qYp1K21WC0YpcJBhsULU/UlsSAJ9RmFEFomcwaem0D+8+/j+Odlb5N3LFtTtAjD73GNt9ThhNTqH4t4cVSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225035; c=relaxed/simple;
	bh=EtFzD2QQt15+t0QIQkCApdGZ2xX1VNTvronLEYu+aYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HOCYg9cOXdoAJyoPn7tMEKb0v3PljV1+EOBB7t5vdYq6FETvFrIq9EVrydauq3dJFWD6lvx/F8dgTM4ermS4kKmLZVFbuiu4oxWwUyqG9kiH8/YDTm3sjd/fV/Fs4JKzw+bfxGPSJI49vFT+YzedWPQBrMW8n6rYqeBL8/rBeFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t16dUnNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3337C113CC;
	Mon, 15 Apr 2024 23:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713225035;
	bh=EtFzD2QQt15+t0QIQkCApdGZ2xX1VNTvronLEYu+aYw=;
	h=Subject:From:Date:To:From;
	b=t16dUnNupY7GbGUQtpjjkQgml12YHlSSWhieo7iwPQUjgYD6HHdq3CokJwyxB7K0o
	 ZjzqtIP+5Jm3u1K3fFBPi6Cd7Cf2EhMfdP2m8Ykn6U+MH00ApWClhR602sxrFNQY3D
	 YbWQTYPCiWr9CkIpp5zxZJdJ8vlyylKrB9sM0/vx/oR1o/44GcVgMMHSIFlRosM3/k
	 sjZDWXVBoOHkXrKf+h/5vlyHXRTP8SB33XqIkn53XSulrhOX9m484RuCmFqb1pBDdh
	 BkMQDtOaXuzfj7wvtymlnVXjdy4H20SYF5wMIVwZkWi1WuJ5UPGmGBhOXo7PpyUHtM
	 uRM+GjxaqXYug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E246EC395FE;
	Mon, 15 Apr 2024 23:50:34 +0000 (UTC)
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
 <171322503487.3168.5247856054751142625.git-patchwork-summary@kernel.org>
Date: Mon, 15 Apr 2024 23:50:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: pxa2xx: Cleanup (part 2)
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=841169
  Lore link: https://lore.kernel.org/r/20240403171550.1074644-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/5] spi: pxa2xx: Move number of CS pins validation out of condition


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



