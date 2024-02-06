Return-Path: <linux-spi+bounces-1066-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D284AD2A
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 04:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9FF1C2245F
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 03:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477F3745DB;
	Tue,  6 Feb 2024 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC4LtxPT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D125026D
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707191792; cv=none; b=FxmFDtrNoCtgNRgjz1+DONRfG5B+UUYzdAlRntr8eq2M8sbJ5YeAuFFH+5lZzPzWhJcZHPRCUpjfDPPJyU3vEcsXwDzaL/IMdMDwDLMJ8cwwIZT4v/ChobcFfSFKhIK/Lf+XY26sO3hd22gmNn/MBcFGhsph2D52SwsCIrl59+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707191792; c=relaxed/simple;
	bh=I5UnWtLNZCvg7KCCMP919SweVvkLJBYIhtXvh9+VUpM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LMkKw7qKml9sWu3uEMW+AREd/34xtONw2VtXeOupNRhz3ZXIhD1cgudDeVyHqKh70MU13yP8nKQnUBfgHJK60WQZVe/ZwLbKG0u/UE5GSFDktRhKAReEiJ46CHdblR3cq/UUd8jEoj7PKU7i0l63J1q/3/3vZn3lfxXkiJORpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC4LtxPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C6DEC433F1;
	Tue,  6 Feb 2024 03:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707191791;
	bh=I5UnWtLNZCvg7KCCMP919SweVvkLJBYIhtXvh9+VUpM=;
	h=Subject:From:Date:To:From;
	b=RC4LtxPTiBwkGtbivrkKJTIrqUP8ZxISFSruhciqnpQSUWEt7J9P2LE4YXhNtfDw2
	 yuRdwYDNXGYgdk4y7YNU7UGQNRrgikkpTDT0NF9oA4IoyNVy1PNdDaENcqVvX8RrDK
	 rD1hTIxj9PXkdF46gpFDetkvxFf+p8TusJFoj+xHZgk/vUXbOzNpDtG4wp3oL0QVBZ
	 n/3n5BT2+vkziF/an92pfGajvy/Apbmwb1VI5rciK5zy8L1vZRpZG/FbM9DJAJPJ+P
	 aAGUJWYEaSa8nJU5Spxfd5aim1YFOftgXq9+ktbNkF7Rh6tcCGe2UAsfHn2Rr1WYmd
	 sLOwqXqJTjN3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7245CE2F2ED;
	Tue,  6 Feb 2024 03:56:31 +0000 (UTC)
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
 <170719179145.23586.8712922836587813927.git-patchwork-housekeeping@kernel.org>
Date: Tue, 06 Feb 2024 03:56:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] DMA Support for SPI in PCI1xxxx (2024-02-06T03:41:16)
  Superseding: [v1] DMA Support for SPI in PCI1xxxx (2023-12-15T11:47:45):
    [SPI,for-next,1/3] spi: mchp-pci1xxxx: Add support for DMA in SPI
    [SPI,for-next,2/3] spi: mchp-pci1xxxx: DMA Read support for copying data into SPI Buf
    [SPI,for-next,3/3] spi: mchp-pci1xxxx: DMA Write Support for copying data from SPI Buf


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


