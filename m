Return-Path: <linux-spi+bounces-9539-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0256B2CCE1
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 21:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B3A5820E4
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 19:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50CE246BBA;
	Tue, 19 Aug 2025 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0/KoU7r"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F932254F
	for <linux-spi@vger.kernel.org>; Tue, 19 Aug 2025 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631197; cv=none; b=teAvkTCEFOQvcEOk193k1/P7gTePitIJejrx5vF9pm5PAbYagBfSDjgZjVDwtfVdWiqJYRdXjRWqnVVE+M/eJKiGFHHS306PRPDTsmgSH7C6f/71g9CDIy0pqcmR2bOoe0m0GaVnBYyBdRrPBZBDIpsIs/312H9tWQIfHz1cOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631197; c=relaxed/simple;
	bh=vlABywNpWR6+JoLsE/g6j97MWVCKKq3VH0Tg4Lel+jM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=k466gtfT6MnYUGXCxWHOjxIQIEubOa4su1k36xRIZes5IaBJiKebG6j+jZvZhAizy2mjABReGbsrw1cfYE5RSe0pFGiNY5n32AfuuxK/Q8ymQ1QnhndWstjiLYJdD0HGufmrAup4TcFnVUW+1UCIIitYiGKPFsxzYEBvXeOTDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0/KoU7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453EFC4CEF1;
	Tue, 19 Aug 2025 19:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755631197;
	bh=vlABywNpWR6+JoLsE/g6j97MWVCKKq3VH0Tg4Lel+jM=;
	h=Subject:From:Date:To:From;
	b=j0/KoU7ryuruAPHW9SY5OhmJnt7qO2GRf8z639gCXVHn0se/crhDzjJ83YAvy2YxF
	 PNMKDRlT5BPybX1ZU638QI2hel9yZeHPzJL9oMrw7tPRU60hFlM+1lZPi6wBY6Ql/9
	 847P4Jtrj9PLRQmiiUShgqWmGVn4dUj8lZBtlG4v837UhE7o8R3727cTAUAZ8zlGWZ
	 Wc0QqwzGE60EFCjab1r91P/LyctjuTrYzCTpPyhGecPfdZ9H4Bn/s4A2kr2h4i/ovZ
	 H9Oj8z1hFp+lEuDUaagktd6PHpvh+gLoaXYTu0pGPq6gg/9oE0ja0dTViLKvdpS6fQ
	 awsCE1qR6QhtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 389A8383BF58;
	Tue, 19 Aug 2025 19:20:08 +0000 (UTC)
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
 <175563120677.3665878.2283184239397062008.git-patchwork-summary@kernel.org>
Date: Tue, 19 Aug 2025 19:20:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Remove the use of dev_err_probe()
  Submitter: Xichao Zhao <zhao.xichao@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=992934
  Lore link: https://lore.kernel.org/r/20250819092044.549464-1-zhao.xichao@vivo.com
    Patches: [v1,1/6] spi: spi_amd: Remove the use of dev_err_probe()
             [v1,2/6] spi: SPISG: Remove the use of dev_err_probe()
             [v1,3/6] spi: Remove the use of dev_err_probe()
             [v1,4/6] spi: mt65xx: Remove the use of dev_err_probe()
             [v1,5/6] spi: pxa2xx: Remove the use of dev_err_probe()
             [v1,6/6] spi: s3c64xx: Remove the use of dev_err_probe()


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



