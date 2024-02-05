Return-Path: <linux-spi+bounces-1060-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546C384A151
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 18:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C371F212FF
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0FE45946;
	Mon,  5 Feb 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFPJf/1I"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8F44C88
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155429; cv=none; b=lYkG1wVGo1JTLt09+uypRUQh/zld8p7Uszfb6Pnm6tqwHcakh4/ejO/U5nq/rrFBDUC0mhppByen3QQazOaLEGBNZ3q2S5G7HnyS3X6CFOl/esTIxGpACRlEtv/jk3gE4auLzSizCykE5ix9lesGqwEXMyF/qMglWIbeEa+5IEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155429; c=relaxed/simple;
	bh=ZzaB4FL2phR/zLZxus5j2dGXT9wHptS46AyI6qlOoOU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tz9EAIRC3a8I93oW4i5tbzXdyvjXwx8mfYeiWHvahR8akD3pslcnSH9xF0L301wkXWxmu0yje4ZpzcllSOz0FKi7Vr6OWi+KGmzOsOwoDok6tnKfUKJwktlPH2ifUpPuKX3dfaJBEwnLTpz6ljIdKEbvoKVH52ald4uDqqsrGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFPJf/1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9398FC433F1;
	Mon,  5 Feb 2024 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707155428;
	bh=ZzaB4FL2phR/zLZxus5j2dGXT9wHptS46AyI6qlOoOU=;
	h=Subject:From:Date:To:From;
	b=IFPJf/1IkQHSc7tm9rJb/qQl9DgpUZeZql4Hi8vRIKQLokwlF9AL+94B1T1XhhK2O
	 lmeLNU4EOhV/cEB9mfWxKqMEBG+Zef/39ki82UD8PfPIZNakHeI+vx+KTnJ3NIm4Ap
	 rYwut7Svardk7aGX8x7ZxOpPCo1QNMd++FTb7oLyTvbGO1hYT536RFyDBDdNgvng8Q
	 bI54yT+HAUBGMVhly2jziLU5PmPvYvz1JagNI8LcY2XYQPJpFwFuO2yttWoDhoUO9J
	 fm6eQONVF9/c8bDF+mt9Lcrprvp9xNBYMigc4+VKEDp0eXtyRrFh/tRSzkV03HEEd5
	 tkhiUl1IpgJuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72453E2F2ED;
	Mon,  5 Feb 2024 17:50:28 +0000 (UTC)
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
 <170715542840.30912.7033957742821506554.git-patchwork-summary@kernel.org>
Date: Mon, 05 Feb 2024 17:50:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v5] spi: imx: fix the burst length at DMA mode and CPU mode
  Submitter: Carlos Song <carlos.song@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=822876
  Lore link: https://lore.kernel.org/r/20240204091912.36488-1-carlos.song@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



