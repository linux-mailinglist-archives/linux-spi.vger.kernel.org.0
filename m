Return-Path: <linux-spi+bounces-5672-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88659C40EF
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 15:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC3B1B22333
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481E17A58C;
	Mon, 11 Nov 2024 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzMEh2ss"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808FE15A84E
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335421; cv=none; b=POjCCa15oa+mD1OBg/9pAkcWG44bKcjKplxgwkZfKtUJNRmgLEcKW8Ytjb+gFcH/4GsqWaDyWxZN3pD6yqFRUB6NnoDt2HgSGAn67slr6WkqVYU5mbxuTnIoa6KNbwHxcSg7fS/U5Xb25zBMDC1A+23DKYVjB+ICCA7fysrm5ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335421; c=relaxed/simple;
	bh=XjMdN7wV7TuYQkIXj+yXh3HjV40+QM6W7H1qEvj/vJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Mr2gXodeBBkCEiCrrMR079qGxkeTR/Jc8qQ2Of5/hBfQ2oFeuRkatQgwCtMaX7rQ16sARJcnM8OqPjm1vb5trBK3VFfT3o/jO5+P2AJaQqylk+H7pVeM36WQ4yBtgSaQ+R3naVk/tUBinsvD0ChKF/vLr9JtEOdG4FfduA04dAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzMEh2ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298EBC4CECF;
	Mon, 11 Nov 2024 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731335421;
	bh=XjMdN7wV7TuYQkIXj+yXh3HjV40+QM6W7H1qEvj/vJw=;
	h=Subject:From:Date:To:From;
	b=BzMEh2ssXdw3IiCAzwWC4/FCsf4aQCW2nFrVtvMMVHJRbJMEJfPj+M1COWO3sMCjH
	 sOCxhE/l7TX5DQytRQJzkRn83A8L2u1q+ERGwmPSrPwqjrLnLyWajKfMP6Lra9YKnl
	 Qp8fVUXwEfCA0t9mVRHF6pd1LySIG4rwLXG+AbXNa9mG0Itx5QJcKODCN5QbZ/cqOL
	 UEMTY+hMfTOn6l4F1bwzGdt/YLKGDIL/DWTBtJrVk8dnCbboEZogdj/cKKwcnj0vkZ
	 S4TQr0H3Ec0dUGJZDS2S+f8Yo9onD6kwo45QlNM23J5JF2u9NedKy3l6Z2RkJZR9PS
	 qcmrpQOLKBoNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37E803809A80;
	Mon, 11 Nov 2024 14:30:32 +0000 (UTC)
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
 <173133543061.4052054.8091981954407464855.git-patchwork-summary@kernel.org>
Date: Mon, 11 Nov 2024 14:30:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [-next] spi: apple: Remove unnecessary .owner for apple_spi_driver
  Submitter: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=908268
  Lore link: https://lore.kernel.org/r/20241111065425.103645-1-jiapeng.chong@linux.alibaba.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



