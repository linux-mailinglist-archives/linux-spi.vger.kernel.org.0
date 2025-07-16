Return-Path: <linux-spi+bounces-9116-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF8DB07C35
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A612A1C41FD2
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119062F547F;
	Wed, 16 Jul 2025 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLusnx0d"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17122F363F
	for <linux-spi@vger.kernel.org>; Wed, 16 Jul 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687588; cv=none; b=gpZeqbGnf4AsAlWg566r1WvZfJlpYz/YP2Gy9rBudLli76mIJXgK85eDtjVokFmcHZVZzCQVyTk103/fepOaKIRT3Gq6GK43QzpqqrzsTeft48KaEvO9mlYyt7csglJh/bxxXjMFcHYcYj/biMaOfZ1ZrSPLbWctrEqIGXru8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687588; c=relaxed/simple;
	bh=iX1dYwJJvAnmAq4zZTgpyT9wtcCWXFX5mqIeBDL6G/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=T9FjCCnPIrOtVJ/U3J7Bm8anAlRBdVJsoGvSZnikC3P8nWhKb+G/lvmqz7tEtjr3IcvJ2dGRa6iYHcUS0UOt3gT8XmZ9ShkI8GOJwAE1aNJCTQgMjiT7ZHDamLa7eULQakKUz9VCLPoxxWCLg0Ud/BMiFDlahHGuXeSEsDz0cNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLusnx0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8C6C4CEE7;
	Wed, 16 Jul 2025 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752687587;
	bh=iX1dYwJJvAnmAq4zZTgpyT9wtcCWXFX5mqIeBDL6G/4=;
	h=Subject:From:Date:To:From;
	b=JLusnx0dcy9JqDAA+LtJTDd5R8ado70PCUzFQ9loWk0Ola2ZReH5lzjNgol0OoUUw
	 qKOm+wmd4yFICWRaBF4oluOPBB+BDbVbhz/dp3N6cRyAgiKK+1DhPyFgyvAUBsOSC7
	 P8xXWFaFauuALTKF9rl6NcVbLMq567H5QMLvAkj7oo+TQ3/sPHY7y87XpKXZ/tqnAN
	 hoLfrZtk1J3ECAYxOCBv9ma/Lo5YC0yCdmj8bkSMvbnMi+UjDE5UPgh7QdBCysJvbh
	 zL4dRvhXSYEvEo8pH6DyRmC2lfryy3c5yUFBMWt4lT63ORdOp1BstcL4hW93Sprydv
	 LKMNL/yx0ZDqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2D82383BA37;
	Wed, 16 Jul 2025 17:40:08 +0000 (UTC)
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
 <175268760719.1270558.2274038368169499965.git-patchwork-summary@kernel.org>
Date: Wed, 16 Jul 2025 17:40:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [next] spi: stm32-ospi: Fix NULL vs IS_ERR() bug in stm32_ospi_get_resources()
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=982722
  Lore link: https://lore.kernel.org/r/fb2a26a2-119b-4b5a-8d44-b29e2c736081@sabinyo.mountain


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



