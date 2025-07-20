Return-Path: <linux-spi+bounces-9137-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA214B0B464
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 10:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471673B9322
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E83C463;
	Sun, 20 Jul 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7mnVAw+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443D817741
	for <linux-spi@vger.kernel.org>; Sun, 20 Jul 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753001869; cv=none; b=V1NpjbBrIgiKxJymGRp/qiBZ0xbOkGqhwNBChgMmvbWW6d9E7GFs/RvT6iv4PaoHhN/4W8CgY6aKHFD3/KV3oTxq/BqhRRWD2X6M0CJqIp2m6dll1ljP+Q+s8O7r76cGC/hOk+RIYu1Gh7e1v3y3BelHw5e3v5kfOdvdw3vzVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753001869; c=relaxed/simple;
	bh=1H7JqfuTSdL47CFlcM0r+DNvw9Qzoc/3QJeXe0AtSJA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=goX/Cdh9sJrGBu/kif6L0fS+jiHnr1qRnwQAvxL04a0WZ1BVk1DsAhTIv227EXDM+Qz40//ubD90aISTSkRnHAatcOHMYOrodVYI2BN1bmzfAburBZZFbvsJvMUw2kJXdiBFMLrcTNsySVFpBYpDmiLPEab8Bb/43llHHLH5aF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7mnVAw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EB8C4CEE7;
	Sun, 20 Jul 2025 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753001868;
	bh=1H7JqfuTSdL47CFlcM0r+DNvw9Qzoc/3QJeXe0AtSJA=;
	h=Subject:From:Date:To:From;
	b=T7mnVAw+Z32LKXHWSxeXKeJRDF2ABKDRMk7041/NJCI9NYgRJpofyn0iWZfvgZgZi
	 HQTI+bwwZpZSsBc57EfEehuov+h3qJWtrp2dq3FyIS1nfcPeFspbnIGCdtUkL2FOny
	 HiDPuXokkGtwbxEiIYgCSRh/Z/2a6PwupL8TcVneE0xCJJ5PY7eaG6/ys22lb4lEhe
	 zfgsQZLiQd/+u175mV56iUuhOzlotSP+KJfJqw0oRHaauWLxoVbgndN5jOH4r2RYmt
	 nLs8fXpBRfIe7jcPDQNdYYSJRz9boVzYVVaJNpv7eSt7X1xt4711iZHKhuDWlYYZfb
	 p/QCFkxCfajkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C11383BF51;
	Sun, 20 Jul 2025 08:58:09 +0000 (UTC)
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
 <175300188779.3161394.14262864976594999702.git-patchwork-housekeeping@kernel.org>
Date: Sun, 20 Jul 2025 08:58:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: sophgo: Add SPI NOR controller for SG2042 (2025-07-20T08:31:42)
  Superseding: [v3] spi: sophgo: Add SPI NOR controller for SG2042 (2025-06-29T08:23:09):
    [v3,1/4] spi: dt-bindings: spi-sg2044-nor: Change SOPHGO SG2042
    [v3,2/4] spi: spi-sg2044-nor: Add configurable chip info
    [v3,3/4] spi: spi-sg2044-nor: Fix reading bytes issue on SG2042
    [v3,4/4] riscv: dts: sophgo: Add SPI NOR node for SG2042


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


