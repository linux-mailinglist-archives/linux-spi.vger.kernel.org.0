Return-Path: <linux-spi+bounces-8201-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BD6ABC349
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 17:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9504C4A0821
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B1F286434;
	Mon, 19 May 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7N1DMsI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E561286424
	for <linux-spi@vger.kernel.org>; Mon, 19 May 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670179; cv=none; b=OC9vKVXK1i0IR9FCeYlhJpryRoO/j73RM/YEpApqCtcP8IKPDVvULwP4jCL4VPQ3hd/breo/Jt8kTPpoRycrDSEDw9+BlbQ0EuF/7vO/t1zeudEVExWVEuao8LjX/0Uq60HtmNgCaxkmawFs1DKY4ksQp1iv/0aawKT8tQ/7UDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670179; c=relaxed/simple;
	bh=L69HThYUKPwKqKKDCxW0Xwwow8Mf08FBxtmGKrXz4eg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HD4hqB146+cYfEIBQh0X+6NAI3L6XmWTQIXC/sDP4pceQq78RrDz6NcT76IiaBBdGBkEKlTnweyFHY+AkhERwiKArS/OPjlDh0XW9PHXhCa0WNSHvWHZmPDjZJUzulwLsSLHXUTW4+6/siHk4KKXCvEqACu/f5iLqS5xXl9fHQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7N1DMsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C00C4CEE4;
	Mon, 19 May 2025 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747670178;
	bh=L69HThYUKPwKqKKDCxW0Xwwow8Mf08FBxtmGKrXz4eg=;
	h=Subject:From:Date:To:From;
	b=p7N1DMsIzhoR+0h3JKqhrjoEwAvKfB/iiTG1cNszoH2xsRQKtxDbSPIoqmQI8HaXw
	 Ey0kwNb/Lt+d9fcnErKuXhIr4Ts3P9A74XJwOqO8nQrhsFJij2LC+ZictAM7kttfwE
	 VNOYDwHXTl+1gP7wU0pq1Yp9ZK76qLl1JNJNUMyieDIGcVOPxT75Lw9kPrsSOGgKGZ
	 qAW0uT4UK3SZ0Qp2i1MuKVCd5Qy2DvvU4ABo9otqqvw1/YJ5sI1kfsl589lusbTNLW
	 YP+TBgSyJboZvELOvj7QtmVXcvCUsZ66V+uNz4DUlgOBNa+8yY6oGEdXPsqFynVY20
	 IccKCY1RVttcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DA4380AA70;
	Mon, 19 May 2025 15:56:56 +0000 (UTC)
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
 <174767021482.978390.4742625729869610387.git-patchwork-housekeeping@kernel.org>
Date: Mon, 19 May 2025 15:56:54 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] clk: clk-axi-clkgen: improvements and some fixes (2025-05-19T15:41:09)
  Superseding: [v5] clk: clk-axi-clkgen: improvements and some fixes (2025-05-12T14:46:43):
    [v5,1/7] clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
    [v5,2/7] clk: clk-axi-clkgen: make sure to include mod_devicetable.h
    [v5,3/7] include: linux: move adi-axi-common.h out of fpga
    [v5,4/7] include: adi-axi-common: add new helper macros
    [v5,5/7] clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
    [v5,6/7] clk: clk-axi-clkgen move to min/max()
    [v5,7/7] clk: clk-axi-clkgen: fix coding style issues


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


