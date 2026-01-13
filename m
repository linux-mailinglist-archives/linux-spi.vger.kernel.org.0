Return-Path: <linux-spi+bounces-12349-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBE6D198FA
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 831EF30031B0
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6ED2C0269;
	Tue, 13 Jan 2026 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1JpnTGt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821A29E117
	for <linux-spi@vger.kernel.org>; Tue, 13 Jan 2026 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315413; cv=none; b=KKIRN2zpQ8KXvoofnyLeMYKcYyzkyjvZUfFVtLRjSk1+Z/KBBDKeAXqS36Mm9KyLtD1/lOxZ3O2vqpR051kTDnAhJTr6zxXujmsOJrWGuPEMI4fBK49CkF7WHORCZd9Xm5sYyeyKhhccRjnz+SNBXC4DrTqS6pDG+2oPHtDbGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315413; c=relaxed/simple;
	bh=XwiTYwbVvenS75KlV0OtCyka33jBsrLdm5VtGY1lP34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=n7Wu57Oq2TG95u5PzJNtw499XCtAwiZz6rpiFApZPT0N0fwOlqcrIK0hI6jU86jOnWIPcJNuUiNTfjOrz9Akx5X861Jqrx9+oW99a++tD6pYGRrYBLuVBMHasJFOelPxeqCrHRE9WyB/AjLaxygdgXoS1qTneXuxwGJqe8lYoPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1JpnTGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C78C116C6;
	Tue, 13 Jan 2026 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768315413;
	bh=XwiTYwbVvenS75KlV0OtCyka33jBsrLdm5VtGY1lP34=;
	h=Subject:From:Date:To:From;
	b=N1JpnTGtrVNKi5gHjvgk6m6U7Rx+HG8ZuNKbXTPJkh/dn5pafueOfgIzARcl+gqxZ
	 OcLWVq6imepMfRDfUbg+iw03i2KylftMscoeCCgesfl/ioPsG3sifNhk1XhX5kZawY
	 cF/q6RBaXduuhxXa0ACfvyEMtRwbmcLSg4mizrcJ0d5s42rTLWAYvFd10wem2SpzH8
	 uSSEyTO/iETJ769TtbFGgkFmCB0rGZ6Io2ZuqXGbyaKTzo1USTuK5y37SIKZxeiZ/b
	 s7vMTK7bsZ8hkoQJudrbJmnF8YbJQ34gnJHcCPkvjg/MidpdG9/Z5oqCEn3WYUjHVs
	 u8En26bIx4VPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BB1E93808200;
	Tue, 13 Jan 2026 14:40:07 +0000 (UTC)
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
 <176831520625.2275927.17090853227080866703.git-patchwork-summary@kernel.org>
Date: Tue, 13 Jan 2026 14:40:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Axiado AX3000 SoC SPI DB controller driver
  Submitter: Vladimir Moravcevic <vmoravcevic@axiado.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1039733
  Lore link: https://lore.kernel.org/r/20260107-axiado-ax3000-soc-spi-db-controller-driver-v3-0-726e70cf19ad@axiado.com
    Patches: [v3,1/3] dt-bindings: spi: axiado,ax3000-spi: Add binding for Axiado SPI DB controller
             [v3,2/3] spi: axiado: Add driver for Axiado SPI DB controller
             [v3,3/3] MAINTAINERS: Add entries for the Axiado SPI DB controller


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



