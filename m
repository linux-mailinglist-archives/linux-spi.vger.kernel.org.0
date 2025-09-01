Return-Path: <linux-spi+bounces-9840-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61903B3F10C
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 00:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2210C20713E
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52E283FCE;
	Mon,  1 Sep 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpKBYgJe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD632CCDB
	for <linux-spi@vger.kernel.org>; Mon,  1 Sep 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756765799; cv=none; b=IwxJ+W09bNv8HGZkQoGdtmSjtxMc6JwXfKNP84NirMR5k40M6L8rzn3qkWyImjaJRnWA0+8/A3cLAsbHqaq5efKUCmbVAaT/A1JavNKE75EWBYjA2+yntmaQwVMGUIgx2x2noaJvN8sFdQbrJODn7LGam2tOAZ3me6wfkQwqjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756765799; c=relaxed/simple;
	bh=IBmGXAwQUfKoDVolBDUXKiXsJcJN5p3elE/hw5Rjf60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OjMDZVKpuCSPPrKgXsYL0XDt8ECoruFDy+OFyp7h1ZLjg06eRz9xgd0Jk0WOp11xL4DgCfsjM8/sdvpmyjgQj1XvS2uUQ4xBbgRnBNnmFRbJ1n7FACPLHi3X53lGQ7OYsSrlkjnKitY8/5YlWiSvnhLCNTnwolWHUQrw2lz1QaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpKBYgJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4A5C4CEF0;
	Mon,  1 Sep 2025 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756765798;
	bh=IBmGXAwQUfKoDVolBDUXKiXsJcJN5p3elE/hw5Rjf60=;
	h=Subject:From:Date:To:From;
	b=JpKBYgJekiR2cNO78rXx2Du5iqmvPoyq8dGzHxRQcNqg6UfgxwnSiVEUu56kO+dIn
	 HBOqcdw9tQAkVLij7qK+GYEdBb1/N+na4ploJrQqBroMyVAIdYEntgM3BBgpaDDhc5
	 9QLApBbt68k6uMY5DVMlB+Op+m3vH02K+deYYqbJq2vKpWc1iXlu9e373BZb6ap+/6
	 NSBJ6p4+S8qqjIfMtS/WHe0UUPwTJNvyLWPmfXN3r+whrTF49m5e8vjq1RogKAKhKp
	 crDmTGidrLB8hLU2BZ4EebT9Cyy2AvkhkEt/zUQDKAj/MMQWtwrvWE8NSK1HqtHMaP
	 oaiS/5cEnCgbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 375D3383BF4E;
	Mon,  1 Sep 2025 22:30:05 +0000 (UTC)
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
 <175676580384.3896089.12994227648021606154.git-patchwork-summary@kernel.org>
Date: Mon, 01 Sep 2025 22:30:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3,1/1] spi: cadence-quadspi: Implement refcount to handle unbind during busy
  Submitter: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=995441
  Lore link: https://lore.kernel.org/r/8704fd6bd2ff4d37bba4a0eacf5eba3ba001079e.1756168074.git.khairul.anuar.romli@altera.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



