Return-Path: <linux-spi+bounces-1265-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB35850C88
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 02:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61001F21D21
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534CAA47;
	Mon, 12 Feb 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCotUoQ2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2BF10E3
	for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707700227; cv=none; b=VnPKPPh1gZLRz5dFuOiaqfkn3xIJ1iMJINl8cEvAsrzOAGfWX4zO/cByhehkD+86QK/XnfjnKZnHxtLN+Yfl0m+zI6rAJ0E1WZAfpYjLxnet/Oykuih89+ciVMZXcH/iA1L5UrveiiGFfm2lTD+YLpS/yhfx72QStkLoVPKPQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707700227; c=relaxed/simple;
	bh=1naVlaiC6AzTmREGZTNQ7DfQ2bcFqBmQXlUz81TaaGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kV3Cm9c/tW6QnRuVAHkVzdhCw61CfgYBUEo48sLk+roUFaTDXBAfTZ6lxCzuhSJaVtUfraVMuUr6+xk/UzabG/Jf46XXgwlueY0rfkkRFzT1Uq0wB+7dhrpR2sK3C7RviV7kb07mrjdKAOrpcNypKPEosgW8UA65Y1qTicOULRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCotUoQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6DD8C433F1;
	Mon, 12 Feb 2024 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707700226;
	bh=1naVlaiC6AzTmREGZTNQ7DfQ2bcFqBmQXlUz81TaaGc=;
	h=Subject:From:Date:To:From;
	b=vCotUoQ2Kozum9gWkRHaukCGLzNxARPmS25CVzOT6+a8OLy4014iEzwvoFgMfzGCh
	 3upmvi3VSCAgbBV9HPhUBi3DTUu7/MIQvL/oRDqlAW2tQZ68CzDNbgh+6q/HqjOqI4
	 OMHceKmMDVP3bjI3Z3cts68NNXsXNrL3V7XJk9MCtSHARoa/iCWmCJHEhTMlYi+IYK
	 87saR8qJjtHurPBaTy4lbTqCGRLhUlZMSOHnfT4obkjmqGuX77woEzHXRKKArIIoxO
	 2emh9SA61EFvXvBbF9hTtylwymmUBFsybXXGRPlJaoaC5leMshQdZNgoZq7ZHKu2CD
	 Sx6R3FIL+ky6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8728BD84BC1;
	Mon, 12 Feb 2024 01:10:26 +0000 (UTC)
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
 <170770022648.4976.11836779976576740014.git-patchwork-summary@kernel.org>
Date: Mon, 12 Feb 2024 01:10:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: ppc4xx: Various fixes
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=824921
  Lore link: https://lore.kernel.org/r/20240210164006.208149-5-u.kleine-koenig@pengutronix.de
    Patches: [1/3] spi: ppc4xx: Fix fallout from include cleanup
             [2/3] spi: ppc4xx: Fix fallout from rename in struct spi_bitbang
             [3/3] spi: ppc4xx: Drop write-only variable


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



