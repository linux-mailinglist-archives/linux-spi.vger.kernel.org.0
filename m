Return-Path: <linux-spi+bounces-8615-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371CFADBF65
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 04:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE16A171C4B
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE49C1624DD;
	Tue, 17 Jun 2025 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsoQcS7q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEA84A3E
	for <linux-spi@vger.kernel.org>; Tue, 17 Jun 2025 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750128971; cv=none; b=rjNN4UbvUjCRA4N1+C5rusEK4ywxuHvq8N3NEWyTLFBQtQOf8RBljpvHiYIA96K8YbZ5kp8qF6fY9zPaLA1rcw3BpqufgujQztqgNNBE8IM+S865OMaGyPysgbT6tZWC0K3LfzQWyEGpFEFJUGvanXHkd6BgRvUDnzqi/Gjbpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750128971; c=relaxed/simple;
	bh=M3l3QVtdN8ocJlRtATqfp5QwY7Iy3nWB1q5Q+8aAePI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ngkQ7e4qL3gWCXmnHt51VKmQfVmkcLYMnFxmEPEoxRokUVnBTVL4nG7tnbV1qNcH6ShEaLw4xAjvp5xm3aHA4BgSbvMFHQB1sCrr8x7sjFmkJA2c9FmItVrvLEHopu7x6MldSv8+WNccRB0ukdvrUes/+W3PLuePU2e2C0Ti5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsoQcS7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A8AC4CEEA;
	Tue, 17 Jun 2025 02:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750128971;
	bh=M3l3QVtdN8ocJlRtATqfp5QwY7Iy3nWB1q5Q+8aAePI=;
	h=Subject:From:Date:To:From;
	b=YsoQcS7qGWYnmLVkplr+pNkj9HTzhiO8IBZOMxOxWRMYb2bHVp8WGO3XOC+v/l8JV
	 FHudIflG12+Fi7wFWTUGoE6fVvsSDR9iZ3nOyb70qQMC7xyErwAvL/5KOMgyNHkT6a
	 yH7+icpzmKgjUiVCAKYsZf+AfxN0mfVghWZk5YUV+uCVBWubJToahOk9EYd2QVNTQb
	 rpdOZL6PBbd6q+uUoT2vT+pP7T23qVZxmeWNF2VGQtjOvaoNGKaQvBfW4nfCqz2tUD
	 cJXLUjGKtowzPmwBLgpZLecCxOsfIEfoggh5lEaDe5Rp8scX8ggqZnlq38xEMUBTwN
	 0VeiYBjAyc88Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DFF38111D8;
	Tue, 17 Jun 2025 02:56:41 +0000 (UTC)
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
 <175012899986.2598344.8253610285354784297.git-patchwork-housekeeping@kernel.org>
Date: Tue, 17 Jun 2025 02:56:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] support for amlogic the new SPI IP (2025-06-17T02:48:35)
  Superseding: [v1] support for amlogic the new SPI IP (2025-06-04T07:40:53):
    [1/3] dt-bindings: spi: Add binding document of Amlogic SPISG controller
    [2/3] spi: Add Amlogic SPISG driver
    [3/3] MAINTAINERS: Add an entry for Amlogic spi driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


