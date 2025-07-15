Return-Path: <linux-spi+bounces-9104-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70098B0686F
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jul 2025 23:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9881AA0EAF
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jul 2025 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18F2652B6;
	Tue, 15 Jul 2025 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sumBobId"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E61E501C
	for <linux-spi@vger.kernel.org>; Tue, 15 Jul 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614385; cv=none; b=C6B0X0AI9VUuYLGW8LOqhJ1BdzrG8GRW2dj0so1LPH6pJK7FYvHSibt+CM3XHTOFMIYqW2aFyi0YUUIjP4VG6M47SAVGmViDzJXUfXcFKnFXdDF06ZyyO+wesH65FJngDB7KXz7I86Y2Bs7W4LCFJdh4Ig6Es6WCF8Tg3FEjIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614385; c=relaxed/simple;
	bh=F2y0n43Gh9aSQiw5sig+8mr5/CpsZ1nVg7hlYXsTADM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=p4mECSWjpMs5xZEJZpJTpacNMteLVQRU/+bvB5Dwq3e149+nLFSdc1W1D7YwtyCwpNCvb6xWZm0FhpVqQwBudNF0kvh6r1174IGXp0H3NuW1h8nMzchEBfH0Y2Ufz4ETw+zBQ+MX88QJ+Jlzx+uz3CiXR07XoHCZl/BxJSSZTHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sumBobId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96254C4CEE3;
	Tue, 15 Jul 2025 21:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752614384;
	bh=F2y0n43Gh9aSQiw5sig+8mr5/CpsZ1nVg7hlYXsTADM=;
	h=Subject:From:Date:To:From;
	b=sumBobIdPRBmV4fPUGBpSQv1UccrOZPRQJBNykGKHMrGXhrXbD4Hn9JCIc1kiJrIo
	 n6eAb0ImR0R7IUJlpz3zepnzlmp4KqfZisAY4C2DxpWhrdyM6lvdFSB0q8GSQMM4fT
	 mmPGSOpepOvEwJtqB+A3mwHVMxa3gT3ueMGe4LldoekZNNUHssACVklvmiWDLaKsYO
	 fS/9SfqvVtexw4gUXpjoSBelSHhb/nbOuPwCUPwqlBgQr9IeylVGGa2VDhih26VBUO
	 hsH1cw+NicOciLkhKanIjMq1BRpZBASVJQCj3EfGrFWd4Nb+Xis/uIVOEOzKKsAjGZ
	 BdUGqf1Hb/SFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37AC0383BA30;
	Tue, 15 Jul 2025 21:20:06 +0000 (UTC)
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
 <175261440465.584333.12904866921933058525.git-patchwork-summary@kernel.org>
Date: Tue, 15 Jul 2025 21:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
  Submitter: Raphael Gallais-Pou <rgallaispou@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=970018
  Lore link: https://lore.kernel.org/r/20250609-update_pm_macro-v1-1-819a53ef0eed@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



