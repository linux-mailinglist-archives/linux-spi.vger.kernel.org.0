Return-Path: <linux-spi+bounces-3497-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697DF910267
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 13:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2F2B21839
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170C31AB531;
	Thu, 20 Jun 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN9j9FyE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24D1AB52F
	for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2024 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882440; cv=none; b=hf2lD1kHkRmqdzm6Jmm99pMVPVGBxSVclVwo5ZHqirvlhtW+wWlC2SGpDIRk0SQrHBYVKfg8tZT9QXDHcFmLx4yl3IQWhobkwODllRHTPOWlsBMVbxn/XG3HZ7uDYI6+MFTYS99MV9qZYuS4BZkL0Ue94yyhO1457Qyc2tHXzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882440; c=relaxed/simple;
	bh=hfTyBFqyeT46WfdtNCwm2dLCMxB0HOpuvYskVNXHCm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bRBpgffSxKVOeAY9I3EfiC41NJal2edqVb/RpD6OzHFaI4t9kVSz9OV2QfmjFVBRBIAghmio+BeswH2/tJq9Zgadd0r7MZya82xGjK4mrtGEk/Lv1R5PHcr2y7h0L2q9r8VRmFcaoatByTnd5mv2HbqZGA5h828k6tABiLoiKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN9j9FyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D79EC2BD10;
	Thu, 20 Jun 2024 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718882439;
	bh=hfTyBFqyeT46WfdtNCwm2dLCMxB0HOpuvYskVNXHCm8=;
	h=Subject:From:Date:To:From;
	b=RN9j9FyEvEAkZVXCFKCqgYXln4O4O/TP+HyKqoFNZidZhBIS90eSUZsecQYMveRE9
	 AS4Ga2sIVyOqCVtwoN04pAo8+7itMCl+jEoO7wVa+S4atqsPut4ru/8eSpJTJMirLx
	 TArU4kHS66INUn/809kcB143TEUs+nlYGZmKQGFUbGap8CZ2/p5kqcSWW1g0olbs3R
	 qMZ1ReMn8zDTCCscvUIOPmSAWGv5rFKaN7WMMQEQP8C+4GGau9rZ0Y5ov+YB+37hQA
	 0IizY/eOebAkYQ4Pa92kyJ7O6s7XTAtBWW0i7sUNVVoyLARDkEjdctpj9O2c8pXHP6
	 4Nk508dX16V5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 562FDC4361B;
	Thu, 20 Jun 2024 11:20:39 +0000 (UTC)
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
 <171888243928.18338.17704493177753113659.git-patchwork-summary@kernel.org>
Date: Thu, 20 Jun 2024 11:20:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-imx: imx51: revert burst length calculation back to bits_per_word
  Submitter: Marc Kleine-Budde <mkl@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=863152
  Lore link: https://lore.kernel.org/r/20240618-spi-imx-fix-bustlength-v1-1-2053dd5fdf87@pengutronix.de


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



