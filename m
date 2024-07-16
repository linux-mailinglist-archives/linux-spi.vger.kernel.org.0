Return-Path: <linux-spi+bounces-3872-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3441A932782
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 15:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F62AB241E4
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7915B20DCB;
	Tue, 16 Jul 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0FZlk5b"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C384C7C
	for <linux-spi@vger.kernel.org>; Tue, 16 Jul 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136634; cv=none; b=eT+j9+hSq46e9u5QuoDS8wE3F2Bj/MyCJEJI47SxZ6/mdxBu3p3xrm0zNS0J7VK/r9J7AOTYJhOxdIK9Hj01CtdERbGswdJ234zs0nJHW3sHz/RjVgL2hLHZjlT5IjBCXzjmf0nNb3XPqNihP6j/yHwRJM42rIrRXplDlfbqBbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136634; c=relaxed/simple;
	bh=qPrMPbvOMRgLmNhgGMYjJOb03QR7/d3jmgU9++hGrEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JualK4gS81I/zxjxU7f5YN3kdOVeuy9MVEBJwK9Kpq7pplSCr04T8zl/ePeoI7nocB4BQS06mafylc4FDJ4RUtg5P7AY/nR+TAyqUNMyR0lbHGNLZg/cr9cV26KlNDURtA1Sihp98+3ozGSWjjgi8wH6+E2wub/SMAIB3ptXplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0FZlk5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7F3FC4AF11;
	Tue, 16 Jul 2024 13:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721136633;
	bh=qPrMPbvOMRgLmNhgGMYjJOb03QR7/d3jmgU9++hGrEk=;
	h=Subject:From:Date:To:From;
	b=E0FZlk5bZAJmd98kR0Cg5ibJVK69FBLxLW49rLe9dS7iOWoPbG88OE9X3aXzWUist
	 bSYo/3g27fe1q1SostjJ6ZL8+Kv2YgHyCm2oY0gGZ44pn3Qc0MmaZY+ueqlcVD71L0
	 K0wUQoxHzVEtHbedzulR2RntpM5ZF/kUHSOL8syIAiMeZJRDZAgCSBW+YCDgnnNM/i
	 7dmWctHveASzeCpMs+eZj/7jdaNdaj9rzCVfykcxeJwwnnQxdpqrdjYFThZOHtF3N5
	 xNf4sV1Y9VX3njMwdCqeOp7qQn0+1rWip4nB46qnY5kONl3n+EtvLcCG6XUCgxK8UW
	 w4RubwiHzHEyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0985C43443;
	Tue, 16 Jul 2024 13:30:33 +0000 (UTC)
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
 <172113663371.14237.12905188479174457119.git-patchwork-summary@kernel.org>
Date: Tue, 16 Jul 2024 13:30:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi-microchip-core fixes & variable word size support
  Submitter: Conor Dooley <conor.dooley@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=871325
  Lore link: https://lore.kernel.org/r/20240715-retail-magnolia-bbd49a657a89@wendy
    Patches: [v1,1/6] spi: microchip-core: fix the issues in the isr
             [v1,2/6] spi: microchip-core: defer asserting chip select until just before write to TX FIFO
             [v1,3/6] spi: microchip-core: only disable SPI controller when register value change requires it
             [v1,4/6] spi: microchip-core: fix init function not setting the master and motorola modes
             [v1,5/6] spi: microchip-core: ensure TX and RX FIFOs are empty at start of a transfer


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



