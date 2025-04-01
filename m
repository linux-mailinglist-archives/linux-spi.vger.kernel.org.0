Return-Path: <linux-spi+bounces-7385-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826C4A78133
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 19:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819F218907A8
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF061F150B;
	Tue,  1 Apr 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y50lC+pK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7842EAF7
	for <linux-spi@vger.kernel.org>; Tue,  1 Apr 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743527397; cv=none; b=jrh3y23Vmp1Le7Z+nAIRNm8bIqAVzWxX8WauqkUBUSUhxU6mDsfl8WUfjAV/+4L2orvLNGa49ptYJA6lv8ibe1lMgADV0Dn6ADEoRJJXpHJGgtmHIZ8mpiu3Uz9EkYgleHiuR9eeQdEfy4SpkPvwRZej9B3eDaZmm4o3lkm5Wsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743527397; c=relaxed/simple;
	bh=scNi9CEryJRd2PYrDBsozIoJmjg6vbUHxayWAcqjsb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GyFMHLgVjbc6ao6DC8/R9nCe7/Z7VqjpVeoVimVGU1f1e4hGJl7jW2n3NftP3z+36t2icjKNH4scu5GLzXv7NrOP4/U0w1ISS5JbjI+sF2ZCVUkk5dGnX2GfFOpgCwjWwTTHSoiIm4WuN0htszxqk/r6gA4RknqOCpVNFNu8VNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y50lC+pK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA4CC4CEE4;
	Tue,  1 Apr 2025 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743527396;
	bh=scNi9CEryJRd2PYrDBsozIoJmjg6vbUHxayWAcqjsb8=;
	h=Subject:From:Date:To:From;
	b=Y50lC+pKphkZCd6y8BFPpe50gZ1Oi5/bs5ZLW2h7ZBFL2tiimonbqvBcF3DtHlnLD
	 SBHpOOUQ0MSUh+Z6GMeJ8p8QfOABSO1t1mt8cb/eAZa2SsJERBnrlGrbHqU2uA+nit
	 906MOl9DMjyzQ7Xc7P6X5sq8A8aFzhUbroyH8nr6zlbwQpE2aGsIHo47oQD78PNpyt
	 UGNZUE9t3q9TN6rpsZzIbq5682QhBDchEbzryFj/IIFw1IQTngJpmu24JNEuDzZ5sn
	 vLYByiqJMIwFhqTafK1jCk+XJfyWyz/YGNbmi+l0P7snL1VpzwPkApksoRfZGfM6ul
	 F9kNismKhYNdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 387AF380AA66;
	Tue,  1 Apr 2025 17:10:34 +0000 (UTC)
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
 <174352743290.839871.4271233950789077036.git-patchwork-summary@kernel.org>
Date: Tue, 01 Apr 2025 17:10:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: Revert "spi: cadence-qspi: Improve spi memory performance"
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=948149
  Lore link: https://lore.kernel.org/r/20250328173500.3687483-1-miquel.raynal@bootlin.com

Patch: [v2] spi: cadence-qspi: revert "Improve spi memory performance"
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=948960
  Lore link: https://lore.kernel.org/r/20250401134748.242846-1-miquel.raynal@bootlin.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



