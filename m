Return-Path: <linux-spi+bounces-9264-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0150CB18777
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 20:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EC53A39A5
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F4D28CF43;
	Fri,  1 Aug 2025 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lai4gbnB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EEA28C84A
	for <linux-spi@vger.kernel.org>; Fri,  1 Aug 2025 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754074191; cv=none; b=laNKYHLa4/Th9x8P/seXFoN6TBMnYmwxqJIGBMSQNILJLFu0HojfjzlAK0uO+fbV+5DQ1FcUl2DtgC5CY+/DyRM1Z32ZA4X9qjZYCRYG8rN/gHkKfj7CvtQTUvE88pVMjW6rha6Jco0g6iXuAnVZoTw9ZpoxRSBqhcj1LhKOedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754074191; c=relaxed/simple;
	bh=SlDkNHOYLV1JFV0EnVzb4cPWiSJm84DAIVhz1JfJgjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ntppH4w96ckjnzzXdJ7H57m/ytGSb8wbhw5RMnRM/+g7YsuYa9Ex6OSLT33sKXMdecpRhKYavTUIYhEwdhc962wCkfuEDCCG0yNee+Fq8XCIUZq09qCS9FjwoX/EA3+WCwTudlHLjivWtTzqA8QVRc/T3jhltEfC7qZx+GbS7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lai4gbnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2BBC4CEE7;
	Fri,  1 Aug 2025 18:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754074190;
	bh=SlDkNHOYLV1JFV0EnVzb4cPWiSJm84DAIVhz1JfJgjk=;
	h=Subject:From:Date:To:From;
	b=lai4gbnBdP7lecSGky2xKo3PVC8ThyUUDbwjBgO/hYIbfKm63437Rpbnwo1G7nBt2
	 Ua1fPvZmGFoFq6UOQqUyto2wakH+gH1Fx1mhNUheHeffgMg+dQnQ69SIGpPl+ACfb/
	 GG17eQtrjpi0sbFeu9bB/P58IOgv4QgBKL+EfK5vQZ1xI/lLuxd0FRfN+LRqua6xId
	 Z4yOhXK7kxZUF2c8NSjVDBskcoJ344Mm16Etm8n3PaadaWhtMmtsjO4muICa6JR9Wh
	 GKxIVq7ZYSR1KWoTb/u8K93xOc5+/G4xjR3xqLSMWXKrwvlahwfddrxaBiIamVGpml
	 N/NmvoGZlP9FQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEB10383BF63;
	Fri,  1 Aug 2025 18:50:06 +0000 (UTC)
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
 <175407420558.4038091.10300491023746899424.git-patchwork-summary@kernel.org>
Date: Fri, 01 Aug 2025 18:50:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cs42l43: Property entry should be a null-terminated array
  Submitter: Simon Trimmer <simont@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=987423
  Lore link: https://lore.kernel.org/r/20250731160109.1547131-1-simont@opensource.cirrus.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



