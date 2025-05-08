Return-Path: <linux-spi+bounces-8003-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAABAAFDC1
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 16:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899A1B2521A
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B426F466;
	Thu,  8 May 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvBb4yfP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE71CAA82
	for <linux-spi@vger.kernel.org>; Thu,  8 May 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715789; cv=none; b=QTvfA5641qar4fIuLpeY0oecyvxPKzO1nhhWCwrAAtCAbWd9nnH4Lq2LNUeCxz3srqAxKFxbJ8ZdtZs5hsb9ezPE01vlhwlcF3p581vmb147FnzDuUD44G0+ESHqmS51X5NDBDNNiZSiH/SFiPM72GOEMCQxMYmWQ0GDm1s9mio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715789; c=relaxed/simple;
	bh=1BISlPjhqCO2ClPLZdaW70MTTvGhEvWDIg/bVk3YKwY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=M+peJlwxQrzOkTmRMIhmHhrN8PJehBab2o4cMMRBuPH6wRDswOf8ArlxmgCTfZgKwalOrCHwhyzsjkaRhLZd7Jx+NoL/BufEd0kFm4ZvJzt4VWGy3n0flG8o56jW1l8GeCbA6DaL6g4cT8KwqxP9Nyr7CTtO0ZImTgL4oahWIQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvBb4yfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30297C4CEE7;
	Thu,  8 May 2025 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746715789;
	bh=1BISlPjhqCO2ClPLZdaW70MTTvGhEvWDIg/bVk3YKwY=;
	h=Subject:From:Date:To:From;
	b=YvBb4yfPLRNZ1BAvhXHYhanNYd1jHloUM1QKcxlGukxixQoBC1NtoMqoaYgLvbK+g
	 YQsVtprI9cFFD1opnwmTXL5YBcqutX/mqD35/cTutBIuV71+5Kc4rpPkRBS31k9BQI
	 Im4UV6CqM9j3KKvaGMdDBOFgXgphrCx9v6I2PELuPr5uOq2bQgulhi0S2sy8/OiGy/
	 nBuy/6RcSFL6wTCxP8Xt4+zSmFETUZQEV1U6C3smhXzgMNv2XOsr+s3bDEfUfePw2k
	 NOLZNoJc9ni20hqC0h7Brkm8vDCC9iozhzfZY+VWpAdef4GbdDTykMpx9ZtEZjnAhc
	 avuN56kVNBvDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEB19380AA70;
	Thu,  8 May 2025 14:50:28 +0000 (UTC)
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
 <174671582744.2937444.3524788674285363570.git-patchwork-summary@kernel.org>
Date: Thu, 08 May 2025 14:50:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: tegra114: Use value to check for invalid delays
  Submitter: Aaron Kling <webgeek1234@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=960145
  Lore link: https://lore.kernel.org/r/20250506-spi-tegra114-fixup-v1-1-136dc2f732f3@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



