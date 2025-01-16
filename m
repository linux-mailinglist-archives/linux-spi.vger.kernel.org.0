Return-Path: <linux-spi+bounces-6368-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEBEA141D7
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 19:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DAC11696E3
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6122CF3B;
	Thu, 16 Jan 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud/dGwe/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454815530B
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053409; cv=none; b=k7usZba7QemLPVZ2l51wb/t9nBv4LPL4+B5bUVtyjkhoSWC26ulFfWjTzZFSg2oB9CH/WXuO3j52gse8WaORU9auhmPKuATB1n3YG/zOyuJA94VR767clCNRk+qk/NqFTfn/WP1qUHPQm9ItLkGmFIoSfg1Vh2FpX2+/iv8723E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053409; c=relaxed/simple;
	bh=DOLeg7jwEbwwOacKkbyy4pCeAk/ym6F7qP7hoM+rKkc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TwgHa19gn1wvBG//s3+QvmH5xSmb6KEkJ4ROoJc3gYEjF4eUvUM55rKVmcbMic8ELXuVoRLcEztoqS/c6PDajA1ncs/2vlk3cA9MT7JP+9v17s3wf0U46Bn5aXg5uTI5aqVQwtzEvybEI5QkkrnCQH9L44y74KeJ+K4F9SZhRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud/dGwe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021E7C4CED6;
	Thu, 16 Jan 2025 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737053408;
	bh=DOLeg7jwEbwwOacKkbyy4pCeAk/ym6F7qP7hoM+rKkc=;
	h=Subject:From:Date:To:From;
	b=Ud/dGwe/5nWni3BtrZHg8NUfe9XDTvoQdRPh7eRtQf05cqIapDgzjKQeQnuIYUR+6
	 D90GL3dY2sNVqEpKOdw+R1P9oDtxilmy8/fws8VASLIIVAew/+lTNnfA7PTo/uZCxs
	 R8cdx3JmLJhxDk4oQdY8mAHXBAcUD9TH/QAgb8nUvfR4Evrtfa2iem9bRvLziyWQ7p
	 uenej7Az6GgE2mSEgTr277BaTlpkOuAoP1GXLXD/wKvFm9DSWZL3aa2a0XwIy4dXed
	 Y4Emp6hNThF5mgIGl3ONwm5bP/xsgh0Hr6y5RzHZ1SbFxtmUdrGvYXp8kyDiJF8Kp4
	 eskmEsCnHa1ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3AED5380AA63;
	Thu, 16 Jan 2025 18:50:32 +0000 (UTC)
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
 <173705343064.1552644.7200006141925925448.git-patchwork-summary@kernel.org>
Date: Thu, 16 Jan 2025 18:50:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: pxa2xx: Introduce __lpss_ssp_update_priv() helper
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=926150
  Lore link: https://lore.kernel.org/r/20250116162109.263081-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



