Return-Path: <linux-spi+bounces-10059-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9C5B7EB5D
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 14:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818711B281B3
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6712BDC23;
	Wed, 17 Sep 2025 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmrodnnZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C4242D6E
	for <linux-spi@vger.kernel.org>; Wed, 17 Sep 2025 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092207; cv=none; b=bHWCluar3J9ooKAfLZIc5+QNTPVjsisQe8i3C4Zgs1os40s64pzUxiKwVuU93jPwCPmRwD/B5Z7WVPbzvW2rH+3lzoqLbrhIPPFEY9TPmxT05TYct9Lns+7N/74ZHI8GLSZGmFoXgw9DV2AyhZJ+pKYLfyI6xoSXxXRKz5NDmMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092207; c=relaxed/simple;
	bh=JGrtKmi+XufQMiC94BNW5es1L/pqE8tCZoBBQj/KQdQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HwpK/Gphy8CU0mgFJofenp905PvI+/3RFol1nJiSgnx93Y5QPg6FoC8SJI00WBX4iwrgIvC9pPi1/uh6Mery66ozWMemkUITI4z89wl6qZekzy6B9xbk6YWmQ6v1nIEKR4ZmMxp5RL/SpRswsz9oPEEYrVR9vXU87inwsU5Hb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmrodnnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48F5C4CEF0;
	Wed, 17 Sep 2025 06:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758092206;
	bh=JGrtKmi+XufQMiC94BNW5es1L/pqE8tCZoBBQj/KQdQ=;
	h=Subject:From:Date:To:From;
	b=VmrodnnZ/psViH8wtG7uY7C2RegOzXWe23GY4dto0Y98sftWWfDgqs2Q4qDjqv6Pz
	 3Q9zMZdqau7OXv8ZMi2sCohsQv/f52TzqZiuPFukc3tsJZBwzIMuWVuQKDOHLQ97mn
	 cQ2kTlX4H8TO4b04G0mT7Baoo0mGiEzhNnLoaNV5E4dGm7yg89AQlv10PXUQinGB6c
	 piJ5RAOHX0QinAG5zRQqT0Lm+t4fyw/TfUelbjOG3vJTD7fSKEsWR76LLf7tN85UWa
	 Mxme9BNqiv42GrKfVTpUtlSY+uSGty7xeAZHDzkn5BRuqyPcIyh3spdLpj+ZQ5gqwx
	 iH2FJ/FUPzQkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB06439D0C1A;
	Wed, 17 Sep 2025 06:56:48 +0000 (UTC)
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
 <175809220738.1495240.1491387189102493939.git-patchwork-housekeeping@kernel.org>
Date: Wed, 17 Sep 2025 06:56:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: mt65xx: add dual and quad mode for standard spi device (2025-09-17T05:58:39)
  Superseding: [v1] spi: mt65xx: add dual and quad mode for standard spi device (2025-09-16T08:15:15):
    spi: mt65xx: add dual and quad mode for standard spi device


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


