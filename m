Return-Path: <linux-spi+bounces-11035-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130CCC35493
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 12:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC4D3B79F9
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A74C30504D;
	Wed,  5 Nov 2025 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbuxS0gZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64497307AF9
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340249; cv=none; b=nRJoGC+scrjRKc/FBk9ZXXAUqGTClCe2MyBR2y4ij2K5l9pB9qTAKfzX/R2Mch4aFgrBQ2sRPmQ97PQe1QqSyXmNMZUd0w1ZorPdio0os/4SZ4RYT3I9QhgNg4g5jQtIRHhP98R+GpRqye+V120CqsbQKS9ZpoHu6DoQsZmhH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340249; c=relaxed/simple;
	bh=AVHwLZmn1IBmtE8Ht97knvClvsQmAkuFYqBQ/19IhQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BuPTqSqgdAEBVfMhzN35V2i9toee423hH17qggwntWYAjLTLp+A/Xy20fMNelORuWYUXBVWU7/8vG83ZpLiRCqI2si5whI29ySki5O6Ou9FguDUXDJui0kOvKqOmTr764RUzUDDWWgpvXII/8RCuF6Q4tkIfQ1wZDBgFK4P41C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbuxS0gZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0322DC4CEFB;
	Wed,  5 Nov 2025 10:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762340249;
	bh=AVHwLZmn1IBmtE8Ht97knvClvsQmAkuFYqBQ/19IhQQ=;
	h=Subject:From:Date:To:From;
	b=pbuxS0gZoV/PUY5FlH9Rr6GY8LmKBwYcZ/KcsgW3QeemXx504llu1+tYxCYcbXiKu
	 kQ5d5TxjgWbON7s2soi3eLeeRcf2ir2/Pq0UN4ofIwLoe54SqXjuzc6rNmLagHIitE
	 RCDo7LNbdIPqR6WSKmmXDg6XXINUZhZoKyMzscrNflyP0J+YVWUPs0xCxgYgNIWIy3
	 ogS94Em1/V2pGBO920RG8Wi+D/6nIzbEwMQUTSx0pXTLV5B887LaHMopt+o1YxvIMS
	 b2zkF9xCoSVIRaCSB9jfpjnnR4PKcNgQi9qd+L7SEOCB7l6HPKXkEZBT29eMOdkCGb
	 F1cbv9hm8nsbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1EE8380AA76;
	Wed,  5 Nov 2025 10:57:03 +0000 (UTC)
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
 <176234022239.3569889.14515378269729864340.git-patchwork-housekeeping@kernel.org>
Date: Wed, 05 Nov 2025 10:57:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add RSPI support for RZ/T2H and RZ/N2H (2025-11-05T10:41:37)
  Superseding: [v1] Add RSPI support for RZ/T2H and RZ/N2H (2025-11-05T09:13:44):
    [01/14] clk: renesas: r9a09g077: add SPI module clocks
    [02/14] spi: rzv2h-rspi: make resets optional
    [03/14] spi: rzv2h-rspi: make FIFO size chip-specific
    [04/14] spi: rzv2h-rspi: make clocks chip-specific
    [05/14] spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
    [06/14] spi: rzv2h-rspi: avoid recomputing transfer frequency
    [07/14] spi: rzv2h-rspi: make transfer clock rate finding chip-specific
    [08/14] spi: rzv2h-rspi: add support for using PCLK for transfer clock
    [09/14] spi: rzv2h-rspi: add support for variable transfer clock
    [10/14] spi: rzv2h-rspi: add support for loopback mode
    [11/14] dt-bindings: spi: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
    [12/14] spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
    [13/14] arm64: dts: renesas: r9a09g077: Add SPIs support
    [14/14] arm64: dts: renesas: r9a09g087: Add SPIs support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


