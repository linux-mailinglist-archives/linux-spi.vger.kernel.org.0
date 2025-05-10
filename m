Return-Path: <linux-spi+bounces-8054-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34846AB20F3
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 04:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5CA1BC59CE
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 02:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4858D267729;
	Sat, 10 May 2025 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCbueTt9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229791F03D4
	for <linux-spi@vger.kernel.org>; Sat, 10 May 2025 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746842991; cv=none; b=RThcMij6TbhXSZgX95qHlwZz4aPIYl68qPKr5JKG6/IHNBzMc6esFzILnQLQZcaSnZbT+cP6rJv8p9wgVt9PBa47MGlDvWw7Qb8w2Ca6tA4uDJ0qaw2bGaHz2lACxI8EfxSttqMhYvuMRkx4dx9VocQ5xoFihx8aHxyolOtkxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746842991; c=relaxed/simple;
	bh=X8dw0px8I1d6T2nDtcOfi1BkVl8TPfPk2gBhiViPlb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qUG9Ch0llqdE+H1AJpQWbZ9qwVJFOYSQLjds7X+zgBEq33QU9pCQ+tJf8QuR2GA+JJszp3rHagQ17fVnycPABh3eqhgN6rDe8dicAO6K/ogUZiK4wkvj5a8w6grC5QFIcyT/VEiiKveqdtFMstnI2KT56jJFn3h3Jq+4A2EazRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCbueTt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7F0C4CEE4;
	Sat, 10 May 2025 02:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746842990;
	bh=X8dw0px8I1d6T2nDtcOfi1BkVl8TPfPk2gBhiViPlb0=;
	h=Subject:From:Date:To:From;
	b=hCbueTt98+3ZkndBy1Fn8D90YpeEV/qTI8pSBFv5ng41WATLY3i6qSz9lRKoaGMH1
	 beXzvoPobBeRNbB3cYrieh1ryXiIvNUv4dfVxfaLihFCTGnG03YqavI7h/NhsE+1iL
	 QM+DMAkSL58WYmvECuGq86u4Bpq6h6oxyvLFeIFghZjnqnsmij89TQuasEjYXiiS+U
	 fLDVYthcqUQ+YiqxQCzgfWqUAwVJo1xtEuWhIppH4ys2btLArRHO0gBvndqNzQtTy/
	 p1/iigrQKSBvDQvwjM7dSEgAwKQQ2xmWInnc77j9/ckWl3U4DGWpuuuq3MsqiygxuW
	 MunWl7b9AuBrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE2B63822D41;
	Sat, 10 May 2025 02:10:29 +0000 (UTC)
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
 <174684302855.3867418.7783126463833720786.git-patchwork-summary@kernel.org>
Date: Sat, 10 May 2025 02:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: Add RZ/G3E xSPI support
  Submitter: Biju Das <biju.das.jz@bp.renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=939063
  Lore link: https://lore.kernel.org/r/20250228160810.171413-1-biju.das.jz@bp.renesas.com

Patch: Add RZ/G3E xSPI support
  Submitter: Biju Das <biju.das.jz@bp.renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=941109
  Lore link: https://lore.kernel.org/r/20250306170512.241128-1-biju.das.jz@bp.renesas.com

Patch: Add RZ/G3E xSPI support
  Submitter: Biju Das <biju.das.jz@bp.renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=941127
  Lore link: https://lore.kernel.org/r/20250306170924.241257-1-biju.das.jz@bp.renesas.com

Patch: Add RZ/G3E xSPI support
  Submitter: Biju Das <biju.das.jz@bp.renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=942683
  Lore link: https://lore.kernel.org/r/20250311113620.4312-1-biju.das.jz@bp.renesas.com

Patch: Add RZ/G3E xSPI support
  Submitter: Biju Das <biju.das.jz@bp.renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=948984
  Lore link: https://lore.kernel.org/r/20250401143537.224047-1-biju.das.jz@bp.renesas.com

Patch: Add RZ/G3E xSPI support
  Submitter: Biju Das <biju.das.jz@bp.renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=956531
  Lore link: https://lore.kernel.org/r/20250424090000.136804-1-biju.das.jz@bp.renesas.com


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



