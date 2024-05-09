Return-Path: <linux-spi+bounces-2798-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B07868C096F
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 03:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21751C215C0
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 01:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA913C835;
	Thu,  9 May 2024 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqBY1kw0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC913C8F9
	for <linux-spi@vger.kernel.org>; Thu,  9 May 2024 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715219790; cv=none; b=LwLkK1fjmnhoAKLAVtm7GIKc+5jFK3f/YcFloef6u8MHrgC5YV5YsH5lznozMpcg7R1/5REYS/Rm/xnPyTObItzpBTl/HA7ZhjY45kYAa5FtAwryp2+S6kxIVi4AQGeNZ16o8+uIm8UyyYIzlON6ndQX5N6jnYut3wkW95C/g18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715219790; c=relaxed/simple;
	bh=nBsYBjwV1pHPd2miH0R/T5kE3d4jOBZa0sDz0jdfYeQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BS499OpflntJRyBbl0H5HiBhCrFwjoDoGVG4UxQ/fL+5p9NgkdIJ7toTv49Ok7gT+8ox2UiBXmdfEQ51kA/DWELzJ46pWWaoO8qxx/YLyIFBVD+NKtEg4jNFsndsQ4YdTDYYT6RdM5zGmyqOd3M2/QjFvCBDx0i+RhKfk31H3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqBY1kw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37712C113CC;
	Thu,  9 May 2024 01:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715219790;
	bh=nBsYBjwV1pHPd2miH0R/T5kE3d4jOBZa0sDz0jdfYeQ=;
	h=Subject:From:Date:To:From;
	b=NqBY1kw0rs7YYhvxJ1xgj648U7vjr8EfFNTHyB8+N/FRDat+hieg1CiaIiGLuqy1+
	 uJX05yEi3F4WeC2EgZsPQ1mzs30RG/ludnZrykMSGXoMlsrpQeqDFY7XVbGEorb7ED
	 lrVyTycu+EvwWhj+ffEzumjCm/DoXgM2FmS3bM5bskzTL0ezlCpuiTHFt0QSu+U9an
	 /FAwBCzxv3atX8jiL1TWGCQsD6rYYiF8l8EJET7myioVH9v2ywlLNLeN9FcwCQY+qf
	 xd4bHek0Wl52AV4P54MG6LfuDmg1zCWAWr9y4YPmELOWs3VDCfRwuOttslXI4CA+h9
	 7xERZD67Zoxhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26421C43330;
	Thu,  9 May 2024 01:56:30 +0000 (UTC)
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
 <171521979015.30418.11041906569254633325.git-patchwork-housekeeping@kernel.org>
Date: Thu, 09 May 2024 01:56:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Marvell HW overlay support for Cadence xSPI (2024-05-09T01:05:18)
  Superseding: [v3] Marvell HW overlay support for Cadence xSPI (2024-04-18T01:13:48):
    [v3,1/5] spi: cadence: Ensure data lines set to low during dummy-cycle period
    [v3,2/5] spi: cadence: Add MRVL overlay bindings documentation for Cadence XSPI
    [v3,3/5] spi: cadence: Add Marvell xSPI IP overlay changes
    [v3,4/5] spi: cadence: Allow to read basic xSPI configuration from ACPI
    [v3,5/5] spi: cadence: Add MRVL overlay xfer operation support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


