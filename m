Return-Path: <linux-spi+bounces-10007-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2736B562FD
	for <lists+linux-spi@lfdr.de>; Sat, 13 Sep 2025 22:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F631634DF
	for <lists+linux-spi@lfdr.de>; Sat, 13 Sep 2025 20:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B222459FE;
	Sat, 13 Sep 2025 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgGFLsc/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AADD23E347
	for <linux-spi@vger.kernel.org>; Sat, 13 Sep 2025 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757797013; cv=none; b=mYlAspiEY/flQIccomcMMvPZNBlcAR1m4KymU4HxBwDQL03LgzGU46sCtC0YW5E91rIxJRYuSOIwb9E7I7JiB07ZAXz5qBTT7gQoWjG1+ZBbEFc/d+UDDzk0Ndb797k6K2ICptO2R/SpsX752A/qbFfjyvECVuWD5vdfqhEVQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757797013; c=relaxed/simple;
	bh=NuKWgnVychTINkgzXtxLz0JQj4r5PZaMaOsQKQ3sK1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WUhcGq5OkEGsHVquck1ZYDkfQ6joHRcRIDoIoTT8O/HNFZSRSkZe3KxA8Rtq3ceI9zARJvt6rdeMpUDxUVVfsx1haANvRhJfYEu1ZfTuu0TtbVJdTthKXJenQEoACLf7ROqFOSrT3g1XbVVSK1EtY0oMmvB349Y1xZBCFYziKO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgGFLsc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064EAC4CEEB;
	Sat, 13 Sep 2025 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757797013;
	bh=NuKWgnVychTINkgzXtxLz0JQj4r5PZaMaOsQKQ3sK1A=;
	h=Subject:From:Date:To:From;
	b=VgGFLsc/NzDXXkstPevnG/ePW40mYg8WzUBr9j2HBzH6/sgY04AScummdl7lOWo0M
	 4Wr5Ijs8OGxTxTZ0x178UI3fyn8mEgOC5M2NrjwBjDie/u+a2DLEq63WF/X1DNdcW+
	 UrHs6rX/iuZ8rQn87nCy+0seyo/gaIho94frJWe/+fXTVWK8DToPyDpLOCbsr4pVIh
	 ViVJJyyFNG/eP5aAZ+2YuwL6sBe4o8TEm/OjA2DtpldF9wi4uXk0lgwsJ6HR3Jgu+A
	 WtIB4hfkaYqCMchF1hdDfI3QSeU1eTVhR54WkR6j8sIcP05c+ZqWrNrdWt26JL8T+W
	 dXmOkeGL1u8Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CDA383BF4E;
	Sat, 13 Sep 2025 20:56:56 +0000 (UTC)
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
 <175779701479.3315017.18106094614697891123.git-patchwork-housekeeping@kernel.org>
Date: Sat, 13 Sep 2025 20:56:54 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: amlogic: Fix error checking on regmap_write call (2025-09-13T20:16:11)
  Superseding: [v1] spi: amlogic: Fix error checking on regmap_write call (2025-09-13T20:15:58):
    spi: amlogic: Fix error checking on regmap_write call


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


