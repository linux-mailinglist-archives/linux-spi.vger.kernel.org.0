Return-Path: <linux-spi+bounces-10698-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A3BE3D35
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 15:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90D76505EB0
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3D12E7179;
	Thu, 16 Oct 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKW3bEwk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A45532BF33
	for <linux-spi@vger.kernel.org>; Thu, 16 Oct 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623014; cv=none; b=JNIYloqNrthBS87ZSKJpeQsoPa/m0QOXF6i7qIUMsQLqb/+hbwAn22INK/OsiJxvReiQ75dUdubzaXYkKmHUPAMJQZRG7BTiuHYja8bVdps2Y90K1ZSOX9oDFjxL+2pr878EinXJwEke67f1IPyB6h4s7CJ/S/3/oChmum5VtDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623014; c=relaxed/simple;
	bh=oAiu4mSlTs2ZfJ21Rt/yLXtfPfHPbKCjpgBxr/DHgis=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=e1gte5d962r9cdtHS60XnENIOTVUziKmlEL3GyX1236/pNRrlVuwOc8sMZHYXkctiatSDjw0NB4Tm+/XrOX1wFrLrCiOtH/ToZwZ0BiI7Vf0bqbqkrwqZy0XnTSqJAvKVWBFVLaaMqYLc5LSzup7WQ/b8Y2QrgcGCoB6NffSO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKW3bEwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C91FC4CEF1;
	Thu, 16 Oct 2025 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760623014;
	bh=oAiu4mSlTs2ZfJ21Rt/yLXtfPfHPbKCjpgBxr/DHgis=;
	h=Subject:From:Date:To:From;
	b=IKW3bEwkwTFOt66Yc/MlYmcxTT250jaQiphb2BiSlx0yjmx+rqefUUBeC6sptQOWb
	 DYZjql79RCOoLTgmEsyMa2yJ8ubAe6QRKpwcIHPW6PmVKjjotQJlWkTOohceNtPqUy
	 jB0YTk2MB0Lz417nq9O3MrrL5wNK/pcZT4pLmd4itk58Q60tKf/AZ/YIm9XkclA+9B
	 f9+a4kBqOP5dNLfh+VVM37JTi1RJRYPszd2dHASOFjcNsybwq4YIg9uvtW8kEMDD/V
	 3eSGh02TPKxnIXTb0O3yWknqdWYPJKzuEfArn37SUau/6zlab9tUjYjf5yDWuHG/Ao
	 Ao+/CuBlgbzNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE055383BA08;
	Thu, 16 Oct 2025 13:56:39 +0000 (UTC)
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
 <176062299820.1363877.17037765536129530929.git-patchwork-housekeeping@kernel.org>
Date: Thu, 16 Oct 2025 13:56:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: tegra210-quad: Improve timeout handling under high system load (2025-10-16T13:29:21)
  Superseding: [v1] spi: tegra210-quad: Improve timeout handling under high system load (2025-10-10T15:19:59):
    [v1,1/2] spi: tegra210-quad: Fix timeout handling
    [v1,2/2] spi: tegra210-quad: Check hardware status on timeout


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


