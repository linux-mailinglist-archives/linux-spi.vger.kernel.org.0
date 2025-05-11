Return-Path: <linux-spi+bounces-8062-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5386EAB2615
	for <lists+linux-spi@lfdr.de>; Sun, 11 May 2025 03:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A6A174481
	for <lists+linux-spi@lfdr.de>; Sun, 11 May 2025 01:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFF442A8B;
	Sun, 11 May 2025 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N40GZv0P"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DB6208A7
	for <linux-spi@vger.kernel.org>; Sun, 11 May 2025 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746928787; cv=none; b=B8A18JatGD/0PbrbxonGp6aafgSi7vZ9M/ODkQu2TDc53gJNTvS6SqwhTW65ebeSynEebHepsYlKd5AMhOCwm3dZdo+xGe8skVR1jIgWhWxnOAeK8FSARMPX4O20o/d/mPI27aDa7AJ71ObhqaXAwE/Y1xonBLrTcTABHwNwn0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746928787; c=relaxed/simple;
	bh=4FYCfXfYT4G/+vMPu52ROGkrQxF8PI90HPgh8JZby44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Q21oFtDF2eAgB/rFc3hkMOv337i9FWeURT77uf0lvx3SczDzBTI1Lyvnhilvo5mYBLop2n/DPmh2AW4Egl1shcnyNPrdULtPy7d3lazFaG3B/pFBaHgp3CgDUxCprTiQ8Tyo4SqinIi242RzGyUMC7x+THmrRnPdEu9G89SdoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N40GZv0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABBBC4CEE2;
	Sun, 11 May 2025 01:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746928787;
	bh=4FYCfXfYT4G/+vMPu52ROGkrQxF8PI90HPgh8JZby44=;
	h=Subject:From:Date:To:From;
	b=N40GZv0PrlEkR4udqRlSa9SY37BfGgOl9YRL/Fp4B2gdvAQF5OaoZW6lIZMNCCllA
	 QtGjaONK2vLJ8DIzmZIAxcyzu4QC+C6pyHKet2XlWC5XK67/Oy2s9izeNoQRK1C4kT
	 dCRC2RoMTPFMXMUX+pxo66ImIpZBX7Uw0x3hHyONP1w/97q+ldjpm7jV0jQY3CEEcP
	 aO/KDd2jf5Wmexb8QCRYMmri9qnKW/bO5B0Gd48bUVBI+bPIy6Hy1eShJfvBwHUyot
	 fFQZeBXD0Ph3XIfZQ88WoZ375pXkRAv2crZyzgTcYHu78ESrOzb2VQ90WAN3x7ZlPr
	 4PXfS2a47RnPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 742DB3805D89;
	Sun, 11 May 2025 02:00:26 +0000 (UTC)
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
 <174692882497.4073699.16457902180534181036.git-patchwork-summary@kernel.org>
Date: Sun, 11 May 2025 02:00:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: dt-bindings: fsl,dspi: Fix example indentation
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=961309
  Lore link: https://lore.kernel.org/r/20250509112130.123462-3-krzysztof.kozlowski@linaro.org
    Patches: [1/2] spi: dt-bindings: fsl,dspi: Fix example indentation
             [2/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Drop unrelated nodes from DTS example


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



