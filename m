Return-Path: <linux-spi+bounces-4429-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C4B9647A7
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263BC1C20A05
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A09B1AD40E;
	Thu, 29 Aug 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiRLHSs5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F171AC44C
	for <linux-spi@vger.kernel.org>; Thu, 29 Aug 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940631; cv=none; b=go6pKUKDEWHCh4aHAvKhGx/EmWbDLSVom22zUsHNyQa3x8sqRrDDm9VC92euyWtROq8HeAqgY36MJSuyRaY0N7MBo2ltXssNqrkPsW/EMwFZpx21JHiRA/+P7+uOpquh9K4QaMC9WIiZLq9qh3ucUVUOSqd+u8qEsSls7t8UP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940631; c=relaxed/simple;
	bh=sRgQ3FQFgbfcsyH/2sdcizKmO3Z6NFv0lZR/bzBRAc0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=o3OdTxpLlGXnrEFLIp3odN6KUQRw4xersktOx8qmVqbFMXEAeK54BMIwLBsn0gGG7w6RAeobSu1CSybm+LGApmSUdm06NKwReoTv0fuiGIuiqd+Z9bbgmjXCnDwS8HMlSRm/Q7i8ezHWvKz5JzSecrDxU3ApCJQBFSyb8ltuTcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiRLHSs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0FFC4CEC1;
	Thu, 29 Aug 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724940630;
	bh=sRgQ3FQFgbfcsyH/2sdcizKmO3Z6NFv0lZR/bzBRAc0=;
	h=Subject:From:Date:To:From;
	b=jiRLHSs5pPiel/WV9hg6Pp2MaqC2/RwZenXEiAMZLWn5s7mjSKFrr8adqhY0oUgjW
	 P7foZqrEMef8orPRdlhuPvemHX/RROrWOwt03IUFLK7WKDL1AyFN9BXNtKo2TgFE2h
	 niMcZN93EUxURnyR5thJOakAto1Rmy2Tvw5G3esaeZ+OcXRBOnZZLKmFro6MBdDNsX
	 As/zJYBrsPL5SrLjDvG+49/jsDrwBxwMYT6qLrIxSp/NzpII5v4TuPewUMgYRpaDDH
	 y8HlWCnRHoNVdEy2AQ++JZJGO8QZgHX51vJMVV6sgEww6GU/6QB30eQWrd67TV58Kh
	 oP4QTBDFGk0WA==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C57D13822D6A;
	Thu, 29 Aug 2024 14:10:31 +0000 (UTC)
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
 <172494063170.1965457.4118174197915232177.git-patchwork-summary@kernel.org>
Date: Thu, 29 Aug 2024 14:10:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v4,1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
  Submitter: Fabio Estevam <festevam@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=884719
  Lore link: https://lore.kernel.org/r/20240829113158.3324928-1-festevam@gmail.com
    Patches: [v4,1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
             [v4,2/3] spi: spidev: Add an entry for elgin,jg10309-01


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



