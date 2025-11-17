Return-Path: <linux-spi+bounces-11265-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D558CC65891
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 18:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A00A4F2514
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE23093BF;
	Mon, 17 Nov 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnCwr8et"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C63093B5
	for <linux-spi@vger.kernel.org>; Mon, 17 Nov 2025 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400639; cv=none; b=FTCcXxVN80I7iYjhAmqXSO4dYYD/IaokUoDuSYLRtDBc/zARlqOTev9piNek9JrekosAZZZsKyIjkIbL2SODu5zDfYNGBp+C92UXvyTlg1s448P4eJ9v8Mtkoin079QkY4brgpXC3yU6KHYWQwhngpUBosb2LyvFSbtuX3CKkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400639; c=relaxed/simple;
	bh=q4SrXpD6dISFSCCPyIbG1gJhx8I5rYfsaCj1/aPK008=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=a0Y8lOVOCu5TnQi7O9LGYgGHDuVX+utvdDZGxvRaqa+VwvBmv8FBF1ek+5tNEd4vDoz5Hf4tElTJ8JSfmr0BbBLWb7zqg+Sw+PwdRCoM/Fmq0OySoL59sz8Y9lni7ytCkWqKCjMdhmiONTohJ8IGWdXH1kyRsYUFlQRIRhM3LTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnCwr8et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826D7C2BCB7;
	Mon, 17 Nov 2025 17:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763400638;
	bh=q4SrXpD6dISFSCCPyIbG1gJhx8I5rYfsaCj1/aPK008=;
	h=Subject:From:Date:To:From;
	b=DnCwr8ethIaW9jz2tpMPUAej0v9qqw2hCTKvrWnDfEbFW3TTcNnJ+wAQK7rInoGb/
	 CaQec6NdOR8upFZveYwcDvPLSZGnQeyjfWp3RP/nRPnpqo1aPraht6XtXVzCtvrZxE
	 zHk17G88kMOjqgvlgBgOFIZvO8btOhKakKwgb37HVBSqnKiXW7tCZPgdAuEG6zKXxz
	 lAddVLtO3B4olboMTaFhdtNumIuZR4jHtPEMAZOGcLhX4ANnZf93H9OWJgT5fzO0ZT
	 /B52pJUcg54wfIbUJF359r55g+Tx/Y8beyQBbIarf117UcT8wSOUQ5UbIhCRv8hJIb
	 uw0sC/FFIBtYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B24483809A02;
	Mon, 17 Nov 2025 17:30:05 +0000 (UTC)
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
 <176340060431.3413199.17747959377537873496.git-patchwork-summary@kernel.org>
Date: Mon, 17 Nov 2025 17:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: bcm63xx: drop wrong casts in probe()
  Submitter: Jonas Gorski <jonas.gorski@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1023948
  Lore link: https://lore.kernel.org/r/20251116093334.17423-1-jonas.gorski@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



