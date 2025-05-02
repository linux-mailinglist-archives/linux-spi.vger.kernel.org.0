Return-Path: <linux-spi+bounces-7851-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8DBAA7102
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 13:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6F3189CE90
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD1A14AD2D;
	Fri,  2 May 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vONs+NWF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87316195
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187189; cv=none; b=K6fmFjhBTa+jEzzV4gP3QYRWnKWtrCdgkOS1g0iDd+ySd3tmMAsEgsjNNyRfdBrWDX5yOS4yDvgRZjvNJB9QZwQWzXHSYXNzaJdxSoAPWdVj3/Ij5NUE8qn0z3kmafvk/4cbDPqqiE9g+nQnwsSfZmiFFmt/sZqEMt7VfTYIs/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187189; c=relaxed/simple;
	bh=xTvdiYIWqfkVCKO8PXyQiVAAGiT71izzdugMxE6KmYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=AjboibAuDtBE9YHDUxEqDBsp6wwg3+qhJPYMMexREGX6v7X757JQ0FsrW0oEtpBRFoAHkgw4MT3K9G0URPm9HenLIGHrLkL/Mw0rs/YMDvVMVNWqHDnPuWnpgiGJPM6zjc53xx7I00nGyC3dq6tYEkuQHXE9bTawJjqiyRYJF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vONs+NWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FF9C4CEE4;
	Fri,  2 May 2025 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746187189;
	bh=xTvdiYIWqfkVCKO8PXyQiVAAGiT71izzdugMxE6KmYM=;
	h=Subject:From:Date:To:From;
	b=vONs+NWFaHuR6IXnYTbgXRriT6w8YvHxITSQYn7vMy2F0091OMWfQJ3pp1v+wqWDx
	 dbwnEr/jnRw+r+bpeqcmDDmqhpkIDYmVHXt6CshMeJyJXs/lZgGN83zoykLshr9b/M
	 KZiCr2UO+sURQECY+kUzvazvpSpCW/L/I0AveXl0l2RTIhQ9HTHPEilt9EYlxH2NGl
	 kKo3N/9KYpVTnXqN45onSUzVdjWmdZas01J4tDVDW6/HnVBuk0iJKeN5EzUk9nkFcE
	 CRU8zZ51Un6iaaJEmGtOMDWnsW6QIKJbYa3Vtr5tnlIfh4A//fIaacpNgPcIc9MJqU
	 6/XRToK79UKVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3762A3822D61;
	Fri,  2 May 2025 12:00:29 +0000 (UTC)
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
 <174618722765.3592767.15767773028733735907.git-patchwork-summary@kernel.org>
Date: Fri, 02 May 2025 12:00:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add QPIC SPI NAND support for IPQ5018
  Submitter: George Moussalem <george.moussalem@outlook.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=958753
  Lore link: https://lore.kernel.org/r/20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com
    Patches: [1/2] dt-bindings: spi: spi-qpic-snand: Add IPQ5018 compatible


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



