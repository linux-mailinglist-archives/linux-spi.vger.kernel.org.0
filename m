Return-Path: <linux-spi+bounces-4098-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B09F94179A
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 18:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056E52874C5
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20052189917;
	Tue, 30 Jul 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3kIbMxt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0637189914
	for <linux-spi@vger.kernel.org>; Tue, 30 Jul 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355832; cv=none; b=O8+uwi5vdEMXPomzludVjx4cxXX03PO+Txhpvuz7mQKHkPxyCyTpG9d2WqVTJVNwDd/Y/Yza6JVgO0mE4yW0Ue5p0bO1wISXiI2rHAGfjqSXw9vteP3ntNCQKdtmTvkVuzLqOajZr039OxGjYHCxzzpTXx+6HLpM8rFveBMeXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355832; c=relaxed/simple;
	bh=eZmDlqnyLbJ03PmlCNqzHSfQDqAG5O1qVWNSSBmXnCM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=W1wVTVioSMbeA7/gKWmh/UHi13dD31L3DoKGmvYiSXVu63Hhi9QroF2oOx35w3Qo1U2fEOjsoHM+W/nA9I/LreOlep1pLGRxgZoiyBLu4mDRwcaUt/4fHYapwfTd0rZcv8nxfv4uZTAODso37L6yTUvZsT9KKSFUJceVEWXfjt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3kIbMxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B170C4AF0A;
	Tue, 30 Jul 2024 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722355831;
	bh=eZmDlqnyLbJ03PmlCNqzHSfQDqAG5O1qVWNSSBmXnCM=;
	h=Subject:From:Date:To:From;
	b=H3kIbMxt5YKqBIlGt8xx8zG+ejUeLLnkf6a8V4e5a7HlwAdIG0xo4WukI0FPnFmoo
	 W9/q0yui831D1ij1BsZuWGuarWCaF5TfBIHS7OBbbzPZ0ZEahLJ8HPt+K87fsJD8xr
	 7zxcQXbXkl1PmbJN/55uxcCdKof+CRbkkyQN6gS950C2AAdVPUSlOgYkiNfiJcLrsH
	 b3ggZt95q/+oIe50+z1ohuIPfcW9wV4rjLYZtCFWZYjsIKD4vUiGIcER5AOdpJM5GZ
	 f59cTbJGTi+vYy/90iqOczFOm057Klx53hqtxDIw5RjKTCL4Xo1a/RreVFg+Mkx07r
	 Uz2czEJXoxDSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88BF5C4332C;
	Tue, 30 Jul 2024 16:10:31 +0000 (UTC)
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
 <172235583149.27096.15097815300927640080.git-patchwork-summary@kernel.org>
Date: Tue, 30 Jul 2024 16:10:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: hisi-kunpeng: Set verification for speed_hz and max_frequency
  Submitter: Devyn Liu <liudingyuan@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=874861
  Lore link: https://lore.kernel.org/r/20240730032040.3156393-1-liudingyuan@huawei.com
    Patches: [1/2] spi: hisi-kunpeng: Add validation for the minimum value of speed_hz
             [2/2] spi: hisi-kunpeng: Add verification for the max_frequency provided by the firmware

Patch: [1/1] spi: cadence: Add 64BIT Kconfig dependency
  Submitter: Witold Sadowski <wsadowski@marvell.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=875072
  Lore link: https://lore.kernel.org/r/20240730131627.1874257-1-wsadowski@marvell.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



