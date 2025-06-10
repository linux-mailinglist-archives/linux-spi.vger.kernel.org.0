Return-Path: <linux-spi+bounces-8438-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE28AD4626
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 00:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA807AB1B0
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 22:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3D321C19C;
	Tue, 10 Jun 2025 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7Ae4Mdq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813F78F34
	for <linux-spi@vger.kernel.org>; Tue, 10 Jun 2025 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749596175; cv=none; b=ptZRZRmluz8TPjy/NDqG4cRYCslUpJgVXsuLRnX+k+riaNLMBJLwZg+vle7zRQ3Ny6kyZ2ald7rUPvWdb//WxPp7cs13sKHKxd/8FnsWWwXnX0kjfsUGqWqu5zXALr6PkA6F3amLRb0KgqL2on/gMCdM1ACbrTx64ckNCo9ikeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749596175; c=relaxed/simple;
	bh=mc70h318SUVsVuS3KSLD7Whl7UjDK3x9S/Qx9xvoQm0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tanM9BsBm4MY63B7s1tUPnug6vz0xercOny4Zz1had9XPuDkj3SYLMHKUf1FMmyGuAqLtHyyIfv40zIvZnOv+9XApSJntBlYjdrsndDCO3TIvWi3BsSBF8ybNRR3CqTCELdFT0svJUtzGOFNztH/Aob/Zs/cP0yDDiWurQyqS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7Ae4Mdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9396C4CEED;
	Tue, 10 Jun 2025 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749596174;
	bh=mc70h318SUVsVuS3KSLD7Whl7UjDK3x9S/Qx9xvoQm0=;
	h=Subject:From:Date:To:From;
	b=h7Ae4Mdq70UZ6l9TPXvG0nWAvBZuBqvvWMExmner4/nVBlaLGSmGiS0A1faTv0ZHG
	 4j+U4OQEo+MAbbeAMr+9rLPYJygQEHokSg4b9PHm7/mTwvjqoKbi0/R67rXFbUufwB
	 oVlZKQFS7hJpnPtpUepUlD0jNARjWVHpywKPlgVxrH/16AVJUO7OwLJ/Tn5sALWwj9
	 mMKvgCGOyCDso6hRWs4ZVSBiOIx3EqQycmMSTKmPYTYIeiF1NUnra6V2IOxky7krL/
	 Bq9czycOnbn2w0xSn4uD1VgOP4YqJWg7KRJTLqQwO5vB6W85N+JY3QFBctMzSzMkNs
	 tQYe5tb9OVtfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D1D38111E3;
	Tue, 10 Jun 2025 22:56:46 +0000 (UTC)
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
 <174959620507.2697632.10871446973601578395.git-patchwork-housekeeping@kernel.org>
Date: Tue, 10 Jun 2025 22:56:45 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-cadence-quadspi: Fix pm runtime unbalance (2025-06-10T22:30:19)
  Superseding: [v1] spi: spi-cadence-quadspi: Fix pm runtime unbalance (2025-06-03T00:24:02):
    spi: spi-cadence-quadspi: Fix pm runtime unbalance


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


