Return-Path: <linux-spi+bounces-9734-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CDBB3A1EC
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 16:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA66189C8C4
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3791E5714;
	Thu, 28 Aug 2025 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNUG0PzG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A4B665
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391465; cv=none; b=mqv84bIRCxexRXGWK4wWpsncWweGvZxgl31MXgXGCdI1+odZ+TYgjrQEXGKYre8oTHGlmW/zoW3Fg4wlge8SGaVVjy6C3y+fybybHonxApkHUJF2KCX3K9ESYKz9sTJVzxtLRcPIehbJR3ffelxOlMSTAix6HmdZiLou0CBbBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391465; c=relaxed/simple;
	bh=EipGNgyeJSZb4G+qdnMIpHHFzYwNmG99tn3GilLG4yk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=roxifsro4Atoi+2xR65R/eVTZykibiGrCyDc2qu0a+2n7Hnji5acxxnrbztBRxT06vAh89U5H3nHddtrBJ2KI89TQOiiWAtyaOa5zxDwPyGg8bc5wMS749sfs1RgJ08kr6ItKzJtN9bftLxL5t46nOm2lcZ3h+if5AUp2akmEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNUG0PzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2A6C4CEEB;
	Thu, 28 Aug 2025 14:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756391464;
	bh=EipGNgyeJSZb4G+qdnMIpHHFzYwNmG99tn3GilLG4yk=;
	h=Subject:From:Date:To:From;
	b=vNUG0PzGYTLu9Gh69Mm/WGaK1ElVStthhYKpTvSMoiphF3U88SWz8mTqmg17Sm4lr
	 bHV/HmkHvL8xb5J+wpMKNibdt6klvK1IXJ8CDPvhWBj6OsA0UhNIR04JFDfIO6cLqJ
	 HYn+tJ9TkpD0DWVBNnc4BGvzQirWatCNUECIZrp+NaDjEXT5lo4yioRmQmcZad4vrs
	 DBlQUcL0Dua03yB2LFMSDVoZyoPkJsmA6AzuVMpyW754i/OgIoO6yalEYJogOXReSn
	 6w6TW4Xk/r2az5J8IEsW5v4ljkl2b4OXjrTWA+DUqD4nX2l01TPAYA7bS7urHJrVx9
	 92EeGeXxJqjbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341DB383BF63;
	Thu, 28 Aug 2025 14:31:13 +0000 (UTC)
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
 <175639147167.1479796.5105984740669235985.git-patchwork-summary@kernel.org>
Date: Thu, 28 Aug 2025 14:31:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Drop dev_pm_domain_detach() call
  Submitter: Claudiu <claudiu.beznea@tuxon.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=995985
  Lore link: https://lore.kernel.org/r/20250827101612.928008-1-claudiu.beznea.uj@bp.renesas.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



