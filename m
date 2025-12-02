Return-Path: <linux-spi+bounces-11713-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62426C9AC4A
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 10:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84237346CB6
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCFD307AC4;
	Tue,  2 Dec 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIxak08q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9302307486
	for <linux-spi@vger.kernel.org>; Tue,  2 Dec 2025 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764666009; cv=none; b=BZzDOgryLSE5HQdlJd5W/U2zonU55LfL7D9u47ZXQloXigEQrQzcNS5q/2g2IXzcS9028BGM0/ociTmKePnkVEfsn7mawHqYNGD7PouPL0XuPYKUwu8CwPdKfL1MfK8wUUA1KZOVutwpi3n8nWimtbZ4tT36uE6nByTW9bUpbVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764666009; c=relaxed/simple;
	bh=s+izu5mc9SjsUctcY7OViGsw+rSDncl457zLitciji4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LIQxkh6NNWFaoWevP+gFLMZO/MtQ+XraWgN/61kbv9/cy+EDcZYMKMxkwZDy0xgoSXk/bzmIB3H9xzhND9MKVd+bxGY7Rk39SRVnLPKxdQGksFyfiAupolST1T6HATIk+8ZqsCEK06P0pCIOEPlLFdhA0kyqymzWGnGEqXgDfKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIxak08q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F16EC4CEF1;
	Tue,  2 Dec 2025 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764666008;
	bh=s+izu5mc9SjsUctcY7OViGsw+rSDncl457zLitciji4=;
	h=Subject:From:Date:To:From;
	b=WIxak08qu77Y6T0qtXWVikYsg2HQF1U0rl1AjZL+gklZShoLn90d/jIGkMurNhafG
	 9MVp3MpJ266m9iFG9Ynhl7mM95pq5gsD3IOj+x/+iV8E5O4gBGHNdtSB0t0KcsaWIn
	 r38bQC9gQCyrTbOyDzZ1CRnEWLd+6EQSAHCPXhX8mXXDDpZpXvM43aGlv/lw4V0xDM
	 a2ZJB/Uur26XItCKeqcWuN51wQ5ULrGnwU1OzteMeNinWnjkrsxgs0GxNznUb8OR6Q
	 ivx9UHETAMGF+a0pvL0wzglwqLqeELmpYYyR/sNbdrreroH0pqi4e8+s6tYoYHIg/h
	 LXTD1JnaO4k2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B87B39D2F42;
	Tue,  2 Dec 2025 08:57:09 +0000 (UTC)
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
 <176466582786.3139917.2086239651462659428.git-patchwork-housekeeping@kernel.org>
Date: Tue, 02 Dec 2025 08:57:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Support ECSPI dynamic burst feature for DMA mode (2025-12-02T07:54:57)
  Superseding: [v1] Support ECSPI dynamic burst feature for DMA mode (2025-11-25T10:06:12):
    [1/6] spi: imx: group spi_imx_dma_configure() with spi_imx_dma_transfer()
    [2/6] spi: imx: introduce helper to clear DMA mode logic
    [3/6] spi: imx: avoid dmaengine_terminate_all() on TX prep failure
    [4/6] spi: imx: handle DMA submission errors with dma_submit_error()
    [5/6] spi: imx: support dynamic burst length for ECSPI DMA mode
    [6/6] spi: imx: enable DMA mode for target operation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


