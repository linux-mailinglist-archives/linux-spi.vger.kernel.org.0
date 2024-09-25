Return-Path: <linux-spi+bounces-4961-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40BA985C0E
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007BC1C24121
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 12:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7E3186606;
	Wed, 25 Sep 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWsKDksK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C0172798
	for <linux-spi@vger.kernel.org>; Wed, 25 Sep 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265387; cv=none; b=smlvaJx3n4XmYSoDsOzEC8yZwxlQRecGPArMZbZW1ExyVdoJ0DRW1/upX0ytWGxT5u1qlzBl6xEdfWAOJ6RgrbKZdZC+hpmf0AIxwAGVyz5sVrcmKISUVIlYUR0lHvixZ//YeysGIi8kX/nnJEqxopkSEjXll3slBXNLypyt8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265387; c=relaxed/simple;
	bh=JJMzJx9cqK2C31Ewx0xBR2uhPxUKt5eWyNz+cj5BoHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PiKatk61lXZcvwhDqPVaYminFww7Gvt+gfADdrIoKZYn3U7nG4LOQh7BGD7WorSNMOcclvXTTXyj1MRiWslcaQcY4vQogqlmFjbbxU5LMpqr8TomH31gEr2ymsNlKtkZkNbJ1XH4F1Uqs7XrtWCzEbhL+2nclFe2YImAkB9/PvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWsKDksK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E5CC4CEC7;
	Wed, 25 Sep 2024 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265387;
	bh=JJMzJx9cqK2C31Ewx0xBR2uhPxUKt5eWyNz+cj5BoHE=;
	h=Subject:From:Date:To:From;
	b=RWsKDksKvIV+htGRe1Nz7k9MtXCqazAjmgM0Z4H/VZ/g9OwUd5Hw3FVyNrhpqoTle
	 hnTq5796rmkHHcxhl4EIPMlld8rx3+5lb3jsIWJgSwuM7kA41jCHdpDTZqw35WBX5p
	 81/2RDrPek9nf+Avmt3HzhgXcjJ1vHwkViuWTSLXEXCVhLa5IF+yiqin5MXQjwfpzN
	 gYwXHjaf+6QKqhzLezttyzgtAvHesZ8emw07MDR/mptU28mNlsL5YRnMXNt7LhKUYo
	 nZMpyFLDlPGQ8TR0mPjuugqKTXz8izEhKZOK0LkpBBuMyS+nHfLDXWlD0B9L3r2tyd
	 9NUy0f6p8Z6pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B863809A8F;
	Wed, 25 Sep 2024 11:56:31 +0000 (UTC)
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
 <172726538970.559567.11263444215711753451.git-patchwork-housekeeping@kernel.org>
Date: Wed, 25 Sep 2024 11:56:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] dt-bindings: spi: zynqmp-qspi: Include two 'reg' properties only for the Zynq UltraScale QSPI (2024-09-25T11:42:03)
  Superseding: [v1] dt-bindings: spi: zynqmp-qspi: Include two 'reg' properties only for the Zynq UltraScale QSPI (2024-09-23T04:45:43):
    dt-bindings: spi: zynqmp-qspi: Include two 'reg' properties only for the Zynq UltraScale QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


