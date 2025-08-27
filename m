Return-Path: <linux-spi+bounces-9681-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F1AB3830B
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 14:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161AF7A7012
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 12:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4CD34F49C;
	Wed, 27 Aug 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psXiIx9E"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C034F491
	for <linux-spi@vger.kernel.org>; Wed, 27 Aug 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299409; cv=none; b=Ij8StMEqCB2EGuNvo/xAvwrvLEjoLuICoAcwLN1z8ZEj3STKDehQrg38M8cOSQ4vnRvk/r8WSMFl/IwrkdKEQ5p4Ps1heMd5QYUcF2MzeHBosrkafymTfcLE2hkNGi/Nx39urzByTi75p8hm83jz4W/b2uqhIvEYTOA5ksXROUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299409; c=relaxed/simple;
	bh=R3KL1dQnqyMYK7ckkSeIHjabYWo8e7NFgd/lxfJLwxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=us5BfxSnX6oOObIXmsY8FV9YYO38IZ/oiA9FsM/s+jrUuR2e5jbIZSm9z9sLGfwxH+njanJNng9RI3gqoO3cbKPPlJ0p2yNdzJdEv3R2OxIsYd9nbwAufKUPZsmFN2Jj6SU06M70Iz072E04Gfdt30uqWonoMYybbbplshRcoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psXiIx9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B24C4CEEB;
	Wed, 27 Aug 2025 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756299408;
	bh=R3KL1dQnqyMYK7ckkSeIHjabYWo8e7NFgd/lxfJLwxg=;
	h=Subject:From:Date:To:From;
	b=psXiIx9EUs6wcH9+Md/7ZcTxbnlUjSpp+9y+Q6Qu4uh0DUz/ghtkvZdPlEBcMJY00
	 S2wzCXYESF0/IhdB6HTevsnBESXjtt6p8G1u6yHcylCdZZYRHKUE2pZ05FVb4y+esI
	 xs0ogXOjoW//hCC/uC6ISp9+AdhcrMeuHpThoSA4S0paewlTcwEq7Yp2Uf05v1Ed3K
	 K+XH4jnCq1X4igEtfiEt+B1mAogNbFLCVGVomX1x76g27W7GWNIPlEPQFZXMdZxSuV
	 C3epGXwcj4Bnl3j6FlrKVQf0mjrddr1fe1MDMjbbk5cZSh9z6JyclKBp3Z42rpyBqG
	 39zCs5s5L/68w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710F3383BF76;
	Wed, 27 Aug 2025 12:56:57 +0000 (UTC)
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
 <175629941609.702880.1455730893895674711.git-patchwork-housekeeping@kernel.org>
Date: Wed, 27 Aug 2025 12:56:56 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] microchip: lan865x: Fix probing issues (2025-08-27T11:53:38)
  Superseding: [v1] microchip: lan865x: Fix probing issues (2025-08-11T15:48:55):
    [1/3,net] net: ethernet: oa_tc6: Handle failure of spi_setup
    [2/3,net] microchip: lan865x: fix module autoloading
    [3/3,net] microchip: lan865x: Fix LAN8651 autoloading


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


