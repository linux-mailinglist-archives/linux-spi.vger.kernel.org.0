Return-Path: <linux-spi+bounces-8405-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F43BAD22F0
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 17:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F4C18869B7
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543FB41C69;
	Mon,  9 Jun 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5zhvwqZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8463D544
	for <linux-spi@vger.kernel.org>; Mon,  9 Jun 2025 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484211; cv=none; b=g5VA5bOvQ9vuKC2PfL0XpZTM/QYbwFG4mDpL4ePjGDAZ9cvMKSq5+GiBrKb+0QmeFsrwTNIr+yvwil+lH7MFVk/xD1HWZ+lakZUB3c7yt/UE1yKZTzKYzzlqeaU1cqMmF+LjIIWGDqgTEEFTYNX5pVTv/5331BpT6mR7EbDIarM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484211; c=relaxed/simple;
	bh=AcKACeyTtLedPGKk6HtPEek6ZlAm2O2QfaeW5j44rV0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZjHt6LmZAJWLDneQMZ6eSuignKXmR4EQF4kvUXDyjmpTzg8JNT5NkJt3pw/pyHik0iATZOTRRi9BpnH4ZgaKjIh9LHDLqs7Bgv8jevejZFYju+d0uZMYkGbXjDBWIpGd9yKEcOTJdfJ/Hx575/qtfh5bST7LNHEK1HQ1Ga8jHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5zhvwqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C920C4CEEB;
	Mon,  9 Jun 2025 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749484210;
	bh=AcKACeyTtLedPGKk6HtPEek6ZlAm2O2QfaeW5j44rV0=;
	h=Subject:From:Date:To:From;
	b=l5zhvwqZvbqb9cLaVTGA2Ub5kY3guR4QAHFMsBjb4MiFWVxXF4ifd1cekcIz8wWzm
	 kt5O+TlrGpRBPgLvsdL7jfwjUEfAXaYpPFR5wejrvOtEEwRRZ8ucCsGdM56JblIMwm
	 x4aM7TjCZv0E8agleiYkhs8ohl10FsttsZjcfx5+QenI0R7QVZy1eO13myhgN+9xRI
	 qbAhKVPiX7bEIAYisjpUq4knLeFsCFt9AlOqSs0S41lJCC37wkcP8eHNimm+HE2mh7
	 +oJ0OBjRUrFk0PkbJiGcJvjn7+xkOQRFWAsDfG4+l448Xf8DoDE8ZheGt1Wk+LegN2
	 GTx4XqmvwyCqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7500E380DBE9;
	Mon,  9 Jun 2025 15:50:42 +0000 (UTC)
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
 <174948424092.1348941.11881383454017602307.git-patchwork-summary@kernel.org>
Date: Mon, 09 Jun 2025 15:50:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: offload: check offload ops existence before disabling the trigger
  Submitter: Andres Urian Florez <andres.emb.sys@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=969640
  Lore link: https://lore.kernel.org/r/20250608230422.325360-1-andres.emb.sys@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



