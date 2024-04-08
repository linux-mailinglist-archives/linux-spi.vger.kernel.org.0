Return-Path: <linux-spi+bounces-2228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7E89CB60
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBF4281A2D
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CB214387A;
	Mon,  8 Apr 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDvQ9d7b"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E71E489
	for <linux-spi@vger.kernel.org>; Mon,  8 Apr 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712599228; cv=none; b=JOqgCYd2lPseJ/r6Hol7UPiM6dy/JuKi89eQFie9iJicBB4mkt0+qxb1MTk1L/1W4YllIC18gg0qh3OOSRF+jlpQ5e+zDlOww6AeGFfejWuBIfgBb4GdBCUO0CRrrdYJ232l8E4ZaqfwvtXNEjfhN7LQmZ4wUvgmTjWXk8cgcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712599228; c=relaxed/simple;
	bh=sFwgzzi9Ot45SWsWgmErzvOtHRqGB1whIi5+ugcOqCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gdok5ta1nARXtat4tAkmjkbLvihoDw7cO2Pfu6nW2e/nu2dH4gMTakOOcCFg85wnSH6/pEXXerS0Inx4cJbv03zziK4+CHDlnhq5yE5AuAIpDNsLKB8japdkjMIDRvDY3UNBbzbERJ66W9djh/WaQZCNF/l120oqxavAxemciYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDvQ9d7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3D97C433F1;
	Mon,  8 Apr 2024 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712599227;
	bh=sFwgzzi9Ot45SWsWgmErzvOtHRqGB1whIi5+ugcOqCA=;
	h=Subject:From:Date:To:From;
	b=lDvQ9d7bbD7tYKmNLLzy925rOOtaIcW0Hq4gVCAF46oU0vmAsOJGT1b1tbEa8lneb
	 XNp+PUAQ1j51iyOUlsgoEXSJKKqx+GyQke+ZJDG4MAqigpD7KLhzoIG6zglQ7eyZrC
	 gb/kyvQBpFvGdRuMbOS0HGSB4abSAbxmebYkEHXQx5MRNRhheG0XgzyzUZ6lrzeL6y
	 dLo5r04IcX8Z6D6fL0Rn492/lXi2Oxq7ebWoND52bCa5gbQNOu96SUtXtdTM3iVJ2m
	 JUitAWVnFf6qDJW9YkKbXQXyxpAjD1d0SlYls1NQF5mapoGvZDosZIgmQV0T5vTvAC
	 /Vr0ApvfS0SkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEA6EC54BD3;
	Mon,  8 Apr 2024 18:00:27 +0000 (UTC)
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
 <171259922771.22237.16754153902898471116.git-patchwork-summary@kernel.org>
Date: Mon, 08 Apr 2024 18:00:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: cadence-qspi: add Mobileye EyeQ5 support
  Submitter: Théo Lebrun <theo.lebrun@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=841849
  Lore link: https://lore.kernel.org/r/20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com
    Patches: [v2,01/11] spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
             [v2,03/11] spi: cadence-qspi: allow building for MIPS
             [v2,04/11] spi: cadence-qspi: store device data pointer in private struct
             [v2,06/11] spi: cadence-qspi: minimise register accesses on each op if !DTR


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



