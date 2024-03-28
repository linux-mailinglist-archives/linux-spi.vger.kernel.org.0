Return-Path: <linux-spi+bounces-2080-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5584D890264
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 15:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACEB1F2321E
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4580BF8;
	Thu, 28 Mar 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTGigpnY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E643ABE
	for <linux-spi@vger.kernel.org>; Thu, 28 Mar 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637801; cv=none; b=FMFZnWb2h+9kcWHxPsiZnkaxZPDB+f9QFWKruExz14EAtshwalwn5TK5jJOOLcloRpkUMyDwjdGEsq5dPc/HVQ3j9HIilsyYAb5ys+b04q/509nAUnQ8I5KNtje2rXvL70Xm3B0TE2+XkMPAMCmUthtOcefuWZja8FJ0HNTu2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637801; c=relaxed/simple;
	bh=n0F7bX6GMYKGMGyu6Z+pPJBG6zVhR/vBIQcYaUwczc0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ua5tDW2F7ZsfayMRe5qb8zhiXkv0n+oWk4dv+EtD/F5DVrE8Z88oX2V7hy6HvibcBcVeAitfu87A7JgVB6LxxbenvUXRTNBRoGFFvxrQYTGbYSCq+EWKx0gbbB+V+TzkkDU5zZYPMkrZF2OveBnMKtq0RPJd7f8qSJYUPdekqW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTGigpnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F308C433C7;
	Thu, 28 Mar 2024 14:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711637801;
	bh=n0F7bX6GMYKGMGyu6Z+pPJBG6zVhR/vBIQcYaUwczc0=;
	h=Subject:From:Date:To:From;
	b=sTGigpnYo1Yjn8Y00GS5b8mmveXzfXgyIaCYqhg+7mammeTrsoOEZIYlgD6UDEsSM
	 cnmJS/UACcRN0f7T3DxsGABD9CdSeC53DbBWIy9JatTOUMK6XVU4VZP2wlnOTJf+bA
	 N1w3Q79qIyj9wZKcKrH0lDF5IsuSCsoyOP3A0eT1kVMuJiQC6l0z9p1z+tGAvvGNpi
	 niwulvZY0Z5yelJIMPAHeNLczyhtTmMvWcxcShkk6L0JEAE8ip6qE6J8JmdEdXE9RC
	 zC+yHNB2vShhng+94/BVCxPsGuCQ2/IPM89VADaZbdU9d7VlU2VPCz8vqy+SHYum8K
	 ZGmD4/9cvbRKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34210D2D0EB;
	Thu, 28 Mar 2024 14:56:41 +0000 (UTC)
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
 <171163780120.13053.10022397060588195323.git-patchwork-housekeeping@kernel.org>
Date: Thu, 28 Mar 2024 14:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add bridged amplifiers to cs42l43 (2024-03-28T14:01:18)
  Superseding: [v1] Add bridged amplifiers to cs42l43 (2024-03-26T14:11:06):
    [1/3] gpio: swnode: Add ability to specify native chip selects for SPI
    [2/3] spi: Add a mechanism to use the fwnode name for the SPI device
    [3/3] spi: cs42l43: Add bridged cs35l56 amplifiers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


