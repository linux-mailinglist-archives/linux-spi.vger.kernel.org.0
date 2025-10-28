Return-Path: <linux-spi+bounces-10871-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A50C14551
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 12:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C4DA4E126A
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D749F3054EA;
	Tue, 28 Oct 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzQ8Chh2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF33054C4
	for <linux-spi@vger.kernel.org>; Tue, 28 Oct 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650515; cv=none; b=GknIF1Npk5nlwYyZaJGIFTXMRsdYq6tvPqk4LTHuujCjqhDEz/gqnNJ0rfHyvtqSZgGM/2OMQg9l6HeZIASC/RkRETjRICbMs0LG5qHVzUyLoL8THTMZRw+9R1f6iWREVGA6hYklBxAcBVHf7pNC05DydOEkDJ8DWUzgslm/mW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650515; c=relaxed/simple;
	bh=nhSpcen0HCWkdlCcI5k2oPk2ukeu4Q/7ajL7oJHC7fM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RP631+vUODJHuEFNS3Nx5ZTTX7DWaZ7MDrIygD6ngkDtTiWZ8dYsEoMcDdJVyvu039HIXcMoGEM9MWLeNjtKGxMjmmT69MMFemlw7Ywf9BumCdC9kqDFNXaiohkb5JNU8S7GXKEUFQx95RBAiGzs0x/PrKAowxtvYTxXyPkEB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzQ8Chh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A520C4CEE7;
	Tue, 28 Oct 2025 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761650515;
	bh=nhSpcen0HCWkdlCcI5k2oPk2ukeu4Q/7ajL7oJHC7fM=;
	h=Subject:From:Date:To:From;
	b=WzQ8Chh2/3T/7Nrl3MiQI9Dqy2/I6PkXoQx6PCt6Nx34spE7wSuGJiulmuMV+eVM1
	 O2kSxVAhaRy35uvKVExqY1zYBIJ+7F5/vF0seeG7XMwdQdLMFjR/C1FbqtGVtq9Jlo
	 Ehfpyy9ZACXSw5Qt/1P89ttWzm9r2hrnbO1Nt4AcymGXRru2/fN6o8tQDhYgE+xX8J
	 yIu8YGPTnxDAJqohsKLctVHoyfCrxEEjVPyHhmPs2ikYNOVGo0NLFMigQ38ydqedYl
	 MpI7Yf6sFQKXcAppARnO4dLuvtUoVc5H38N7D+h7RPg02qPEcbkSH8Bq6FQmULVfVh
	 zcxqCJ3NG5GqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74A4B39EF97F;
	Tue, 28 Oct 2025 11:21:34 +0000 (UTC)
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
 <176165049303.2189980.3165820528727107066.git-patchwork-summary@kernel.org>
Date: Tue, 28 Oct 2025 11:21:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: spi-mem: Trace exec_op
  Submitter: Sean Anderson <sean.anderson@linux.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1014082
  Lore link: https://lore.kernel.org/r/20251021144702.1582397-1-sean.anderson@linux.dev


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



