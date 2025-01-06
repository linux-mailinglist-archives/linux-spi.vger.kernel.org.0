Return-Path: <linux-spi+bounces-6235-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B88CA02E73
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 17:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDAB3A69AC
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98EA1DFE04;
	Mon,  6 Jan 2025 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5TS1iqi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56681DFE00
	for <linux-spi@vger.kernel.org>; Mon,  6 Jan 2025 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182557; cv=none; b=LBY9pnYPO2NC7YEhlgTJHm2TQYZO/Rkk+N3oy8dWCpwG5ozV2FI+5O1ByfszLx/aEhDHBDUGDd5vSmO7LzR3RHq7AkJQBVIDnVLJzk3KnO4GfE4JGaG1f7JSX7eH50ZHufdz15Y+bouS8Z8HRJ9pVEkyjjI2h1EAeMLpUF02zKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182557; c=relaxed/simple;
	bh=3zvScxz5q/keWvqkTator7Q0zc8svp33KkyE8aCKiC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HpjFySUB7kPPCxfc/L2jabUqflvSOSX/Nst6QZiDUpZo1ghCZkzf7kn9lhF7RhCExmgX9klUbadpY3vrqqrhHZeFm/Xrq9C3ZQWr0wpbgLitc+oUQH9ktNcrXbiiMfopsAqPCwQbMMG53EPSbbg+D3GgBPBCWVk2fW7/iUacqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5TS1iqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DC9C4CED2;
	Mon,  6 Jan 2025 16:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736182557;
	bh=3zvScxz5q/keWvqkTator7Q0zc8svp33KkyE8aCKiC8=;
	h=Subject:From:Date:To:From;
	b=B5TS1iqiDHWLeYlQORdtoBlJeG2pe0GboYzQmEP1j1iZH2cjlUpsDnslcUIQUtCif
	 Dhszddut2MBpBfTQvnuXtoRbo/F8kA1lua/56zogp9bMVECug5q1sgjZ+d2xXZ0zHr
	 STsB0Y4qpwXzPHHpZM6NV5Hs9/8KWn1bEw4Np++/TLzEK6uDK5pX5O55iBwWWFF1wj
	 muPuauHvhCkRwRy0y5qUkV62JRBpnmNFMiPQtIOGPjaK06ECx/exYk5/mwgv53PzQ9
	 micdDiK/Ar2dClqXwvZ85wNDNTYastGorPTb/R8goKwo1WwMZLTmyCRI5SL1gylHG6
	 pBqLYzVzX6UEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 780E9380A97E;
	Mon,  6 Jan 2025 16:56:19 +0000 (UTC)
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
 <173618257793.3559204.8536593475906458429.git-patchwork-housekeeping@kernel.org>
Date: Mon, 06 Jan 2025 16:56:17 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: atmel-qspi: Memory barriers after memory-mapped I/O (2025-01-06T15:48:06)
  Superseding: [v2] spi: atmel-qspi: Memory barriers after memory-mapped I/O (2024-12-19T09:12:58):
    [v2] spi: atmel-qspi: Memory barriers after memory-mapped I/O

Latest series: [v1] spi: atmel-quadspi: Use devm_ clock management (2025-01-06T15:54:16)
  Superseding: [v1] spi: atmel-quadspi: Use devm_ clock management (2024-12-19T14:28:51):
    spi: atmel-quadspi: Use devm_ clock management


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


