Return-Path: <linux-spi+bounces-909-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCD78411F2
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jan 2024 19:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4F6281555
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jan 2024 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481C6F066;
	Mon, 29 Jan 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk6XcDfS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624B3F9FF
	for <linux-spi@vger.kernel.org>; Mon, 29 Jan 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552427; cv=none; b=NFbV7q3L8Vg4F8k8h/CPW7VHYT4U71FYSzrCm9bLTf5PQk/2gZk9p6/5X6AKxz10ACesmdq289HObKAb8r4VZ/Un1kH2AOD/RY9+L96slNpuj/kTPyPKNtknqLynFCxdFCZL88nuqqjk0beG9z2pHR88mWl0zl2KLkmoY3bLIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552427; c=relaxed/simple;
	bh=z09jQ70IR46KVkRqmtZ2NMyRM0wbnrAIBbTa/nT7SkM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=vGb9Wej0BRQsRQqCflk+sQHYdunySVQgwKAg0xeVnu+DWo2+M8DQw7nfoQzF9MhDRWr2YAb6eTKy+IKC+8nHxmv+CW5StSv+2FfYHQ2vx7cliL5qhJEjh5wqY9d/ubChMPB4gcoQ3Pi3nAVqbBGDVDYuDJGDyMlDeNZKXHqSW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk6XcDfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10512C433F1;
	Mon, 29 Jan 2024 18:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706552427;
	bh=z09jQ70IR46KVkRqmtZ2NMyRM0wbnrAIBbTa/nT7SkM=;
	h=Subject:From:Date:To:From;
	b=Mk6XcDfSxNXq/ZKP77vaDPGaadotGLKmkhVETnX7Irwh96uHTfQTQvMbeiFTTzTV6
	 wE602nX8J2Fe28E1L8ZmRlFz8YEfJsLAQtxF08b3DXQjhVtgaB64+CZmog8fK/gCd2
	 TBDGgV3OPYoAvKuZVViSxP1skBNI79DNETTRiN3iG2FbURSPSFh0GOuhADCPX7YOcN
	 JTZ/yryTrNlTqSbbMAyEOiouMfSlN7ASgJ+cCkafipPwInxX+3PQElEZwli1qbuV5A
	 DT+qM/Xh/+i3xe2EIKkdvqkMeJwTgzLi2vguixtBfnvk+TxQvcIsxSd5O/aqXn3wAN
	 T67zINhK+mRSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0EB8E3237E;
	Mon, 29 Jan 2024 18:20:26 +0000 (UTC)
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
 <170655242686.14738.12084710738334198162.git-patchwork-summary@kernel.org>
Date: Mon, 29 Jan 2024 18:20:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Kconfig: cap[c]ability
  Submitter: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=820593
  Lore link: https://lore.kernel.org/r/lq6gstev3sd7i4iw2btiq3gg7lhsraj5w74fkbp6lpbl6nkyff@tarta.nabijaczleweli.xyz


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



