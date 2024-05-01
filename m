Return-Path: <linux-spi+bounces-2688-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824678B8EA5
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 18:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AD31F25A02
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE41B285;
	Wed,  1 May 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5E0dxRl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6930E18E29
	for <linux-spi@vger.kernel.org>; Wed,  1 May 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582612; cv=none; b=SCcwZWi6fU+AMGMmBhsGrkx7VuJGk6ptiBoJLfi3fFAIaFeJ/4zK3ZGc/DnHBVD7VDLXazpgCfKa7khcLvi78dTHSIOd7AmKWXI2wPWoV6q315ozZRPuw44EwDKohSGa4y+BosRtPfwWhz24AKo6NfCPyrkKDa65HjenR9/oA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582612; c=relaxed/simple;
	bh=yYJbEvaPprs193pMWly9K46b8tnLFmuv4GqRbprY54o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KuxQ7XK4O9IMNb10FKXygOCk0/6QawhTPNLuEqh+nzKpM8338g7tSxBJ/ChCX+em/KQ9QcDYxPwtUkx79IuG+3Fd8d3OXxpGZxsQcLnsuYQdnY1b+e43fCwvY/La2y6xCYgWIgaIocpPO2k9PGpNbsaJTE1dkpT/JzehM0Fi4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5E0dxRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0298CC4AF14;
	Wed,  1 May 2024 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714582612;
	bh=yYJbEvaPprs193pMWly9K46b8tnLFmuv4GqRbprY54o=;
	h=Subject:From:Date:To:From;
	b=b5E0dxRlte0miSCTn3UwYsL4hjjNR7URP4fefnDCBJT8P85e7x4zcq+j0fUbvt2zl
	 klDAKSBZmcJy50nmJXZfVvWcl8ojhMyg4urM2JnD/QDZGwiJh62DCEpW6b2CH0RoQo
	 n20zo8+6bhasD5Z9POc8PG6pDDRIqIqMUJP4aHxLd3p289s/MOmNGxBWt24KzVgmhz
	 mcqnE43rTgmQ0HdKWI9Ny+mLWKQaLe4owkAueemKpKOR7zEssoObEAykT5SaqZ7Y41
	 fMuqOilRLToSKp7jMilTTFIqh2d9l52VzaZvIjqtdn+m1sh7pkzroGG88Ik3GcklEu
	 N48D/OfthnHiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8A76C433A2;
	Wed,  1 May 2024 16:56:51 +0000 (UTC)
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
 <171458261194.2469.1240558370609853440.git-patchwork-housekeeping@kernel.org>
Date: Wed, 01 May 2024 16:56:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: dt-bindings: ti,qspi: convert to dtschema (2024-05-01T16:48:53)
  Superseding: [v2] spi: dt-bindings: ti,qspi: convert to dtschema (2024-04-29T15:44:21):
    [v2] spi: dt-bindings: ti,qspi: convert to dtschema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


