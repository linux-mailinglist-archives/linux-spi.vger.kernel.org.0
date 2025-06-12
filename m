Return-Path: <linux-spi+bounces-8474-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4328AAD709D
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 14:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85D53A38BA
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D3317BED0;
	Thu, 12 Jun 2025 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4N0JNAz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEE2F4326
	for <linux-spi@vger.kernel.org>; Thu, 12 Jun 2025 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731997; cv=none; b=UpSOAzB8SJgs/lyM/IPOVX8cTEoDyC70TdL2b1MBO4rmDCeNWe3a0LZ0TQ132WF0ZCb1uP6UIdO/z4NTX8Ymuwq3VqoPMmmusGgSTWn2PqqfA4wF4wdyc3i1Mnnu1Tq2P10JDzang4c348uE0wfI4rut+QskovtUloK9+y/Hm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731997; c=relaxed/simple;
	bh=hL5HdwhaAWa+abAxz0PzAxIh7IvuxVXFmSON1HpeTOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ioVVFWmIDHMPC6DMIJCHs+G92lu899SB9gilvzJkB5Gl01xib608kIpZGAVgXy3p1zXSGzAa6eGli/Pq9s/PmrOSSOBBs8m3QBQENTkj0E8dtz57keGcAkQMGg1SEVMWrw1wJquit4DJXvb5H6OloB9iVMoNDBeq6hk0/rgbWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4N0JNAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C79C4CEEA;
	Thu, 12 Jun 2025 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749731996;
	bh=hL5HdwhaAWa+abAxz0PzAxIh7IvuxVXFmSON1HpeTOI=;
	h=Subject:From:Date:To:From;
	b=b4N0JNAzqlfUI+paT6xSdMR8ef7Jp/s8T2QwjiHvIQxIraKRPumkcvckPwX3ECVuv
	 B1ngHyj+pJxh8eUh05atqc5fQNuu0NonzmCai7cXf6ARZTnPvl5c43vrSx9tYVpQ2M
	 JGl/nxjbEizK11PF34UGsfl72NdZmuEewNRzmWD7Vn010GZf+TzNqwp1hhjSVwnH+V
	 jSNkwt28ISWNO6Li2h32nzY6aKuvqvLYveLzcJ2YZvTGd8cUkpXwmmPDduZBP8vh/s
	 snyo/sBN4yqEqw/h7PLnb2og6kdK5uTArP8fVWMFB+VHdFdvEtF8yeHSRQxv0eQ12h
	 0TCJBU78QlySQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE3CB3822D45;
	Thu, 12 Jun 2025 12:40:27 +0000 (UTC)
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
 <174973202651.4115014.10166602066673520011.git-patchwork-summary@kernel.org>
Date: Thu, 12 Jun 2025 12:40:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [next] spi: stm32-ospi: clean up on error in probe()
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=970849
  Lore link: https://lore.kernel.org/r/aEmAGTUzzKZlLe3K@stanley.mountain


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



