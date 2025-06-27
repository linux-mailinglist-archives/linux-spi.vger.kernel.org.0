Return-Path: <linux-spi+bounces-8811-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D983FAEB853
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 14:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC80189FFDF
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C73264A83;
	Fri, 27 Jun 2025 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCBIcdue"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC141DA5F
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751029179; cv=none; b=jigil6z5dOPcME5p7fMRgx8SA4++H21JoWUG5EPjy86AF8Pvy+XbiP17XMUpUzH6VIvD2i03TdIOMyiWDeDKXJ3clWIMiUWGNYEXX4jZeu2peh3D2zxEGtwuHqRIjPHEWnq/wAzJZvBM0i0339DhUhVUfj49RCSf9KC5mSsihU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751029179; c=relaxed/simple;
	bh=fs78lyVBiWvgY4acvEeWn55PRiKcD2ILZB17a60GAQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=u0UtHenzkOl0xXVP4jEu8AL4aMWbeWhkJaJmNvB16xM59NLW8mx9Mgj3IBwLCp24WXS1XtHKrJiX1unjG96nRVec6rk0mdQ0mtunAHfprXlRgh7hK9uWvu34cWCO53+/Mt3Hkl4W9soiuA/3Erg8zrcfkqndiMdWDK5gi8qo4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCBIcdue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431E1C4CEE3;
	Fri, 27 Jun 2025 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751029179;
	bh=fs78lyVBiWvgY4acvEeWn55PRiKcD2ILZB17a60GAQk=;
	h=Subject:From:Date:To:From;
	b=TCBIcdueNq6mlcurnJoctCZPvFHW/t4FLwzwZx23eUwEbIicT9ML0RjPuaa8gl7OP
	 SNPjWTgqsAP2hF4AUP1iwso7teEwqu7dZfNGzMOEhZX8kN+kD2bSIWA5EBqzD1z/2S
	 XgSQhAEoo11Za14QUQCVj+g4y9BPD+MQGWZubqQxZdfOizsoYfD3IyNyw3I9YdnkfC
	 jOG9g/8GH7Aw1aD7n3J56FXr5QnrEPZbzm7ENvA0fh/jA/zHf6aTjAzQFAIrdbTjyg
	 oaMxuodV75sVUs0X9z7jwCBtqubQOms15sS8Q9o2rL4S822sgEZtcVaeoRJfEEwual
	 sFvmCfsdAP2XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74C11380DBEE;
	Fri, 27 Jun 2025 13:00:06 +0000 (UTC)
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
 <175102920503.1915790.9692985637443623817.git-patchwork-summary@kernel.org>
Date: Fri, 27 Jun 2025 13:00:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: Add `devm_dma_request_chan()` to simplify probe path in atmel-quadspi.c
  Submitter: Bence Csókás <csokas.bence@prolan.hu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=963140
  Lore link: https://lore.kernel.org/r/20250515083132.255410-1-csokas.bence@prolan.hu

Patch: Add `devm_dma_request_chan()` to simplify probe path in atmel-quadspi.c
  Submitter: Bence Csókás <csokas.bence@prolan.hu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=970169
  Lore link: https://lore.kernel.org/r/20250610082256.400492-1-csokas.bence@prolan.hu


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



