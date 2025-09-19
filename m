Return-Path: <linux-spi+bounces-10161-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C240B89336
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 13:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF803BB4A8
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596EA27E041;
	Fri, 19 Sep 2025 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMQV42sQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35895230BE9
	for <linux-spi@vger.kernel.org>; Fri, 19 Sep 2025 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280205; cv=none; b=ZEEKU0DpxcXl8nBdoYxCZDuKMbQIuQZBfqEfoewLi071oSRrhCMtt12o1rAtUFo0bwtmk1rSpnyVTLQZzhZPSNnB0ZtrErigcTFTeUJgwCirU2ZuJMpXAllPR3u1mz4krLIrF5HcQCZ7l8WzksvH5qPU2esiGWwDMqxlFzRuFHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280205; c=relaxed/simple;
	bh=v5dMEQfcOURwrPMJufUbiPaSpA//JT37Thp4MsRKIKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Yi0MnA5uucT8fRAlrPtLQeZFs/1VbwIxe11RlxAc1+2XdifskXTt66DwSkycgbgZfz6dOgvlq/15PIhfataSX6I61pCzYxwNEVszJFp7PBlcfhMutYmo3vkn2RYUunKyn73Rx+fopE9oK7U/+jaqhpRJPqW7c+0ko9DOQyHVohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMQV42sQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12515C4CEF0;
	Fri, 19 Sep 2025 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758280205;
	bh=v5dMEQfcOURwrPMJufUbiPaSpA//JT37Thp4MsRKIKY=;
	h=Subject:From:Date:To:From;
	b=IMQV42sQxMZRiO3EY9gjNWi/fn+OJZrYJIpo9ZDK9fL7WB2QfA4wNQtiRjEAL77V+
	 BaUJdPt6GI2mju0uEDba9kOKeHK/hjs7pkULQVhCCr3D9MZKes0uRlrhkeYuBw1TMO
	 AL30xKtizWzgpp5zShhhurPA85Q9lmKXVJJtVzOrI4PuY/E0KmHS0O8gA+jEH7tnms
	 cSeV9M7+eFJGPcNorqhfGIAyolb4h5A0ifhefy69KqoKaYU062qXYlDYkEWpbRNg/C
	 SdXGEXE5xfInTxMvz5UClE7V6fdelUIjNefqaN7HDqkakGSwh4zAu3LNo5t7phoZbD
	 9zqh0inBpRLww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B359F39D0C20;
	Fri, 19 Sep 2025 11:10:05 +0000 (UTC)
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
 <175828020421.3158781.15686989627434028192.git-patchwork-summary@kernel.org>
Date: Fri, 19 Sep 2025 11:10:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [1/1] spi: cadence-qspi: defer runtime support on socfpga if reset bit is enabled
  Submitter: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1000840
  Lore link: https://lore.kernel.org/r/910aad68ba5d948919a7b90fa85a2fadb687229b.1757491372.git.khairul.anuar.romli@altera.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



