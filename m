Return-Path: <linux-spi+bounces-1912-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B9F87FD31
	for <lists+linux-spi@lfdr.de>; Tue, 19 Mar 2024 12:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0B31C21CAA
	for <lists+linux-spi@lfdr.de>; Tue, 19 Mar 2024 11:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BAC7F470;
	Tue, 19 Mar 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkhTq6es"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01F1CD13
	for <linux-spi@vger.kernel.org>; Tue, 19 Mar 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849146; cv=none; b=kOpkPoZM7YT0TRwzZoh/w8xBUBBgiWVoJZa0Q9PFGMpMWuJakzs7LAXBsjeq80sotzD8tcmiTCIbWGnP3ycWVMTJFRH40c9ACRo2Ud477Bc3lXbhpmWz0uq2wOh3jSznCqzz3OUPinyAZRdwWQktcCszfHRRe28/ndG4+IK9LNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849146; c=relaxed/simple;
	bh=JSoMwgi0Gy52M6Smdt2TpjqPClfukcBb+bQ05aK4t0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=aJHKYIb/uk/vcqJS7X2bPHMw8hV1qtJT+idyau0N2B8qF91S8DvJax4GeKtihMO4vQPdl0S0Cb0ym4teHt9LL5Z77zNkbimaIenvzFNrDQvirvCh4bJm+iYHgkIxQieUNv6t6X78SGlpnlAYiXlDHJMpDN0Kqk02PFeseUuaiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkhTq6es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32627C433C7;
	Tue, 19 Mar 2024 11:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710849146;
	bh=JSoMwgi0Gy52M6Smdt2TpjqPClfukcBb+bQ05aK4t0k=;
	h=Subject:From:Date:To:From;
	b=pkhTq6essUvFqdI3NcXGOwnzUzJUgRvS4UBeZTy270CD8gCqNPfRn3Iywhiqkuxlg
	 D9n80L7p99eHJMt5e0rrT+pptcjAyzcs81vI86M00s+9JULAFdpgUyAvxIl2MjVXsR
	 4YwdgNi19e29EoEOBZrcJbq9aoY2pASzNZcV7HBcR+93SbAwZfWHskT4GILxS5cNd6
	 41tOokNOD+dQ2XfMNAogRi8Qa7kJaYJFeuAPezNRpfb5eOAHP2YtixYVhfiTVAOqvT
	 X8lCHWgkHtHsOsl30YT6SUigR4dCK8I+S3iTNGDc62C6zx+Z9pLrVxBDNyRpXip283
	 lIoEXeq8EftVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19BCCD84BA6;
	Tue, 19 Mar 2024 11:52:26 +0000 (UTC)
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
 <171084914603.22329.18314476347272145626.git-patchwork-summary@kernel.org>
Date: Tue, 19 Mar 2024 11:52:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length
  Submitter: Adam Butcher <adam@jessamine.co.uk>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=836161
  Lore link: https://lore.kernel.org/r/20240318175119.3334-1-adam@jessamine.co.uk


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



