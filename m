Return-Path: <linux-spi+bounces-2440-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B31C8AC27E
	for <lists+linux-spi@lfdr.de>; Mon, 22 Apr 2024 03:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258EC1C20873
	for <lists+linux-spi@lfdr.de>; Mon, 22 Apr 2024 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610E10FD;
	Mon, 22 Apr 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO2FSD0v"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22DBED9
	for <linux-spi@vger.kernel.org>; Mon, 22 Apr 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713748227; cv=none; b=gxRlgQPLSBXW3IJZlLvG7fPL0RI+iq9wuQhEdxRmTgKfY83IV731ZaXIWgnPiRX7HNhPR0pOOh6hRJg+cJGcvcQZpHkXyjCPB6hZINFeaLDAkTnk7wVyr/sAJOPj+eoJuMHc6fX62iYmGk//ky2nYCrjOdh0NCYdNMCLCYiioX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713748227; c=relaxed/simple;
	bh=HjGZjld+eokwdzZpfM6taMXgtw/iSB1/zbzYf2WVqzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=eGYSBrl/z3z4DjRBVNWA75xFEX6TNDrX6ojVJCEINF/XoQ04CUzF1n8VYQeX56R8jPDJ5hKqeCd6GXD8hnHnb0QG7c0IAaW8xQjFerH0IO8pXeoWf/E5Mt+Xf61SRDuDfUkXdr7+daMa3XGjupkMM98rBY7ISnu4ymNaVyZVL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO2FSD0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29E3AC113CE;
	Mon, 22 Apr 2024 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713748226;
	bh=HjGZjld+eokwdzZpfM6taMXgtw/iSB1/zbzYf2WVqzQ=;
	h=Subject:From:Date:To:From;
	b=VO2FSD0v9YGn4cWhheq58VHHDDRUQUx18PEf+sT7mmbE5Qf4Klr5tThljIBTVUmN/
	 G+inz5iG5gcK48w6i0hM5M0Rj1xKqHaH00pgGabuHkC2oU0RuWv61STIPAwW87rN+R
	 eidrwF7wJ0hyB+5630SyPkuQn+xl4+KapbQ4+JeahNhxAkrLHC9iE/eCIjhi77CkN3
	 ICb62kZVwrJkomcLbTP2kmRP3X/pjQqVeJQAbiRW41qrBvh3Sn4D4vafixTiMJ4DKN
	 xw4BDFNMPlop6cpIaNCqqwvaIjKFwYYePDIs81jQf5Da47vws2kIRJzWDurWPDOqFl
	 kHmFRA2xcrn/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1259EC43140;
	Mon, 22 Apr 2024 01:10:26 +0000 (UTC)
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
 <171374822602.28631.7330245381793924189.git-patchwork-summary@kernel.org>
Date: Mon, 22 Apr 2024 01:10:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dt-bindings: armada-3700: convert to dtschema
  Submitter: Kousik Sanagavarapu <five231003@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=845292
  Lore link: https://lore.kernel.org/r/20240417052729.6612-1-five231003@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



