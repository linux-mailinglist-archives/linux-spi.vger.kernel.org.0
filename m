Return-Path: <linux-spi+bounces-8558-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41F8ADA622
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 03:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139543A6DD6
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 01:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BAB3C465;
	Mon, 16 Jun 2025 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyxUEHUC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF0D2E11C1
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750038972; cv=none; b=OsXfpJoDjGDMqhI6vQsciVx64OZBJgEwFcYLV0YDJjoTiHVVXgdo3EE8isAuqe7TGjV+0lt2BNHuUzNCgvi27f3GMnUxFzurVUAjrXeK47sEEUWTJ1bSZ8Y2ze6FMhLelTurXyXeWXsUdbUDJ4FSTaLxsNKaUZhSUcMvck9avEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750038972; c=relaxed/simple;
	bh=FjljdyIBHv+0VNGeqUXJBFoIxJmmD8VFFeA41jA6PDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GAXEwQt2/bbwUyERomYWs4k5g+bMX5eJ/nEKcWgCdpiZ7WjLb72Ams1Y6SvHiNO6dTnQUPNz72jx2zZ0qp9i345XXJ9FtJ9DRhbFIve+9Xw5p7r3EG/fVdVMXFbbpHQ2028zU0KfX86MQ3glLXVApOoH8n6avYkKQCW0rTAojZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyxUEHUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AEAC4CEE3;
	Mon, 16 Jun 2025 01:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750038972;
	bh=FjljdyIBHv+0VNGeqUXJBFoIxJmmD8VFFeA41jA6PDs=;
	h=Subject:From:Date:To:From;
	b=QyxUEHUCflnBUO6+bNuWuNpOsHCVRJeWYdwYRkDi+91H4b5JX/lFHkvCE6dm5Ow80
	 X967+CLmJH5zqJw1cntR/eweXdJaARqwFlOVcMi+pkWPuqVP3UUGdcJVcAtFzBODbN
	 9WG4+dCXwMiG+HnLza56b6PlSAU4H55TlvWGHKf8K5kq+qivRHrqMSJameBWMlVHNv
	 DgpfzZyDLGlhsXxxmSO0DKyRKfH3OU5BgvtBqHYQ/3Ui9sX1K2dHwW0oQHLIcA6ONE
	 6gOz5hydbos8YaXBNtgoLdwJ+KAeYJlbYJQ+BdeZV2ShRxKeEh/uSvBgvhihWRgx7u
	 CnMBX5ZxD4GJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C59380DBEE;
	Mon, 16 Jun 2025 01:56:42 +0000 (UTC)
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
 <175003900094.1805414.16611565146040021596.git-patchwork-housekeeping@kernel.org>
Date: Mon, 16 Jun 2025 01:56:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: spi-cadence-quadspi: Fix pm runtime unbalance (2025-06-16T01:13:53)
  Superseding: [v2] spi: spi-cadence-quadspi: Fix pm runtime unbalance (2025-06-10T22:30:19):
    [v2,1/1] spi: spi-cadence-quadspi: Fix pm runtime unbalance


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


