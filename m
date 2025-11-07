Return-Path: <linux-spi+bounces-11102-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF99BC3DEDB
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 01:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A03A2C47
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 00:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DFA3BBF0;
	Fri,  7 Nov 2025 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiSlihUN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178F249EB
	for <linux-spi@vger.kernel.org>; Fri,  7 Nov 2025 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473655; cv=none; b=LgPLT++0H+veM9Hqv2ZVi2lkRKgcD5Vh9hH4J670YDPZIlHumBhziXsBprqEjaNPB72zzOOMZjj1zv7XFlKq4Nje9Rm6+i+L1AxpSueY1PRrE20cgG51tqs8/IHbarahliYnZkq9dffvOPiOZ5m1v7zDjB8BNpVA4AtrM/HJb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473655; c=relaxed/simple;
	bh=P4C9WFix9/9Gaxk1rVxe8UgR81YMmihEX7zR6EmgbsM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=CP/Qc7ubLelYf9YzHyQ30RJZCtMvTBDx5TZIENlr3jNVN2A1xmnXA16WibBkpp9fweMnhSwARzDV1jcFHxBpm6RQm2/vNjjiQ4HPqJ+RPeL6zIM5xXZNyq23zrIOyzalo5pvXPadp67SnnuX1jBxmUoKenuwxAh1FjnI3bSuIBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiSlihUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EBDC113D0;
	Fri,  7 Nov 2025 00:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762473654;
	bh=P4C9WFix9/9Gaxk1rVxe8UgR81YMmihEX7zR6EmgbsM=;
	h=Subject:From:Date:To:From;
	b=QiSlihUN+U3zjM93RZBpHWYmYeGWd8/QndzfB6HEj5MWyAu/uIP48MnN3N+A7k2yM
	 7MWha1ug3J0e1SCPULHK4qI47C3a3TjDZxki4s+xhUC3d73pJuLFu1Tfa1717pgETU
	 yMiSA9DdSi9H6hn5afS9zjVG9YWCq5VcAkyX4z+6yYyLEdWw6Nc7aJCHU/teOP+u2C
	 HA7k1jYY6BRSznzyayIzk5VInjkRLbk0iNYcU+c6xnhTzT9Ls2tze8Ztis2Jyv7Up6
	 70U7O2X0MpdJQRNzDJbR0WXMoFSv9nveZLySKwfCk2/IGPX41PBNBCW/pBfV8JT1Lm
	 p255Xgm3TMHag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2B2839EF974;
	Fri,  7 Nov 2025 00:00:28 +0000 (UTC)
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
 <176247362723.398561.18132443361966441596.git-patchwork-summary@kernel.org>
Date: Fri, 07 Nov 2025 00:00:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: imx: keep dma request disabled before dma transfer setup
  Submitter: Carlos Song <carlos.song@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1016172
  Lore link: https://lore.kernel.org/r/20251027110406.543370-1-carlos.song@nxp.com

Patch: spi: imx: remove CLK calculation and check for target mode
  Submitter: Carlos Song <carlos.song@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1015313
  Lore link: https://lore.kernel.org/r/20251024055211.408440-1-carlos.song@nxp.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



