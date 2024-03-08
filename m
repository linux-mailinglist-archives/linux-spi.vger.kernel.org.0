Return-Path: <linux-spi+bounces-1741-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC2E8768FA
	for <lists+linux-spi@lfdr.de>; Fri,  8 Mar 2024 17:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAC6283822
	for <lists+linux-spi@lfdr.de>; Fri,  8 Mar 2024 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807531804E;
	Fri,  8 Mar 2024 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQYjPZzi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC6179B1
	for <linux-spi@vger.kernel.org>; Fri,  8 Mar 2024 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917021; cv=none; b=pCpYNoMgV7U8XK+9o4O2yHeqHP2Mr50K8Dzo+ct9Zt149O7QjyOiazV8dUJ/T9z62jRVpuLNGinZbVOnrzh/z8xu/1hVK3d0cqvKZ5km5SIk06ij0WvQv0byHw5S0ReJpr7yhgPXLk3woO/6cKKekr1kT4Ve5j0j4cdBVUpfvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917021; c=relaxed/simple;
	bh=eZuhftrC1PzRIcpY4w4fddvMQixFSi25UkZy8odU9tU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NOlr/4VCJk1b7VJPlwRFIWlawsuf6MHJMU2fvir7URomdOs+VwB9BF2B/1PnRRK5ZpoWNvOtkNhQ0RrSSmlm9gAuNfWnw4063zOdSHShT0+9l1UT9xk3lpGaAm8qJx03gaxDenCPxdFX9B7ycjhiPTUCfkF1DnenVUgm0HbbgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQYjPZzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E410EC433F1;
	Fri,  8 Mar 2024 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709917020;
	bh=eZuhftrC1PzRIcpY4w4fddvMQixFSi25UkZy8odU9tU=;
	h=Subject:From:Date:To:From;
	b=qQYjPZziWnT195f65KpW1TnhqS8vKyrFO+AsDGZvewfBFwcro1XJd3udUbHl8BtC+
	 leNTf+O2Ru1qMl8XgLSy6G5D4WacnJa4GO8ItAvP4PB6denIiTngndw/bfnUTczjAT
	 uQLBGITtE8U+vYk7FblOX32KE8xXeUmaJ+vACDYgeeZacA3gUhe1JVrA8IkVcsrjlZ
	 cYr6E9bIXIZt1c8dNzhNS1XPu80O/MSt9kjK+DH47cQG9yxWlB2maCjMZP224UPB4k
	 E0vbtNqvDGJle1Nw8UoBSxiiUg51SR5/o1CgzH+I0dxXd91i/Yoy2fLeJOSPGY1ttP
	 tPVNbbNLbFEyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2389C39562;
	Fri,  8 Mar 2024 16:57:00 +0000 (UTC)
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
 <170991702069.13717.13671070874878420774.git-patchwork-housekeeping@kernel.org>
Date: Fri, 08 Mar 2024 16:57:00 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: xilinx: Massage xilinx_spi.h (2024-03-08T16:27:45)
  Superseding: [v1] spi: xilinx: Massage xilinx_spi.h (2024-03-07T15:43:57):
    [v1,1/3] spi: xilinx: Fix kernel documentation in the xilinx_spi.h
    [v1,2/3] spi: xilinx: Add necessary inclusion and forward declaration
    [v1,3/3] spi: xilinx: Make num_chipselect 8-bit in the struct xspi_platform_data


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


