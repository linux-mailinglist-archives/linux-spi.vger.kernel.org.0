Return-Path: <linux-spi+bounces-2608-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C43848B5DF5
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 17:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE48B251C2
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B9C81AB4;
	Mon, 29 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGVnIMuy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182F81AA1
	for <linux-spi@vger.kernel.org>; Mon, 29 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405230; cv=none; b=LjsmI1gfg8KGhryff7a5Jhs9cd76PTaMnSN759RFDozYkXF6VvcH/M0yOhSz0FXWOGHFfcKAZzBWQ6i4pZU0INcs9k8TO13swMiTJ9QTwoXmtHcyqTIqzUtAT2dDVofQjqrr8fkTi8NqSFLvsaBVpdS6m2mFg/HkGwmyewJtEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405230; c=relaxed/simple;
	bh=m58hO+IRkW11sF3XouTiWGobCw3Yz/e5eD1BxKTwcvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mtZua8kGz4m8BwqfJP319nLl5fIVwGP1NeJyFH33X0gLiV0Ckws+j0ryO7/kQqwuz6hOWrVmqX2/dhAu/84nFmwUkN4utkpotS3a3PCywTqkHd3A40ThJP3FCDC3OlUqjfBMLG4LsM2CXmMu6vnUUGIbBuJOFrNe06nIEFOt9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGVnIMuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 182FDC116B1;
	Mon, 29 Apr 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714405230;
	bh=m58hO+IRkW11sF3XouTiWGobCw3Yz/e5eD1BxKTwcvk=;
	h=Subject:From:Date:To:From;
	b=pGVnIMuyR3LfPXb9GGB7+GM0JORrRcV+kmQyKJcv8Ba9fXxSDOx3eyuLEetHgPHaK
	 ouXZAyq7IPjwkVuzycx+KOsRJHrlqyiY6adx6H6s/H/j4uSvaDs7O+mo8aCb77GoSk
	 2Uq2DTdgg7DC+UwSOFJbOk5urK696zFanZfV/I6E41U9AofppLmCDGx5O84vIfdwXH
	 sgrYuAzJ/XedYAkfPwtqGE4QinxI+3VvRxOGMDdMBfytpivmk32izzGy4EsglvhATB
	 FFnai1mIsFOjD3aarushI2VjSknSB+oqQwvtNv8RBi901dFOrHnaPLSP18fxqP9NYj
	 VNuxWh+SwL+Sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFB97C54BA9;
	Mon, 29 Apr 2024 15:40:29 +0000 (UTC)
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
 <171440522992.13045.16859246889423228232.git-patchwork-summary@kernel.org>
Date: Mon, 29 Apr 2024 15:40:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: cadence-qspi: add Mobileye EyeQ5 support
  Submitter: Théo Lebrun <theo.lebrun@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=846954
  Lore link: https://lore.kernel.org/r/20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com
    Patches: [v4,1/6] spi: cadence-qspi: allow FIFO depth detection
             [v4,2/6] spi: cadence-qspi: add no-IRQ mode to indirect reads
             [v4,3/6] spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
             [v4,4/6] spi: cadence-qspi: add mobileye,eyeq5-ospi compatible


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



