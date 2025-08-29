Return-Path: <linux-spi+bounces-9776-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E641CB3BA57
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 13:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DDA1CC08DD
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EF02D0C8D;
	Fri, 29 Aug 2025 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLQx1oNB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13CE229B1F
	for <linux-spi@vger.kernel.org>; Fri, 29 Aug 2025 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468605; cv=none; b=R8RQv3VbY2yb/1turUQ+Yp45DFFBZVOmykPNUkBBJKOqs71PbdLzZyuwfhDYdhONydSZ9wJwqpocj/WM1X3t6+a7MWzL6qI+/mpxwe4QiB+ZOK/OlBueNEjLp9eN20KFdFoPJFSe98UgIQPPt5dapNruyo//8yy6IMl4zgnhEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468605; c=relaxed/simple;
	bh=tqdV3EQxuQ5+KknTX+gaJh+aGet9qemOMcRknzQ+FxQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=o8lHsN15NDgxkdy9+laBYIhp24u/WuBdUINV3ljACExz6sEXhGdO9IggzPMk124lN1Gu2Ev5gHK4QE1KnjMVFFkLs+nl/iVXXc1nS0oJGvh3mOc5aKhPuSyQ3gWGuSCDLegLTaTPtCTYquC8xqqRFcxAlpQ7aNsPimVwqa1i03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLQx1oNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3499BC4CEF0;
	Fri, 29 Aug 2025 11:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756468605;
	bh=tqdV3EQxuQ5+KknTX+gaJh+aGet9qemOMcRknzQ+FxQ=;
	h=Subject:From:Date:To:From;
	b=DLQx1oNBZ+Wp3rIPxnD0aG49+XK1KDBMES30kqjHiSPPZXo8K6xBZAKYcUffQj0/E
	 085rHekPp92AjH5WXiOvh6ksgGi4pWs4JtKTVDuXITCt03DDejPxKCDQqJ3ZKADsEY
	 9cUEF1MDa9KLlA34Hz/K0rQ97kaku63oyW0l4j5tsRYbDFcI3+ZX7wvnfrOY8mqg5x
	 FTn5LqnRV3VCKZJhnHsoA4Wf2fEaAXwPdHSsKGBF6GCzRCg9onURReZ9Fq7icCn7ey
	 u2hKFf/MbWF2L/gZvzqXKvGi8tpTotPCNwGwmUek4ja8T6kxATO2PLNaEva/PsADcz
	 4FyrZkBEU5T0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34393383BF75;
	Fri, 29 Aug 2025 11:56:53 +0000 (UTC)
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
 <175646861164.2187011.9619758959933292514.git-patchwork-housekeeping@kernel.org>
Date: Fri, 29 Aug 2025 11:56:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: spi-fsl-dspi: Target mode improvements (2025-08-29T11:46:42)
  Superseding: [v4] spi: spi-fsl-dspi: Target mode improvements (2025-06-27T10:21:36):
    [v4,1/6] spi: spi-fsl-dspi: Clear completion counter before initiating transfer
    [v4,2/6] spi: spi-fsl-dspi: Store status directly in cur_msg->status
    [v4,3/6] spi: spi-fsl-dspi: Stub out DMA functions
    [v4,4/6] spi: spi-fsl-dspi: Use non-coherent memory for DMA
    [v4,5/6] spi: spi-fsl-dspi: Increase DMA buffer size
    [v4,6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


