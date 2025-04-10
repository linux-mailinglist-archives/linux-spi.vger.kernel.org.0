Return-Path: <linux-spi+bounces-7527-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1EA84575
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 15:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21667AEC04
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8FD21324E;
	Thu, 10 Apr 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwbnh2Cp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC226ACB
	for <linux-spi@vger.kernel.org>; Thu, 10 Apr 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293389; cv=none; b=PEuTzvYW+B7aM+UwwakRJK7nqBxWIGAYNFZzSSUHgY94p9WgYP1Q0sLV/Gi1RKGnK642zWrX1or8HrLpNjxJvyd7BUre9M6fQ7UR6SfhaSG65Yo2oMJJEIgQDbHlZ6WlgwkX2odBgcKVkz/pSmquyC9NDiLUl840Q8rJ/mImka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293389; c=relaxed/simple;
	bh=tXlDVGc2/lDB+FO3v/7I4i7owqwoigF0g8Cl9ru0d/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EkakI8gjw2lxaqj8YVeiLMu1Zp8yZ0LW3+PLcbIgblRxcnzoEa/ELqieezjYtniI2sX5/NRuOLo/xTcbMfFJTaZhyqpYBZBYCaTttt6Cz8RsjJZXDsEJIkvZhsLiCREYzf1ixgRLK+Xhv3QPfybf5c/PCUX89RlDIogOr5vhEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwbnh2Cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1D0C4CEDD;
	Thu, 10 Apr 2025 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744293388;
	bh=tXlDVGc2/lDB+FO3v/7I4i7owqwoigF0g8Cl9ru0d/Q=;
	h=Subject:From:Date:To:From;
	b=bwbnh2CpzT66EZq1OanvoXqoREAsNJ/3qK9OzliZdNNX+895BtPZkfm1jo1sWQIp2
	 SV3iz0WPmxUma6kYNU2A/ZqLnJaPqDmxa/v5lPIuyM5sfZ6ixl+nIDB+//VoP5Xb/T
	 5eSn2lB9uiOMSSxisNzdaE1zgYg8vJc01MYcroy1YiT1Bm5pw96z659L+r52gYIk03
	 dzvyys2yWrd4+NIc2bYtdsmuYE9t8CbKxMINc8j2xnG9sAf83oNW76TYxuv5kegqjT
	 d9xINdG77rxPgLPelwINBXN32BGvpgxUCSqaF5Ev3H4MxnUVvShDT8p7v2p7EpX1+s
	 nnSrmyykXYdCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EFD56380CEF4;
	Thu, 10 Apr 2025 13:57:06 +0000 (UTC)
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
 <174429342549.3680853.9203500030374409274.git-patchwork-housekeeping@kernel.org>
Date: Thu, 10 Apr 2025 13:57:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Add support for Double Transfer Rate (DTR) mode (2025-04-10T13:02:07)
  Superseding: [v2] spi: Add support for Double Transfer Rate (DTR) mode (2025-04-04T13:54:27):
    [v2] spi: Add support for Double Transfer Rate (DTR) mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


