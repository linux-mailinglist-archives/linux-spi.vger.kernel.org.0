Return-Path: <linux-spi+bounces-844-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748FA83DC92
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 15:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A481A1C22241
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB767C72;
	Fri, 26 Jan 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF+FWifW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966D1CA90
	for <linux-spi@vger.kernel.org>; Fri, 26 Jan 2024 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280027; cv=none; b=OAXosGkDg3nUg8NzJAdBGdsUkTCNrRvv0bMzUOQkxT1dRQP5LKEACuYM1PK9Qc4yLqy3iitTR8nD3w9ppGdQSjCzwuuMXw1pQM4CQ1TCS7nOjJINevjPBiP+dmZsCRCe8lWgqgC+iiwEkO4mKNG0hNTgxjOsNB6D3pGlXp6TtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280027; c=relaxed/simple;
	bh=vaaEDE92O1Xd9JEdAeObvbVAItu/qnM52jQOdJzH8VI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=CEXz/7pzIHp9NQm6ZaeR7L3LDLDnMIZ3CGJ1WhYAl4/l+M38gqXt+udPMDqWgiXWj3kGBiqmazOL3p36xKG15qMhZPeBbfu5IDTyv9djADOjiphof0vQMaADRJUnzbQdXyJRhpJO/Mu8xKGdcY5XQb4gblk9SZdKeVk+EdlOYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF+FWifW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F50AC32782;
	Fri, 26 Jan 2024 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706280026;
	bh=vaaEDE92O1Xd9JEdAeObvbVAItu/qnM52jQOdJzH8VI=;
	h=Subject:From:Date:To:From;
	b=ZF+FWifWIXXa0Gx3pFDRMzpE9iall7RxXU5adbcJkTbREA8o7LrJu5O6SjheVb0Ui
	 F5SQgRiFTj2S0I2X43Ul0LPlqjj5e7sc1plD4f4LL2+mFgG2FprxH0pw93nth0XD82
	 VocQJ/sRIXTm/8iGEr59pt0tjSDn9YZHI9yMmFSayUE4S+ZynyxtKOIC0oLZs7EWcd
	 9U+hZZ0w/rwSzRRBVr+/cfWePi+ov1BaEOzgd/EkUF6yh/SozO2ssyKPy7+kzACdAN
	 2roF+5eODUU+cN2MfoLhVXzdFVfxA50uIACH+/WQPVFlpt7OiooIyo9yqr0qK3hiK3
	 nnM7EsoSIshYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CBBADFF760;
	Fri, 26 Jan 2024 14:40:26 +0000 (UTC)
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
 <170628002632.25835.16315244462317589265.git-patchwork-summary@kernel.org>
Date: Fri, 26 Jan 2024 14:40:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: fix finalize message on error return
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=820028
  Lore link: https://lore.kernel.org/r/20240125205312.3458541-2-dlechner@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



