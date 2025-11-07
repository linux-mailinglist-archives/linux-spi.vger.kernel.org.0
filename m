Return-Path: <linux-spi+bounces-11108-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2D8C3F39E
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 10:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF693B294E
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45999302147;
	Fri,  7 Nov 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRb/NNqE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205382FD691
	for <linux-spi@vger.kernel.org>; Fri,  7 Nov 2025 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508434; cv=none; b=E7P0OPq2+ix+d6TbcHjk3BXs1ZHXwe9yg70qEoIlNA19GxEQrCq/uKz5bTZwSyvY6bjxRwtucG+kTup+9/ZmXm2l4wiqLtCKE2hMzJ9GZcrNOl541PkyQ5z69W+B2J4bqMo8zG1BAGKpR6I30DbCZS6CYNjP6fyYT1oS9X4dDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508434; c=relaxed/simple;
	bh=6bGSNFA9Rn3mbKvMdoYd9dp4SsHXzg7MeP4WAjXjP3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OnuZv1eRF+Fs2oOQmtY1a/Yrd9wVOD1jw7/uI35IEAI2uHhlCpRUhH9HTGOWLukX10rkKLU4zEYLfbS5g36ZVHsH3mk1jl5NM5OD8VVVkGKHpSesFuRTaWHJyhZVu5kFiR5B1gpbUm9PXZqJNTGgjbbcRpuHYWxHyr019janvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRb/NNqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951E2C113D0;
	Fri,  7 Nov 2025 09:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762508433;
	bh=6bGSNFA9Rn3mbKvMdoYd9dp4SsHXzg7MeP4WAjXjP3E=;
	h=Subject:From:Date:To:From;
	b=FRb/NNqEv6cr89vNeWPXUu1vkTaJwBLnncoiGSz4mUaF/sim695ymFeW/a/VyCjhe
	 1bM+Znj0vw9UmW+vPQPsW5I7KGJXt/MXnFSR1Bi9UPQS9PlF9SuB7xc6EDdt4s1bUD
	 QiZyNWrniswTLtGfhplhZBE1UAINqOoRLAFfoZQ1qWLjaU+fgiMQiPGMGTc1VMYEcG
	 WSsJA+av8Tr3hlqtnxih5K43ZZUYC6yr6F7GutJOLPuwWPQIZD88GOXtm1ZUU1yGdp
	 f80sPD3+BL3NVvxJnypi+fbicA350rPykLvIEtFDt44+Ml2SfADz8E3HRmzS+F9gu/
	 flwcYJ6rz5a5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3776539EFA51;
	Fri,  7 Nov 2025 09:40:07 +0000 (UTC)
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
 <176250840563.935102.11876738767389853453.git-patchwork-summary@kernel.org>
Date: Fri, 07 Nov 2025 09:40:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: imx: add i.MX51 ECSPI target mode support
  Submitter: Carlos Song <carlos.song@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1016171
  Lore link: https://lore.kernel.org/r/20251027110256.543314-1-carlos.song@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



