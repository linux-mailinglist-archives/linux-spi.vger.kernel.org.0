Return-Path: <linux-spi+bounces-2164-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B782897159
	for <lists+linux-spi@lfdr.de>; Wed,  3 Apr 2024 15:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB75B27BCA
	for <lists+linux-spi@lfdr.de>; Wed,  3 Apr 2024 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648F14831F;
	Wed,  3 Apr 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb4jZBRF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189314831E
	for <linux-spi@vger.kernel.org>; Wed,  3 Apr 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151632; cv=none; b=RopJjabguM2XZ5jrSy+A9H5o418ccglxL6LWrb6lKDaScWUL+2QfK/CGWJPd3a8RlruR4AONLHXOul2++osxdwq6z61IWwAhYqlao07Ko5v/q2giklZdDXHEX6haLfmkxPNSUUSAXeJDR3Y66+Ta6UliBHMigif6B+YE5FL653Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151632; c=relaxed/simple;
	bh=4PDOL45C8ES8aaGsNzmqRXejNLd+Dyhl7rkXvC1Kfiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SCcSuMT3X1gaMB8NuAuRCcMIBins15D03rXX/lKJb0PR6v76uS5U+NqTf3+qsKcvzg39S0ewt/Uj59YCzYPfBffjdUht0X/yFx832ifhnwUOm2Pj9NB0YN8yrbwrF/c/Slqoru3ad8lu9rT5ZLT8SbRMJqzcR2LbcIg96ZlEygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb4jZBRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CE3CC43390;
	Wed,  3 Apr 2024 13:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712151632;
	bh=4PDOL45C8ES8aaGsNzmqRXejNLd+Dyhl7rkXvC1Kfiw=;
	h=Subject:From:Date:To:From;
	b=Zb4jZBRFkMw58c8fmn6ZYgO7FrRuhqhoBlrimSqTlriF2ArVnCKqQ9GEX4VRiWGU3
	 XmKxtWR97YWQfV4G50djS6EceCFe1JRABYXsfbGGmw1L6gvU3oLK+W6OCmAxCf7q2v
	 dALD3v/4dZvhIcGO3OJRpN4EBK569i49dgD9c6qYN3nq7jMTBGRIXKJCAeGiiwncTl
	 caKyo6kE4FWSBlGt7eaiKquF1529IgB4vgm718IGgmzfBMFh/Qy6U4Y1ZKCMYjFJJd
	 QnsmB8KiXplr1hIDK33POg2CEe2UILHdzf25W54qlKR1TQTjXR2sdLYV5GrSy75lIu
	 pPqE7bkB+jnpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCCBED9A151;
	Wed,  3 Apr 2024 13:40:31 +0000 (UTC)
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
 <171215163178.11353.13769142853096165181.git-patchwork-summary@kernel.org>
Date: Wed, 03 Apr 2024 13:40:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: mchp-pci1xxx: Fix a possible null pointer dereference in pci1xxx_spi_probe
  Submitter: Huai-Yuan Liu <qq810974084@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=840837
  Lore link: https://lore.kernel.org/r/20240403014221.969801-1-qq810974084@gmail.com

Patch: spi: spi-fsl-lpspi: remove redundant spi_controller_put call
  Submitter: Carlos Song <carlos.song@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=840965
  Lore link: https://lore.kernel.org/r/20240403084029.2000544-1-carlos.song@nxp.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



