Return-Path: <linux-spi+bounces-8332-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8176DAC8001
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBC6A4034C
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36FE22AE5E;
	Thu, 29 May 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qus+Kilz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54B226D1E
	for <linux-spi@vger.kernel.org>; Thu, 29 May 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748531395; cv=none; b=mtOxFrIlbu912x2ohaIzow/nduBLsmzlQCVOobh/kBeXzfVj9UwOS6PhTNYSNh+X+A9dGlChPe60EHX7NoU+curki7I0CjkCZJEzpjOuiWwF3TAqWAwfQm+fhb5xTqi57VfLNPkn4wEdmBhcp087myfjLnNI47MimmOzzzTyltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748531395; c=relaxed/simple;
	bh=0U+8mkZ1KKrdL9cNiX7pI+9+Eh5XPJV5PT+8jOkMqqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZYpibbIUgod9GOVQbV2dpN4VMSJ1U5ElmSlzLtsNiB1BCrjBwsh5g7iyx16+mc3LxHziuGiAbzaLYs01Gwm6OAL5XcYEGti+1ChSrFYCkY4jIBX/bz5oqK1m2dE+VmNPPV8A+odQiXH1b7wouQkCGuJhbtuVtuVOpT37yAdEZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qus+Kilz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2409FC4CEED;
	Thu, 29 May 2025 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748531395;
	bh=0U+8mkZ1KKrdL9cNiX7pI+9+Eh5XPJV5PT+8jOkMqqk=;
	h=Subject:From:Date:To:From;
	b=qus+Kilzkbse3APeMFLjhUgr5atBlTaRx6lnGIUy9PYVXJm9jZsonSeRqtqn54EB2
	 5arjhLt9uhk2g/aGAB2e28drmTidSztKtIt7Iehda8sCPOGshH0JIHSZ34ybkLBwpX
	 ybtKrisjB/Mvbuc70plYczxICFmpazVcRPV2MiMYu6RYTyggXlHznjSQDwye7TFKpr
	 WE+i2E4UZg9Xsl7KzwUxNFIVIXGvVHHkBpaBfXiopnV269kj/sHMC2FWHTPHgyaY4/
	 IJ+FASRH1VouLdJ0w4JVbA9YFM/PIv4is+PgcTz9pRp+2y54BXQS2uSXzjfmwaAszh
	 XOZDCG/ajrX5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEE31380664F;
	Thu, 29 May 2025 15:10:29 +0000 (UTC)
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
 <174853142836.3293316.17061132438510919727.git-patchwork-summary@kernel.org>
Date: Thu, 29 May 2025 15:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: MAINTAINERS: Update HiSilicon SFC driver maintainer
  Submitter: Yang Shen <shenyang39@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=967228
  Lore link: https://lore.kernel.org/r/20250529061704.190725-1-shenyang39@huawei.com

Patch: MAINTAINERS: Update HiSilicon SPI Controller driver maintainer
  Submitter: Yang Shen <shenyang39@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=967227
  Lore link: https://lore.kernel.org/r/20250529061406.183992-1-shenyang39@huawei.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



