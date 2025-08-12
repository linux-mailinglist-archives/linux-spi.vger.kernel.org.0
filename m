Return-Path: <linux-spi+bounces-9376-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA7B2295B
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 15:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CCD5042D2
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06E52868B3;
	Tue, 12 Aug 2025 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5miYDu0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1B27E04C
	for <linux-spi@vger.kernel.org>; Tue, 12 Aug 2025 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005994; cv=none; b=lPJ62eCCjDJObbsZgfT9hGH/nDP2MePZNsBPGRwpj4wNGVBvVwNtQaHUo0rZQLfRDvSpsCw+v/B9jjlE23wzE4ogINhJ5cM1P7+gVDMrkdgboYIgbbgtnCaLAD7dTrqSyytw+UrfYPzd6LhYSxfMFF4Jf/raaF1c6t9vatlhe1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005994; c=relaxed/simple;
	bh=iTR+H5k5JzIPfQozQTkirOVqq6VZoM/c2zJeXnP8UFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Aajy1duxXWoIm1cDN3qdVoInl6Ci4Qs/sMeLxbPMGtl9csTOtriN5P+G47PV7naWN1B4kZxw55GnzwNrH2MbPwqOsBep45Tk0Q7YKSJGYuq8sid258ikxKPjcjE6UBQYJPS4D8+z/OIZC7fDfWdAX6lIxlY9P2SI+WFO/gCEbxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5miYDu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56088C4CEF5;
	Tue, 12 Aug 2025 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755005994;
	bh=iTR+H5k5JzIPfQozQTkirOVqq6VZoM/c2zJeXnP8UFM=;
	h=Subject:From:Date:To:From;
	b=W5miYDu0tVqA/Lph+nrPW2ujXnWdbjfA23Sm51Phhmbd6tJ2rBIF4XuHiWATJlfpY
	 HxK36GNr5GR15o6EZfNrYFAmSlTYDrrmVYLHy+Kh50s+I5sUp76oxhzp34sabHDH6D
	 aK7622x6qcbi0cRhjczxIawZzTTYtDajOluau1lrl0BF6Z2sy/lw+7l5TUXHZO7fyd
	 SfMfHtti1wlPsPb14fteXZU77gciYYklk3xdgNvdB3ZCHXviKN+S0b7XFOCPtzs8uU
	 FkVminQgRLjjG0fBawwdphtx5xGiVc/Tw9oHpZ5lXD5yDgckolWDtiWz1mgBB2HC3y
	 lyOyTkeWD5g+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7B401383BF51;
	Tue, 12 Aug 2025 13:40:07 +0000 (UTC)
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
 <175500600590.2622949.9669735538927929467.git-patchwork-summary@kernel.org>
Date: Tue, 12 Aug 2025 13:40:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: loopback-test: Don't use %pK through printk
  Submitter: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=990011
  Lore link: https://lore.kernel.org/r/20250811-restricted-pointers-spi-v1-1-32c47f954e4d@linutronix.de

Series: spi: Remove redundant semicolons
  Submitter: Liao Yuanhong <liaoyuanhong@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=990325
  Lore link: https://lore.kernel.org/r/20250812033817.487565-1-liaoyuanhong@vivo.com
    Patches: [1/2] spi: bcm2835: Remove redundant semicolons
             [2/2] spi: mtk-snfi: Remove redundant semicolons


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



