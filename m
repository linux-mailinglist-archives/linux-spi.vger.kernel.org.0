Return-Path: <linux-spi+bounces-4899-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC897D3DF
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD631C209C8
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D96113A3F9;
	Fri, 20 Sep 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhNi17QM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756984E18
	for <linux-spi@vger.kernel.org>; Fri, 20 Sep 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825830; cv=none; b=XZyiAz4yyNLAGNeOTItt6SulpF95gKDtMmneOMvubQy8XnBKND1IlOH0be5KY6sh4mZf44nyg9ctI/zR21L79Y0aIaCeYM9MbcmbNcxypYWPcgsxnRjz4oOHAOUJqQg8kOcP6OCM7L2w06fZJQnu9GgkyPfQua9V+qlUtfeGg3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825830; c=relaxed/simple;
	bh=3RdeWaAdHnxCR2EX3h3I32p4fBJ23YNp6j9FkBu8DU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=S+Ms/xNwJivb669qaU4M2D36EzIfy1LnXFsrzaenFvLvnozXDyLKhEHVCa7uvn1cYQnwq9tYlbO/q3YhtEFX3wWT860BxWWJSoxYG2nR7R+6/M5HPdHIwFxhKgvXxyIaYdJZEserd5+qoS7Oboe+9HzhSSxbWKncuTIoCvO1qek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhNi17QM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03574C4CEC3;
	Fri, 20 Sep 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726825830;
	bh=3RdeWaAdHnxCR2EX3h3I32p4fBJ23YNp6j9FkBu8DU0=;
	h=Subject:From:Date:To:From;
	b=JhNi17QMtHJwm1wmwYAXVYqBJD61HGdLRBBnIRVCkyJS7hxwpi3H8RkFdoUNXfK2K
	 7kkKGz5VDb0ppg/Yb+tGb92IOWwy04FNCHQZYHC1pCYLghKLiy6kVrST7iwmmpr99+
	 jFdOOfobGplh+FBvLMNIAe773Gu1iA3mKtbPYqArBe96gzDO85WA09H973rLsOatZZ
	 eKpqbo7VQrBaBhLLXLYxg8pZAfsb2TPOvgxrjJt93GW5a2WuXtpVeNIzCF36whS/FR
	 J3HEbqtuut7mW7X38sepFDEVAL17c3cM8VB3ckhXIsIJejTL9ybSJ/WQJiiBSOlZHW
	 daZqDMq79xb8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF1AA3806644;
	Fri, 20 Sep 2024 09:50:32 +0000 (UTC)
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
 <172682583138.2160960.7817313680117634802.git-patchwork-summary@kernel.org>
Date: Fri, 20 Sep 2024 09:50:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: airoha: Fix errors reported by mtd_test kernel modules
  Submitter: Lorenzo Bianconi <lorenzo@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=891479
  Lore link: https://lore.kernel.org/r/20240919-airoha-spi-fixes-v2-0-cb0f0ed9920a@kernel.org
    Patches: [v2,1/2] spi: airoha: remove read cache in airoha_snand_dirmap_read()


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



