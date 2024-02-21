Return-Path: <linux-spi+bounces-1459-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547E685E6A6
	for <lists+linux-spi@lfdr.de>; Wed, 21 Feb 2024 19:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EB61F28647
	for <lists+linux-spi@lfdr.de>; Wed, 21 Feb 2024 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8547885628;
	Wed, 21 Feb 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyK9EFyG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0885269
	for <linux-spi@vger.kernel.org>; Wed, 21 Feb 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541428; cv=none; b=u9ncvlmcK5oyuMpiVKC80DvTZ7mzhzFlN6l2f66qnz1vc/NZkLEd8ac0cyrRYNKLhbyVOf/G00Tc2a/AeAU3dIbe1o0r5zLGrmENz05/aGMB4+SUfn4FAeuAW5mUB7PB3ofds80OcD11IcoqcyRfLC7VoswIv75+ilXyLhj9nSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541428; c=relaxed/simple;
	bh=fr2a5dJ2sMB9iCFuOdvXjWr5rZtYOooQ0oysGj2acZo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EdvPHKQrMJY71U+CjnXMRBj6eCZma1F7Tq1rNFY2Xl9szhHRWhRAA/MESPiRXIDNhjd0nM//Rh6Ls0t8ZD+VjBr857LzfKlVFV5lniwDe5i2Ui4k0JRiH6ILpY0w66hlnT3sR7oDKC5GDms0scardysqfPl0kkOJhPhpVqYD4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyK9EFyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E779BC433C7;
	Wed, 21 Feb 2024 18:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541427;
	bh=fr2a5dJ2sMB9iCFuOdvXjWr5rZtYOooQ0oysGj2acZo=;
	h=Subject:From:Date:To:From;
	b=iyK9EFyGIep604c+gn5PvyJ2jhoLaomA6wATuDx+SByAckGsoT1mlNX8Mx4KCIZCw
	 Onn8o7aYdmMKyllGNvQGuA0oDGcVD7+jOJT97mA/vwYN+IvbnG1uLms/YgGsR1U0DJ
	 uwTOfEsQF2ovZotaxJm/n0U46vLBzggoQCbZQUvfUL8ZdVTc4bccg17IvLzDNWgWAb
	 U0kZvki9YRFUBgMgqjgUICW0gXLy+WFDbCeEMNZ7jZUCBqNeYlJSrbUBM1HbcEdlqq
	 kScyBobLyZ8+I0eB1Ae8iESqmC0i9zqkl2dvoyOwoxOEyftrnxEmVdpVXOSBGoao72
	 X63Nlxt077xpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB454D84BB9;
	Wed, 21 Feb 2024 18:50:27 +0000 (UTC)
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
 <170854142777.32188.313240628025431672.git-patchwork-summary@kernel.org>
Date: Wed, 21 Feb 2024 18:50:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: cadence-quadspi: correct chip-select logic
  Submitter: Théo Lebrun <theo.lebrun@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=824645
  Lore link: https://lore.kernel.org/r/20240209-cdns-qspi-cs-v1-0-a4f9dfed9ab4@bootlin.com
    Patches: [1/4] spi: cadence-qspi: assert each subnode flash CS is valid
             [2/4] spi: cadence-qspi: set maximum chip-select to 4
             [3/4] spi: cadence-qspi: report correct number of chip-select


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



