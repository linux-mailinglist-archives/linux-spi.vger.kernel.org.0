Return-Path: <linux-spi+bounces-8113-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D1DAB5E2A
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 22:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CB019E415E
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 20:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A551F0E39;
	Tue, 13 May 2025 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IypeEaX6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948AB3596B
	for <linux-spi@vger.kernel.org>; Tue, 13 May 2025 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747169798; cv=none; b=jaE8fZzHicIwBGVcZlsNg3VhpB71t9y+OmxL5/icJxrUCM6vwkDD6Sw3x3hk+E+6W/VlMmhaTFzRvK4Wm1BFy5e1BuEak5eHibTcq+IRpWN+Ev2HIsrlSO8KHBQPrZVYJJZIu/v55psBTrO9TBp/gE6R8iuHT87tHV+y6lU75dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747169798; c=relaxed/simple;
	bh=Xodb7yKbO6aSKQcxfvcYs4klirYz6QI+LbcHPmgSdE8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=X1zt09ccdCxzxyztfexa3t6cfweYtYFANdfnQCE7TMpkcXW8WoERXGpAia+D7hjt832s937SQ5Fp5CCLD2JBJ0bkZogaQL4onFOqMXc4TWBxCWh5PeqGwTppHWXWe3TDwHREHDGDuXW1oikiKG7+1CEvYoVoAHuc/uULQexFFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IypeEaX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0406BC4CEE4;
	Tue, 13 May 2025 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747169798;
	bh=Xodb7yKbO6aSKQcxfvcYs4klirYz6QI+LbcHPmgSdE8=;
	h=Subject:From:Date:To:From;
	b=IypeEaX68we+kJwoTr4pXQpdSGLv0ulikyhfE+6UgpnmISpky8wHyJMGKsOdF0k4u
	 mA+9dstjqpBRLSFse/ZIDPHg6JN66PFzamXVoJ9IW/+4pIA/dtv/i/PQtVllXbbw0h
	 RbSs7ui1xQpfeDl9Lq27zoTKxJYldoQj24evmY/oMgZyTBppem4iyTKQDw0CuHQRk1
	 cT5mhcEKrI8tXSRj2QLex1PUR5SQ/Qgo+LvIRHvo0/NssK33Nk+kg0sARxp5ZxliV4
	 o3kIPauri76zF+U2qdudR8J510MwsiA8fOjvfnh9vFBboJvvr4I2DoS8tJ0v4sN0qL
	 IARmF7SwBDdoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC1380DBE8;
	Tue, 13 May 2025 20:57:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174716983535.1789093.9950910534733469846.git-patchwork-housekeeping@kernel.org>
Date: Tue, 13 May 2025 20:57:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI (2025-05-13T20:00:42)
  Superseding: [v3] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI (2025-05-09T16:54:08):
    [V3,RESEND,1/2] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI
    [V3,RESEND,2/2] spi: tegra210-quad: Add support for internal DMA


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


