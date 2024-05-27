Return-Path: <linux-spi+bounces-3105-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D958CFC40
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 10:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F841F22EF2
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 08:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F716CDAB;
	Mon, 27 May 2024 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD3+p3OC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E544C68
	for <linux-spi@vger.kernel.org>; Mon, 27 May 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800189; cv=none; b=X6sBYtoBrs0hGdujEiDoyjtB8HZ4amG60dC5achW/NdvWFDgP+8HKAj4P/GZr/xvdDst/wKcrQgOKW3fb5DsFhG2DWHXhGOizsnxmmAnu/k57ruZ7AP3zjVdZHRCX7popFH6ixN4W693C1adNBHTz8ankAkHBFLdtve78HEWjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800189; c=relaxed/simple;
	bh=zoAH5siTsV3YvGFVy8hzEDKH7zP5JWpNklXtlktsR9c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=l6k/L91BCmvYiMji0ScSGGV+j67rSEG/EdWz+8USlR+3FwEDzVskezvyZ3ZRri4Ta4Xd4BjT8D5wL+GPYAJ9xbnhmll2rLWnE/6SyRZNGsjHhli5ATQK4Ur4K2zrp84XbDWsq7ZNkNlGuvGxGnyZfp0TcnP4hNxDhZf6EA+35Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD3+p3OC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF727C32781;
	Mon, 27 May 2024 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716800188;
	bh=zoAH5siTsV3YvGFVy8hzEDKH7zP5JWpNklXtlktsR9c=;
	h=Subject:From:Date:To:From;
	b=KD3+p3OCkuKvfSjDlIlougWCgEfmlPVeemIGAjJDBMDTGEh81GlLkfBNlue90vCbg
	 HMV1QgSspeQT4g+e5+RKWZI2uTMoNTR17NP797dyfZvOmIZno9eaEeNijzKdvEorBw
	 pVeHM6ww5Wbuzk4ajWev0vEbIXtC7pIUdOzmURwqidg+tir2OjAFCYujxE4C1XuN/F
	 H0+Rhh75LzU86nGIcxFy8ipiMF9xMiF2vG2w/3beIyCLZrR0bXfleDo7L8mlsa2lEc
	 IsobnrFW5rJrBoML1W3VqIQoyhio6KCRuZnaceYLDXHMoy8UbzpjNSbzUI3XigmAHs
	 8oIsvDReoZZQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4F38CF21F8;
	Mon, 27 May 2024 08:56:28 +0000 (UTC)
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
 <171680018873.12521.12883986831560790124.git-patchwork-housekeeping@kernel.org>
Date: Mon, 27 May 2024 08:56:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Marvell HW overlay support for Cadence xSPI (2024-05-27T08:42:10)
  Superseding: [v4] Marvell HW overlay support for Cadence xSPI (2024-05-09T01:05:18):
    [v4,1/5] spi: cadence: Ensure data lines set to low during dummy-cycle period
    [v4,2/5] dt-bindings: spi: cadence: Add MRVL overlay bindings documentation for Cadence XSPI
    [v4,3/5] spi: cadence: Add Marvell xSPI IP overlay changes
    [v4,4/5] spi: cadence: Allow to read basic xSPI configuration from ACPI
    [v4,5/5] spi: cadence: Add MRVL overlay xfer operation support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


