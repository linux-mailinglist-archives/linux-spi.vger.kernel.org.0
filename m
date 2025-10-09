Return-Path: <linux-spi+bounces-10488-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B51A2BC7D38
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 09:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A58A44E9875
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 07:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F812BEFE6;
	Thu,  9 Oct 2025 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/xU7om2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4BD222586
	for <linux-spi@vger.kernel.org>; Thu,  9 Oct 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996608; cv=none; b=JXNIDB0pgd7uc2muVNVQyIdLFL1Mb6VQmOqQN1/vDwxFImYDW5yVSqVOqAnx86LdgGy55yMD8LVNIErIDLS4PHOpsLq2AQ4gATMOgXd9JnIVFvT97+Z6PJxhNf1HPFnQsfLbswQ/eQpi97HURfQu1Krsvt6afiQBQBu/AfWH1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996608; c=relaxed/simple;
	bh=37XsGoEtHSajXLFSCU+XLSdBvvjvrffgXuw/VU0H810=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DatTJIOg8Zz8/QUGeU5jSkTv6XzxyErYVC/KyuSpn5LLoPdbsFx2oVTscnZ3MTI1PxLNYq6LGpM54dZneG29lGQDOKKnNn1mJOh0ajxX+a9qLydcUGQm6H4Ui8mZsHsXrYvOPO5PQbLZ1v1rNl8YocfQzWjPdojwFZ1kK5PHSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/xU7om2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9C1C4CEE7;
	Thu,  9 Oct 2025 07:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759996607;
	bh=37XsGoEtHSajXLFSCU+XLSdBvvjvrffgXuw/VU0H810=;
	h=Subject:From:Date:To:From;
	b=l/xU7om2uBzCzH0aD3T5ZNNCiUHtlRnvmz63t/C5q93wWotr+N+ybS/sT11VZnd8W
	 LZMxE6bOQUzqaSzDY8hoaJQbXkJGIKpvGWJ5wo43WXKd/4HZrzMTmUHgFaUElqgUQh
	 FslrFQ3HwCzucfOg9Ly8amGRsqLlqitn7i59B0CBOc/LXb29im3J7z5PXLlrIrDusv
	 W7hOhowtRWUivBkwnrZ8SiIWGRilsLPMidGWUtgWXJH9ArnGrrfh5wfK16r2K5/LNX
	 CdlMzyCpWVyj7+1GkksGCj0FKJAcnAL8jfel5zA5ylt+vbxaHZit90LmeQ3PpubM8H
	 h8TAckZ50ezOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B18CE3A41038;
	Thu,  9 Oct 2025 07:56:36 +0000 (UTC)
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
 <175999659539.3811925.15160243813777136123.git-patchwork-housekeeping@kernel.org>
Date: Thu, 09 Oct 2025 07:56:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: cadence-quadspi: Fix pm_runtime unbalance on dma EPROBE_DEFER (2025-10-09T07:10:38)
  Superseding: [v1] spi: cadence-quadspi: Fix pm_runtime unbalance on dma EPROBE_DEFER (2025-10-08T13:38:39):
    spi: cadence-quadspi: Fix pm_runtime unbalance on dma EPROBE_DEFER


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


