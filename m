Return-Path: <linux-spi+bounces-3599-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC5891746D
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2024 00:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231371C20C43
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 22:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A25158A23;
	Tue, 25 Jun 2024 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrWhAhIH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B414A61A
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719356192; cv=none; b=PVV8xrThjTwEIE64LuiktlYZHIP/gtT/33ObTrfAN80L6lJpmEy1zCfgw9n9sOgU1d4jrk2LduWln3uTd64T8go1rwDPrACrQq7jweeKXX/x18tNyHISwughKo1Yk46sQ6qCPrAnr/JEWb9mt5t6ck7LqUscEWd9JXiU44FcxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719356192; c=relaxed/simple;
	bh=mJjW6v5oWprtd32srHCHOGl0Fy82wclaxfQPYyQdaQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Xj8FsAXBD7Fgsh3JW7gd/+sOIKfWmX6e9bQ3xK1pr72SsxC4SmqYKQNQPrzWmPaO0lBFRdr7jFnqsqe2RmBS43FOYL8AE+N6mIMCMD76IlNxAgsZ49JN+IvSDKMcjJB90WNIfW03YHHKkTe6oqMqljlcS5Q4UsKP0/nmokFdpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrWhAhIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D88AC32781;
	Tue, 25 Jun 2024 22:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719356192;
	bh=mJjW6v5oWprtd32srHCHOGl0Fy82wclaxfQPYyQdaQA=;
	h=Subject:From:Date:To:From;
	b=PrWhAhIHJPUyA5dR5OTVRhVMa9T+JRyph9soMUyDCFRosCkNLzEnecJ3bClyUO/1F
	 Aa3TcCoReyudryQo+pD6Ctaoq1Me32XSrPa2txfPh91Ln64Mj8K3czvQ0BkdenRXE9
	 YLm2HBOhaKyV4nQYW8EK/IlgEF81HKfcZw2My4YRYdl4uMclHsmDFNIn+jl8PefcVP
	 LJFiQi3Bqd9wjijw1TSQ+1RZ00ozS30BNFBQ5JtRJFS2H7t3Y2iy+qo7gTPofSMrd0
	 JQZR9sZ8uzobpXPy+DuIlunLNCef3okozX8PmJHmpnRXSvKhhL7aqyln/pZ8AJIsd5
	 yBTddnmKw/o/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BE33C41677;
	Tue, 25 Jun 2024 22:56:32 +0000 (UTC)
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
 <171935619217.4254.9589148992646166512.git-patchwork-housekeeping@kernel.org>
Date: Tue, 25 Jun 2024 22:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Add support for AD4000 series of ADCs (2024-06-25T21:52:00)
  Superseding: [v4] Add support for AD4000 series of ADCs (2024-06-18T23:10:07):
    [v4,1/6] spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
    [v4,2/6] spi: bitbang: Implement support for MOSI idle state configuration
    [v4,3/6] spi: spi-gpio: Add support for MOSI idle state configuration
    [v4,4/6] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
    [v4,5/6] dt-bindings: iio: adc: Add AD4000
    [v4,6/6] iio: adc: Add support for AD4000


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


