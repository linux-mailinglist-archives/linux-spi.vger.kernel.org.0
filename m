Return-Path: <linux-spi+bounces-9097-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB05B0455E
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jul 2025 18:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6021B18828FE
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jul 2025 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820D225F78D;
	Mon, 14 Jul 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf5Ef8DS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44721C174
	for <linux-spi@vger.kernel.org>; Mon, 14 Jul 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510022; cv=none; b=ExmU1uBDo4Udmy7raBgan7k9q5CWWL4a4Ii7Xc3so8UrX7fgE35/kO1wdp6sYcaBPUFNv+RSC9USVX3uRjBo5zb7v7D2Tswh7kFf+2RSTk16I2kOW1Px6s4ZVhEEkrdpcRdnh45l0mgJMOyVcA7JpuGeZUYH2r0xIeI0HbocNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510022; c=relaxed/simple;
	bh=OR4Yg+DRukd6jXFfDoJOxWA/QKbPCPm7ATW8HWVrhOQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ImU1rVZogybG2RFtnrZSAR5Xgwc4KBETppDHjwaxwHyACPsHo0DvOYA+2QPPQjQV6rsX30B5l3+l9uIyQvyUOMe75AoGytmvk1pYihRY3SXdaDsIZpJdhA38zCPkMUwTOFigoT92MIfbYBXX/5pUMeR92JsNvKhVRDu315XOcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf5Ef8DS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E229DC4CEED;
	Mon, 14 Jul 2025 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752510021;
	bh=OR4Yg+DRukd6jXFfDoJOxWA/QKbPCPm7ATW8HWVrhOQ=;
	h=Subject:From:Date:To:From;
	b=Nf5Ef8DSneiZ1qkj0eoJo3sOLZVHXyPTGynZRi6Z4N1JBghm5g3gVH7WujyzCMHTl
	 4YtWIWw1XytK+nnw3hzEwg11TKs/76A0zfRBjKxuUYXrC0gktyaZYYNWdHzaWY8aA/
	 NIcayt46ckBpDiMgCYHmgQxhcRrkCR4sFTk3PhpOWZJ3qwItzI9SCBMH5Ps1ShJWq3
	 FoCpi7g/Zz5QMQfqFFiLoBiHCc3v98Xt+FrqfQbYnj2TsHX6GVTImPcazb2DWji+Er
	 p0DT6TD43eDNx5j5d5aawz0Le9Wl3a/aKkMXzj2HDRt0CJZW6ZSa7y9IxMG7cZrIJy
	 nGXrVixg/wSqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE727383B276;
	Mon, 14 Jul 2025 16:20:43 +0000 (UTC)
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
 <175251004261.3912741.16366483958371942023.git-patchwork-summary@kernel.org>
Date: Mon, 14 Jul 2025 16:20:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Add check for 8-bit transfer with 8 IO mode support
  Submitter: Cheng Ming Lin <linchengming884@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=981881
  Lore link: https://lore.kernel.org/r/20250714031023.504752-1-linchengming884@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



