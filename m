Return-Path: <linux-spi+bounces-11533-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92725C86E59
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62E0D4E684E
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE783271E3;
	Tue, 25 Nov 2025 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilSauQju"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740E2FF144
	for <linux-spi@vger.kernel.org>; Tue, 25 Nov 2025 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100660; cv=none; b=VzTQMStH/bi90bv+MqtkiDmajhDiQASoc2lANhBbqjTHmvlaAmIyCZqUso5iZUMKpEGxvWvZZpezlRRBi/Q37tLIQZQr+5ZsZRCtWWpdl/Ng1AIZ1FONYGzNY64xioFjT0ds2nCmBYmpcTrfQ86dUlk4DUoJbgB+Kiel+KDRhfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100660; c=relaxed/simple;
	bh=VroK1YwajTxurRrlnTwTtSeVe2VvrGYfyCsX/LMTXKs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uYnT/FyMbM/y4p7QjpLKKZhX2TcpRedy8kt2bNm3DovRzwh5zh3+m48nigTin/NxdpAuTqg5hAtopqJrGmbi3/3l7Kzb/Np3JR02ZPtRp+RDnfN+Unof2FoWYcYYlsR/RpvsIiQqGe2ldE5RSBfrjOulZgqA4UKbS2jysCpd1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilSauQju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE2CC4CEF1;
	Tue, 25 Nov 2025 19:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764100660;
	bh=VroK1YwajTxurRrlnTwTtSeVe2VvrGYfyCsX/LMTXKs=;
	h=Subject:From:Date:To:From;
	b=ilSauQju/QJTNAkOJ3S1RSAdRmDAblx7cpyHmGuuKKrNP292MItg5Gnj0tshHrJ5g
	 OxFhH4376E8I9s6cJRYagImu3K98g8TXYBEDus+7OIoq/CmI5e7SGN0qchTuwd61vm
	 JkCdAzhWchIMIRnM72fLT1rx1gi5Sr7ysuVa3U2r1++jzjrHWku9vaZcg7wpdALoQb
	 SyCZf7mgKJ49EZmWKah02y8z6kbecVx/XWCo450OCqZc0MirzUEF95XL7YZ2XN/Vve
	 qJHgSrsndpmXY8ytLpbQLyBBIeipjIMcZSwRSnQ+oawu5/Ed/eko7cQpg8SimLo9lz
	 fj05v7EZI4iBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1748380AAD9;
	Tue, 25 Nov 2025 19:57:03 +0000 (UTC)
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
 <176410062222.896754.12240387455432130932.git-patchwork-housekeeping@kernel.org>
Date: Tue, 25 Nov 2025 19:57:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: airoha: add support of en7523 SoC (for 6.19) (2025-11-25T19:16:32)
  Superseding: [v4] spi: airoha: add support of en7523 SoC (for 6.19) (2025-11-25T02:10:48):
    [v4,1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
    [v4,2/3] dt-bindings: spi: airoha: add compatible for EN7523
    [v4,3/3] arm: dts: airoha: en7523: add SNAND node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


