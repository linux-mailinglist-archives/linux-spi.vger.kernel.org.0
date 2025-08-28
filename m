Return-Path: <linux-spi+bounces-9686-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3791B398E6
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 11:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA847206FCC
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 09:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3BA2641C3;
	Thu, 28 Aug 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg7LYf46"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ED025BF1B
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375004; cv=none; b=O7V2T0JnEq7n8JeuVyzqzHtOEOUFkpCX1LFUmvybHi9HyWVNEr+Stwb1heR08jW34N7UA33NqzKXgwRo6p5AZGjjX/VIn/l1+Xr0cuqNwaQHxhf62hKqOgSfN35KtQc3hNai8CxMhKP/8CZtzGNO1IHBoKmAniS0YvpWl92NtXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375004; c=relaxed/simple;
	bh=RNYhAxR4/Fm6JU66hIq3CB+iDJfgKxraVa0E6pLKBIg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=p6of0yG8Tr6BRQpgGEPeDFBKnrKRtdveg4+pdqPAy8GBwvhxoFrlCDxouAOHthdL1zZxikLeonXBDwnIUwVDZbm93dPPE97bibrf1btRHQj96ipf9d/D8bu9GBYsUlzzyM4zYnAvfM5TQT7xxeMezO7DZWn5Wr4Tbhs0tQveDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg7LYf46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997A5C4CEF4;
	Thu, 28 Aug 2025 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756375003;
	bh=RNYhAxR4/Fm6JU66hIq3CB+iDJfgKxraVa0E6pLKBIg=;
	h=Subject:From:Date:To:From;
	b=Wg7LYf462i6Q22lanNT8zUgth8PD+VaPqgxCPA1poBO2VmnS+RYoC3CDocT5SaOOp
	 VP1tMRPE0MCQDA2hdAgRoyrbR15Bw7f5cNI68Iogfb7IZlKBHZ0GA2vqAJjAiPEQcg
	 gUWs9N4g2She3Em59iTCIKJoRY+UD5tnGsVC9eIpulC3YxEA3k+6luBzSPN163WbbH
	 /au7N98yilUA1zOM7XFxBC33tatWO02iIPuo24skHu7j+qfzJAATJ/0BsBxTjHiJrM
	 VoETdvRd9muhpVnUdgtv/pc/1dJCPBzYFb6C4jYGnvXkP1Ug+l27HLz7mpTLTL7+pO
	 DZUeSFCdHqJXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF5A383BF70;
	Thu, 28 Aug 2025 09:56:51 +0000 (UTC)
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
 <175637501059.1387218.7997502460834320107.git-patchwork-housekeeping@kernel.org>
Date: Thu, 28 Aug 2025 09:56:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v9] Virtio SPI Linux driver (2025-08-28T09:34:48)
  Superseding: [v4] Virtio SPI Linux driver (2025-08-20T08:49:42):
    [v4,1/3] virtio: Add ID for virtio SPI
    [v4,2/3] virtio-spi: Add virtio-spi.h
    [v4,3/3] SPI: Add virtio SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


