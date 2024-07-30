Return-Path: <linux-spi+bounces-4102-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF03942054
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 21:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B872A284602
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641FD18B475;
	Tue, 30 Jul 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxbQBQCs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A718B46F
	for <linux-spi@vger.kernel.org>; Tue, 30 Jul 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366629; cv=none; b=cDdS3w/cFLTTYSp7iazBBsUoKj+Ms7xKoji91C8t5bB6RIkFGb3YCwG0dNeLqVfV4sDx+gEIWSzm0x7qCNAodxe2tfTJOnX2ih1z9DVjwiQFRaOkXdkOdTVpeuna52JxZAXJT3b5RoGback12VuF5GGVOP+7awrsmed+e+nyeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366629; c=relaxed/simple;
	bh=s52MTMI7Mcts4gDzUUJWtvAyHr4lb2oWJcSE1alo9W4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=UmHWgblMlvZP54CHAZwQWu/Rg69D2OrAuQfNV+/fNgbcCOkSys2MFd06bet31WbPZJKooirhG2xOqzbPYPFL9xBImGrUL+6O/HIszGoRE6pRAYkExCsucrSgzNf1v1Z/OjdkRTnNNyHoX/E0CQsz27zcuGRAybyfIUVxZoHrQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxbQBQCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 104B1C4AF0B;
	Tue, 30 Jul 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722366629;
	bh=s52MTMI7Mcts4gDzUUJWtvAyHr4lb2oWJcSE1alo9W4=;
	h=Subject:From:Date:To:From;
	b=jxbQBQCsFJ4FQ3RniXOgwELKBRQ9nDy/FvfuBXZZaqQpKLbfck/dBiPViFGtm4/VP
	 eN2ysAkMqVtCLKOTS0fwcftr+iOBoBpT99YcG777mtTlhO332ifNQJCY/F5Y6bXvQp
	 33K1ANGeFMKHt0m77tb3CfV+7fsIgRRfcnGD/6TumRWUEx+GEfKKTY/8l9EnYOrde2
	 Fq7IOTn5yLMmmYnUju4+WnuakWDWOMwFQr0jXeaGzO6aaNx1HrdkAiCyp1lS+tQAIq
	 2Ucd+6Azgm0roJq7SD/0BrZdBbi2faPAtvOjLuM8eXoJpcEQOisr87FfkFUW5eniTD
	 hSjZj1ktXE1iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1E09C43619;
	Tue, 30 Jul 2024 19:10:28 +0000 (UTC)
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
 <172236662885.9892.6609108695615384575.git-patchwork-summary@kernel.org>
Date: Tue, 30 Jul 2024 19:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spidev: Add missing spi_device_id for bh2228fv
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=875082
  Lore link: https://lore.kernel.org/r/cb571d4128f41175f31319cd9febc829417ea167.1722346539.git.geert+renesas@glider.be


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



