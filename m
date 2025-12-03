Return-Path: <linux-spi+bounces-11746-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206EC9E9D8
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0B2C347EBB
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD22E2840;
	Wed,  3 Dec 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx1r8ER2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B72E11BC
	for <linux-spi@vger.kernel.org>; Wed,  3 Dec 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756008; cv=none; b=hd4kZrx9N/g+h4Qln7qoYZZOGgM0E3NDgsS/jqV4kXRRAYDW/muEWGut352+LjyCGZK30oklUxOtgH6tQyW5EgDClfrG3RdEgiPjrHJzgu7go/GxeuMDxSem5Vdn2KKCi6n72LYl7/VzYUoq/rBYIiu5hzxoZnTlA14ullLgI7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756008; c=relaxed/simple;
	bh=QmaKFVhBQiQzNlVCCt7yiAN9GeZGGLPzGFBlpaWziso=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XKIZbDzbnxwWEQ6FA5doo0Tgd70zxfevhmVQ1onU6ZiOmSZaiEU4D/OI70tViW1HRDDwirzMD4jF3qv453CTNveU5tQhVxQg2pf0M9YRJZNZGEEwzPZyuSlwOr0WF91jzqsY0+Y1Y4A+nXel3N4rGpsJOzC60S6+X31UgxWH29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx1r8ER2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03610C4CEFB;
	Wed,  3 Dec 2025 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764756008;
	bh=QmaKFVhBQiQzNlVCCt7yiAN9GeZGGLPzGFBlpaWziso=;
	h=Subject:From:Date:To:From;
	b=Cx1r8ER2JsTzlvvqAvC7P3BAf2PzGEcxCrUEHtY1v7chZ6hdrLkSV9kmOSTZ2A2G5
	 C/Z9jV2ABQY5xUS9ryjwhq2uXcg/CAL+g92MHzAFtrusZmU0osELuJEITwKkAxITjO
	 AigAx50ojUtJjKDfqoy5DVg7psCGB4+nEss1+ec5FcZ4gAUytu3sS7GfzmEwFfUGgl
	 IbBtXXUbTHOaxA24LbQ44BswEbjiIgGI6oxEuX7lafLDt/v8GVZJLRua2gkgscZdbe
	 tzp57LWZHJi23CN1z3ADPfEH7prsoUK2wVeGy5hGnn8zqOb/MyHn+O1RCgJi9zW6GT
	 ah5F4TwoB3ySw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BBFA3AA940E;
	Wed,  3 Dec 2025 09:57:08 +0000 (UTC)
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
 <176475582686.3988481.874786683025469544.git-patchwork-housekeeping@kernel.org>
Date: Wed, 03 Dec 2025 09:57:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Support ECSPI dynamic burst feature for DMA mode (2025-12-03T08:59:43)
  Superseding: [v2] Support ECSPI dynamic burst feature for DMA mode (2025-12-02T07:54:57):
    [v2,1/6] spi: imx: group spi_imx_dma_configure() with spi_imx_dma_transfer()
    [v2,2/6] spi: imx: introduce helper to clear DMA mode logic
    [v2,3/6] spi: imx: avoid dmaengine_terminate_all() on TX prep failure
    [v2,4/6] spi: imx: handle DMA submission errors with dma_submit_error()
    [v2,5/6] spi: imx: support dynamic burst length for ECSPI DMA mode
    [v2,6/6] spi: imx: enable DMA mode for target operation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


