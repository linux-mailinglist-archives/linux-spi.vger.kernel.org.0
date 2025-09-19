Return-Path: <linux-spi+bounces-10172-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F06EB8AA85
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 18:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3C61892E71
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18572BE622;
	Fri, 19 Sep 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT6MdY1J"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B4254848
	for <linux-spi@vger.kernel.org>; Fri, 19 Sep 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301017; cv=none; b=kn6KDaabipnLsua9Aftt8oIwXEQJEofvnq/aoOjg2teDBb/Pyg1PsIYYdlsj35+iFuz/45rMeSaHptgE0zEhXCW1fc3xKAVJVB1++hp1FEzHIHDEH7FyApcqRbwPaQ9cikFHVpMJNPGN/DVwkz4ON2sCIiEKnjC5Y5mxc8r2f9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301017; c=relaxed/simple;
	bh=8xLamae9nOZrQvBLc5188bBaLnbtnsS2D+mR3eWbx9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=AGMKsVoO4E5/67sN6TxKMXesidcwb9ONQlVc0lrOnTcjac5xMUxiqEf2qI5fNu1byYvoVo/FgQG/xxtYvCGpJCEPfY1I96v3MTwPJeisND3j1t0UvatZ0ucZQODpKUx/trluQ8hOwdTnL3pnybAJMjLqd2QcXvRKVVQiEi3NSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT6MdY1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547A8C4CEF0;
	Fri, 19 Sep 2025 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758301017;
	bh=8xLamae9nOZrQvBLc5188bBaLnbtnsS2D+mR3eWbx9k=;
	h=Subject:From:Date:To:From;
	b=cT6MdY1JgSVD2YKkejgGry8IgQ9+LhyViSNS3Sex4FnMu0KI6WFmVAFM5MK0zEmxB
	 dQ9OfK7Jrgr1eJcpO4fp+8Lkb2u57W6vHcl4dBhODOFMu8/dHjEX0tkfNrg/jgqED0
	 N7QPow5NFnzQYW6xo2qdsNemU1QddjeawaI6/0iBMmo8lS5FSPQSUMmB/VMfO0+0Mx
	 9xuGhXRlAh/vWMX5QIxBM4g4i6Y5p/e6mVcoYgllgaLarXTF/6MuJ9AobneoOVir/S
	 8UwJa71ocMC9JS409WbOpb+eU6VaI079GldliGEtNTTVXbFI+x9vd6WlS0kbNaZ5LK
	 PjVjfcZp5+wHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBBAF39D0C20;
	Fri, 19 Sep 2025 16:56:57 +0000 (UTC)
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
 <175830101648.3630047.16003571623171180044.git-patchwork-housekeeping@kernel.org>
Date: Fri, 19 Sep 2025 16:56:56 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: support the SpacemiT K1 SPI controller (2025-09-19T15:59:10)
  Superseding: [v1] spi: support the SpacemiT K1 SPI controller (2025-09-17T22:07:20):
    [1/3] dt-bindings: spi: add SpacemiT K1 SPI support
    [2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver
    [3/3] riscv: dts: spacemit: define a SPI controller node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


