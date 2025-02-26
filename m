Return-Path: <linux-spi+bounces-6952-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981BCA46706
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 17:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97B43A51CB
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B77222587;
	Wed, 26 Feb 2025 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWilOKxH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915F2222D1
	for <linux-spi@vger.kernel.org>; Wed, 26 Feb 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588616; cv=none; b=oToGW1KNB+e9LnS5mp+FCrmC7Tch/C3GgizYjLQrM/JOVwJ3rTt9osvUYJ+GpPXLZE3CF89rxFH+lpMq/jiw0plVbpb33WuCNCsyFQmIbAsTMSvWhclzJSyVP2TvIdp0nsSa009c49dd1Kv02focvKZcaD6irfFFS3uFxgpBZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588616; c=relaxed/simple;
	bh=fgtTq/5O8Eq+y4e/j3LvCl2ouPzw+k42DZFK8jVkirY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uNEwp6141pi1bQbV3N/yV7qu+l/YzIKQJrUdJuFPoN3vPwnm8kGY7gTouRcPSBwnbFhti9JdS64oGzmteFtIZgEDDZZcFSS76iEwTftivGxM9rlX3mSHk0jV9OZDB0DqJQklAV5ivEomgr7nCFgHqa1pio2KGB1znlspy9R7NY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWilOKxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0A2C4CEEB;
	Wed, 26 Feb 2025 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740588610;
	bh=fgtTq/5O8Eq+y4e/j3LvCl2ouPzw+k42DZFK8jVkirY=;
	h=Subject:From:Date:To:From;
	b=UWilOKxHbk4Bu6eKIJeI3Jei9llFFvRG0R9+6OIBbiipjYfp2FzA9RuYYbzHoWs68
	 8ptT/UiDB0B7ClJPaiJ51LuMTRj+IgVVD/u5WqJ1eDqxWTT9yzmAWgJ+zLIK9lNIqu
	 S0/UGVcftREz/mD6GzXe2QRDhkuh4qAjNG24vR0SC314DjwYMa4qgkzvxRhAlarmkf
	 b7UvD5cbmt2VtdTlz59Wy8MTEyIMO0MxQe4qt4KZrXXGXZBoVau9MSsBYoSOP/YFfn
	 x09zAB0HJAWGcBUm3lHfdpHUxVtzPzHIC4bpmAY7qjhdyoi5upA6i2RuVax8uuSe8w
	 Jv07G907vDeJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2ABE380CFDF;
	Wed, 26 Feb 2025 16:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174058863023.772035.807039736684708069.git-patchwork-summary@kernel.org>
Date: Wed, 26 Feb 2025 16:50:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Converge on using secs_to_jiffies() part two
  Submitter: Easwar Hariharan <eahariha@linux.microsoft.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=937701
  Lore link: https://lore.kernel.org/r/20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com
    Patches: [v3,01/16] coccinelle: misc: secs_to_jiffies: Patch expressions too
             [v3,12/16] spi: spi-fsl-lpspi: convert timeouts to secs_to_jiffies()
             [v3,13/16] spi: spi-imx: convert timeouts to secs_to_jiffies()


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



