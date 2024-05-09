Return-Path: <linux-spi+bounces-2800-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4868C0B9C
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 08:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DED284215
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2682F1A2C37;
	Thu,  9 May 2024 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9Fgtx/X"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A10624
	for <linux-spi@vger.kernel.org>; Thu,  9 May 2024 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715236844; cv=none; b=ek7YdCG4v8kaaXqz0Go0RZoZam/IDIR+nLO58w3YyapjbbO3UH/Xey0OkjvualnFPxCX/5KzR+wuEXTexdQcnDiPal+6xQttaVDIjLc2xKVTNcfAL5rd1OfIfFeFi1COGz8miEUd81ZqVEb/Gl+xiEXVWOXfEcpotCPLmSKK1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715236844; c=relaxed/simple;
	bh=yn8hHO9yXnsMgIBSYl79FyD17cgqmfnl+5e6tfTkwgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lmUjQGtWUWFD5AuKTP6r1FmXXCs5jMkJAfa8r4gdwLKsTY4jXyGgMJC7k++vP0e0fC9dg5a6S7AKGon42OOI57yUOrMjl18O5gH1yxPLPZ1aUkfXKY0ZdFfVgQtkqMSS+/uSkrYfs6qKSTqXCMJZrh9ylx06iUflaQdMTkKLsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9Fgtx/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78C3FC3277B;
	Thu,  9 May 2024 06:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715236843;
	bh=yn8hHO9yXnsMgIBSYl79FyD17cgqmfnl+5e6tfTkwgY=;
	h=Subject:From:Date:To:From;
	b=S9Fgtx/X5xc3vg9jy7fvHNoh65AZRmKUdfXyGCmLL+1MSzkmsSv6tU2PKoKfgEqbK
	 sJT/XD8Vw0TWlmD05nfqYZbmI98Qcehbr3UmY8T7teI626GU+dfY/U+sdaWot24s2b
	 KDDjzWSltlA5v8ssKdN2cIpw+6yzyA47Q2qiC5ym/oeK8TzzYWqBCMq6XcxH7RApKL
	 sjEaNCDbuNRqMBgABAc5y4zQYrurPPr5m7B2RQ8foMb5cISM7QxSCGUbK2IrqfOEoY
	 EjSygqP/s3rpxQ4Q64pYA6yEpxNe21955GQHzwTPWI3wYqQjcaLP8oIVtWeEsgTVAb
	 H2TJiRJoUQVFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EFC7C43331;
	Thu,  9 May 2024 06:40:43 +0000 (UTC)
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
 <171523684308.14650.5320850071083264.git-patchwork-summary@kernel.org>
Date: Thu, 09 May 2024 06:40:43 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1] spi: microchip-core-qspi: fix setting spi bus clock rate
  Submitter: Conor Dooley <conor@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=851635
  Lore link: https://lore.kernel.org/r/20240508-fox-unpiloted-b97e1535627b@spud


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



