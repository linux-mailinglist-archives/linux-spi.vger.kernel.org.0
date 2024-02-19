Return-Path: <linux-spi+bounces-1423-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF685A8BC
	for <lists+linux-spi@lfdr.de>; Mon, 19 Feb 2024 17:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70891F2216A
	for <lists+linux-spi@lfdr.de>; Mon, 19 Feb 2024 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F33C46F;
	Mon, 19 Feb 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QESmvcQf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E23B79D
	for <linux-spi@vger.kernel.org>; Mon, 19 Feb 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359626; cv=none; b=b55t8nlsEmB3kuJZdzX0vs1apWth5ShF3su+fTzZ4uMqNjEuAy60FMgx9WxBbIaCPEeQlx9XyyJ4XOrgTxX5XxyzgidK9RNmETtWEyZbj01LgZFIxGzp7gILN1GME3R/CkGOXHKo1gOCI2QKCf9ueaIAE6wjv1DPL0f+nfWTTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359626; c=relaxed/simple;
	bh=Yw1nhcAu3+dc93rXJZGHd59bMLQWrFVafnT8Qp6Zo5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=l1oevrI3c4W8M3PFyin8PWjlL4NzPQjjNuex9Rm6kQ9j+xXucvbkLDL9zelsq1cpwj/wACQRUpmcioIKdFvwdB031Rn5KcA1gvK4Ir9DEP1kmwjmuOtbsO1GHt+B/NmxJNJv+yo0ImMwKaJP5dcaWJDlnuRo165ySjRnALrLW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QESmvcQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 707F7C433F1;
	Mon, 19 Feb 2024 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708359625;
	bh=Yw1nhcAu3+dc93rXJZGHd59bMLQWrFVafnT8Qp6Zo5M=;
	h=Subject:From:Date:To:From;
	b=QESmvcQfE6wZg1VnW4VsPe2j1LUSCE4g3GrbDHvC8HCgLHyvaP/i/DtczuE+Pjm3l
	 UktgVolGS8SZqPh/LzfH5sM/BSoU9I1fGAJ8JgNFrzJTTpv5QGXZSx9ycj894eAH6K
	 DkD0nZPnA3jFeqMce3r+zaKyONqgS9WsAAW0FdwFx519KdYuV5DPhsInrwcWCMU6+K
	 Tsyk7PQvvikskY1sHGri9jHnLOq1uqysj8XlVkDElVAvqS/QwmSIjRBlrcMhoE+hT9
	 PPoE110CYFY8dFeTsk9P4OU8eV69j1sSkokcQgqvaZveoyB7MAvtk8Tea8OQjIH9hn
	 tIbp+P/6GFK2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EEDAD990CD;
	Mon, 19 Feb 2024 16:20:25 +0000 (UTC)
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
 <170835962527.9574.6593527451351265217.git-patchwork-summary@kernel.org>
Date: Mon, 19 Feb 2024 16:20:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [-next] spi: spi-summary.rst: fix underline length
  Submitter: Randy Dunlap <rdunlap@infradead.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=826651
  Lore link: https://lore.kernel.org/r/20240216051637.10920-1-rdunlap@infradead.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



