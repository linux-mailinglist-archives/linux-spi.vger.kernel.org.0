Return-Path: <linux-spi+bounces-12207-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9254D0423D
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 17:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23D0E301A0F3
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB183659F7;
	Thu,  8 Jan 2026 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKw/UVZM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C236829E
	for <linux-spi@vger.kernel.org>; Thu,  8 Jan 2026 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859187; cv=none; b=l1we0FxVMjmefqH6kSGRmZyiwwPD0LptubGhFLy3XNCivoYQewankNMEVyxaN7zBmNISKpyoEfxugr9lq6/sO0L8I04ljyJohNRK1vpBekxPeACs8RxJsxMHWKC7LVelCl4wpcCsSKKaUL1TEItB4xbDvreRHSkEhvURtJY1qNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859187; c=relaxed/simple;
	bh=zybLVtnvlxRGSAy3Ju2hnnE+59U/4RgxNItszAsTvDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LxfIXVGMlCQaujRmYh2bL4Pc2SShjuAFB63FluoklkjjQ/R6dWxRfwmazf0gsy2+lWkN/4yccUMQtUorUnnqFgJQXFAC76QYMoxaPJfoGrH+SJVpic0+mm+j2Gr016eEV/5UxS78LXHkr36oOL/ONTPA6iJS9Gxg9pSnPV/KkfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKw/UVZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A96BC116D0;
	Thu,  8 Jan 2026 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767859184;
	bh=zybLVtnvlxRGSAy3Ju2hnnE+59U/4RgxNItszAsTvDQ=;
	h=Subject:From:Date:To:From;
	b=FKw/UVZM49aWQGxZ4NSBBNgERvpByLMRHmwQssMD7huaScoA2ySMyeXkcyGWLYKAA
	 /RKMnLXBvZw9e0KHu1W1p8bLwFkW4JBJDmVkvysjgALvtqtuFJUVwGsDurOdr6j18K
	 NmhAbjZ9xLOaGWGYO3Uu8O+K9NFNGmH68R70jhtiCPvWU0yL+8Me9D1omnzDAmpdfd
	 vm3IPl00z3GuBH5Epm5gWskMXEWXGzCmt9VFEY5vHyXUcOV6Pq80qM4MHJcJIPFr3d
	 D+b6ps2laJlDRtNMvxU4+T4LtAcxAy1hhHlAI7VKflPLBk49EZwR1Z5drFh1zVN2Wl
	 rc+l9B/mOfdPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B91B3A54A3E;
	Thu,  8 Jan 2026 07:56:22 +0000 (UTC)
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
 <176785898092.3510770.5801095840306131368.git-patchwork-housekeeping@kernel.org>
Date: Thu, 08 Jan 2026 07:56:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: hisi-kunpeng: Fixed the wrong debugfs node name in hisi_spi debugfs initialization (2026-01-08T07:53:23)
  Superseding: [v1] spi: hisi-kunpeng: Fixed the wrong debugfs node name in hisi_spi debugfs initialization (2025-10-24T06:31:33):
    spi: hisi-kunpeng: Fixed the wrong debugfs node name in hisi_spi debugfs initialization


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


