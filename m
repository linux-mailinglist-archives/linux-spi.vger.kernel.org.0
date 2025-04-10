Return-Path: <linux-spi+bounces-7525-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2BAA843CB
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 14:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9B23B03C2
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 12:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536B28540E;
	Thu, 10 Apr 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPNST8f4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0D285404
	for <linux-spi@vger.kernel.org>; Thu, 10 Apr 2025 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289772; cv=none; b=CekgnAbkYthR+EwGGRtGAphXzZyDtLDHwcQscJ5iGtk2T+o/H92z6UvwfAaex/BL6nkJsrQhuhwHjf24M/mFTnkdcURXvDE5+i8DY+tshjP+4v0zLpi2PNHwLLHFWU/oi/P96v/+ZV6E1z5wWzXG2/JQmYGt4QPisplxe1RzWwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289772; c=relaxed/simple;
	bh=eE0122PHskf9tbGdofjn3xlQUugsTs7xSzU28Tw2Kr8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HmVip+aTZrXLfKPxeucF/VBmwOe8cvs9iJjNjJHkHmq/DM9GovjjLQP8YXQ5JiN6fKA08cTWA9qUMq2Z4lXWBEH9+tMsp00Ev0HjdcqeXIDoMxsrD/Vascu8UBnVkmfcNSl/eR5OnmR8G16exeBj1wxtGVOPC75wojiglK54zkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPNST8f4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B81C4CEDD;
	Thu, 10 Apr 2025 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744289771;
	bh=eE0122PHskf9tbGdofjn3xlQUugsTs7xSzU28Tw2Kr8=;
	h=Subject:From:Date:To:From;
	b=bPNST8f40Gey2qGnpj9hzpmOxqJQd6lPgmtZwE9J196T639U6Lv5FPqo/Jnq/NFSz
	 ocRIh1xUYOc9fZEGXUJ8ZCWhM4TDhXPeeHexDEcUzYRgp45xKLuN5AUgKzA6mWcydE
	 OC8F46vjUK88gFLp4PRXD/O28hzMdZE+16dGkP6xT8qFZGxvZBQcZ4Ua9m2bwzgRCA
	 BPvvEmhFrj1YqMbiXrCujSxvI3CXR03BE6jaAVfz0Ae4EFGevblj3fcZLKR1qs7LJH
	 fxWUYE5ERtOL04YBC8Rn3ValbWAx4rgxa4ABNDBs3UPm8p33ZZCxwoCjMXXJFE/Cf6
	 g/4t4/NOzajeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF3380CEF4;
	Thu, 10 Apr 2025 12:56:50 +0000 (UTC)
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
 <174428980886.3658865.6835746418679553310.git-patchwork-housekeeping@kernel.org>
Date: Thu, 10 Apr 2025 12:56:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] QPIC v2 fixes for SDX75 (2025-04-10T10:00:18)
  Superseding: [v3] QPIC v2 fixes for SDX75 (2025-03-10T12:09:02):
    [v3,1/4] mtd: rawnand: qcom: Pass 18 bit offset from QPIC base address to BAM
    [v3,2/4] mtd: rawnand: qcom: Fix last codeword read in qcom_param_page_type_exec()
    [v3,3/4] mtd: rawnand: qcom: Fix read len for onfi param page
    [v3,4/4] spi: spi-qpic-snand: set nandc_offset for ipq9574


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


