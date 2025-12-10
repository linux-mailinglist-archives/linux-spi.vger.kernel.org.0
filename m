Return-Path: <linux-spi+bounces-11840-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11808CB256E
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 09:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4D30302A05E
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 08:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF74B2EAD0D;
	Wed, 10 Dec 2025 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7+uT4F6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3272E5405
	for <linux-spi@vger.kernel.org>; Wed, 10 Dec 2025 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353598; cv=none; b=dRSZdCJh0ydX1ScKTZT9myW1f70rIpjvtm9WCItLbqsle9eaduTf35WEKAMnE3bpR+G75xsL9NmIBYvz+EMG1/aqB1YULUfps+Zh5n0oQ7uuhnYREcyFu1orMX8mBn/WR2TUHot1OJD6kKMUnvGEKJ0ZtxFayDv8Yc/SOnFNHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353598; c=relaxed/simple;
	bh=lP2T1qS2kogNkZpCTqvXsymARWJH1/9vyzb1/yUQIoY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=h5fhhD9ChyZdUFdx++X7MuCn/hw9ABegA8SZ6Nw9taduovLh8qd3Wk8swVLlltjxrqu86MvySl/yFYBPtgVDb0+51Q8nN53PQeAgGASzRPwd3j/rLYAz/DCuykZaI2GR07bLUgmztz0FVcDtYbxgrKVH5CNCHCytb0+ndc7FWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7+uT4F6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295EBC4CEF1;
	Wed, 10 Dec 2025 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765353598;
	bh=lP2T1qS2kogNkZpCTqvXsymARWJH1/9vyzb1/yUQIoY=;
	h=Subject:From:Date:To:From;
	b=V7+uT4F6GzyqTPrJyZUWqHR6bSPjCQMOVvxOFFL3VS0zDtddt0t1x3qH1GpKbgChB
	 U4wFi0T2+bK+Noi4TD8MY+QrwmeppXcyvWaGOm5mKezGMyn1sbjHU1BPgl8kSRr+1o
	 JvhYmBBs1dPfTSafnZowzDU0+s/7IUFUKOU+N1SN5Jimk5e5V2aSb3pJs/YnCRKiu+
	 +3rNcLYV1rhiMsbTRR7uuBP8Wes1kfQDpFIjoHM3VBmrJ2bW8cJOhb4ICaYRQISLs+
	 tBlcwOm7UKRxUkiOD38FTg6ACM87aptW+2MK/3rPupx5F/MC64E/o8caj2LRNy3Q9e
	 FLza45vR/WFGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F5B3809A18;
	Wed, 10 Dec 2025 07:56:54 +0000 (UTC)
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
 <176535341251.495883.13785034099229569533.git-patchwork-housekeeping@kernel.org>
Date: Wed, 10 Dec 2025 07:56:52 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-fsl-lpspi: convert min_t() to simple min() (2025-12-10T07:41:15)
  Superseding: [v1] spi: spi-fsl-lpspi: convert min_t() to simple min() (2025-12-09T05:56:34):
    spi: spi-fsl-lpspi: convert min_t() to simple min()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


